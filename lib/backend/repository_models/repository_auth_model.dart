abstract class RepositoryAuthModel {
  dynamic login(var model);
  dynamic register(var model);
  dynamic logOut();
  dynamic checkCurrentUser();
}
