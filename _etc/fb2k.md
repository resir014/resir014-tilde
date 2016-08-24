---
layout: page
title: "The Ultimate foobar2000 Setup*"
---

<p class="lead">*) Well, according to me, at least.</p>

If there's something that I've learned in the past year or two, is that [foobar2000](http://www.foobar2000.org/) is the most lightweight, powerful, customizable music player I've ever used. I switched over from iTunes, as I was getting tired of the bloat it has become, and I have never turned back ever since.

Of course, I did run into some concerns that it won't be able to do the things that I always found useful on iTunes, like organising your songs neatly into their own folders based on artist, album, and the like. And with foobar2000's bare, customisation-focused experience, it does certainly look unappealing to the casual music listeners, and it *really* involves a lot of tweaking to really make your daily listening session a pleasant one.

So I started looking around for custom components and toyed around with them a bit, and this is what I came up with.

<a href="{{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-23-02.png" target="_blank">
  <img src="{{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-23-02.png" alt="foobar2000">
</a>

Here's a guide on how to make your foobar2000 look more like mine, which I find to be really neat. Sure, this might not be the best setup there is, but at least it makes your foobar2000 experience more bearable.

---

## Components

First off, you will need the following additional components. The version numbers might not be the latest when you're reading this off in the future, but as of the writing of this post, the version numbers are confirmed to be the most stable.

* [Columns UI (v0.3.9.1)](http://yuo.be/columns.php)
* [Dynamic Fields (v1 beta 4)](https://www.hydrogenaud.io/forums/index.php?showtopic=86853&start=0&p=744320&#entry744320)
* [Playback Statistics (v3.0.2)](http://www.foobar2000.org/components/view/foo_playcount)
* [Queue Contents Editor (v0.5.1)](http://wiki.hydrogenaud.io/index.php?title=Foobar2000:Components/Queue_Contents_Editor_(foo_queuecontents))
* [Discogs Tagger (v1.55)](https://www.foobar2000.org/components/view/foo_discogs)

## Interface - Columns UI

The default foobar2000 interface is fine, but unfortunately it lacks some pretty important features, like customizable playlist views, and, most importantly, [thumbnail toolbars]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-07_00-03-28.png)[^fn-thumbbars].

When I started transitioning to foobar2000, a friend of mine recommended that I use [Columns UI](http://yuo.be/columns.php), and I loved it at first sight. It improves much of foobar2000's user experience, and it also adds thumbnail toolbars to your taskbar, without any additional components needed. Talk about a multi-purpose UI kit.

After you've finished installing Columns UI and set it as your default UI, you will be presented with this screen.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-07_22-25-11.png)

Here you can choose a number of quick UI presets for you to get started, but if needed, you can later customize it from `Preferences > Display > Columns UI > Layout`.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-07_22-36-35.png)

Unfortunately, I've never touched this section, so look up on how you play around with this section yourself, I guess. Although the next few parts will explain why I chose to use Columns UI.

## DADA algorithm - automated track ratings

One other thing that foobar2000 lacks is a rating system. I've tried looking for some random components that does this but most of the time they do this thing where it will store the rating in your ID3 metadata, which is a big no.

So I tried looking up for something again, and came across [this article](http://www.giantpygmy.net/gpa/index.php?id=dada-autorating) on an automated rating system for foobar2000, known as the Date and Duration Adjusted (DADA) auto-rating algorithm.

The article above provides an in-depth explanation on how the algorithm works. It does take a while to understand how the algorithm makes any sense, but four or five months in, you'll start to see it really kick in.

### Getting DADA up and running

You will need these two components:

* [Dynamic Fields](https://www.hydrogenaud.io/forums/index.php?showtopic=86853&start=0&p=744320&#entry744320)
* [Playback Statistics](http://www.foobar2000.org/components/view/foo_playcount)

[This link](http://www.giantpygmy.net/gpa/data/uploads/files/dada_autorating_dar_latest_version.txt) shows in detail how to get the DADA algorithm up and running, complete with all of the options that are available. But if you want to get it up and running easily, here's my guide.

First, open `File > Preferences > Media Library > Dynamic Fields`, click on the Add Field (+) button, and name this field `dynamic_rating`.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-20_23-21-32.png)

Then, on the "Title formatting expression" textfield, paste the following:

{% highlight text %}
$puts(pc,%play_count%)
$puts(x,$add($date_diff(%added%),2))
$puts(y,$date_diff(%added%,%last_played%))
$puts(z,$sub($get(x),$get(y),2))
$puts(l,%length_seconds%)
$puts(lib0,$date_diff(2000))
$puts(lib1,$div($add($mul($sub(100,$div($date_diff(%added%),$div($get(lib0),100))),15),2600),30))
$puts(pc1,$add($get(pc),2))
$puts(pc3,$mul($get(pc1),$get(pc1),$get(pc1)))
$puts(b1,$add($div($date_diff(2015),5),0))
$puts(b2,$add($div($get(b1),50),500))
$puts(d0,$ifgreater($get(l),3599,$muldiv(9000,$get(l),3600),9000))
$puts(d1,$muldiv($add($get(l),540),1,4))
$puts(d2,$muldiv($get(l),$get(l),$get(d0)))
$puts(d3,$add($get(d1),$get(d2)))
$puts(r0,$mul($add(1000,$muldiv($get(d3),$get(pc),100)),10))
$puts(dd,$div($add($get(y),50),10))
$puts(pp,$muldiv($get(pc),10000,$get(x)))
$puts(2,$muldiv($get(dd),$get(pp),100))
$puts(3,$muldiv($get(x),$get(lib1),100))
$puts(4,$div($get(pp),50))
$puts(5,$div($muldiv($add($div($date_diff(%added%,%first_played%),5),5000),$get(b2),$add($div($get(l),20),140)),$add($div($get(pc3),58),3)))
$puts(6,$muldiv($get(pc),625,$get(x)))
$puts(7,$add($get(3),$get(5),$get(6)))
$puts(r1,$add($get(2),$get(r0)))
$puts(r2,$add($get(4),$sub($get(r1),$get(7))))
$puts(r2a,$ifgreater($get(r2),0,$get(r2),1))
$puts(r3,$sub($get(r2),$div($mul($get(r2a),$get(z),3),50000)))
$puts(r4,$add($get(r3),$get(b1)))
$ifgreater($get(pc),0,$num($get(r4),5),-----)
{% endhighlight %}

Then set your recalculation interval in the dropdown at the top. I usually set it to 5 minutes. Then click "Okay" twice, and foobar2000 will restart.

Now, to add the column to our playlist view, go to `File > Preferences > Display > Columns UI > Playlist View`, then click on the Columns tab.

Add a column at the very end. Let's call it "Rating."

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-20_23-37-20.png)

Now, click on the Scripts tag, and paste the following into the textfield on the "Display" tab.

{% highlight text %}
$puts(maxdar,10000)
$puts(mindar,5000)
$puts(maxsub,$sub($get(maxdar),0))
$puts(r3,$ifgreater(%_dynamic_rating%,$get(maxsub),$get(maxsub),%_dynamic_rating%))
$puts(r4,$ifgreater($get(r3),0,$get(r3),1))
$puts(minmax,$sub($get(maxdar),$get(mindar)))
$puts(darind1,$sub($get(r4),$get(mindar)))
$puts(darind2,$div($mul($get(darind1),10),$get(minmax)))
$puts(darind3,$ifgreater($get(darind2),1,$get(darind2),1))
$puts(display,$rgb(100,100,100)$repeat($char(9679),$get(darind3))$rgb(220,220,220)$repeat($char(9679),$sub(10,$get(darind3))))
$puts(notplayed,$rgb(200,200,200)- n/a -)
$ifgreater(%_dynamic_rating%,0,$get(display),$get(notplayed))
{% endhighlight %}

This will give you a nice visual of the rating, with dots, as seen below. If you want to just use the actual number for this column, just type `%_dynamic_rating%` into the same textfield.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-20_23-41-37.png)

Congrats, you now have the DADA rating installed!

### DADA-curated playlist

Now what I'd usually like to do after this, is to create a "Top Tracks" autoplaylist using the DADA algorithm to determine the ranks, and this is where Columns UI really stands out. The NG Playlist configurations built into Columns UI allows for further customisations on how your playlists are displayed.

If you take a look at my first screenshot, the "All Music" playlist are grouped based on albums. Obviously I wouldn't want to same grouping for the Top Tracks playlists. So far, Columns UI is the only component that I can find that supports different grouping schemes for playlists.

If you open `Preferences > Playlist View > Grouping`, you will see this.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-17-37.png)

The first grouping rule in that window is included by default. But we're gonna tweak it a bit by double clicking on it. Then, on the playlist filters, select "Hide on playlists" from the dropdown, and add the playlists that you want the grouping rules to be ignored at, separated by semicolons. Here's an example.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-19-46.png)

Save your changes, and there you go, a 100%-working Top Tracks playlist.

<a href="{{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-13-37.png" target="_blank">
  <img src="{{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-13-37.png" alt="foobar2000">
</a>

## Organising your music

This section will be broken down in two parts. In the first part, I will explain on how to organise your music library with a neat, iTunes-like folder structure, and in the second part I will talk about automatic tagging with Discogs.

### File Operations

If there's one thing to love from iTunes, is that I love how it organises your music collection neatly into their own folders, separated by artist and album. It really has been what made me stuck with iTunes for too long, and when I made the switch to foobar2000, I just had to research on whether foobar2000 would be able to do the same.

Fortunately, there's a built-in component that does more or less the same thing. File Operations (`foo_fileops`) is a built-in component that is included if you choose to install foobar2000 with some additional components.

First thing to do would be to set up your FileOps configs. Right click on any track and go to `File Operations > Move to > ...`.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-26-49.png)

Here, you can add, remove, or save presets for FileOps. The most important option here would be "File name pattern". I use the following pattern, to make it look more like iTunes:

{% highlight text %}
%album artist%/%album%/[%discnumber%-]%tracknumber% %title%
{% endhighlight %}

You can learn more about defining file name patterns on this [wiki page](http://wiki.hydrogenaud.io/index.php?title=Foobar2000:File_operations).

In order to organise new music in your library, first you **must** move your new music into a placeholder directory inside your main library folder, like `_unsorted`. Then head over to `Library > Album List`, then right click on "All Music", then head over to `File Operations > Move to` then select your saved preset, like so.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_00-35-07.png)

You will now see a preview of the changes made in your directory. Click "Run" to confirm your changes.

### Tagging with Discogs

It's very important to properly tag your music library, for the sake of consistency, especially when you're sharing what you're listening to to services like [Last.fm](http://www.last.fm/).

Well, good news: `foo_discogs` does exist. Unfortunately, before you want to use it, you will have to create an account at <http://www.discogs.com/> in order to get an OAuth token to access their API[^fn-discogs-oauth]. If you don't want to do that, you can try [MusicBrainz tagger](https://www.foobar2000.org/components/view/foo_musicbrainz), which grabs data from MusicBrainz's database, though it's not as robust as the one for Discogs. (You can always use a third-party tagging tool like [Picard](https://picard.musicbrainz.org/).)

To use this component, right click on any track/album, and head over to `Tagging > Discogs > Write Tags`. It will then look up the Discogs database for your album details.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_01-03-47.png)

Once found, choose the appropriate release for the album, and click Next. (You can also manually type the Release ID, if you know it.)

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_01-05-57.png)

Review your changes in the next dialog box, and click on "Write Tags" to write the new ID3 tags to your tracks.

Though keep in mind that this only saves the album art into the album directory *without* writing it into the ID3 tags too. To do so, right click on the tracks again, and go to `Tagging > Batch attach pictures`.

![foobar2000]({{ site.baseurl }}/public/images/etc/fb2k/2015-11-08_01-08-51.png)

Choose to overwrite the album art already attached to the track if necessary, then click "OK" to save your changes.

## Backing up your foobar2000 installation.

If in some cases you'll need to reinstall your computer, and you couldn't afford to lose your sick foobar2000 setup, you can back up your foobar2000 installation and transfer it to another computer. [This article on How-To Geek](http://www.howtogeek.com/howto/19035/backup-and-transfer-foobar2000-to-a-new-computer/) will explain how.

---

## Conclusion

In conclusion: yes, you *can* actually make your foobar2000 experience to be more bearable. Yes, foobar2000 is the one of the best, most customisable music players out there, and yes, you *should* use it yourself too.

But feel free to use this guide as you wish. Customisation is one of foobar2000's prime experience, in fact, I *encourage* you to improve on this setup yourself. The setup demonstrated here is what has always worked for me, and people's tastes can be different, so feel free to change things up here and there if you don't like how some stuff works.

It's a tedious process at first, but trust me, it really *will* be worth it at the end of the day. Feel free to [tweet at me](https://twitter.com/resir014) if you need help in your setup procedure.

[^fn-thumbbars]: [Source](https://msdn.microsoft.com/en-us/library/windows/desktop/dd378460(v=vs.85).aspx#thumbbars)
[^fn-discogs-oauth]: [Source](https://www.discogs.com/developers/#page:authentication,header:authentication-discogs-auth-flow)
