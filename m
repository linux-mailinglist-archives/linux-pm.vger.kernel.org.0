Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8D45C230
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 14:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbhKXN0D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 08:26:03 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42605 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbhKXNYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 08:24:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so4174553otv.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 05:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjDvGV48Mk7OhPYxiaw7Kd0se2piGB7D4NuwBC25iqw=;
        b=Bwt5Zc4MkDhiwZ84gnB/TQ+IU1lqyANY8IrN/p0UIu66Zl2jOKh85VLUOov38V2JMW
         rK0kaVzm7ESvG1YQmI6C1cT3i2bBqDuc7HX7yv/J8qViI9ISDzfeuvGA30J4q6MFmmVe
         43DuSjs+nm94JSepuOpQk+Ld6Z2AfrMg6RY6dhX/3Og9YfOQVZgHeyd5JYrVgaMjifpM
         OkhK8+wXFHwzNjubI9fxcoLV4Rye3zXOtsY4I0P1kifwJ7xoyum8mC1z9VVlYsmK+IJd
         CNyvxZ+aziczYHyQEJX12cDy9bmOkRr8mudRWf6PAp0O/K/pcNPxkjUuHIZeHZgpkSfh
         kpcg==
X-Gm-Message-State: AOAM53327T+/ndJw2F2KPxGj4NkHvjvnuwUUb/YiEbvkyLWnWp8+1sOo
        3DVuTim+fJfb/zlLO5axUZL8fkrk8Ec6YJQ7EDuWbpXq8Zs=
X-Google-Smtp-Source: ABdhPJys2zb2fshiWFKLJdiCszm2OMSjdxjogTaWYvNjAaVojo2Bs3aKRKfSO+S6300GpAf2g6GZY+wf2Woq4e9L0fc=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr13068365otu.254.1637760054068;
 Wed, 24 Nov 2021 05:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20211027082237.26759-1-rui.zhang@intel.com> <20211027082237.26759-3-rui.zhang@intel.com>
In-Reply-To: <20211027082237.26759-3-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 14:20:43 +0100
Message-ID: <CAJZ5v0juUmxM5gRa5WW=fXo18idRrKGpYmNTF=JFVf5hmscW2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] intel_idle: fix cpuidle_device unregistration
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> cpuidle_device is allocated as percpu data, and it is registered for every
> CPU that has ever been onlined.
> When unregistering, checking current online CPUs is not sufficient,
> because some cpu may be offlined later with its cpuidle_device registered.

But the unregistration happens only in the error code path of
intel_idle_init(), doesn't it?

While I agree that doing a for_each_present_cpu() walk for that is
more prudent', I'm not sure if that makes any difference in practice.

> Fix this by using for_each_present_cpu() instead, and unregistering all
> the cpuidle_devices that have been registered.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e7f2a5f85bf9..9e916e2adc89 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1687,8 +1687,13 @@ static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
>
>         if (intel_idle_cpuhp_state > 0)
>                 cpuhp_remove_state(intel_idle_cpuhp_state);
> -       for_each_online_cpu(i)
> -               cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
> +       for_each_present_cpu(i) {
> +               struct cpuidle_device *dev;
> +
> +               dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
> +               if (dev->registered)

dev->registered is checked by cpuidle_unregister_device().

> +                       cpuidle_unregister_device(dev);
> +       }
>         cpuidle_unregister_driver(drv);
>         free_percpu(intel_idle_cpuidle_devices);
>  }
> --
