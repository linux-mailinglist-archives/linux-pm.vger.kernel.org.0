Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFF433AF1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJSPpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:45:52 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41537 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSPpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:45:52 -0400
Received: by mail-oi1-f176.google.com with SMTP id r64so5553194oih.8;
        Tue, 19 Oct 2021 08:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkfBN/rtJjv/nkCEXki6iqgm9un4yYf85O9IdXTWC2o=;
        b=Z3WW4CYi+RIUhWYEp6onxCMCsI+Fh6OtqRFEqiXDNFNAyPERhjMfwlLnRVWmdBsM7H
         +zjzYSDAjzYbojekQKgflH3XI3m6gCQBmEVTX9aQRnOLARGHqDrf0nZrc73bNFgltHpm
         tpEeXS6AAQvcxEcS5WB9fiJl+qDICnoo1tRllkEZu5TDrrh/17O58hapABG0YFUT9RGL
         fZjf1XVg0tgDLF0G8bdGawlvIeasZhhp3qf6SCsfEZECyr87I36cqZlYpKupwcO/H+Yk
         /MWjo8cM5D5E1HAc9Oota3sGrCyjCIHOkqXawZeXujpFteG/4NE7i/tNPIpYNxqE+Ge0
         bpng==
X-Gm-Message-State: AOAM530UYoFAL6FC77MIlk8UGZj4hyxHjUgAuVsyKXBByD4g5XADZ9IR
        hucs9OWiBrHeSEoOtaeYogRbrNLRqjnquiLZNz9HoxxZ7TU=
X-Google-Smtp-Source: ABdhPJwD7U61qH5mNOzChZMSPNCYQUE7tKjG4zsILe2s6ixffd5UaE8T10MfwHySdyzwJ2IdY/BGQi6xDhqRHqZYFFU=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr4835983oif.154.1634658219338;
 Tue, 19 Oct 2021 08:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
 <20211019150203.2805738-2-daniel.lezcano@linaro.org> <CAJZ5v0i1RCKs8nMCc0ROsM03beOPL941r+=NPbQpidiZJ2OA8A@mail.gmail.com>
In-Reply-To: <CAJZ5v0i1RCKs8nMCc0ROsM03beOPL941r+=NPbQpidiZJ2OA8A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 17:43:28 +0200
Message-ID: <CAJZ5v0hLVb=vbyxtraoBgPBWb8FkjzpPtH+10_AY4E8CDgc5sA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/core: Make deprecated cooling device state
 change from userspace
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 19, 2021 at 5:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > The cooling devices have their cooling device set_cur_state
> > read-writable all the time in the sysfs directory, thus allowing the
> > userspace to act on it.
> >
> > The thermal framework is wrongly used by userspace as a power capping
> > framework by acting on the cooling device opaque state. This one then
> > competes with the in-kernel governor decision.
> >
> > We have seen in out-of-tree kernels, a big number of devices which are
> > abusely declaring themselves as cooling device just to act on their
> > power.
> >
> > The role of the thermal framework is to protect the junction
> > temperature of the silicon. Letting the userspace to play with a
> > cooling device is invalid and potentially dangerous.
> >
> > The powercap framework is the right framework to do power capping and
> > moreover it deals with the aggregation via the dev pm qos.
> >
> > As the userspace governor is marked deprecated and about to be
> > removed, there is no point to keep this file writable also in the
> > future.
> >
> > Emit a warning and deprecate the interface.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index 1c4aac8464a7..730f1361dbef 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
> >         unsigned long state;
> >         int result;
> >
> > +       pr_warn_once("Setting cooling device state is deprecated\n");
>
> Maybe dev_warn_once() even?  I guess it won\t hurt to print it once
> per the affected device?
>
> > +
> >         if (sscanf(buf, "%ld\n", &state) != 1)
> >                 return -EINVAL;
> >
> > --

Also I think that changing the subject to something like "Deprecate
changing cooling device state from userspace" would help.
