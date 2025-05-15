<!-- database\relationships.md -->

Voici les relations d'entité impliquées par le schéma SQL :

* **SurfSpot ↔ Influencer** (many - to - many via `SurfSpot_Influencer`)
 Un spot de surf peut être promu par plusieurs influenceurs, et un influenceur peut promouvoir plusieurs spots de surf.

* **SurfSpot ↔ SurfBreakType** (many - to - many via `SurfSpot_SurfBreakType`)
 Un spot de surf peut présenter plusieurs types de cassures (récif, plage, etc.), et chaque type de cassure peut être présent dans de nombreux spots de surf.

* **SurfSpot ↔ Traveller** (many - to - many via `SurfSpot_Traveller`)
 Un spot de surf peut être visité par de nombreux voyageurs, et un voyageur peut visiter de nombreux spots de surf.

* **SurfSpot → Photo** (one - to - many)
 Chaque spot de surf peut avoir zéro ou plusieurs photos ; chaque photo appartient exactement à un spot de surf.

* **Photo → Thumbnail** (one - to - many)
 Chaque photo peut avoir plusieurs thumbnails (un par `kind` : « small », « large », « full ») ; chaque thumbnail est lié à une seule photo.
