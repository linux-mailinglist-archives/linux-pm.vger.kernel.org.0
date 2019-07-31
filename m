Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4407D1DF
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 01:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfGaX1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 19:27:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46742 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfGaX1f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 19:27:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so52093977oid.13
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tl5pYeZ72qtvUfn4lyn1cjKCDdQYMVgYKeR/aYm1DhE=;
        b=v47GlmL8kD1utdUfl8QhSsYQ4Ycd1eqmlLIHQozoHfiH8imsFoYdxlYhZfXBlHKFOj
         uc6mUixJlfqK2Ks7KZrES+UXs3+sQ+cRBxjYePOuqQaWoYycbs3/Uee7taScQRy8QISM
         3owBKhe1Przm4WbIC7G+XSYIy/zAqp8IlFfNkg17DwlXCEoPRmT/hvTqqsFF2nA57OYy
         XH++6DrmmoxUbh+d6ESIDCalkrsni5GDPUaMhoLe+JHbWReauiXTwZUKmosfI3M//lT5
         o9UOiMzDqvjjctii9bqV4cS9Ej+khBG6LKgnKtr6NkUqgvP3cFHkcQW/BHJTthIuY1px
         kgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl5pYeZ72qtvUfn4lyn1cjKCDdQYMVgYKeR/aYm1DhE=;
        b=p4onqAqTCtR8QD/9Aoy/KhEO4U2OHDoWfZqmrfEhk292AUzIxVFkDYIhh943UYEk7D
         b4r/NmqOw4ydzFHv9TpiSRVSRQ8zxiMi2+cP350O5f2Kzgbvx/Sce03LlmSif6fuurpU
         L8/inaE9FiOcU0IS5aPlJ0Xb4IzjJz1VmHA6iRjrcD/xkwaQlgQ5ODAg2+Z2j914kacF
         YneOHj2PpnwW5AmdoXEQCP3RI8YuxW/HBnTMnPrE+rUiOwrYfGoVevr6k720jgHb9ETl
         IjrGj5cMZxn37Ds70GthKgvq5Mm+NkLW25C7yxcH7PrJXtoKwm1knlSQZgRY9jNKFqV8
         rygw==
X-Gm-Message-State: APjAAAUbr+wxfGeTtBzBoFpZl8TpgISjovr1WIW5Qnf1NiUbxp/yRloS
        7Qtd3+bMiaCoYRujKS+Ne4EGWInpgW5zSlxWQF4=
X-Google-Smtp-Source: APXvYqyppFnT/zO2PIEGT6+0P4UqCcqPeWL48szxnJE54BD9KxbK4wyAaRAVfkEEU0cRzX4ZhboJkbq9bcf/MYP1XpA=
X-Received: by 2002:aca:3509:: with SMTP id c9mr64322694oia.179.1564615654731;
 Wed, 31 Jul 2019 16:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 16:27:23 -0700
Message-ID: <CANA+-vDikTE21qOYcvtduqaqPkEaK+8d46A1ReV5VDEZ_O49ww@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Wed, Jul 31, 2019 at 4:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > > > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > > > +/**
> > > > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > > > + */
> > > > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > > > +{
> > > > > > > +       struct device *dev;
> > > > > > > +       int id;
> > > > > > > +
> > > > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > > > >
> > > > > So can anyone remind me why the IDA thing is needed here at all?
> > > >
> > > > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > > > among wakeup_sources. That is what ends up in
> > > > /sys/class/wakeup/ws<ID>/* path.
> > >
> > > That's not my point (see below).
> > >
> > > > > > > +       if (id < 0)
> > > > > > > +               return id;
> > > > > > > +       ws->id = id;
> > > > > > > +
> > > > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > > +                                       wakeup_source_groups, "ws%d",
> > > > > >
> > > > > > I thought the name was going to still be 'wakeupN'?
> > > > >
> > > > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> > > >
> > > > "ws%d" here is the name in the sysfs path rather than the name of the
> > > > wakeup source. Wakeup source name is not altered in this patch.
> > > >
> > >
> > > So why wouldn't something like this suffice:
> > >
> > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > >
> > > ?
> >
> > ws->name is inherited from the device name. IIUC device names are not
> > guaranteed to be unique. So if different devices with the same name
> > register wakeup sources, there is an error.
>
> OK
>
> So I guess the names are retained for backwards compatibility with
> existing user space that may be using them?

Yes, in Android we do rely on the name to aggregate statistics across
a fleet of devices. That wouldn't be possible with just the id, as
those are generated at dynamically runtime.
>
> That's kind of fair enough, but having two different identification
> schemes for wakeup sources will end up confusing.

It's not without precedent though. rtc, input, and other devices have
a similar scheme.
