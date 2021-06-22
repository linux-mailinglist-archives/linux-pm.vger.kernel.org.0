Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279F63B0578
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFVNJA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:09:00 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:46965 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhFVNI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:08:59 -0400
Received: by mail-oo1-f41.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso5344009ooc.13;
        Tue, 22 Jun 2021 06:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chE9bMyNBH413ASQvMhl/suJETQNVpND5Md5xII89Tc=;
        b=fnaerrmQIFHVu2H0S4J9HFt8GOscseFQL32YKKUS+g2wT4Id8iVSJktboDz8aR7DZb
         32jMmK86erAMuiTG9yI6Q09aD9jqWSMInqVttVvY/lJ6Ckyi+NnlbgSFT6ADPPsgDKO6
         VyQTXZ0VbEmmAmtztVyiXSBBIpr9wYuoNZPG1K8j5/x4Yr6+5RjKFhHmrUE2+QZ+OUrH
         ggxzu8xLJJ6bkvquV8mmFVu8nRscK8bhnUBmoKgov0qj6h80ryC76ZX+pkn21if0Sbhw
         tzOLkdY6PUnxAUoehGpYSbh/sjsyEDcj64Eio8Os7z8tvCrwyzTzNXo8ICCoP9g8mq9Q
         /Z3w==
X-Gm-Message-State: AOAM533lpajDs5bbGfyR44VELKOOECdhM2jV/NerwUmFrBO5Vod6dGMF
        HXCPpwVyhDXyuNX4RawoNRcKAjzYzMrLxHA0QwG3sJ8G
X-Google-Smtp-Source: ABdhPJyNO8kSogqtvkdApyiMVGuC+hG49Z6wicY0IoySDzQQJpO0HKqCdBn4Eo7wFblDWo0VKQ+P0ygkT1zl9z6JjpI=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr3257019ooa.1.1624367203069;
 Tue, 22 Jun 2021 06:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210622124547.28317-1-pingshuo@uniontech.com>
In-Reply-To: <20210622124547.28317-1-pingshuo@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 15:06:31 +0200
Message-ID: <CAJZ5v0gnYHmbWANVkoG+6XrUNzBB4__uM0Ladrpn5=L0KEiefA@mail.gmail.com>
Subject: Re: [PATCH] hibernation:stop resume screen during hibernation
To:     pingshuo <pingshuo@uniontech.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 2:46 PM pingshuo <pingshuo@uniontech.com> wrote:
>
> The display will be woken up during hibernation.

That actually depends on its driver.

> if the computer equipment is poor, it will cause the screen to flicker.
> Skip to reusme the display devices in "thaw".

But this patch looks like a proof of concept rather than a proper solution.

This needs to be done more carefully.

> Signed-off-by: pingshuo <pingshuo@uniontech.com>
> ---
>  drivers/base/power/main.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f893c3c5af07..f3e92ac7b4b3 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -35,11 +35,14 @@
>  #include <linux/cpuidle.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/pci.h>
>
>  #include "../base.h"
>  #include "power.h"
>
>  typedef int (*pm_callback_t)(struct device *);
> +#define VIDEO_PCI_CLASS 0x030000
> +#define VIDEO_PCI_CLASS_VALID 0xff0000
>
>  #define list_for_each_entry_rcu_locked(pos, head, member) \
>         list_for_each_entry_rcu(pos, head, member, \
> @@ -693,6 +696,40 @@ static void async_resume_noirq(void *data, async_cookie_t cookie)
>         put_device(dev);
>  }
>
> +/**
> + * dpm_resume_skip_display_devices - Skip to reusme the display devices.
> + * @dev: Device to handle.
> + * @state: PM transition of the system being carried out.
> + *
> + * Delete the display devices from the wake-up list during the "thaw".
> + */
> +static int dpm_resume_skip_display_devices(struct device *dev, pm_message_t state)
> +{
> +       struct pci_dev *pci_test = to_pci_dev(dev);

If you want to deal with PCI devices, that needs to happen at the PCI
bus type level in the first place.

> +
> +       if (state.event == PM_EVENT_THAW) {
> +               /*
> +                * Filter out the display devices
> +                */
> +               if ((pci_test && ((pci_test->class & VIDEO_PCI_CLASS_VALID) == VIDEO_PCI_CLASS)) ||
> +                       (dev->driver && dev->driver->name &&
> +                       strncmp(dev->driver->name, "video", 6) == 0)) {
> +
> +                       pr_info("Skip the display devices during the thaw.");
> +                       /*
> +                        * Remove the display devices from the resume stage
> +                        */
> +                       list_del(&dev->power.entry);
> +                       /*
> +                        * Remove the display devices from the power down stage
> +                        */
> +                       list_del(&dev->kobj.entry);
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static void dpm_noirq_resume_devices(pm_message_t state)
>  {
>         struct device *dev;
> @@ -713,6 +750,10 @@ static void dpm_noirq_resume_devices(pm_message_t state)
>         while (!list_empty(&dpm_noirq_list)) {
>                 dev = to_device(dpm_noirq_list.next);
>                 get_device(dev);
> +
> +               if (dpm_resume_skip_display_devices(dev, state))
> +                       continue;
> +
>                 list_move_tail(&dev->power.entry, &dpm_late_early_list);
>                 mutex_unlock(&dpm_list_mtx);
>
> @@ -737,6 +778,8 @@ static void dpm_noirq_resume_devices(pm_message_t state)
>         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
>  }
>
> +
> +
>  /**
>   * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
>   * @state: PM transition of the system being carried out.
> --
