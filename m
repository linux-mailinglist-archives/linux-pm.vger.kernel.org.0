Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06D1E8336
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgE2QJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 12:09:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36061 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 12:09:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id h7so2342138otr.3;
        Fri, 29 May 2020 09:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kor8EfOYBepC7cHCZaAuPT3ixwWluZI0nzQn7RAc+Mk=;
        b=pmnCeBnZPckulMfXWGNoS/JaLRGoXvCTVU5gV5arG3Po0iX9Unm59kJamHQ/GZ7Wj1
         CBAfMZVtw5ZrLCyZZaBibhNdBgAp4OPTheq2PTWZvh2/rbKvlOgpQ54EeIUwejb1SEH9
         FBR80efQqT2ePxmSPvi1YWolJwKsjanGqRFiPLibf3qIRysi0KSOBFRG2KwHY+HnCJbK
         xv9Nmw+0LC44GTS2aGRiITvlyP2+aIsQKS5QFXI5UZylJPjN4qJ3NlU+oTiyhtfRh25F
         0/Hu386Uanvu3WBW2gK1ZphKG8GohxvXRG8Qam+ujhN8F858NQQn7qD922d6z5nxscqE
         SYKg==
X-Gm-Message-State: AOAM532ALUm/PMUNRGppj0VAwF+4Pz7zo/U44ZNhyO1JoqcMQyIPCGPr
        vs2uh1o72YLfg0Xkf0M9gl+/j7wzMSNqZWnSNDc=
X-Google-Smtp-Source: ABdhPJwjM+ICsGKgZcwtJbIgXNIutRUNdgtdT7teYn4gCXH8umdEGlq2PjsB+thkpYgdWrHDyg/zMnhD7No8oyJhyXE=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr4810443otq.167.1590768541943;
 Fri, 29 May 2020 09:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200528182046.845-1-wu000273@umn.edu>
In-Reply-To: <20200528182046.845-1-wu000273@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 May 2020 18:08:50 +0200
Message-ID: <CAJZ5v0jNUPqAGZ9RO4UYyT_kQdG1fPqkFaRLp854tavzLe8R+A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Fix several reference count leaks.
To:     wu000273@umn.edu
Cc:     Kangjie Lu <kjlu@umn.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 28, 2020 at 8:21 PM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem.
>
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/cpuidle/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index cdeedbf02646..55107565b319 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -515,7 +515,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>                 ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
>                                            &kdev->kobj, "state%d", i);
>                 if (ret) {
> -                       kfree(kobj);
> +                       kobject_put(&kobj->kobj);
>                         goto error_state;
>                 }
>                 cpuidle_add_s2idle_attr_group(kobj);
> @@ -646,7 +646,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
>         ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
>                                    &kdev->kobj, "driver");
>         if (ret) {
> -               kfree(kdrv);
> +               kobject_put(&kdrv->kobj);
>                 return ret;
>         }
>
> @@ -740,7 +740,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
>         error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
>                                    "cpuidle");
>         if (error) {
> -               kfree(kdev);
> +               kobject_put(&kdev->kobj);
>                 return error;
>         }
>
> --

Applied as 5.8 material, thanks!
