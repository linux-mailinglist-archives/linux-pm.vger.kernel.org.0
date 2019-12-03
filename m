Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868DE11032E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLCRLh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:11:37 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43088 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLCRLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:11:37 -0500
Received: by mail-ua1-f67.google.com with SMTP id o42so1619623uad.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYPCalvxomeQV1CkDjlQpVsPcmQcNpZDg8Vkr5RNt0c=;
        b=bKdTNc7Wqr668+yrFz8j1YGhU16Y4rqLkEgT0+/N9W5hwVVczyND1CDzIb/zEmN4or
         2bHP9QhjOYz6WfvJ+Uq2fWdbM7ZtOHw2di6BzZe4Hd7noLUUTwrNS9n5N4BWuadig+8l
         8IQydC1LrLzd5Z2rsMXECRfDDPB0D6vVOUfgIHEk0wcVfqDTFM7plsDknpyigh+8gDEy
         mHsP9jSD2KGAjqoYOfz60YmYF1OfW3bOVYXq5maVMfSuI9HbTdjrpz58U+pL2m1Ny327
         X189Fy9UqvQ4FfmsqPlqxJ9CR0a5L5cjOOiPOXObew+1plAdkEtsf9/4MLWcy9vXQvXh
         kX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYPCalvxomeQV1CkDjlQpVsPcmQcNpZDg8Vkr5RNt0c=;
        b=gRlTAXhbdo8/WYGXPS4Zo4VpDTNXsXhQbnjM0OEl1vLZ3eyHZ9puv16daCH/iyCDQo
         TXZFjfXdxkRwnt3tZCBQlbvm2Bdz7lBQwZ2gp4BeXj1BymbsXnlyRL8LduHury5eT9XZ
         0Mtbhqj7XGUvTckQnTwjqEup21rgf38F5Il6XwE8aoiF2pcLJRnuoKNnsMWHVqCMhAbg
         Qy0Dim3kgaa6hP+nTiNDyGr0Xn2fJI/ELyd7BL1L00Q8RG1DXh0ppj5ZfBF/gO9NPRxg
         MhNtV7MmNTfkWdtvfBnEd8HdxcFTDZi3gOG54OEiskfW5776XJgTHISjGUfO5OqOdAW6
         0BXg==
X-Gm-Message-State: APjAAAW5/lf9U19IpKk3R3JVxITBuW/yBcquUXZFMlOnWDeyTaRWVy36
        uYW8aK2WfTj1GTFYjmrT+ARzymMFq01YpNceBUuM7Q==
X-Google-Smtp-Source: APXvYqyrsPU83KSAbx46fxu4fPfOtzF6WCy9KBLD8pLeQB+6NEVYfCLKfKR/4scTI3JPZVvBxWqUo13V18lIgWoem78=
X-Received: by 2002:a9f:3f46:: with SMTP id i6mr3994929uaj.60.1575393096169;
 Tue, 03 Dec 2019 09:11:36 -0800 (PST)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-4-git-send-email-thara.gopinath@linaro.org> <CAHLCerOCt9VBizAHu+y+CmzFmz-ktqCJgcB_NeC3WC4W9YBvAQ@mail.gmail.com>
In-Reply-To: <CAHLCerOCt9VBizAHu+y+CmzFmz-ktqCJgcB_NeC3WC4W9YBvAQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Dec 2019 22:41:24 +0530
Message-ID: <CAHLCerMq=jGmpvw9XCfkj8z=m+5--E8Ku4-GxYAcDbSm9-ZoTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] thermal: core: Add late init hook to cooling
 device ops
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 10:34 PM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Thu, Oct 17, 2019 at 1:07 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
> >
> > Add a hook in thermal_cooling_device_ops to be called after
> > the cooling device has been initialized and registered
> > but before binding it to a thermal zone.
> >
> > In this patch series it is used to hook up a power domain
> > to the device pointer of cooling device.
> >
> > It can be used for any other relevant late initializations
> > of a cooling device as well.
>
> Please describe WHY this hook is needed.

Just noticed you dropped this for v4. Nevermind.

> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > ---
> >  drivers/thermal/thermal_core.c | 13 +++++++++++++
> >  include/linux/thermal.h        |  1 +
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 886e8fa..c2ecb73 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -994,6 +994,19 @@ __thermal_cooling_device_register(struct device_node *np,
> >         list_add(&cdev->node, &thermal_cdev_list);
> >         mutex_unlock(&thermal_list_lock);
> >
> > +       /* Call into cdev late initialization if defined */
> > +       if (cdev->ops->late_init) {
> > +               result = cdev->ops->late_init(cdev);
> > +               if (result) {
> > +                       ida_simple_remove(&thermal_cdev_ida, cdev->id);
> > +                       put_device(&cdev->device);
> > +                       mutex_lock(&thermal_list_lock);
> > +                       list_del(&cdev->node);
> > +                       mutex_unlock(&thermal_list_lock);
> > +                       return ERR_PTR(result);
> > +               }
> > +       }
> > +
> >         /* Update binding information for 'this' new cdev */
> >         bind_cdev(cdev);
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index e45659c..e94b3de 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -125,6 +125,7 @@ struct thermal_cooling_device_ops {
> >                            struct thermal_zone_device *, unsigned long, u32 *);
> >         int (*power2state)(struct thermal_cooling_device *,
> >                            struct thermal_zone_device *, u32, unsigned long *);
> > +       int (*late_init)(struct thermal_cooling_device *);
> >  };
> >
> >  struct thermal_cooling_device {
> > --
> > 2.1.4
> >
