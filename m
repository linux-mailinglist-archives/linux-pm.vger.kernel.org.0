Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FA29A357
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 04:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgJ0Dag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 23:30:36 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35012 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440930AbgJ0Dag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 23:30:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id m188so53304ybf.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 20:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgpV19NIPOwsC536pNKEm7qeTuOSm4UvN7w5snlJtXA=;
        b=KRWsB60LNFRJT1Lrs5d58UfoikPtp5nt/O/InxTKpzH5jpwzF7y9esv+tT2zjN62yR
         Z+6O2gkFwcROcilrjgMove1ClAR6malt82NyWDod+D8JzkGSsk/yyn9K+hgQj5JtkxQJ
         5+jDDdZEfedg4n82m4IZgfdudoOYMyzEAhwU7H3VfPH/mLCLDr8uqzt5Y/5ElnZkB9tP
         OSxe4AugpujEFHkDtOW/wWycFH/o32gnuDon9GsYbsB++apBdI9jT79sklvBilmcG4bJ
         FYc5fVEXDXVCzA4f7qNif3NvvsvnbLIpk5+J91adQXh2WGO9GKaiXcXWsm1MaYXhZKg8
         EkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgpV19NIPOwsC536pNKEm7qeTuOSm4UvN7w5snlJtXA=;
        b=Vm4M/z8FuM+ka2kWQYrtIp9DdlE3VN/UOQehgfxCLbhV1Bt8uAcG566rQS92u2J1ox
         +C9VPQ3y/BZWB/UpFYDqwolzv10GhCjy61gmb7rL/gTkwlVv0ZzvSDXfbWA9XZp9SG0a
         fSTR9krHxYGBeONYL51aFgTquXUhzzbwC+npEkU3VTyWjQGJWgI6+vh/QJTuCgYs2gBB
         y6X34ytU4XEVXqkYPXVmMQr+qa0/q/jcsb0CfH0yceXMdI+qLdyxXdzwWChKkhwYbAjf
         PZSvOSJmDnuozrfBtzOxrU15GkHq2KPtOKsrIsX2aTn1fFosQ6OrZUut7LmIlfWbKKZM
         lCQA==
X-Gm-Message-State: AOAM530zlXJYa+ssE+1amlNktll7k2KATAz9NvIsfBCcsDuc96PsPduM
        0xntiikO3wohXoO8kx+0Vd/CVMqJC5uD7i8zCAoOng==
X-Google-Smtp-Source: ABdhPJw73jUszV9tqbPYtoH3T3cC0JPWJb13BMkaU+CnEmRIClEot2S71JQhsrz9YU9G9FRKu9hq9XEcY4UbNyxMotg=
X-Received: by 2002:a25:7452:: with SMTP id p79mr344716ybc.346.1603769432917;
 Mon, 26 Oct 2020 20:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com> <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
 <20201002175423.GE3933@pendragon.ideasonboard.com> <CAGETcx-7nJaU6pDo_KL-nKmCaxv57C5aaXq-pvo4XiN=N0K5Jg@mail.gmail.com>
 <20201002182712.GF3933@pendragon.ideasonboard.com> <11018e7e-a6a1-2df6-5639-821a7c0cb68b@ti.com>
 <CAGETcx8DCiEJy-1PiHheyuuw3YBYfFh67MBcOwv4JEviXmsp3Q@mail.gmail.com> <20201003001342.GA1730@pendragon.ideasonboard.com>
