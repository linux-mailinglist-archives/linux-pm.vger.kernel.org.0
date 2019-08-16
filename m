Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E090A42
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfHPV1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 17:27:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44839 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHPV1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 17:27:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so5794320oiw.11
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqmSQA31vLUNhr87Xa+IWQLTTVCCaklCI55tBVwyFNQ=;
        b=A3J5SEaIUVTi9GzBvEYudEnLY+MD/Tms4QCct9Le1jCJ+1WYIAbD+48NaEyqtvfbRh
         Qe7pfKphAnMr5eryDM3Opv7Gus2oEdfIptH+ke3T8lWJzlA9JPTYcb3oi++PxTcT1mjd
         YWUTfqhnD+bZLIBnkc36REFChte0qoz/DfKubxH+EQl2xkoOU1ca6IV1pe0LvGO37LKD
         uU4V13hlIEa8yUjpa0txpKASYcF78pANyvXfalCfMwwLfVEVbDeiuTEo/sNRZe+Q5ph3
         ZvER8Ejg/XEyMNC981lqM9ivVQe6iUZsSvO2p+l3jZnDzYEBGoc+uTWqSHr74axyQHej
         8+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqmSQA31vLUNhr87Xa+IWQLTTVCCaklCI55tBVwyFNQ=;
        b=BE+AOaUc3BBOda0Uu3aj/baS5e+8j0zNAKB13yJQxamCJkvAgNGrhSXj5xCHhA4Ln6
         JIQBEauz7V50ZfnqK00XMDxxX/z1dtPmXK8seCOOiBbaCDJ71/ZbUdslfg0fhKCSxW9s
         xCqyA/+Zamps4s/YR0B/kuwrPvybslG/nQF8eH8f/quhHv/DN7qcIFM3s7KEl9PVfOdb
         pqIoPfROWP7gMoWfDpfx+c+3tIWQdxPRP1ErWJpC7IVpuNSRHllairoi5WRtEC++nRKL
         KpuFSguMl1ny6PV30P0x5PMTJMyMwkYrQ1T96vW5ctPpiYJKKCMPJmqqRA4t+vrt/Hia
         Njqw==
X-Gm-Message-State: APjAAAWTRerX/FaJDLVqULacaUkD0I44huJwNoJFESpOvFTMyRcUy15s
        7UuT9vU3vHDV+Th8X5umKFBnmrcibfwb/x3W70epAg==
X-Google-Smtp-Source: APXvYqyUY2tOiKVAj3q1ha+TiJ4c/MJUuqSosee46aTi/hV6edQ9nSXhS/v5n62lG0AS/lTxt6wg3iJ4TDkL+2lmAuw=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr5854082oiy.145.1565990866341;
 Fri, 16 Aug 2019 14:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190816145602.231163-1-swboyd@chromium.org>
In-Reply-To: <20190816145602.231163-1-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Fri, 16 Aug 2019 14:27:35 -0700
Message-ID: <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Register wakeup class kobj after device is added
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 7:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The device_set_wakeup_enable() function can be called on a device that
> hasn't been registered with device_add() yet. This allows the device to
> be in a state where wakeup is enabled for it but the device isn't
> published to userspace in sysfs yet.
>
> After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
> sysfs"), calling device_set_wakeup_enable() will fail for a device that
> hasn't been registered with the driver core via device_add(). This is
> because we try to create sysfs entries for the device and associate a
> wakeup class kobject with it before the device has been registered.
> Let's follow a similar approach that device_set_wakeup_capable() takes
> here and register the wakeup class either from
> device_set_wakeup_enable() when the device is already registered, or
> from dpm_sysfs_add() when the device is being registered with the driver
> core via device_add().
>
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/sysfs.c  | 10 +++++++++-
>  drivers/base/power/wakeup.c | 10 ++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 1b9c281cbe41..27ee00f50bd7 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -5,6 +5,7 @@
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
>  #include <linux/atomic.h>
>  #include <linux/jiffies.h>
>  #include "power.h"
> @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
>                 if (rc)
>                         goto err_runtime;
>         }
> +       if (dev->power.wakeup) {

This conditional checks for the situation when wakeup source
registration have been previously attempted, but failed at
wakeup_source_sysfs_add(). My concern is that it's not easy to
understand what this check does without knowing exactly what
device_wakeup_enable() does to dev->power.wakeup before we reach this
point.

> +               rc = wakeup_source_sysfs_add(dev, dev->power.wakeup);
> +               if (rc)
> +                       goto err_wakeup;
> +       }
>         if (dev->power.set_latency_tolerance) {
>                 rc = sysfs_merge_group(&dev->kobj,
>                                        &pm_qos_latency_tolerance_attr_group);
>                 if (rc)
> -                       goto err_wakeup;
> +                       goto err_wakeup_source;
>         }
>         return 0;
>
> + err_wakeup_source:
> +       wakeup_source_sysfs_remove(dev->power.wakeup);
>   err_wakeup:
>         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
>   err_runtime:
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index f7925820b5ca..5817b51d2b15 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
>
>         ws = wakeup_source_create(name);
>         if (ws) {
> -               ret = wakeup_source_sysfs_add(dev, ws);
> -               if (ret) {
> -                       wakeup_source_free(ws);
> -                       return NULL;
> +               if (!dev || device_is_registered(dev)) {

Is there a possible race condition here? If dev->power.wakeup check in
dpm_sysfs_add() is done at the same time as device_is_registered(dev)
check here, then wakeup_source_sysfs_add() won't ever be called?

> +                       ret = wakeup_source_sysfs_add(dev, ws);
> +                       if (ret) {
> +                               wakeup_source_free(ws);
> +                               return NULL;
> +                       }
>                 }
>                 wakeup_source_add(ws);
>         }
> --
> Sent by a computer through tubes
>
