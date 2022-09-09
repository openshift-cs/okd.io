## Setting up a documentation environment

<!--- cSpell:ignore linkchecker linkcheckerrc mkdocs mkdoc Runtimes -->

To work on documentation and be able to view the rendered web site you need to create an environment, which comprises of:

- [MkDocs](https://www.mkdocs.org){: target=_blank} with the [Materials theme](https://squidfunk.github.io/mkdocs-material/){: target=_blank}
- [CSpell](https://cspell.org/){: target=_blank}
- [linkchecker](https://linkchecker.github.io/linkchecker/){: target=_blank}
- [Node.js](https://nodejs.org/en/){: target=_blank}
- [Python 3](https://www.python.org){: target=_blank}

You can create the environment by : 

- running the tooling within a container runtime, so you don't need to do any local installs
- if you have an Eclipse Che installation on an OKD cluster then you can make the changes using only a browser, with all the tooling running inside Che on the OKD cluster.
- installing the components on your local system

=== "Tooling within a container"

    You can use a container to run MkDocs so no local installation is required, however you do need to have [Docker Desktop](https://www.docker.com/products/docker-desktop){: target=_blank} installed if using Mac OS or Windows.  If running on Linux you can use **Docker** or **Podman**.

    *If you have a node.js environment installed that includes the npm command then you can make use of the run scripts provided in the project to run the docker or podman commands*

    The following commands all assume you are working in the root directory of your local git clone of your forked copy of the okd.io git repo.  *(your working directory should contain mkdocs.yml and package.json files)*

    !!!Warning
        If you are using Linux with SELinux enabled, then you need to configure your system to allow the local directory containing the cloned git repo to be mounted inside a container.  The following commands will configure SELinux to allow this:

        (change the path to the location of your okd.io directory)

        ```shell
        sudo semanage fcontext -a -t container_file_t '/home/brian/Documents/projects/okd.io(/.*)?'
        sudo restorecon -Rv /home/brian/Documents/projects/okd.io
        ```

    ### Creating the container

    To create the container image on your local system choose the appropriate command from the list:

    - if you are using the docker command on Linux, Mac OS or Windows:

        ```shell
        docker build -t mkdocs-build -f ./dev/Dockerfile .
        ```

    - if you are using the podman command on Linux:

        ```shell
        podman build -t mkdocs-build -f ./dev/Dockerfile .
        ```

    - if you have npm and use Docker on Linux, Mac OS or Windows:
    
        ```shell
        npm run docker-build-image
        ```

    - if you have npm and use Podman on Linux:
    
        ```shell
        npm run podman-build-image
        ```

    This will build a local container image named mkdocs-build

    ### Live editing of the content

    To change the content of the web site you can use your preferred editing application.  To see the changes you can run a live local copy of **okd.io** that will automatically update as you save local changes.

    Ensure you have the local container image, built in the previous step, available on your system then choose the appropriate command from the list:

    - if you are using the docker command on Linux or Mac OS:

        ```shell
        docker run -it --rm --name mkdocs-serve -p 8000:8000 -v `pwd`:/site:Z mkdocs-build
        ```

    - if you are using the podman command on Linux:

        ```shell
        podman run -it --rm --name mkdocs-serve -p 8000:8000 -v `pwd`:/site:Z mkdocs-build
        ```

    - if you are on Windows using the docker command in Powershell:

        ```powershell
        docker run -it --rm --name mkdocs-build -p 8000:8000 -v "$(pwd):/site" mkdocs-build
        ```

    - if you are on Windows using the docker command in CMD prompt:

        ```cmd
        docker run -it --rm --name mkdocs-build -p 8000:8000 -v %cd%:/site mkdocs-build
        ```

    - if you have npm and use Docker on Linux or Mac OS:
    
        ```shell
        npm run docker-serve
        ```

    - if you have npm on Windows:
    
        ```shell
        npm run win-docker-serve
        ```

    - if you have npm and use Podman on Linux:
    
        ```shell
        npm run podman-serve
        ```

    You can now open a browser to [localhost:8000](http://localhost:8000){: target=_blank}.  You should see the **okd.io** web site in the browser.  As you change files on your local system the web pages will automatically update.

    When you have completed editing the site use *Ctrl-c* (hold down the control key then press c) to quit the site.

    ### Build and validate the site

    Before you submit any changes to the site in a pull request please check there are no [spelling mistakes](./okd-io.md#spell-checking) or [broken links](./okd-io.md#links-within-mkdocs-generated-content), by running the build script and checking the output.

    The build script will create or update the static web site in the **public** directory - this is what will be created and published as the live site if you submit a pull request with your modifications.

    - if you are using the docker command on Linux or Mac OS:

        ```shell
        docker run -it --rm --name mkdocs-build -p 8000:8000 -v `pwd`:/site:Z --entrypoint /site/build.sh mkdocs-build
        ```

    - if you are using the podman command on Linux:

        ```shell
        podman run -it --rm --name mkdocs-build -p 8000:8000 -v `pwd`:/site:Z --entrypoint /site/build.sh mkdocs-build
        ```

    - if you are on Windows using the docker command in Powershell:

        ```powershell
        docker run -it --rm --name mkdocs-build -v "$(pwd):/site" --entrypoint /site/build.sh mkdocs-build
        ```

    - if you are on Windows using the docker command in CMD prompt:

        ```cmd
        docker run -it --rm --name mkdocs-build -v %cd%:/site --entrypoint /site/build.sh mkdocs-build
        ```

    - if you have npm and use Docker on Linux or Mac OS:
    
        ```shell
        npm run docker-build
        ```

    - if you have npm on Windows:
    
        ```shell
        npm run win-docker-build
        ```

    - if you have npm and use Podman on Linux:
    
        ```shell
        npm run podman-build
        ```
    
    You should verify there are no spelling mistakes, by finding the last line of the CSpell output: 
    
    ```text
    CSpell: Files checked: 31, Issues found: 0 in 0 files
    ```
    
    Further down in the console output wil be the summary of the link checker:
    
    ```text
    That's it. 662 links in 695 URLs checked. 0 warnings found. 0 errors found
    ```
    
    Any issues reported should be fixed before submitting a pull request to add your changes to the okd.io site.

=== "Editing on cluster"

    There is a community operator available in the OperatorHub on OKD to install Eclipse Che, the upstream project for Red Hat CodeReady Workspaces.

    You can use Che to modify site content through your browser, with your OKD cluster hosting the workspace and developer environment.

    You need to have access to an OKD cluster and have the Che operator installed and an Che instance deployed and running.

    In your OKD console, you should have an applications link in the top toolbar.  Open the Applications menu (3x3 grid icon) and select Che.  This will open the Che application - Google Chrome is the supported browser and will give the best user experience.

    In the Che console side menu, select to **Create Workspace**, then in the **Import from Git** section add the URL of *your* fork of the okd.io git repository (should be similar to `https://github.com/<user or org name>/okd.io.git`) then press **Create & Open** to start the workspace.

    After a short while the workspace will open (*the cluster has to download and start a number of containers, so the first run may take a few minutes depending on your cluster network access*).  When the workspace is displayed you may have to wait a few seconds for the workspace to initialize and clone your git repo into the workspace.  You may also get asked if you trust the author of the git repository, answer yes to this question.  Your environment should then be ready to start work.
    
    The web based developer environment uses the same code base as Microsoft Visual Studio Code, so provides a similar user experience, but within your browser.

    ### Live editing of the content

    To change the content of the web site you can use the in browser editor provided by Che.  To see the changes you can run a live local copy of **okd.io** that will automatically update as you save local changes.

    On the right side of the workspace window you should see 3 icons, hovering over them should reveal they are the **Outline**, **Endpoints** and **Workspace**.  Clicking into the workspace, you should see a **User Runtimes** section with the option to open a new terminal, then 2 commands (Live edit and Build) and finally a link to launch MkDocs web site (initially this link will not work)

    To allow you to see your changes in a live site (where any change you save will automatically be updated on the site) click on the **1. Live edit** link.  This will launch a new terminal window where the **mkdocs serve** command will run, which provides a local live site.  However, as you are running the development site on a cluster, the Che runtime automatically makes this site available to you.  The **MkDocs** link now points to the site, but you will be asked if you want to open the site in a new tab or in Preview.

    Preview will add a 4th icon to the side toolbar and open the web site in the side panel. You can drag the side of the window to resize the browser view to allow you to edit on the left and view the results on the right of your browser window.

    If you have multiple monitors you may want to select to open the website in a new Tab or use the **MkDocs** link, then drag the browser tab on to a different monitor.

    By default, the Che environment auto-saves any file modification after half a second of no activity.  You can alter this in the preferences section.  When ever a file is saved the live site will update in the browser. 

    When you finished editing simply close the terminal window running the Live edit script.  This will stop the web server running the preview site.

    ### Build and validate the site


    The build script will create or update the static web site in the **public** directory - this is what will be created and published as the live site if you submit a pull request with your modifications.

    To run the build script simply click the **2. Build** link in the Workspace panel.

    You should verify there are no spelling mistakes, by finding the last line of the CSpell output: 
    
    ```text
    CSpell: Files checked: 31, Issues found: 0 in 0 files
    ```
    
    Further down in the console output wil be the summary of the link checker:
    
    ```text
    That's it. 662 links in 695 URLs checked. 0 warnings found. 0 errors found
    ```
    
    Any issues reported should be fixed before submitting a pull request to add your changes to the okd.io site.

=== "Local mkdocs and python tooling installation"

    You can install MkDocs and associated plugins on your development system and run the tools locally:

    - Install [Python 3](https://www.python.org){: target=_blank} on your system
    - Install [Node.js](https://nodejs.org/en/){: target=_blank} on your system
    - Clone **your fork** of the [okd.io repository](https://github.com/openshift-cs/okd.io/){: target=_blank}
    - cd into the local repo directory (./okd.io)
    - Install the required python packages `pip install -r requirements.txt'
    - Install the spell checker using command `npm ci`.  If you want to use the cspell command on the command line, then you need to install it globally `npm -g i cspell`

    !!!note
        sudo command may be needed to install globally, depending on your system configuration

    You now have all the tools installed to be able to create the static HTML site from the markdown documents.  The [documentation for MkDocs](https://www.mkdocs.org){: target=_blank} provides full instructions for using MkDocs, but the important commands are:

    - `mkdocs build` will build the static site.  This must be run in the root directory of the repo, where mkdocs.yml is located.  The static site will be created/updated in the **public** directory
    - `mkdocs serve` will build the static site and launch a test server on `http://localhost:8000`.  Every time a document is modified the website will automatically be updated and any browser open will be refreshed to the latest.
    - To check links in the built site (`mkdocs build` must be run first), use the linkchecker, with command `linkchecker -f linkcheckerrc --check-extern public`.  This command should be run in the root folder of the project, containing the **linkcheckerrc** file.
    - To check spelling `cspell docs/**/*.md` should be run in the root folder of the project, containing the **cspell.json** file.

    There is also a convenience script `./build.sh` in the root of the repository that will check spelling, build the site then run the link checker.

    You should verify there are no spelling mistakes, by finding the last line of the CSpell output: 
    
    ```text
    CSpell: Files checked: 31, Issues found: 0 in 0 files
    ```
    
    Similarly, the link checker creates a summary after checking the site:
    
    ```text
    That's it. 662 links in 695 URLs checked. 0 warnings found. 0 errors found
    ```
    
    Any issues reported should be fixed before submitting a pull request to add your changes to the okd.io site.