In-Reply-To: <20201003001342.GA1730@pendragon.ideasonboard.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Oct 2020 20:29:56 -0700
Message-ID: <CAGETcx8Vy2k8igc9QmktFohJSQXvdPTFYu8i_8tgeYvBLk6QfA@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 2, 2020 at 5:14 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Saravana,
>
> On Fri, Oct 02, 2020 at 12:56:30PM -0700, Saravana Kannan wrote:
> > On Fri, Oct 2, 2020 at 11:35 AM 'Grygorii Strashko' via kernel-team wrote:
> > > On 02/10/2020 21:27, Laurent Pinchart wrote:
> > > > On Fri, Oct 02, 2020 at 10:58:55AM -0700, Saravana Kannan wrote:
> > > >> On Fri, Oct 2, 2020 at 10:55 AM Laurent Pinchart wrote:
> > > >>> On Fri, Oct 02, 2020 at 10:51:51AM -0700, Saravana Kannan wrote:
> > > >>>> On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >>>>> On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >>>>>>
> > > >>>>>> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > > >>>>>> adding all top level devices") optimized the fwnode parsing when all top
> > > >>>>>> level devices are added, it missed out optimizing this for platform
> > > >>>>>> where the top level devices are added through the init_machine() path.
> > > >>>>>>
> > > >>>>>> This commit does the optimization for all paths by simply moving the
> > > >>>>>> fw_devlink_pause/resume() inside of_platform_default_populate().
> > > >>>>>>
> > > >>>>>> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > >>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >>>>>> ---
> > > >>>>>>   drivers/of/platform.c | 19 +++++++++++++++----
> > > >>>>>>   1 file changed, 15 insertions(+), 4 deletions(-)
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > >>>>>> index 071f04da32c8..79972e49b539 100644
> > > >>>>>> --- a/drivers/of/platform.c
> > > >>>>>> +++ b/drivers/of/platform.c
> > > >>>>>> @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
> > > >>>>>>                                   const struct of_dev_auxdata *lookup,
> > > >>>>>>                                   struct device *parent)
> > > >>>>>>   {
> > > >>>>>> -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> > > >>>>>> -                                   parent);
> > > >>>>>> +       int ret;
> > > >>>>>> +
> > > >>>>>> +       /*
> > > >>>>>> +        * fw_devlink_pause/resume() are only safe to be called around top
> > > >>>>>> +        * level device addition due to locking constraints.
> > > >>>>>> +        */
> > > >>>>>> +       if (!root)
> > > >>>>>> +               fw_devlink_pause();
> > > >>>>>> +
> > > >>>>>> +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> > > >>>>>> +                                  parent);
> > > >>>>>
> > > >>>>> of_platform_default_populate() vs. of_platform_populate() is just a
> > > >>>>> different match table. I don't think the behavior should otherwise be
> > > >>>>> different.
> > > >>>>>
> > > >>>>> There's also of_platform_probe() which has slightly different matching
> > > >>>>> behavior. It should not behave differently either with respect to
> > > >>>>> devlinks.
> > > >>>>
> > > >>>> So I'm trying to do this only when the top level devices are added for
> > > >>>> the first time. of_platform_default_populate() seems to be the most
> > > >>>> common path. For other cases, I think we just need to call
> > > >>>> fw_devlink_pause/resume() wherever the top level devices are added for
> > > >>>> the first time. As I said in the other email, we can't add
> > > >>>> fw_devlink_pause/resume() by default to of_platform_populate().
> > > >>>>
> > > >>>> Do you have other ideas for achieving "call fw_devlink_pause/resume()
> > > >>>> only when top level devices are added for the first time"?
> > > >>>
> > > >>> I'm not an expert in this domain, but before investigating it, would you
> > > >>> be able to share a hack patch that implements this (in the most simple
> > > >>> way) to check if it actually fixes the delays I experience on my system
> > > >>> ?
> > > >>
> > > >> So I take it the patch I sent out didn't work for you? Can you tell me
> > > >> what machine/DT you are using?
> > > >
> > > > I've replied to the patch:
> > > >
> > > > Based on v5.9-rc5, before the patch:
> > > >
> > > > [    0.652887] cpuidle: using governor menu
> > > > [   12.349476] No ATAGs?
> > > >
> > > > After the patch:
> > > >
> > > > [    0.650460] cpuidle: using governor menu
> > > > [   12.262101] No ATAGs?
> > > >
> > > > I'm using an AM57xx EVM, whose DT is not upstream, but it's essentially
> > > > a am57xx-beagle-x15-revb1.dts (it includes that DTS) with a few
> > > > additional nodes for GPIO keys, LCD panel, backlight and touchscreen.
> > > >
> > >
> > > hope you are receiving my mails as I've provided you with all required information already [1]
> >
> > Laurent/Grygorii,
> >
> > Looks like I'm definitely missing emails. Sorry about the confusion.
> >
> > I have some other urgent things on my plate right now. Is it okay if I
> > get to this in a day or two? In the end, we'll find a solution that
> > addresses most/all of the delay.
>
> No issue on my side.

Hi Laurent,

Sorry it took awhile for me to get back to this.

Can you try throwing around fw_devlink_pause/resume() around the
of_platform_populate() call in arch/arm/mach-omap2/pdata-quirks.c?
Just trying to verify the cause/fix.

If it fixes the issue, then considering Rob's comments [1], a good
short term solution might be to have the suggestion above and some way
to do pause/resume only when the top level devices are added.

> By the way, during initial investigations, I've traced code paths to
> figure out if there was a particular step that would consume a large
> amount of time, and found out that of_platform_populate() ends up
> executing devlink-related code that seems to have an O(n^3) complexity
> on the number of devices, with a few dozens of milliseconds for each
> iteration. That's a very bad complexity.

As you said, the complexity of fw_devlink parsing can be O(N^2). There
are other ways to improve it to make it O(N) but it has a bunch of
additional complexity and memory increase. When I tried to do it that
way the first time, I was question whether O(N^2) actually translated
to measurable difference. Looks like we do now :) I have something in
mind for how to do it with O(N) complexity, but I expect it to take a
while to get in. So in the meantime, I'm thinking of using
fw_devlink_pause/resume() as a short term optimization.

-Saravana

[1] - https://lore.kernel.org/linux-omap/CAL_Jsq+6mxtFei3+1ic4c5XCftJ8nZK6_S5_d15yEXQ02BTNKw@mail.gmail.com/
