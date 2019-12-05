Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9EC113CA7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 08:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEH4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 02:56:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:20787 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfLEH4k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 02:56:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 23:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; 
   d="scan'208";a="209067399"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2019 23:56:38 -0800
Message-ID: <a9d9bc3b6ab7b6621157c61da92e55f9c7de0da1.camel@intel.com>
Subject: Re: [PATCH v2 1/2] thermal: fix and clean up tz and cdev
 registration
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Dec 2019 15:56:37 +0800
In-Reply-To: <CAHLCerNT0p7cj+yAhJbNbqCkQguu8AMyngwuvbxaQYTSAB5GPA@mail.gmail.com>
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
         <20191204215618.125826-1-wvw@google.com>
         <20191204215618.125826-2-wvw@google.com>
         <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com>
         <CAGXk5yr=jfXq+n7oB0sc=6LT0raURmQ9rgFWqrg0hxMDKYFDig@mail.gmail.com>
         <CAHLCerOpv3Dqd7AB6=EEUUMpTWujNeLok3=ZpLntCdvHewGyww@mail.gmail.com>
         <CAHLCerNT0p7cj+yAhJbNbqCkQguu8AMyngwuvbxaQYTSAB5GPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-12-05 at 12:36 +0530, Amit Kucheria wrote:
> On Thu, Dec 5, 2019 at 11:56 AM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> > 
> > On Thu, Dec 5, 2019 at 11:44 AM Wei Wang <wvw@google.com> wrote:
> > > 
> > > On Wed, Dec 4, 2019 at 8:13 PM Amit Kucheria
> > > <amit.kucheria@verdurent.com> wrote:
> > > > 
> > > > Hi Wei,
> > > > 
> > > > On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
> > > > > 
> > > > > Make cooling device registration behavior consistent with
> > > > 
> > > > Consistent how? Please add details.
> > > > 
> > > 
> > > Consistent with
> > > 
https://lore.kernel.org/linux-pm/1478581767-7009-2-git-send-email-edubezval@gmail.com/
> 
> Studying this a bit more, git blame pointed to this SHA[1] that fixed
> it so that NULL value for 'type' is allowed, we just check for it.
> However, none of the users of thermal_cooling_device_register() seem
> to pass NULL.
> 
> Rui, any insight into the history of why we would NOT want to create
> a
> sysfs attribute by passing NULL?

Actually, I don't recall there is any requirement that wants to
register a cooling_device without "type".

>  Do we still need to allow for NULL
> values or should we cleanup the API to prevent NULL values?
> 
well, my suggestion is to make this (do NULL check) a separate patch
and see if we have any complains, if yes, we can revert it easily.

thanks,
rui

> [1] 204dd1d39c32f39a95
> 
> 
> > > 
> > > will include aboce in next version.
> > 
> > Thanks.
> > 
> > > 
> > > > > thermal zone. This patch also cleans up a unnecessary
> > > > > nullptr check.
> > > > > 
> > > > > Signed-off-by: Wei Wang <wvw@google.com>
> > > > > ---
> > > > >  drivers/thermal/thermal_core.c | 16 ++++++++++++----
> > > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/thermal/thermal_core.c
> > > > > b/drivers/thermal/thermal_core.c
> > > > > index d4481cc8958f..64fbb59c2f44 100644
> > > > > --- a/drivers/thermal/thermal_core.c
> > > > > +++ b/drivers/thermal/thermal_core.c
> > > > > @@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct
> > > > > device_node *np,
> > > > >         struct thermal_zone_device *pos = NULL;
> > > > >         int result;
> > > > > 
> > > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > > > -               return ERR_PTR(-EINVAL);
> > > > > +       if (!type || !type[0]) {
> > > > > +           pr_err("Error: No cooling device type
> > > > > defined\n");
> > > > > +           return ERR_PTR(-EINVAL);
> > > > > +       }
> > > > > +
> > > > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > > > > +           pr_err("Error: Cooling device name (%s) too long,
> > > > > "
> > > > > +                  "should be under %d chars\n", type,
> > > > > THERMAL_NAME_LENGTH);
> > > > 
> > > > Consider fitting into a single greppable string as "Error:
> > > > Cooling
> > > > device name over %d chars: %s\n"
> > > > 
> > > 
> > > Was intentionally keep it the same as this
> > > 
https://lore.kernel.org/linux-pm/31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org/
> > > Will make it shorter in both places next verion
> > 
> > Yes please, make it a separate patch. We didn't catch it during
> > review.
> > 
> > > 
> > > > > +           return ERR_PTR(-EINVAL);
> > > > > +       }
> > > > > 
> > > > >         if (!ops || !ops->get_max_state || !ops-
> > > > > >get_cur_state ||
> > > > >             !ops->set_cur_state)
> > > > > @@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct
> > > > > device_node *np,
> > > > >         }
> > > > > 
> > > > >         cdev->id = result;
> > > > > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > > > > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> > > > >         mutex_init(&cdev->lock);
> > > > >         INIT_LIST_HEAD(&cdev->thermal_instances);
> > > > >         cdev->np = np;
> > > > > @@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char
> > > > > *type, int trips, int mask,
> > > > >                 return ERR_PTR(-EINVAL);
> > > > >         }
> > > > > 
> > > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> > > > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > > > >                 pr_err("Error: Thermal zone name (%s) too
> > > > > long, should be under %d chars\n",
> > > > >                        type, THERMAL_NAME_LENGTH);
> > > > >                 return ERR_PTR(-EINVAL);
> > > > > --
> > > > > 2.24.0.393.g34dc348eaf-goog
> > > > > 

