Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7749B35C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jan 2022 12:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383514AbiAYLzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 06:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385899AbiAYLrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 06:47:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D5C06174E
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 03:45:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q127so1547261ljq.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 03:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wod5gWshu23pmO/7zcX1A3gygVLcoqtrX7j57tlK/80=;
        b=rtB3ApHks/v1XsvTvyj4TgPQXU1wdN5rxb8uGTGOLMWmblyXHIM2xjP0mefAXnFyrZ
         YKGI3iIYLXGdib5TLqP1l9wE7VzSph5SF2lXLPFtNSdQhcPUKNrbu2SEuMzeEWI5VLUJ
         6CjpMl8abJpCDCb8WRYnsBPyawPRGFV3oQABpCbF+rFmDJcMJc+IRFHipBjcNhesLsSf
         BwIgxkcPo0VyzDh+zIR8gvNqhYM0xguZf7hfxPLz5y9iPOLTpaBp5DKtmQt0j4vR07bS
         nGVYbl9sjdwopWwFdKfAFBrilMvRsP0DCgsNC0xd3T9GTIYLztb0xuWyFZsMsj+OVksg
         XOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wod5gWshu23pmO/7zcX1A3gygVLcoqtrX7j57tlK/80=;
        b=DIki4/Z4nK/8pgb200WbqnHD8GuJZtrUVrhx3NxUl6/lRn6v6YKNOYG2Ogn9nP5L32
         g5tQX/XqWXA58q096wZdjLWdnnWFGfhgeC0GDxhPJcw8pMC0kyTVF6B3kJO2j9y3hcD2
         0+tpzA6+7x4ejmTEAeH8v/p2sJQD6H5jInOU6mV320dVu97NMASnGVDxjRXuTZoCdfAw
         jvjkjWSN0mWYMIP5FtFqn5x06BsqdwSHqE/Vvqs4lbPnDctrajOvuLf4ym77qjodaln4
         roU8aKIzdDiclzyGwWANAYcCC8YP6m+6qy3uC2dUnE3UrS0PfZpL8k7AzAjTeub75LPg
         F08A==
X-Gm-Message-State: AOAM532B+0mG+KhMV1q80NcvP18OHURvI/A97zDt78cCZGbEoWKaNm50
        yvOWFwJPl2Q9eCwZFd1QSQHbW8paz+iBhrsztPIGgg==
X-Google-Smtp-Source: ABdhPJzhx0lTUZpuJBlVSGIRLZlgdAD/dyygJTz/K7hU1+coUIWH4WBBke5nmhZf8ZLxq8cqag0js0bP7vpVxqS3Pt0=
X-Received: by 2002:a2e:5356:: with SMTP id t22mr6955614ljd.300.1643111136879;
 Tue, 25 Jan 2022 03:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
 <20220119085719.1357874-3-daniel.lezcano@linaro.org> <CAPDyKFrtq0J2O0WBwLr7Zb+WkomhLcR1h+eDzzV-SxpiJmm_yQ@mail.gmail.com>
 <061cd428-c022-4058-9a11-c5dbe3cb9777@linaro.org>
