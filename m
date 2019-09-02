Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E38A5DA8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfIBVrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:47:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39973 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfIBVrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 17:47:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so4718896ota.7;
        Mon, 02 Sep 2019 14:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wynMwgJ6dPgxpqFm1W1fM1ypK/FfJKNuS0EDxY2Khs=;
        b=Fc+7FnjFGnEcq1mDJw1ItJFkTBin7Joo7vp1yTg24fzsqQnW02nEEaYct/DRYL7waf
         VLlRnXlvcu5zD2n+04vU5MRN0pwfnLPeAhNioGjGhilSK4Vn2Ob35127udhWgBXK2G0b
         6U0BPXu39Feh0S3YVJIApLbv5zZpXRhsvBR9B4nHrMKO7x00UusB17Gu8nKzAKh7aoQ6
         wB+EGeK6SU2bJ9TcVbjGahHOxXHg6rwovwAlkiOHxvNUF1CMzltfjFds/2WZk5ESZHWj
         AZ9OYfUKcMXn07HLxJYRytBwF7Mi398TcDImjPaF2RzKRn73KkEc+w9SvkJf0S8hxi8o
         kddA==
X-Gm-Message-State: APjAAAXW17ym4I0AZQFTmRjv5HVMayJmYZmRUabF5g9lcaTXpCxj3PB6
        gZuLityTqzFt+wjhlmzlauKf6Ynw9Xo/Pd/hhcQ=
X-Google-Smtp-Source: APXvYqxFipaLyXSjK+dxktB3ibQpeRRm0TczNF1Vs+QeimDbFWDTwWAFvQgOhJQcYINPelboxk6cMBS9zSdvhpLl+gw=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr11598412oto.262.1567460836879;
 Mon, 02 Sep 2019 14:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com> <1567346932-16744-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1567346932-16744-2-git-send-email-akinobu.mita@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:47:05 +0200
Message-ID: <CAJZ5v0g+NqasLwWRLA_LM+QEjrHquxzEgtvG4_P=4n=vzpOHWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM-runtime: allow userspace to monitor runtime_status changes
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 1, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This enables the /sys/devices/.../power/runtime_status attribute to
> allow the user space to get notifications via poll/select when the device
> runtime PM status is changed.
>
> An example use case is to avoid unnecessary accesses for device statistics
> (e.g. diskstats for block devices) while the device is in runtime suspend
> by user space LED device actitity trigger.
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 2 ++
>  drivers/base/power/power.h                    | 1 +
>  drivers/base/power/runtime.c                  | 1 +
>  drivers/base/power/sysfs.c                    | 5 +++++
>  4 files changed, 9 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 3e50536..47dc357 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -269,3 +269,5 @@ Description:
>                 the current runtime PM status of the device, which may be
>                 "suspended", "suspending", "resuming", "active", "error" (fatal
>                 error), or "unsupported" (runtime PM is disabled).
> +               This attribute allows the user space to get notifications via
> +               poll/select when the device runtime PM status is changed.
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index ec33fbdb..8891bf4 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -74,6 +74,7 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
>  extern void pm_qos_sysfs_remove_flags(struct device *dev);
>  extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
>  extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
> +extern void sysfs_notify_runtime_status(struct device *dev);
>
>  #else /* CONFIG_PM */
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b753355..3a3e413 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -94,6 +94,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>  {
>         update_pm_runtime_accounting(dev);
>         dev->power.runtime_status = status;
> +       sysfs_notify_runtime_status(dev);

There are concerns about this.

First off, it adds overhead for devices that change the PM-runtime
status relatively often.  I'm not sure if that's sufficiently
justified.

Second, it is called for status changes from "active" to "suspending"
and from "suspending" to "suspended" (and analogously for resume)
which may not be particularly useful.  At least, user space may not
have enough time to act on such notifications.

Finally, it is racy, because at the time user space does something on
a device PM-runtime status change, it very well may have changed the
other way around already.

>  }
>
>  static u64 rpm_get_accounted_time(struct device *dev, bool suspended)
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 1b9c281c..e86d8cb 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -734,3 +734,8 @@ void dpm_sysfs_remove(struct device *dev)
>         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
>         sysfs_remove_group(&dev->kobj, &pm_attr_group);
>  }
> +
> +void sysfs_notify_runtime_status(struct device *dev)
> +{
> +       sysfs_notify(&dev->kobj, "power", "runtime_status");
> +}
> --
> 2.7.4
>
