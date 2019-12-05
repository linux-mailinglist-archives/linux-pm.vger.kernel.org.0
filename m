Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F5113C17
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 08:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLEHGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 02:06:14 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38505 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEHGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 02:06:13 -0500
Received: by mail-ua1-f66.google.com with SMTP id z17so850152uac.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 23:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48H2Q0jce9hn5rPUGQ82lc7wKpQZ76ct4p8NjtF+Ank=;
        b=cSwCAmAhhA34fp0Z+ZFycH7GsX4J14HDAlz/cvLxWTGHVoYtg9rfokW3BLdHPH6dcv
         /jw2LyCRANBXWPJ/IvdnvPakkj33hzDx9xaEXaBNudPdCk6XcHUD1XY1VQ7KUlg01Nzf
         2OmoQ6D9S3BDYtkknoVRwztIt1INWToD/eFSA8C0ccdsQBi0ndiyQsGD2WkS2xkehwzs
         r4M6YfmDGwmJ+zVmko9ucf74ySszsSALebJWqGaQNh3Nrfrhra6SSwmLGh5aCnEWiYyW
         JCByf0CyQ7mjw4F55PQxDSNEHSDaYtQhCTsJhMtAFKDeTiekrXiCyZd3r8J6TXwIeKMq
         q5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48H2Q0jce9hn5rPUGQ82lc7wKpQZ76ct4p8NjtF+Ank=;
        b=gO4FI9bKZAltMO8cgdEbnnp7o7PkVak5mYaN5OS3ii55WSQLTIQQjOlTungyBNjNWq
         2YBa4/M/jz+FlUjp1nKimQGbyYwUuehWa7mDcp4pN4WdKap7BuzhNYC334pq/9UktuOL
         ler/3QEhEhxAiCoymM8jEMM5rzVOvRpkbh6XM/ylTzdzywWogctmalbUAcDjLsRSwSd6
         z/ijNJNfsC1ugxhUZGICq4fWmT/xq/UqVx5HUhgdWjpsJU0S/m5vCzVzrv/q9JI9+E0Z
         LQ7pW+Ft2/bRPpISKano20/lRMKAv5BQyo9uKDY9C2AIqnf6UX7hlN2roQdwd5RxQeaA
         h4GA==
X-Gm-Message-State: APjAAAXRoy0gfP18EdlodWZU5vE5tFg9kzN07iUcIGPRqK/xDmg20acR
        sscSK4nYOFKh10tKrAEgu88rMxtmj3263UomI0gOvQ==
X-Google-Smtp-Source: APXvYqwklVCdNCEdlx6N7sxXlxs5vA7J+OTW4/szRcO2OJXYlZUs17GktD8/GHgUPR0Q9nVTr62JZntZI2vtL3Lmx8I=
X-Received: by 2002:ab0:7352:: with SMTP id k18mr5729489uap.77.1575529572190;
 Wed, 04 Dec 2019 23:06:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com> <20191204215618.125826-2-wvw@google.com>
 <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com>
 <CAGXk5yr=jfXq+n7oB0sc=6LT0raURmQ9rgFWqrg0hxMDKYFDig@mail.gmail.com> <CAHLCerOpv3Dqd7AB6=EEUUMpTWujNeLok3=ZpLntCdvHewGyww@mail.gmail.com>
In-Reply-To: <CAHLCerOpv3Dqd7AB6=EEUUMpTWujNeLok3=ZpLntCdvHewGyww@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Dec 2019 12:36:01 +0530
Message-ID: <CAHLCerNT0p7cj+yAhJbNbqCkQguu8AMyngwuvbxaQYTSAB5GPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 11:56 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Thu, Dec 5, 2019 at 11:44 AM Wei Wang <wvw@google.com> wrote:
> >
> > On Wed, Dec 4, 2019 at 8:13 PM Amit Kucheria
> > <amit.kucheria@verdurent.com> wrote:
> > >
> > > Hi Wei,
> > >
> > > On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
> > > >
> > > > Make cooling device registration behavior consistent with
> > >
> > > Consistent how? Please add details.
> > >
> > Consistent with
> > https://lore.kernel.org/linux-pm/1478581767-7009-2-git-send-email-edubezval@gmail.com/

Studying this a bit more, git blame pointed to this SHA[1] that fixed
it so that NULL value for 'type' is allowed, we just check for it.
However, none of the users of thermal_cooling_device_register() seem
to pass NULL.

Rui, any insight into the history of why we would NOT want to create a
sysfs attribute by passing NULL? Do we still need to allow for NULL
values or should we cleanup the API to prevent NULL values?

[1] 204dd1d39c32f39a95


> >
> > will include aboce in next version.
>
> Thanks.
>
> >
> > > > thermal zone. This patch also cleans up a unnecessary
> > > > nullptr check.
> > > >
> > > > Signed-off-by: Wei Wang <wvw@google.com>
> > > > ---
> > > >  drivers/thermal/thermal_core.c | 16 ++++++++++++----
> > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > > index d4481cc8958f..64fbb59c2f44 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
> > > >         struct thermal_zone_device *pos = NULL;
> > > >         int result;
> > > >
> > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > > -               return ERR_PTR(-EINVAL);
> > > > +       if (!type || !type[0]) {
> > > > +           pr_err("Error: No cooling device type defined\n");
> > > > +           return ERR_PTR(-EINVAL);
> > > > +       }
> > > > +
> > > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > > > +           pr_err("Error: Cooling device name (%s) too long, "
> > > > +                  "should be under %d chars\n", type, THERMAL_NAME_LENGTH);
> > >
> > > Consider fitting into a single greppable string as "Error: Cooling
> > > device name over %d chars: %s\n"
> > >
> > Was intentionally keep it the same as this
> > https://lore.kernel.org/linux-pm/31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org/
> > Will make it shorter in both places next verion
>
> Yes please, make it a separate patch. We didn't catch it during review.
>
> >
> > > > +           return ERR_PTR(-EINVAL);
> > > > +       }
> > > >
> > > >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > > >             !ops->set_cur_state)
> > > > @@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
> > > >         }
> > > >
> > > >         cdev->id = result;
> > > > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > > > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> > > >         mutex_init(&cdev->lock);
> > > >         INIT_LIST_HEAD(&cdev->thermal_instances);
> > > >         cdev->np = np;
> > > > @@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> > > >                 return ERR_PTR(-EINVAL);
> > > >         }
> > > >
> > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> > > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > > >                 pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> > > >                        type, THERMAL_NAME_LENGTH);
> > > >                 return ERR_PTR(-EINVAL);
> > > > --
> > > > 2.24.0.393.g34dc348eaf-goog
> > > >
