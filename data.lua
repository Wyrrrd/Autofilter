--data.lua

data:extend(
{
    {
        type = "tips-and-tricks-item",
        name = "autofilter",
        tag = "[entity=filter-inserter]",
        category = "inserters",
        indent = 1,
        order = "g",
        trigger =
        {
          type = "build-entity",
          entity = "filter-inserter",
          count = 1
        },
        dependencies = {"inserters"},
      },
})