Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28A3149078
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAXVxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 16:53:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38372 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXVxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 16:53:06 -0500
Received: by mail-qv1-f65.google.com with SMTP id g6so1353206qvy.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwPE2uTviQEjsE1utp28wLeHm+u6Nm1mopOXiGOBzew=;
        b=hdSRR6y3yyYN5tacXi+RUq0t2z4YfE1ePsXUhGNpUWKTMDRZTr0wsZPXDXhVSa8tA3
         CAW1ZeaBTTIg/bnTiHLkBV0tSmf2R9eAHjlHSvTCE3u0S4VczhZas42sBXaqKOA0K1WF
         OzJBeZRPvezT+6eL4IyyN1n8kytHgbLrRA+jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwPE2uTviQEjsE1utp28wLeHm+u6Nm1mopOXiGOBzew=;
        b=XQloSsiETAH71dvpJPil+SDhSuqAIKnst8zshQelvsvk/ynELP+9kS08SWNldW+0Tw
         29pikf21Lntx8idJuAeNfebRNkIDuGSLKZJGkX5324zWOSisxkuj0QcAUVGv8x3b2QhG
         QBNuU9n9Jyw5cJKJ/60kDCKTI+A0RHunrk17qD3LEaZPtbkc9e5R0k1xzft+BE2z2kWc
         BLWwNfa7dMTpkB4i/LqOqKBZlK1d7MKyigZc4Pg9PNwcdIfEZXNN0gxdox1HW2bzNMed
         L5ttRyMocFHolIxq0X3kJC3tI/79Tjaabzo2yTnwPCp+etSVtg2+j3V33oYYdOEm32Yn
         xhQw==
X-Gm-Message-State: APjAAAWDyYTtEDBrGcwrYn/m2YoSTIChS7PZ60CahWh8CsjWoGdRpTa2
        bZoaFydRCUJAKmjozCo8ZAEJeNDvZhDqd6r2A6HT6w==
X-Google-Smtp-Source: APXvYqwaEBzde+nCZdruWwVj8c3DUWHnDaZLJU9IaZnAYEkiij1P43wPznbHTec6Ot4T0ZERdsB+1brEdVsmz/xobxI=
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr5098954qvb.133.1579902784863;
 Fri, 24 Jan 2020 13:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20200117002820.56872-1-pmalani@chromium.org> <c338d46d-5600-a53e-5a04-12100f5628b1@collabora.com>
 <CACeCKafMOUgLgrO-VwAH5so-O7ALZXdTaiC_=2E9M91mhfFt6g@mail.gmail.com> <75dc83a6-c183-6808-c668-d31a71a31682@collabora.com>
In-Reply-To: <75dc83a6-c183-6808-c668-d31a71a31682@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 24 Jan 2020 13:52:54 -0800
Message-ID: <CACeCKafersQp9gx_zSYNczNTbB7u-2UYdxsrrgPhAmpW_nC2rQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric

(removed lot of the context text to keep the message length small)
> > So, in summary, my proposed additions to the edits you suggested are:
> > - Remove IS_ENABLED(CONFIG_OF)... checks from
> > cros_usbpd_notify_probe_plat() and cros_usbpd_notify_remove_plat()
> > - Change check in cros_ec_dev to be:
> >               if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node)
> >
> > WDYT? Could you kindly try this on your kevin configuration? I've
> > tried it for the cases "CONFIG_OF && !CONFIG_ACPI" and "!CONFIG_OF &&
> > CONFIG_ACPI" but not the third one (CONFIG_OF && CONFIG_ACPI) since I
> > don't have an environment to test with (I can confirm it builds).
> >
> > Thanks as always for helping iterate on this.
> >
> >
>
> Let's continue talking with a new version. Could you send another one and I can
> check. I have now setup both systems one with ACPi and another one with OF.
Sounds good. Will push a new version. Thanks.
>
> Thanks,
>  Enric
>
>
> >>                 if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> >>                         retval = mfd_add_hotplug_devices(ec->dev,
> >>                                         cros_usbpd_notify_cells,
> >>
> >>
> >>> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
> >>> new file mode 100644
> >>> index 0000000000000..4f2791722b6d3
> >>> --- /dev/null
> >>> +++ b/include/linux/platform_data/cros_usbpd_notify.h
> >>> @@ -0,0 +1,17 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * ChromeOS EC Power Delivery Notifier Driver
> >>> + *
> >>> + * Copyright 2020 Google LLC
> >>> + */
> >>> +
> >>> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +
> >>> +#include <linux/notifier.h>
> >>> +
> >>> +int cros_usbpd_register_notify(struct notifier_block *nb);
> >>> +
> >>> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> >>> +
> >>> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> >>>
> >>
> >> Cheers,
> >>  Enric
