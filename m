Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E6633425
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 04:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKVDpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 22:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiKVDpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 22:45:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5622873F
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 19:45:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z20so17431589edc.13
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 19:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QR536p2gGCkxha4o6fxwGlER6MG9ufp5pleM3jEqWQk=;
        b=b3ExBeffr1D3+LEQamxGefmMUYbjmpT3u6jRUjrkL/C+PLfrKZBl6TWNYnN/DQGDbB
         nhSZ07fjBLunlkqbBhIHMAmuiqKUO3Blptvy1LDhu2XfyJt7sgi4BysOcjh2ZNho81qL
         Fx7aUCmd+BAQ1euG8yOB7ggsYOgJAir87382ZIeFHFHPGw6L+dVubrxli3rWU7qQzDpF
         mBouFsjyC1LLhMSMeiMqBWT9Z0zlgwFMePqn1FQj/AEWmNPACDB6JfixFA0/gkKV5aRU
         EvLFK3YhQHQHl5QMAH5hQUvZc/JJSgB9f3M4LKUhZZPmxeHrSZAquHcBUcqaeCmXStyt
         VF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR536p2gGCkxha4o6fxwGlER6MG9ufp5pleM3jEqWQk=;
        b=5m1SbBMCfc3spC8XxZ66+U1p8aFJt53Qrzv7SBAlVU/09VeSsBR8Lu29xT3IHvMbuA
         7X1hHxtCt0dlwc+X2fp5d/cngLlgPnURniBxsWGsvyP8aVvTtW9RTlxUwV5oZuW0a8Yr
         +lzFXV3bVF8sjhNii6PjRUDvJzMaHId6L8LOCB+T7kim0r80HXuI5qWULuaqOHD9sm1M
         2P4aGD2u5YzgI86RmUrxEP31mhzyBKJkKiAgBDRRMSqCSCae6b/+wSf2Zu36tuorwuvL
         b0qa8rE2ohbFLuRqldKvJuFxiaK6Nv7d5iCu6g9VDoyls4GDDIGfxIQYL4xY9d7GeMSb
         jyPA==
X-Gm-Message-State: ANoB5pmzg5t+KKxOA5qD/90ZfnNZLiK4MjAXTeVuswCYUGeqVQf0qZO+
        +z2dJEVbiM8rBIKHZ+KHx87a5GiexJyAFmCff8TWkw==
X-Google-Smtp-Source: AA0mqf4yjz0wapNgLrXP9qbZGJveXMpt82Pv41iphT5tamJREHPQUqBSmnJFZtQ3+mtnteYXCcxFIg1XvFB8LbzD0ZY=
X-Received: by 2002:a05:6402:399a:b0:468:fdf2:477f with SMTP id
 fk26-20020a056402399a00b00468fdf2477fmr16691217edb.329.1669088719273; Mon, 21
 Nov 2022 19:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20221121205647.23343-1-palmer@rivosinc.com>
In-Reply-To: <20221121205647.23343-1-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 22 Nov 2022 09:15:07 +0530
Message-ID: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> As per [1], whether or not the core can wake up from non-retentive
> suspend is a platform-specific detail.  We don't have any way to encode
> that, so just stop using them until we've sorted that out.
>
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

This is just unnecessary maintenance churn and it's not the
right way to go. Better to fix this the right way instead of having
a temporary fix.

I had already sent-out a patch series 5 months back to describe
this in DT:
https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/

No one has commented/suggested anything (except Samuel
Holland and Sudeep Holla).

Please review this series. I can quickly address comments to
make this available for Linux-6.2. Until this series is merged,
the affected platforms can simply remove non-retentive suspend
states from their DT.

With all due respect, NACK to this patch from my side.

Regards,
Anup

>
> ---
>
> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
> Events are stopped during CPU suspend"), which fixes suspend on the D1
> but breaks timers everywhere.
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 05fe2902df9a..9d1063a54495 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>         if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>             state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>                 return false;
> +
> +       /*
> +        * Whether or not RISC-V systems deliver interrupts to harts in a
> +        * non-retentive suspend state is a platform-specific detail.  This can
> +        * leave the hart unable to wake up, so just mark these states as
> +        * unsupported until we have a mechanism to expose these
> +        * platform-specific details to Linux.
> +        */
> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +               return false;
> +
>         return true;
>  }
>
> --
> 2.38.1
>
