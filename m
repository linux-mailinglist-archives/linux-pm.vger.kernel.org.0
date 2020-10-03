Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E7281FA3
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 02:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgJCAOX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 20:14:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47802 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJCAOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 20:14:23 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE87A2A2;
        Sat,  3 Oct 2020 02:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1601684060;
        bh=+6oLaNXCzW10EOi7yZGKf53UByBP3OfCZ2DbymvFru4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bc+Deodasn0sCNZhaf6Gx6XbXjbyA7lfRaoFjKOxRjIEndIeT2xnvZAokcMbefTQw
         OP9+oMRViNvXrrED+cG2VM92CfLmCZbm2aFhZAD3Wyigb0P4dwUvUhDrhDIY7727CE
         Y+hgqcbTo6LIJe9vjNIbPBBkIdeb+0UBK1ua8qu0=
Date:   Sat, 3 Oct 2020 03:13:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
Message-ID: <20201003001342.GA1730@pendragon.ideasonboard.com>
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
 <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
 <20201002175423.GE3933@pendragon.ideasonboard.com>
 <CAGETcx-7nJaU6pDo_KL-nKmCaxv57C5aaXq-pvo4XiN=N0K5Jg@mail.gmail.com>
 <20201002182712.GF3933@pendragon.ideasonboard.com>
 <11018e7e-a6a1-2df6-5639-821a7c0cb68b@ti.com>
 <CAGETcx8DCiEJy-1PiHheyuuw3YBYfFh67MBcOwv4JEviXmsp3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGETcx8DCiEJy-1PiHheyuuw3YBYfFh67MBcOwv4JEviXmsp3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On Fri, Oct 02, 2020 at 12:56:30PM -0700, Saravana Kannan wrote:
> On Fri, Oct 2, 2020 at 11:35 AM 'Grygorii Strashko' via kernel-team wrote:
> > On 02/10/2020 21:27, Laurent Pinchart wrote:
> > > On Fri, Oct 02, 2020 at 10:58:55AM -0700, Saravana Kannan wrote:
> > >> On Fri, Oct 2, 2020 at 10:55 AM Laurent Pinchart wrote:
> > >>> On Fri, Oct 02, 2020 at 10:51:51AM -0700, Saravana Kannan wrote:
> > >>>> On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >>>>> On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
> > >>>>>>
> > >>>>>> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > >>>>>> adding all top level devices") optimized the fwnode parsing when all top
> > >>>>>> level devices are added, it missed out optimizing this for platform
> > >>>>>> where the top level devices are added through the init_machine() path.
> > >>>>>>
> > >>>>>> This commit does the optimization for all paths by simply moving the
> > >>>>>> fw_devlink_pause/resume() inside of_platform_default_populate().
> > >>>>>>
> > >>>>>> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > >>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >>>>>> ---
> > >>>>>>   drivers/of/platform.c | 19 +++++++++++++++----
> > >>>>>>   1 file changed, 15 insertions(+), 4 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > >>>>>> index 071f04da32c8..79972e49b539 100644
> > >>>>>> --- a/drivers/of/platform.c
> > >>>>>> +++ b/drivers/of/platform.c
> > >>>>>> @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
> > >>>>>>                                   const struct of_dev_auxdata *lookup,
> > >>>>>>                                   struct device *parent)
> > >>>>>>   {
> > >>>>>> -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> > >>>>>> -                                   parent);
> > >>>>>> +       int ret;
> > >>>>>> +
> > >>>>>> +       /*
> > >>>>>> +        * fw_devlink_pause/resume() are only safe to be called around top
> > >>>>>> +        * level device addition due to locking constraints.
> > >>>>>> +        */
> > >>>>>> +       if (!root)
> > >>>>>> +               fw_devlink_pause();
> > >>>>>> +
> > >>>>>> +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> > >>>>>> +                                  parent);
> > >>>>>
> > >>>>> of_platform_default_populate() vs. of_platform_populate() is just a
> > >>>>> different match table. I don't think the behavior should otherwise be
> > >>>>> different.
> > >>>>>
> > >>>>> There's also of_platform_probe() which has slightly different matching
> > >>>>> behavior. It should not behave differently either with respect to
> > >>>>> devlinks.
> > >>>>
> > >>>> So I'm trying to do this only when the top level devices are added for
> > >>>> the first time. of_platform_default_populate() seems to be the most
> > >>>> common path. For other cases, I think we just need to call
> > >>>> fw_devlink_pause/resume() wherever the top level devices are added for
> > >>>> the first time. As I said in the other email, we can't add
> > >>>> fw_devlink_pause/resume() by default to of_platform_populate().
> > >>>>
> > >>>> Do you have other ideas for achieving "call fw_devlink_pause/resume()
> > >>>> only when top level devices are added for the first time"?
> > >>>
> > >>> I'm not an expert in this domain, but before investigating it, would you
> > >>> be able to share a hack patch that implements this (in the most simple
> > >>> way) to check if it actually fixes the delays I experience on my system
> > >>> ?
> > >>
> > >> So I take it the patch I sent out didn't work for you? Can you tell me
> > >> what machine/DT you are using?
> > >
> > > I've replied to the patch:
> > >
> > > Based on v5.9-rc5, before the patch:
> > >
> > > [    0.652887] cpuidle: using governor menu
> > > [   12.349476] No ATAGs?
> > >
> > > After the patch:
> > >
> > > [    0.650460] cpuidle: using governor menu
> > > [   12.262101] No ATAGs?
> > >
> > > I'm using an AM57xx EVM, whose DT is not upstream, but it's essentially
> > > a am57xx-beagle-x15-revb1.dts (it includes that DTS) with a few
> > > additional nodes for GPIO keys, LCD panel, backlight and touchscreen.
> > >
> >
> > hope you are receiving my mails as I've provided you with all required information already [1]
> 
> Laurent/Grygorii,
> 
> Looks like I'm definitely missing emails. Sorry about the confusion.
> 
> I have some other urgent things on my plate right now. Is it okay if I
> get to this in a day or two? In the end, we'll find a solution that
> addresses most/all of the delay.

No issue on my side.

By the way, during initial investigations, I've traced code paths to
figure out if there was a particular step that would consume a large
amount of time, and found out that of_platform_populate() ends up
executing devlink-related code that seems to have an O(n^3) complexity
on the number of devices, with a few dozens of milliseconds for each
iteration. That's a very bad complexity.

-- 
Regards,

Laurent Pinchart
