Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C23C2713
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGIPxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 11:53:10 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43984 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhGIPxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 11:53:10 -0400
Received: by mail-oi1-f172.google.com with SMTP id m3so12687246oig.10
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 08:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr+XMjDKyDhlaFAhWTMGzIR/npmMHuwQFkxJli8TMS0=;
        b=mxGhN/rtluid41l/y0Wh1fzfHGJIpsYG9pjeyf2lRfa8tU8s7NVLFdQZuCB68AjQwp
         m0ITgOxzyFT2toGGCjiHYyN+48RJtNWSE62TsDSGBuL840nYHDiJGb9EB3IzU70vxwP7
         ujsuHDkl+p0Tc7arCBSRMUAERjjERKt21letpCkKbZL/f3VE6F8CDjfLP3P/DJaI4b+G
         jllXNypyoOcX+C/c0YihrM2XkqJBkvT6kLdWpDHkOsmL5Wcwiy9dJlBV1yUjmj5ZJI6F
         cL2csyCMBnReVltjSVQfS3xPwPidt2srit2dIOgM+ESaYC13j7d3AK7EEFDSjc+08tbw
         OFIg==
X-Gm-Message-State: AOAM530siSvil8M456hBO6PYp+dhUbmTcx6NI25KpOafQkvvwwB7+5Sm
        xyev52R06xLDmIsHR5Dxv3YiGzKbVpTbtOlwyI0ENAVeWpU=
X-Google-Smtp-Source: ABdhPJzM4iKP9irqSgMTAsrODDiZ9cCJ+MzFmE8+lIbDxlRRA8fIKTULusVqCk+SdLQGwE57vTqLbStnM4dDm4uNfo4=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr8966405oiw.157.1625845814982;
 Fri, 09 Jul 2021 08:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <4c65cdd3-05cd-499d-0dd1-b7d6e76372b1@hisilicon.com>
In-Reply-To: <4c65cdd3-05cd-499d-0dd1-b7d6e76372b1@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jul 2021 17:50:04 +0200
Message-ID: <CAJZ5v0hsK_kJMfyQFaf1AjJHFHde1J3U2FxhsaJ59KVkyxsoQg@mail.gmail.com>
Subject: Re: Question about __pm_runtime_disable()
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 9, 2021 at 4:24 AM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>
> Hi Rafael and other guys,
>
> I encounter a runtime PM issue: there are four devices, and device 0 is
> the parent device, and device 1/2/3 are the children devices of device 0.
>
> All of them supports runtime PM. But i want to ignore device2 and
> device3, so that if device 1 is suspended, then device0 can
>
> be suspended. I use function pm_runtime_disable() to disable device2 and
> device3, and device 1 is suspended but device0 is still active.
>
> I find that runtime_active_kids of device0 is still 2 though
> runtime_usage = 0, so it doesn't enter suspend status.
>
> And i hack the code of funciton __pm_runtime_disable() to decrease
> child_count of device's parent as follows, and it works.
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b570848..6ba224b 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1382,6 +1382,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>    */
>   void __pm_runtime_disable(struct device *dev, bool check_resume)
>   {
> +       struct device *parent = NULL;
> +
>          spin_lock_irq(&dev->power.lock);
>
>          if (dev->power.disable_depth > 0) {
> @@ -1413,6 +1415,10 @@ void __pm_runtime_disable(struct device *dev,
> bool check_resume)
>          if (!dev->power.disable_depth++)
>                  __pm_runtime_barrier(dev);
>
> +       if (dev->parent) {
> +               parent = dev->parent;
> +               atomic_add_unless(&parent->power.child_count, -1, 0);
> +       }
>    out:
>          spin_unlock_irq(&dev->power.lock);
>   }
>
> Is it appropriate for me to use function pm_runtime_disable() to ignore
> them

No, it is not.

> (i try function function pm_suspend_ignore_children(), but it
> ignores all children of the device )?

IMV you still need to use ignore_children (and yes, all of the
children will be ignored in that case) and use pm_runtime_get_*() and
pm_runtime_put_*() on the parent in the child 1 driver to make the
parent automatically resume and suspend, respectively.

> Or does it need to decrease child_count the device's parent in function
> __pm_runtime_disable() ?

Doing this is not recommended.
