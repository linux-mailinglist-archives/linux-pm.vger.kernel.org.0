Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7323E05FB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbhHDQcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 12:32:47 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34711 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhHDQcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 12:32:47 -0400
Received: by mail-oi1-f176.google.com with SMTP id t128so3528993oig.1;
        Wed, 04 Aug 2021 09:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWa0uh1W/Nbg1hoTafvW6Mebrx5ojhLkUa52uY/Ibow=;
        b=iXVpWRQB9v63X2IXmirShLmiPi/oka3OZDc34O2ueIosTM73QIf8Fj9ARYPKrmHkGG
         6qJSCYBBzMKUJpdCJyBp/yd8MJfZCC4+/4ICTkJS2uptyqiG7IHRBiQlQversMjPjvUj
         tnAABiK137P6UYu0eRvxhgQSQdEloANI0vC5zaWiXcCgzCLZIwMBswgSt0uaylvHWBej
         7Kxh/jFq8M7p5sxj2/gMCYC5zb52FEI6WSHqfAyhB09zdOE8+dvyJjIBSfVwGPrehVjY
         ySc70mJl60m2p6A6OE+7kRmJqQN6hB7NlymlQ3FvRO4UP7pkrYfDwGFCy4nJkfg+JxvQ
         drWw==
X-Gm-Message-State: AOAM533igL+f39MIPkVLVqLpW9qwXWaYo78whWKt+HdYBpItu4jZW3J0
        PeZNIVs0a2dksX19/oiY8VjG+H+YrJnYyzOOVuk=
X-Google-Smtp-Source: ABdhPJwYJaxTvwoQsTuJQ3gY1ToMd6A4tR89WOhB/00Vc/v+4MY2E3Nw7eWF1E6hMBoqxauDkn2IUysCOeRg6RQvfq0=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr252366oib.71.1628094753377;
 Wed, 04 Aug 2021 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210709003204.26944-1-win239@126.com>
In-Reply-To: <20210709003204.26944-1-win239@126.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 18:32:22 +0200
Message-ID: <CAJZ5v0iXyAgfVrKthkxwK-PL5vH9EXfLguR0LsJPP=k7a3Ukug@mail.gmail.com>
Subject: Re: [PATCH] PM / s2idle: Fix the failure of specifying
 "mem_sleep_default=" parameter
To:     xiongxin <win239@126.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xiongxin <xiongxin@kylinos.cn>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 9, 2021 at 3:03 AM xiongxin <win239@126.com> wrote:
>
> From: xiongxin <xiongxin@kylinos.cn>
>
> On the arm64 platform, the psci driver is used by default to set the
> suspend_ops structure; but the psci_acpi_init() function is called
> before the command-line parameter "mem_sleep_default=" is specified;

You seem to mean that psci_acpi_init() runs before
mem_sleep_default_setup() and so there is a confusion regarding the
mem_sleep_default setting.

Clearly, suspend_ops cannot be set before mem_sleep_default_setup()
runs, so I'd prefer to fix the ordering instead of hacking the latter
to fix up the mess.

> the user cannot set the desired suspend mode through the
> "mem_sleep_default=" parameter;
>
> In mem_sleep_default_setup(), judge whether suspend_ops is set, if it
> has been assigned, rewrite the value of mem_sleep_current variable; in
> order to complete the user setting;
>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index d8cae434f9eb..bef4b17de3f6 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -192,6 +192,21 @@ static int __init mem_sleep_default_setup(char *str)
>                         break;
>                 }
>
> +       /*
> +        * When the suspend_ops has been set, "mem_sleep_default=*" will
> +        * be invalid, here to fix this situation.
> +        */
> +       if (suspend_ops) {
> +               if (mem_sleep_default == PM_SUSPEND_TO_IDLE)
> +                       mem_sleep_current = PM_SUSPEND_TO_IDLE;
> +               else if ((mem_sleep_default == PM_SUSPEND_STANDBY) &&
> +                               valid_state(PM_SUSPEND_STANDBY))
> +                       mem_sleep_current = PM_SUSPEND_STANDBY;
> +               else if ((mem_sleep_default >= PM_SUSPEND_MEM) &&
> +                               valid_state(PM_SUSPEND_MEM))
> +                       mem_sleep_current = PM_SUSPEND_MEM;
> +       }
> +
>         return 1;
>  }
>  __setup("mem_sleep_default=", mem_sleep_default_setup);
> --
> 2.25.1
>
