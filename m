Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D540C4FF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhIOMQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 08:16:27 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:47037 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbhIOMQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 08:16:26 -0400
Received: by mail-oi1-f177.google.com with SMTP id w144so3847064oie.13;
        Wed, 15 Sep 2021 05:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVoKhQMadoazrYqvBJf6sjlsjVA0vPUwCX5n5F/L45k=;
        b=pC6ut59k0UdWWwzmqciW2y0HNvuTz+loqurzaF943sAoWN66w+jEeXDEI4yQFnEc/k
         4Ai3cNQynqMHB8nfC8zcslTa3NVAnrch6DRGtFQbR5nep8JO7lFveE7IUWqg4zXDbWZb
         NJ/nMLoObkXcZ5R2YP6BNg4VKUHHoEqujJq5rxCMygcgp5E56bPEjhVp9UEFmmnl01Li
         u8RrciORrf6FEMSLbTCl6RPvzXN89GPYqN3qTf7i/wKsI1vJIJ5z+mOTd6zMDtHzZbJV
         t5uUOryLPYKPEvmF5m//weBGHLFTwNZ15XckrXp6JQJvqG5nVHT/b4TQ+KvWiejHPm8l
         iCCA==
X-Gm-Message-State: AOAM533AlmXNUqT2y0mjPlC8L0fFZwo9b1AxUCm9eihuRFgZR/Xv1KBp
        NwH9qHioZuxOT06VuOI1CVPsJ5GFEl48m2pQ9tc=
X-Google-Smtp-Source: ABdhPJxiXPyfVZ86C3VvELmHrJtllKoriucpmjNpPoJ++iUpceHQmZsmie3jG5VVjOErZWWEHSmr5E4H3r14jTOif5I=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr4773694ois.69.1631708107631;
 Wed, 15 Sep 2021 05:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210906183440.85710-1-anelkz@amazon.de>
In-Reply-To: <20210906183440.85710-1-anelkz@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 14:14:56 +0200
Message-ID: <CAJZ5v0ghTGx_1Y5R07pJ9CkTxrMjs=nj2UefeJn6Yh5ud2uP2A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Fix memory leaks
To:     Anel Orazgaliyeva <anelkz@amazon.de>
Cc:     Aman Priyadarshi <apeureka@amazon.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 8:35 PM Anel Orazgaliyeva <anelkz@amazon.de> wrote:
>
> Commit c343bf1ba5ef ("cpuidle: Fix three reference count leaks")
> fixes the cleanup of kobjects; however, it removes kfree() calls
> altogether, leading to memory leaks.

Wait, won't the cleanup be done by cpuidle_free_state_kobj()?

> Fix those and also defer the initialization of dev->kobj_dev until
> after the error check, so that we do not end up with a dangling
> pointer.
>
> Signed-off-by: Anel Orazgaliyeva <anelkz@amazon.de>
> Suggested-by: Aman Priyadarshi <apeureka@amazon.de>
> ---
>  drivers/cpuidle/sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 53ec9585ccd4..469e18547d06 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -488,6 +488,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
>                                            &kdev->kobj, "state%d", i);
>                 if (ret) {
>                         kobject_put(&kobj->kobj);
> +                       kfree(kobj);
>                         goto error_state;
>                 }
>                 cpuidle_add_s2idle_attr_group(kobj);
> @@ -619,6 +620,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
>                                    &kdev->kobj, "driver");
>         if (ret) {
>                 kobject_put(&kdrv->kobj);
> +               kfree(kdrv);
>                 return ret;
>         }
>
> @@ -705,7 +707,6 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
>         if (!kdev)
>                 return -ENOMEM;
>         kdev->dev = dev;
> -       dev->kobj_dev = kdev;
>
>         init_completion(&kdev->kobj_unregister);
>
> @@ -713,9 +714,11 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
>                                    "cpuidle");
>         if (error) {
>                 kobject_put(&kdev->kobj);
> +               kfree(kdev);
>                 return error;
>         }
>
> +       dev->kobj_dev = kdev;
>         kobject_uevent(&kdev->kobj, KOBJ_ADD);
>
>         return 0;
> --
> 2.32.0
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
