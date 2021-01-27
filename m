Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA38306342
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhA0S0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:26:37 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44142 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbhA0S0b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:26:31 -0500
Received: by mail-ot1-f54.google.com with SMTP id e70so2628497ote.11
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 10:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A13iMOBwFqJYU97Rsh0P9RAMXT1a3pGRukgND9rLsSQ=;
        b=J/tOrY9Ky2FpccERHuZwAAamyTZvsDwQJ6gSY9+OMPytG0+0YKVcEOU6OPbplOtGBT
         WHg+C6fWy5KfdXSwblZ84PuLZbROv+QEGG1mSI3TVU51kXtoswxnHjqxVulTj3CgpvGF
         TqXkug8w55cRbLN96pS+++EzevJCUxs/rw/yIPU9Y+Ao3/iozxVYaioefzRqid9MOm0D
         ZiTbwQTKaH3fPIPAoTATF9IyQcCA0KLuZWEPCsleuFzFjWFp4ugoUqBLT2hy849/sJvJ
         WwhaiVy2wVwSywUrLVu/rIKG9K9wjOYE7uNan8k9AcyVqLhQzKeefZh/srNdQrZzNTOU
         gJfQ==
X-Gm-Message-State: AOAM530ZRNJ2exL2wABdk1+bPDUDE9B1riBoIdS2aTKtFisdbaFQXj6a
        g/33fc5FIKpoW4VBy4Cs3kkCUg7X+XjVUNgtmnk=
X-Google-Smtp-Source: ABdhPJz050YoFK6jfQYcaKyTgzu5Ob+46ZRzUewa4/OzZ50QRipOEmbxSV188pnZhKRvWCmrHO0vdIwbfHwEMZMA+OU=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr8864497otm.206.1611771950299;
 Wed, 27 Jan 2021 10:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20210126212655.2921965-1-helgaas@kernel.org>
In-Reply-To: <20210126212655.2921965-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 19:25:39 +0100
Message-ID: <CAJZ5v0hQ_WSu7Y1ACFSkijLXO5V_54j8D2+c+eLz3OFM=ieT0A@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix typos and grammar
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 8:23 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix minor typos and grammatical issues.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied as 5.12 material, thanks!

> ---
>  Documentation/power/runtime_pm.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 0553008b6279..d9c777b18f7a 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -579,7 +579,7 @@ should be used.  Of course, for this purpose the device's runtime PM has to be
>  enabled earlier by calling pm_runtime_enable().
>
>  Note, if the device may execute pm_runtime calls during the probe (such as
> -if it is registers with a subsystem that may call back in) then the
> +if it is registered with a subsystem that may call back in) then the
>  pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
>  appropriate to ensure that the device is not put back to sleep during the
>  probe. This can happen with systems such as the network device layer.
> @@ -587,11 +587,11 @@ probe. This can happen with systems such as the network device layer.
>  It may be desirable to suspend the device once ->probe() has finished.
>  Therefore the driver core uses the asynchronous pm_request_idle() to submit a
>  request to execute the subsystem-level idle callback for the device at that
> -time.  A driver that makes use of the runtime autosuspend feature, may want to
> +time.  A driver that makes use of the runtime autosuspend feature may want to
>  update the last busy mark before returning from ->probe().
>
>  Moreover, the driver core prevents runtime PM callbacks from racing with the bus
> -notifier callback in __device_release_driver(), which is necessary, because the
> +notifier callback in __device_release_driver(), which is necessary because the
>  notifier is used by some subsystems to carry out operations affecting the
>  runtime PM functionality.  It does so by calling pm_runtime_get_sync() before
>  driver_sysfs_remove() and the BUS_NOTIFY_UNBIND_DRIVER notifications.  This
> @@ -603,7 +603,7 @@ calling pm_runtime_suspend() from their ->remove() routines, the driver core
>  executes pm_runtime_put_sync() after running the BUS_NOTIFY_UNBIND_DRIVER
>  notifications in __device_release_driver().  This requires bus types and
>  drivers to make their ->remove() callbacks avoid races with runtime PM directly,
> -but also it allows of more flexibility in the handling of devices during the
> +but it also allows more flexibility in the handling of devices during the
>  removal of their drivers.
>
>  Drivers in ->remove() callback should undo the runtime PM changes done
> @@ -693,7 +693,7 @@ that the device appears to be runtime-suspended and its state is fine, so it
>  may be left in runtime suspend provided that all of its descendants are also
>  left in runtime suspend.  If that happens, the PM core will not execute any
>  system suspend and resume callbacks for all of those devices, except for the
> -complete callback, which is then entirely responsible for handling the device
> +.complete() callback, which is then entirely responsible for handling the device
>  as appropriate.  This only applies to system suspend transitions that are not
>  related to hibernation (see Documentation/driver-api/pm/devices.rst for more
>  information).
> @@ -706,7 +706,7 @@ out the following operations:
>      right before executing the subsystem-level .prepare() callback for it and
>      pm_runtime_barrier() is called for every device right before executing the
>      subsystem-level .suspend() callback for it.  In addition to that the PM core
> -    calls  __pm_runtime_disable() with 'false' as the second argument for every
> +    calls __pm_runtime_disable() with 'false' as the second argument for every
>      device right before executing the subsystem-level .suspend_late() callback
>      for it.
>
> @@ -783,7 +783,7 @@ driver/base/power/generic_ops.c:
>    `int pm_generic_restore_noirq(struct device *dev);`
>      - invoke the ->restore_noirq() callback provided by the device's driver
>
> -These functions are the defaults used by the PM core, if a subsystem doesn't
> +These functions are the defaults used by the PM core if a subsystem doesn't
>  provide its own callbacks for ->runtime_idle(), ->runtime_suspend(),
>  ->runtime_resume(), ->suspend(), ->suspend_noirq(), ->resume(),
>  ->resume_noirq(), ->freeze(), ->freeze_noirq(), ->thaw(), ->thaw_noirq(),
> --
> 2.25.1
>
