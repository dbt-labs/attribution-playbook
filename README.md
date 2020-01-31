# attribution

dbt models for acme

## Getting started
1. Clone this github repo
2. Install dbt following [these instructions](https://docs.getdbt.com/docs/installation)
3. Ask your database administrator for a set of snowflake credentials.



  The database administrator should run the following statements from a super user account to create your account.
```sql
create user <user>
    password = '<generate_this>'
    default_warehouse = transforming
    default_role = transformer;
```

4. Copy the example profile to your `~/.dbt` folder (created when installing dbt):
```bash
$ cp ./sample.profiles.yml ~/.dbt/profiles.yml
```
5. Populate `~/.dbt/profiles.yml` with the credentials you obtained in step 3:
```bash
open ~/.dbt
```
6. Verify that you can connect to your database
```
$ dbt debug
```
7. Verify that you can run dbt
```
$ dbt run
```

## Coding conventions
This project follows Fishtown Analytics' [coding conventions](https://github.com/fishtown-analytics/corp/blob/master/dbt_coding_conventions.md) and [git guide](https://github.com/fishtown-analytics/corp/blob/master/git-guide.md).

## Understanding the structure of this project
This project follows the structure set out in [this article](https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355).
