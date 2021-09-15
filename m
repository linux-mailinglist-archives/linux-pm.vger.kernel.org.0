Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829740C4E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 14:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhIOMGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 08:06:52 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:40809 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbhIOMGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 08:06:51 -0400
Received: by mail-oo1-f46.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so804329ooh.7;
        Wed, 15 Sep 2021 05:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMf2u34NGnOhwbnxOobe2zbbeVBloCBqlHv3VYYj/vQ=;
        b=HFJuR5xhvJwW83ZNqldbx5uQaqGY6WCZe99Dsoi/g7YxRQla2+kuJn/zxDNobHJJhE
         D64lI2juNYnMtQiGFNTQG2BX2AhcRcl4l2InmuDKtcms9uSnfm0z/uGypY99YBIRbf04
         hEchZFHJOX2lkga5PeCbEGUMooi5p9/4fDjnM53ZFUzHUHx/mFpj7maqaTyIH61qXb79
         1kwC/ImksmRJCRf8SV1sdtef6OO+V2B7wZ6FVaRKrKxkksgekESXtfOPWs/zy4j40hMm
         rHBTRVHGc6Hg3rpeQvZFlqnJIPtz5wzN9zSFacPxnxXA0Xs1y83QvTiksB46DbRQsjlI
         C4NQ==
X-Gm-Message-State: AOAM530SPH3u5CMUZZt/V+If5c93bK4ZB3c++A9yYrYseUU90iBhTS5m
        UVikOq34vSQjvHrImErFhqzlX9W6Q/iRkVIWLvM=
X-Google-Smtp-Source: ABdhPJwaeDCJw4wkhR5ZHBVb9QM2iz4q8UB8AAgsUqRj4I9J/aa9yR156ZHujEIzC1fasNUq+u9txobijOgV3qrwrwg=
X-Received: by 2002:a4a:a78a:: with SMTP id l10mr17920412oom.30.1631707532223;
 Wed, 15 Sep 2021 05:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210915022328.56702-1-f.fainelli@gmail.com>
In-Reply-To: <20210915022328.56702-1-f.fainelli@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 14:05:20 +0200
Message-ID: <CAJZ5v0hEjQn-yr29RdpfYcsfqMCv_BK8obZy7kFP1q0SeM0Zxg@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Do not assume that "mem" is always present
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 15, 2021 at 4:23 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> An implementation of suspend_ops is allowed to reject the PM_SUSPEND_MEM
> suspend type from its ->valid() callback, we should not assume that it
> is always present as this is not a correct reflection of what a firmware
> interface may support.
>
> Fixes: 406e79385f32 ("PM / sleep: System sleep state selection interface rework")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  kernel/power/suspend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index eb75f394a059..02e306ad8db8 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -171,8 +171,7 @@ static bool valid_state(suspend_state_t state)
>
>  void __init pm_states_init(void)
>  {
> -       /* "mem" and "freeze" are always present in /sys/power/state. */
> -       pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
> +       /* "freeze" is always present in /sys/power/state. */
>         pm_states[PM_SUSPEND_TO_IDLE] = pm_labels[PM_SUSPEND_TO_IDLE];
>         /*
>          * Suspend-to-idle should be supported even without any suspend_ops,
> @@ -214,6 +213,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
>         }
>         if (valid_state(PM_SUSPEND_MEM)) {
>                 mem_sleep_states[PM_SUSPEND_MEM] = mem_sleep_labels[PM_SUSPEND_MEM];
> +               pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
>                 if (mem_sleep_default >= PM_SUSPEND_MEM)
>                         mem_sleep_current = PM_SUSPEND_MEM;
>         }
> --

Applied as 5.16 material, thanks!
