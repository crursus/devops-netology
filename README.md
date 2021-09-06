# devops-netology
Выполнено клонирование репозитория с исходным кодом терраформа в локальный репозиторий.

1. Полный хеш и комментарий коммита **aefead220** следующие:
   * **aefead2207ef7e2aa5dc81a34aedf0cad4c32545**
   * **Update CHANGELOG.md**
   
   **Решение**: `git log aefea -1 --pretty=oneline`
   

2. Коммит **85024d310** соответствует следующему тегу:
   * **v0.12.23**
   
   **Решение**: `git log -1 85024d3`
   

3. У коммита **b8d720** 2 родителя, с следующими хешами
   * **56cd7859e05c36c06b56d013b55a252d0bb7e158**
   * **9ea88f22fc6269854151c571162c5bcf958bee2b**
   
   **Решение**: `git log --pretty=%P -n 1 b8d720`

   
4. Хеши и комментарии всех коммитов сделанные между тегами **v0.12.23** и **v0.12.24** следующие:
   * **b14b74c4939dcab573326f4e3ee2a62e23e12f89**
      * [Website] vmc provider links 
   * **3f235065b9347a758efadc92295b540ee0a5e26e**
      * Update CHANGELOG.md
   * **6ae64e247b332925b872447e9ce869657281c2bf**
      * registry: Fix panic when server is unreachable
   * **5c619ca1baf2e21a155fcdb4c264cc9e24a2a353** 
      * website: Remove links to the getting started guide's old location
   * **06275647e2b53d97d4f0a19a0fec11f6d69820b5**
      * Update CHANGELOG.md
   * **d5f9411f5108260320064349b757f55c09bc4b80**
      * command: Fix bug when using terraform login on Windows
   * **4b6d06cc5dcb78af637bbb19c198faff37a066ed**
      * Update CHANGELOG.md
   * **dd01a35078f040ca984cdd349f18d0b67e486c35**
      * Update CHANGELOG.md
   * **225466bc3e5f35baa5d07197bbc079345b77525e**
      * Cleanup after v0.12.23 release

   **Решение**: `git log v0.12.22..v0.12.24 --pretty=oneline`


5. Коммит в котором была создана функция **func providerSource** следующий:
   * **8c928e83589d90a031f811fae52a81be7153e82f**
   
   **Решение**: `git log -S 'func providerSource('`
   

6. Все коммиты в которых была изменена функция **globalPluginDirs** следующие:
   * **35a058fb3ddfae9cfee0b3893822c9a95b920f4c**
     * main: configure credentials from the CLI config file
   * **c0b17610965450a89598da491ce9b6b5cbd6393f**
     * prevent log output during init
   * **8364383c359a6b738a436d1b7745ccdce178df47**
      * Push plugin discovery down into command package

   **Решение**: `git log -S globalPluginDirs --pretty=oneline`


7. Автор функции **synchronizedWriters**:
   * Martin Atkins
   
   **Решение**: `git log -S globalPluginDirs --pretty=format:"%h | %an | %cn"`
