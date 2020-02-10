Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55E158327
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 20:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBJTAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 14:00:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39249 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBJTAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 14:00:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id w15so7611903qkf.6
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2020 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH/VVZ+rx3z46+bguDaGUoDZVAFhf8vV3LCshasYBUw=;
        b=eN+8C3zCv1jVl4l26NJeWeOHWAU00eJ8h/VQc12frZzxK6JGkG8/6i6fKqGW0n6YLK
         RI8iEM5efrglfqZNENOUIwGPSX1ugqr6WtkbYr3Q9JceR13gvAT2Lzaip+tg54+s88mK
         TxtbTvt5AjD9dNuBvDt5bfm9GmiwouM1YrlfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH/VVZ+rx3z46+bguDaGUoDZVAFhf8vV3LCshasYBUw=;
        b=Ki/YCAoR1EBmdBN7TeEOvWUKdgOLbFAhXm3ipLItvAwr98K/9R29lTHlgqbv4wVC+8
         3s14Q+2129rsHVtjUNwcWfkP6vBQiYm5z6zMoHE2j25UMx+Lu3bZV36XKrrJc/9vTR8l
         JeozCeAHh8DVy36fgyZfOZjcswG7Ddm1UPPfh6fVTznT1PEr26ICuaXJYQMKh22AYrpS
         68Q4PvqZIZPlNgmUo0yDsJhcHWj1nkPLvkuJRyoZJAF0jeloubAVzajEaqLj0+hUliIX
         n/5Yr+awh8IyUaZGK+1HU1wD3MjEsC9QNhpEBGNOp7rT1R+4bTCAD+A9a2rCmcIqwnEb
         UdEA==
X-Gm-Message-State: APjAAAUBQWINR2stWDUNzmk0NcngSWx5g/2N//VcL28IkgGQp5PHQ08R
        S5il7nh7GmvyVLM3jx0+fdMeYOnn9rD1SI0NC9T88w==
X-Google-Smtp-Source: APXvYqwUpJG6BB/IfJf0v/qUwO7E1hhAxojRU/uJ/VFFxP6inYxlYjwy+K7agTn8BSt2Bc1ax7UOQPTFG2yUjRyGWso=
X-Received: by 2002:a05:620a:2218:: with SMTP id m24mr2796044qkh.442.1581361206043;
 Mon, 10 Feb 2020 11:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20200124231834.63628-1-pmalani@chromium.org> <20200124231834.63628-3-pmalani@chromium.org>
 <495e2427-7233-cb4d-0128-f6926969fb8a@collabora.com> <e755af86-3c45-8dcb-07af-68fbe903d87a@collabora.com>
 <CACeCKadtoAA0z88dYy3O-tQE=KLpR5Rx=ZXkkEKyhnAsKyqzjw@mail.gmail.com> <60312890-cd5e-840e-8c71-2d7876542650@collabora.com>
In-Reply-To: <60312890-cd5e-840e-8c71-2d7876542650@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 10 Feb 2020 10:59:54 -0800
Message-ID: <CACeCKacwg2gapH7MjByg76qrbh0CvQJ9tftr+ot+NzrMUjXGKA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric,

On Mon, Feb 10, 2020 at 8:38 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 10/2/20 17:32, Prashant Malani wrote:
> > Hi Enric,
> >
> > On Mon, Feb 10, 2020, 02:11 Enric Balletbo i Serra <enric.balletbo@collabora.com
> > <mailto:enric.balletbo@collabora.com>> wrote:
> >
> >     Hi Prashant,
> >
> >     On 27/1/20 15:50, Enric Balletbo i Serra wrote:
> >     > Hi Prashant,
> >     >
> >     > On 25/1/20 0:18, Prashant Malani wrote:
> >     >> Add a check to ensure there is indeed an EC device tree entry before
> >     >> adding the cros-usbpd-notify device. This covers configs where both
> >     >> CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
> >     >> using device tree and not in ACPI.
> >     >>
> >     >> Signed-off-by: Prashant Malani <pmalani@chromium.org
> >     <mailto:pmalani@chromium.org>>
> >     >
> >     > With this change, an playing with different CONFIG_ACPI + CONFIG_OF
> >     combinations
> >     > I don't see anymore the problem where the driver is registered twice on
> >     > CONFIG_ACPI side. So,
> >     >
> >     > Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> >     <mailto:enric.balletbo@collabora.com>>
> >     >
> >     > Maybe it requires a fixes tag if Lee already picked the other patch?
> >     >
> >     > Fixes: 4602dce0361e ("mfd: cros_ec: Add cros-usbpd-notify subdevice")
> >     >
> >
> >     Now that v7 from mfd side was merged and v8 from platform side was merged, could
> >     you resend this specific patch alone collecting all the fixes and tested tags. I
> >     guess will be more clear for mfd people.
> >
> >
> > Sounds good. Should I maintain the same versioning and series info i.e v9 3/4?
> > Or just v9?
> >
>
> I'd do "[PATCH RESEND] mfd: cros_ec: Check DT node for usbpd-notify add" and
> then after the "---" explain that you are resending this alone because the other
> patches are already applied, and reference this patch series.

Got it. Will re-send across the patch now.

Thanks!

>
> > Thanks,
> >
> >     Thanks,
> >      Enric
> >
> >     >> ---
> >     >>
> >     >> Changes in v8:
> >     >> - Patch first introduced in v8 of the series.
> >     >>
> >     >>  drivers/mfd/cros_ec_dev.c | 2 +-
> >     >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >     >>
> >     >> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> >     >> index d0c28a4c10ad0..411e80fc9a066 100644
> >     >> --- a/drivers/mfd/cros_ec_dev.c
> >     >> +++ b/drivers/mfd/cros_ec_dev.c
> >     >> @@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
> >     >>       * explicitly added on platforms that don't have the PD notifier ACPI
> >     >>       * device entry defined.
> >     >>       */
> >     >> -    if (IS_ENABLED(CONFIG_OF)) {
> >     >> +    if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
> >     >>              if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> >     >>                      retval = mfd_add_hotplug_devices(ec->dev,
> >     >>                                      cros_usbpd_notify_cells,
> >     >>
> >
