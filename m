Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2461722CC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgB0QGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 11:06:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40562 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgB0QGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 11:06:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so3938043ljj.7;
        Thu, 27 Feb 2020 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aeAAGL1lN/mti66y5xOWWYla0SoqdV+XcmEKiiyHrQ=;
        b=k1OJ5Kog27zuKwJHPC5y6tnPBYX5HF2ktRokz4/EhYbZyLw8rjnfQ32BqqC5E2eX/c
         ATNlvZEpSrTeED5xQ0ecEYwJjjquqZEjEVDk9079Z6Fk0M8yicFeN+EtyqD970kUdowa
         pLx4AzfK1XJG0bmG/VcP5AewgU2sIAR0+9+ypa0s13535oMKnbG1FDAh5h1IhnZvnPB5
         aCmp3G91iD6KEMxaUFKIIgsju7Kc+Fuko82IBNEUtoXzKwgZRTyEjiE6/0fGX0Ct+H4D
         ulkjg+KbA0Aj/ZcyiM6hz+9kxz0phQ+PHZLLFW1k7oswnzb113MuCi/t5Pd/C70DpEy+
         M6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aeAAGL1lN/mti66y5xOWWYla0SoqdV+XcmEKiiyHrQ=;
        b=Jk5UpLPjzNvvs5G3C+NMgUZGmBdAD4QkBcyTay6tFCLLdF2xcCmRaRrSxAFEE5oMe9
         ob52IueJ2AJOApb5bGdXEwXnEOxLQiO632LoHWEFkuuZBQ2LOGhb8+BcJk4+ICpHd0yd
         1B39lLC/4tUk4K3MV7ZUC4Zj8qchFuWEd48JJmSqNHMkZYafySYgY1skfJrXK8Syt2je
         ug88pGUyFnUM+VkEX9LIO9nbuEDzn3q70WAjpVWAus1dbg0S9Y33YPzxSCWc02BvNMkk
         S2k6ctBmBgyr8t62dULYGyGb0cOvzosoCYUUcbclH/6Uz7D0KD4AAanWYzJP7hsnuFZ2
         PRDA==
X-Gm-Message-State: ANhLgQ32kzWftzhibuyWCHoCmI7nHxbDULMKYZBURo4zzGasFubv4kCL
        l1DOAV4WWg3BEMH54LerxavoDakfQHIWKcip14o=
X-Google-Smtp-Source: ADFU+vtLvp5dq+6TDzZtWM2VvPfgxIDR+ELg2azdIqTGKxI6g2SIZep9LmGFxz0v2Bdx3XotYMzbsefl0IspdMoxK0U=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr124172ljk.13.1582819588888;
 Thu, 27 Feb 2020 08:06:28 -0800 (PST)
MIME-Version: 1.0
References: <2d0854b00d7f85e988aff4f8186e8ac5d8a9aff2.1581410798.git.baolin.wang7@gmail.com>
In-Reply-To: <2d0854b00d7f85e988aff4f8186e8ac5d8a9aff2.1581410798.git.baolin.wang7@gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 28 Feb 2020 00:06:17 +0800
Message-ID: <CA+H2tpFAZuPSH0EErLt0Lj=TKLVq3XwEox06tbGzFaquSpKa0w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Allow charger manager can be built as a module
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lyra Zhang <zhang.lyra@gmail.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian and other guys here,

On Tue, Feb 11, 2020 at 4:51 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Allow charger manager can be built as a module like other charger
> drivers.
>
What do you think about this patch?
We want to set charger-manager as module in our project for new Android devices.

-Orson

> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/power/supply/Kconfig          |    2 +-
>  include/linux/power/charger-manager.h |    7 +------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 9a5591a..195bc04 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -480,7 +480,7 @@ config CHARGER_GPIO
>           called gpio-charger.
>
>  config CHARGER_MANAGER
> -       bool "Battery charger manager for multiple chargers"
> +       tristate "Battery charger manager for multiple chargers"
>         depends on REGULATOR
>         select EXTCON
>         help
> diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
> index ad19e68..40493b2 100644
> --- a/include/linux/power/charger-manager.h
> +++ b/include/linux/power/charger-manager.h
> @@ -248,11 +248,6 @@ struct charger_manager {
>         u64 charging_end_time;
>  };
>
> -#ifdef CONFIG_CHARGER_MANAGER
>  extern void cm_notify_event(struct power_supply *psy,
> -                               enum cm_event_types type, char *msg);
> -#else
> -static inline void cm_notify_event(struct power_supply *psy,
> -                               enum cm_event_types type, char *msg) { }
> -#endif
> +                           enum cm_event_types type, char *msg);
>  #endif /* _CHARGER_MANAGER_H */
> --
> 1.7.9.5
>
