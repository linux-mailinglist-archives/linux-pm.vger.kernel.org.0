Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19D2173EF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGGQ2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 12:28:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46180 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQ2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 12:28:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id l63so33924109oih.13;
        Tue, 07 Jul 2020 09:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqA8J6CgHJ1oaRzYuw9U/pBjnnBjCWF7/6JXnD6SNeI=;
        b=fAiVt3yqIgVL/Vd9TRAgthE4dRaHiCqRkxSnfarLUPMS4LYutAu8xdEPhJoA4bi1pw
         ne+rdWwu/aQAaFAuqIVf6IhdMBWAy8XRlMOowocJ1sYWMhD0srRbqDv89rlbaN1lLCoD
         XbGJ892l6I7pVFjPd1ngGQgTn/dGqaWpqXVZl4vhf8M47bXZdysOt/0C1mTkYbGxT7B8
         xvqn1X1xssyxWuJTpJQZS5pwKr2e84+Cn2qinjANbazLFS6iUiph9U9GwLYdaVN2yn2N
         7Wped44lTUlbjZ2Xt3V9lkaaWTm1VM0uLXkOpIazHk53EK/Hl3oD+xBUAgLekBUK3cER
         X/wQ==
X-Gm-Message-State: AOAM530Y4wubsuDnbmiZXxo9vUubteHb0wgrD+VSwvzdp37gXBro5BHr
        GTZpZ4wFHZJn053oxSPBGllrVQJ75OdKc2vfBoo=
X-Google-Smtp-Source: ABdhPJwWEu1nW2hVdT2oditOw+IT/F4slchce0IYqSxCLUtcrqN8q00tngKV7H/5HMxNHixTJq1zO157Gf900Ep315g=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr3798335oih.68.1594139296771;
 Tue, 07 Jul 2020 09:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200707162417.3514284-1-abhishekpandit@chromium.org> <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
In-Reply-To: <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 18:28:05 +0200
Message-ID: <CAJZ5v0iyvge_Hqgm46_vfjh45YFdnsJ7ksvY7DqD6gx+f+1dvg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 7, 2020 at 6:24 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Udev rules that depend on the power/wakeup attribute don't get triggered
> correctly if device_set_wakeup_capable is called after the device is
> created. This can happen for several reasons (driver sets wakeup after
> device is created, wakeup is changed on parent device, etc) and it seems
> reasonable to emit a changed event when adding or removing attributes on
> the device.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
> Changes in v4:
> - Fix warning where returning from void and tested on device
>
> Changes in v3:
> - Simplified error handling
>
> Changes in v2:
> - Add newline at end of bt_dev_err
>
>  drivers/base/power/sysfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 24d25cf8ab1487..aeb58d40aac8de 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* sysfs entries for device PM */
>  #include <linux/device.h>
> +#include <linux/kobject.h>
>  #include <linux/string.h>
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
> @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>
>  int wakeup_sysfs_add(struct device *dev)
>  {
> -       return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +       int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +
> +       if (ret)
> +               return ret;
> +
> +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);

So let me repeat the previous comment:

If you return an error here, it may confuse the caller to think that
the operation has failed completely, whereas the merging of the
attribute group has been successful already.

I don't think that an error can be returned at this point.

>  }
>
>  void wakeup_sysfs_remove(struct device *dev)
>  {
>         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> +       kobject_uevent(&dev->kobj, KOBJ_CHANGE);
>  }
>
>  int pm_qos_sysfs_add_resume_latency(struct device *dev)
> --
> 2.27.0.212.ge8ba1cc988-goog
>
