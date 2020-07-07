Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B22173E4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGGQ0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGQ0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 12:26:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E0C08C5E1
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 09:26:18 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a17so11955179vsq.6
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRr27JuPAO9BtO0TvQuQd84+DLvcv/di5urxMpWy8HU=;
        b=AMbK+oPGJMrhcLzdTKVqdsj/fnW07exNQ4TfkfoR1gVnKJjaWCGe5xwBxQVmKK+irV
         fjX5Y8mO1V428PM8obISuijQcpBkW3hAMzyCcsx6xB+puWYTFe36YATxutNJJhA5YkYz
         /FK0hkJuuyzABQqkl43WR2KDwIVw/lALcBtlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRr27JuPAO9BtO0TvQuQd84+DLvcv/di5urxMpWy8HU=;
        b=jhS9ur7m/su2bFCopXHhGGCC1P2Zse/qCJwjtflCpA9p0fXT/Q35zorcq2lqJ8BIoQ
         RrmM8b2pPDvBfwDxAsmNHxrhbAsaQBjuMaIJL9ugiybuKqEu0d9HIH+gHa39aCJGY4/D
         asbRTcbUC7sRoU8k4wUHaP7D8oe8QYFkBHtgYrFKg76rX2/ZOloxatguhvRgnq95g4cE
         1xd7ky8QWuzxAvDQ+1qvf4cQvQZ0jJlBMHLX46uWsXJPGsYNw+zzEaMptwhZxYNW/RFZ
         1S7U6LtLlUD+1+9ozQ4IV7vwQCwlCCukYS/5KSTW2jpPPd0o7SVI4AkxynkT4ZRoHIMS
         Hdwg==
X-Gm-Message-State: AOAM5306/uLFj/XIy62eGV4OjMm6s8ZBRWKlYjugRUaGKLpVWLb6cx3m
        HAppSuBEJn02dR1WXAu33jRPM94mqXZr1NyrXFusMg==
X-Google-Smtp-Source: ABdhPJxCjKbtHJ0QRoS8w68vwUhPXgCL2a51zg3xQGp0FusBhjC89hy1Xe2YrPDkL0SatDDJVVgU9IMvnLThGvduZTU=
X-Received: by 2002:a67:6e05:: with SMTP id j5mr32213071vsc.196.1594139177799;
 Tue, 07 Jul 2020 09:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707162417.3514284-1-abhishekpandit@chromium.org> <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
In-Reply-To: <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 09:26:07 -0700
Message-ID: <CANFp7mVBbsv4t=vSSXvU0GP2fqW3B8cZD1_ndxoAHWWCdU1m=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        rafael.j.wysocki@intel.com, Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Built and tested on Chromebook w/ 5.4 kernel.

Sorry about the churn -- will start building with warnings = errors
before I send patches upstream.

Thanks
Abhishek

On Tue, Jul 7, 2020 at 9:24 AM Abhishek Pandit-Subedi
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
