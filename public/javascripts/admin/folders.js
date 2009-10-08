Event.addBehavior({
  'table#folder_map': FolderMapBehavior(),
  'input#folder_name': function() {
    var title = this;
    var slug = $('folder_slug');
    var oldTitle = title.value;
    
    if (!slug) return;
    
    new Form.Element.Observer(title, 0.15, function() {
      if (oldTitle.toSlug() == slug.value) slug.value = title.value.toSlug();
      oldTitle = title.value;
    });
  }
});