In-Reply-To: <061cd428-c022-4058-9a11-c5dbe3cb9777@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Jan 2022 12:44:59 +0100
Message-ID: <CAPDyKFptf9QGB9+ke5x25eBiYS5aXpX5Hng2Hebkc1vo=hn+og@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, robh@kernel.org, lukasz.luba@arm.com,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Jan 2022 at 11:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 24/01/2022 21:00, Ulf Hansson wrote:
> > On Wed, 19 Jan 2022 at 09:58, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> The DTPM framework is available but without a way to configure it.
> >>
> >> This change provides a way to create a hierarchy of DTPM node where
> >> the power consumption reflects the sum of the children's power
> >> consumption.
> >>
> >> It is up to the platform to specify an array of dtpm nodes where each
> >> element has a pointer to its parent, except the top most one. The type
> >> of the node gives the indication of which initialization callback to
> >> call. At this time, we can create a virtual node, where its purpose is
> >> to be a parent in the hierarchy, and a DT node where the name
> >> describes its path.
> >>
> >> In order to ensure a nice self-encapsulation, the DTPM subsys array
> >> contains a couple of initialization functions, one to setup the DTPM
> >> backend and one to initialize it up. With this approach, the DTPM
> >> framework has a very few material to export.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/powercap/Kconfig |   1 +
> >>  drivers/powercap/dtpm.c  | 168 ++++++++++++++++++++++++++++++++++++++-
> >>  include/linux/dtpm.h     |  15 ++++
> >>  3 files changed, 181 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> >> index 8242e8c5ed77..b1ca339957e3 100644
> >> --- a/drivers/powercap/Kconfig
> >> +++ b/drivers/powercap/Kconfig
> >> @@ -46,6 +46,7 @@ config IDLE_INJECT
> >>
> >>  config DTPM
> >>         bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
> >> +       depends on OF
> >>         help
> >>           This enables support for the power capping for the dynamic
> >>           thermal power management userspace engine.
> >> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> >> index 0e5c93443c70..10032f7132c4 100644
> >> --- a/drivers/powercap/dtpm.c
> >> +++ b/drivers/powercap/dtpm.c
> >> @@ -23,6 +23,7 @@
> >>  #include <linux/powercap.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/mutex.h>
> >> +#include <linux/of.h>
> >>
> >>  #include "dtpm_subsys.h"
> >>
> >> @@ -463,14 +464,175 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
> >>         return 0;
> >>  }
> >>
> >> -static int __init init_dtpm(void)
> >> +static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
> >> +                                      struct dtpm *parent)
> >>  {
> >> +       struct dtpm *dtpm;
> >> +       int ret;
> >> +
> >> +       dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
> >> +       if (!dtpm)
> >> +               return ERR_PTR(-ENOMEM);
> >> +       dtpm_init(dtpm, NULL);
> >> +
> >> +       ret = dtpm_register(hierarchy->name, dtpm, parent);
> >> +       if (ret) {
> >> +               pr_err("Failed to register dtpm node '%s': %d\n",
> >> +                      hierarchy->name, ret);
> >> +               kfree(dtpm);
> >> +               return ERR_PTR(ret);
> >> +       }
> >> +
> >> +       return dtpm;
> >> +}
> >> +
> >> +static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
> >> +                                 struct dtpm *parent)
> >> +{
> >> +       struct device_node *np;
> >> +       int i, ret;
> >> +
> >> +       np = of_find_node_by_path(hierarchy->name);
> >> +       if (!np) {
> >> +               pr_err("Failed to find '%s'\n", hierarchy->name);
> >> +               return ERR_PTR(-ENXIO);
> >> +       }
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
> >> +
> >> +               if (!dtpm_subsys[i]->setup)
> >> +                       continue;
> >> +
> >> +               ret = dtpm_subsys[i]->setup(parent, np);
> >> +               if (ret) {
> >> +                       pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
> >> +                       of_node_put(np);
> >> +                       return ERR_PTR(ret);
> >> +               }
> >> +       }
> >> +
> >> +       of_node_put(np);
> >> +
> >> +       /*
> >> +        * By returning a NULL pointer, we let know the caller there
> >> +        * is no child for us as we are a leaf of the tree
> >> +        */
> >> +       return NULL;
> >> +}
> >> +
> >> +typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
> >> +
> >> +dtpm_node_callback_t dtpm_node_callback[] = {
> >> +       [DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
> >> +       [DTPM_NODE_DT] = dtpm_setup_dt,
> >> +};
> >> +
> >> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> >> +                              const struct dtpm_node *it, struct dtpm *parent)
> >> +{
> >> +       struct dtpm *dtpm;
> >> +       int i, ret;
> >> +
> >> +       for (i = 0; hierarchy[i].name; i++) {
> >> +
> >> +               if (hierarchy[i].parent != it)
> >> +                       continue;
> >> +
> >> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> >> +               if (!dtpm || IS_ERR(dtpm))
> >
> > This can be tested with the "IS_ERR_OR_NULL()" macro.
> >
> >> +                       continue;
> >
> > We have discussed the error path previously. Just ignoring errors here
> > and continuing with the initialization, isn't normally how we design
> > good kernel code.
> >
> > However, you have also explained that the error path is special and
> > somewhat non-trivial to manage in this case. I get that now and thanks
> > for clarifying.
> >
> > Nevertheless, I think it deserves to be explained a bit with a comment
> > in the code of what goes on here. Otherwise another developer that
> > looks at this code in the future, may think it looks suspicious too.
> >
> >> +
> >> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >
> > [...]
> >
> > Other than the above, this looks good to me!
>
> With the above fixed, shall I add your reviewed-by ?

Sure, that's fine!

Kind regards
Uffe
