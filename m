Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAD7D1A2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfGaXAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 19:00:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38532 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGaXAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 19:00:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so52076112oie.5;
        Wed, 31 Jul 2019 16:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1XGA7+OOT5M94yaSPtFGkRyMp9RBaIxbFA4iWh0TPU=;
        b=oir4h7Qbwxjou/TsIYiSWBpO5s7T+pl0WM4ye2uPEBT2APk0dqegCcdXBNm3ZY1/JY
         z18bACf5lRlOVW/HkHXdsV5v8xGNImn4mE55pWayZqNdZdQcfQ8bMfJ4KyMYfamsi4fN
         0uyoPCc72Ma413Xcn1MPqam5mupMLmTE5CT8dtsE3vb/kivq0blfH5Y0+H4pyRq+6+9x
         rpKsSHfBqg79VuF2Jg0Qsh1peZYek3236uvn8YacjjTS/Yz9J7golr9GP2rSVzy4ldaM
         7cO33hL+wE6W1F79Ymco7Z12VCmDKON9ar0twI2pyWzjr1A3TPzdUB6ovQGBBZcl5YJm
         sQ+Q==
X-Gm-Message-State: APjAAAU1GHDRncXHbjoQamqbh7E+/Ev4ZqaK5urI8DYPC8eneIB/2jG6
        HeKVenYBryt6kqofnRt4M/vOhixhDfNp3wXLCYg=
X-Google-Smtp-Source: APXvYqxyKtZ+TJkRBsq9SCAb52PyvOrYXcza7RJymYREaG9NE3KY9niyKZ+Sn4OndoXJqhnn9omlWX7RrQb2pWMtrFs=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr60392932oih.103.1564614015358;
 Wed, 31 Jul 2019 16:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher>
In-Reply-To: <6987393.M0uybTKmdI@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 01:00:03 +0200
Message-ID: <CAJZ5v0j7ZbSq45U9DFt_KsKuk30h5vB1m2a7L6qx2fRb+4kP2A@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 12:42 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > +/**
> > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > + */
> > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > +{
> > > > > +       struct device *dev;
> > > > > +       int id;
> > > > > +
> > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > >
> > > So can anyone remind me why the IDA thing is needed here at all?
> >
> > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > among wakeup_sources. That is what ends up in
> > /sys/class/wakeup/ws<ID>/* path.
>
> That's not my point (see below).
>
> > > > > +       if (id < 0)
> > > > > +               return id;
> > > > > +       ws->id = id;
> > > > > +
> > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > +                                       wakeup_source_groups, "ws%d",
> > > >
> > > > I thought the name was going to still be 'wakeupN'?
> > >
> > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> >
> > "ws%d" here is the name in the sysfs path rather than the name of the
> > wakeup source. Wakeup source name is not altered in this patch.
> >
>
> So why wouldn't something like this suffice:
>
> dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
>                                 wakeup_source_groups, "wakeup:%s", ws->name);
>
> ?

And more generally speaking, we are adding another way to identify
wakeup sources (by id), which is not related to the one we already
have (by name).  Why do we need both of them?
