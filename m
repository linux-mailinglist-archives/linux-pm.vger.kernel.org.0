Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAB1172E0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 18:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLIRep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 12:34:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39325 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 12:34:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id v16so13402477edy.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqGWgekCxDubwDbyQN/6yZHuFRZ1dg3jUzpNTfM9+xY=;
        b=gQTZrrf4vN8IBztt71aOzBZf8fdXSZ0eVtga7ZrfIAjwHB+D4J+M5Gc6L1lqW8B1ed
         2hCTiPcUFtkv1eE5pJ8WY5g1/EQiv133HBNom2s1cRHxGXsQzapUnWhENnTMW88DS0V0
         X+MOu2GLoqpNrLhY1i9kD/6WjHXWDUd8rL4Okz0SphkUCDd3igh/0rzDdH9xY6iggk97
         n/J4eEH161Cj05AB/ESQ2pCmsWfJ3Or66VZdoF6TJJXvpqjWGTkobDE7Z+WOwP/P33vo
         1/r0SEQ509ttPWpW6Ir9mHvPzwSGe+e9bwI+Xks5GVVqRrLSU/BcZlXHZ9zeFuYKsGKH
         sbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqGWgekCxDubwDbyQN/6yZHuFRZ1dg3jUzpNTfM9+xY=;
        b=COGxrL6akJY1dbBUG21EPK9BoBsJIzpVrq0YSjrbOuc8bwwIj1CGHYAjSn4C4CofuX
         47OQ4Ij43t9gYOnr5eh7aRZu8Gz/D14fDoUuswIMy3iH4FZaLTIUeeWCVblZMQw3h40H
         1wDrVUigDl6i7tn92QUHdUgD12rgOzk/J6mQ5/VDU3qZKsHPPSSjZZq1KZijAGwuETTv
         2PC5GjGHCuVS08y7zMAcugvM5S0ibEH25/RSl3UxBpI6bYapDq220qieC37mJL4siKzA
         0A3JeR930AgRIwZ3b2VVJkl6OchGtgd/hVhHXFMPy3pGLVTRauvNJY1sEL+OMaK25SYz
         v+Rw==
X-Gm-Message-State: APjAAAUkCJC0TduImDvEyWkPtu59+pl75ld0jqC9LrY9pay5/U5x+Db6
        ZVi2Y58EF1aipUh65TmRH2zrqBwvPEL/Rk6oFcPeqA==
X-Google-Smtp-Source: APXvYqxbnJ4K1dmT7UAnkHHGB8sYwJAHvtz+y4Cpn1GujHOMPOb23yrCn28dziXqoH6a2Nzeh2ZTilyr6s+P03U6XxU=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr9011744ejq.329.1575912882849;
 Mon, 09 Dec 2019 09:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-2-wvw@google.com>
 <CAHLCerOFUTrg+sJJVaP0wpRErhDdfNebfM4OAOepH4RfXopvQg@mail.gmail.com>
In-Reply-To: <CAHLCerOFUTrg+sJJVaP0wpRErhDdfNebfM4OAOepH4RfXopvQg@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 9 Dec 2019 09:34:31 -0800
Message-ID: <CAGXk5yox+g4U-g22_+UqEOLHzpn+TZFmuPmehUNBk5SWpvNpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: prevent cooling device with no type to be registered
To:     Amit Kucheria <amit.kucheria@verdurent.com>
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

On Sun, Dec 8, 2019 at 11:41 PM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
> >
> > commit 54fa38cc2eda ("thermal: core: prevent zones with no types to be
> > registered") added logic to prevent thermal zone with empty type to be
> > registered. Similarly, there are APIs that rely on cdev->type.
> > This patch prevents cooling device without valid type to be registered.
> >
> > Signed-off-by: Wei Wang <wvw@google.com>
>
> Looks better now. Thanks.
>

Thanks Amit for the review and testing.

> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> > ---
> >  drivers/thermal/thermal_core.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d4481cc8958f..974e2d91c30b 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -954,12 +954,22 @@ __thermal_cooling_device_register(struct device_node *np,
> >         struct thermal_zone_device *pos = NULL;
> >         int result;
> >
> > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > +       if (!type || !type[0]) {
> > +               pr_err("Error: No cooling device type defined\n");
> >                 return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > +               pr_err("Error: Cooling device name over %d chars: %s\n",
> > +                       THERMAL_NAME_LENGTH, type);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> >
> >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > -           !ops->set_cur_state)
> > +           !ops->set_cur_state) {
> > +               pr_err("Error: Cooling device missing callbacks: %s\n", type);
> >                 return ERR_PTR(-EINVAL);
> > +       }
> >
> >         cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
> >         if (!cdev)
> > @@ -972,7 +982,7 @@ __thermal_cooling_device_register(struct device_node *np,
> >         }
> >
> >         cdev->id = result;
> > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> >         mutex_init(&cdev->lock);
> >         INIT_LIST_HEAD(&cdev->thermal_instances);
> >         cdev->np = np;
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
