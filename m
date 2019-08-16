Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534D490A6E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfHPVqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 17:46:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38261 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfHPVqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 17:46:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so3561924pga.5
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=gmTcK20VFhzJpyAdUQqTgMwvx7152jQ/nCZquZvlO1o=;
        b=HQJ3its2EmWWKhCPXHYf1fOoQVe8SOjbDSSmHwnVxdCo+kQhFYinW7HtHvK3WzjIF/
         k5CD4X+mMyNN8SthDXt614QIGAUR0jKy485gdloJZT1+s/qUgr1Rw4fvDQA2qFGXjOYR
         PtyaZV9ab4vrwR3o3MkcSCDPodLfRhHj1T2ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=gmTcK20VFhzJpyAdUQqTgMwvx7152jQ/nCZquZvlO1o=;
        b=DoleTd5RB39EZIRvXtXdCylKpOhTN8GsSM8oiK3cAfYzynZ7DOEhoHd/j+aWOtC6XP
         O9tzDmphEPA7wemJX1Gg7qxZv4S+VFOmNaq5v3KQ7d5+L+c2HYq7bbFFvmXRxUsQ1iPS
         /RLRzEeahxJykOW1n1MKcOmEbB6lUQ2JFzlXIZm5MrA/NcJ/cUshUGLqDJZod/h6Whp9
         b9Rhu/PCgHR2Q2KkTQvVm7NNQ1Kya48MAH8rnyLtWDFPSWQlo+VK3GmPhusIV5rpYsED
         wJymb4izZ0zDmHQ1DCM3uuYwGvztqvgcQbzWDdgMjw5DMgJgd0ORox19MuMlasheEjCh
         YZzg==
X-Gm-Message-State: APjAAAXPxNj1Jcti1p725l1hhbHpwqyU7xOfdtXJghtYed1TtWylYs6m
        lT2QG1XgQ/06mhsUAhvbJCBnfMA7RoWIgQ==
X-Google-Smtp-Source: APXvYqxC6w3p8TV+4amz1vlQWiAeDhF3PHlfUQeUspUO6UzVAEuOj5UgY2ux36waJExqyv5uWobG7A==
X-Received: by 2002:a63:eb51:: with SMTP id b17mr9230742pgk.384.1565991981451;
        Fri, 16 Aug 2019 14:46:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e24sm6220844pgk.21.2019.08.16.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:46:20 -0700 (PDT)
Message-ID: <5d57242c.1c69fb81.bba86.14f6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com>
References: <20190816145602.231163-1-swboyd@chromium.org> <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Register wakeup class kobj after device is added
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 14:46:19 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-16 14:27:35)
> On Fri, Aug 16, 2019 at 7:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index 1b9c281cbe41..27ee00f50bd7 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/export.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeup.h>
> >  #include <linux/atomic.h>
> >  #include <linux/jiffies.h>
> >  #include "power.h"
> > @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
> >                 if (rc)
> >                         goto err_runtime;
> >         }
> > +       if (dev->power.wakeup) {
>=20
> This conditional checks for the situation when wakeup source
> registration have been previously attempted, but failed at
> wakeup_source_sysfs_add(). My concern is that it's not easy to
> understand what this check does without knowing exactly what
> device_wakeup_enable() does to dev->power.wakeup before we reach this
> point.

Oh, actually this is wrong. It should be a check for
dev->power.wakeup->dev being non-NULL. That's the variable that's set by
wakeup_source_sysfs_add() upon success. So I should make it:

	if (dev->power.wakeup && !dev->power.wakeup->dev)

And there's the problem that CONFIG_PM_SLEEP could be unset. Let me fix
it up with a new inline function like device_has_wakeup_dev().

>=20
> > +               rc =3D wakeup_source_sysfs_add(dev, dev->power.wakeup);
> > +               if (rc)
> > +                       goto err_wakeup;
> > +       }
> >         if (dev->power.set_latency_tolerance) {
> >                 rc =3D sysfs_merge_group(&dev->kobj,
> >                                        &pm_qos_latency_tolerance_attr_g=
roup);
> >                 if (rc)
> > -                       goto err_wakeup;
> > +                       goto err_wakeup_source;
> >         }
> >         return 0;
> >
> > + err_wakeup_source:
> > +       wakeup_source_sysfs_remove(dev->power.wakeup);
> >   err_wakeup:
> >         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> >   err_runtime:
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index f7925820b5ca..5817b51d2b15 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(stru=
ct device *dev,
> >
> >         ws =3D wakeup_source_create(name);
> >         if (ws) {
> > -               ret =3D wakeup_source_sysfs_add(dev, ws);
> > -               if (ret) {
> > -                       wakeup_source_free(ws);
> > -                       return NULL;
> > +               if (!dev || device_is_registered(dev)) {
>=20
> Is there a possible race condition here? If dev->power.wakeup check in
> dpm_sysfs_add() is done at the same time as device_is_registered(dev)
> check here, then wakeup_source_sysfs_add() won't ever be called?

The same race exists for device_set_wakeup_capable() so I didn't bother
to try to avoid it. I suppose wakeup_source_sysfs_add() could run
completely, allocate the device and set the name, etc., but not call
device_add() and then we can set ws->dev and call device_add() under a
mutex so that we keep a very small window where the wakeup class is
published to sysfs. Or just throw a big mutex around the whole wakeup
class creation path so that there isn't a chance of a race. But really,
is anyone going to call device_set_wakeup_*() on a device that is also
being added to the system? Seems unlikely.

>=20
> > +                       ret =3D wakeup_source_sysfs_add(dev, ws);
> > +                       if (ret) {
> > +                               wakeup_source_free(ws);
