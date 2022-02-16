Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4C4B7C49
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 02:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiBPA5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Feb 2022 19:57:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiBPA53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Feb 2022 19:57:29 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64744DCE11
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 16:57:18 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e140so1262676ybh.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 16:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8G5LYNj0LAd4VWKhX4PRkQunQsiCSSKv2IZ3Pf+XZs=;
        b=gpERkwaSaLIxACa9WIVhxhGtJssexFQa3ON9pkBRsTjx4PNq0MQw2kjCHUZz4hQjFI
         X4MeU8dMf0P33tjb48vBqe9UNBGOrBYQpILedHOhpC7eX44P1DuShRsNX9XjfoAcud+f
         y8FClYnR/o87poChRgDdKBi4llSa+2dvnrZXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8G5LYNj0LAd4VWKhX4PRkQunQsiCSSKv2IZ3Pf+XZs=;
        b=5Oe0XPkF54QqMCZgQ5Ms78NYLc3aXWWOGaQoYELXDeajR0b+eQkF0QI8BSLVPj1YT4
         LQGrWzFbPET3ap2eS6dpMLwFHgmso+68xolBJHH1Zg9HU9SHzYw2OYqV5fhp3OlPbAYo
         mh1Ze2vcZ1mWKl6IyMnkq+4LXVoE8vJ0GkRA7cSG+WP2dNhGXzwA+dcKoIKAC+l/M44d
         hHxfq9wd9gnKH9VN8yzPBfJYTefbRD0SM19OdY1lUj9KgoWkRJ7t3ZBtTT+6avcxTp5P
         C/m9nQ/1ki5xwzcFHv0sWa+Y+rsqhAd5lLO5J9MMqMkqcf99WC+7HwfX+Ikn82/2xiop
         19jA==
X-Gm-Message-State: AOAM530EJ0hQwc1qBlOVpLAottY5pHMQ3bZ9qDJg6OSBp3zcSsl6WisJ
        RFZTlAZi9vvMYqe1nyj08sr1FSRXJ91VTdM99tfP
X-Google-Smtp-Source: ABdhPJxWU3rQFdHx9DRWoyTLBAygvzH/GruMqzNlGu+Yz+32ovLqbluWBIZUb8NNplrLnx1jx1ox/IdWtkgRPbbh3v8=
X-Received: by 2002:a25:9388:0:b0:61d:6ff8:6472 with SMTP id
 a8-20020a259388000000b0061d6ff86472mr208446ybm.121.1644973037573; Tue, 15 Feb
 2022 16:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20220210054947.170134-1-apatel@ventanamicro.com> <20220210054947.170134-3-apatel@ventanamicro.com>
In-Reply-To: <20220210054947.170134-3-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 15 Feb 2022 16:57:06 -0800
Message-ID: <CAOnJCUJHk4Yaj8Dx2-gViJNrRYmmnZqWCUqqddg44QCwCgF4Ag@mail.gmail.com>
Subject: Re: [PATCH v11 2/8] RISC-V: Rename relocate() and make it global
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 9, 2022 at 9:50 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> The low-level relocate() function enables mmu and relocates
> execution to link-time addresses. We rename relocate() function
> to relocate_enable_mmu() function which is more informative.
>
> Also, the relocate_enable_mmu() function will be used in the
> resume path when a CPU wakes-up from a non-retentive suspend
> so we make it global symbol.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/head.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 2363b43312fc..5f4c6b6c4974 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -90,7 +90,8 @@ pe_head_start:
>
>  .align 2
>  #ifdef CONFIG_MMU
> -relocate:
> +       .global relocate_enable_mmu
> +relocate_enable_mmu:
>         /* Relocate return address */
>         la a1, kernel_map
>         XIP_FIXUP_OFFSET a1
> @@ -185,7 +186,7 @@ secondary_start_sbi:
>         /* Enable virtual memory and relocate to virtual address */
>         la a0, swapper_pg_dir
>         XIP_FIXUP_OFFSET a0
> -       call relocate
> +       call relocate_enable_mmu
>  #endif
>         call setup_trap_vector
>         tail smp_callin
> @@ -329,7 +330,7 @@ clear_bss_done:
>  #ifdef CONFIG_MMU
>         la a0, early_pg_dir
>         XIP_FIXUP_OFFSET a0
> -       call relocate
> +       call relocate_enable_mmu
>  #endif /* CONFIG_MMU */
>
>         call setup_trap_vector
> --
> 2.25.1
>



Reviewed-by: Atish Patra <atishp@rivosinc.com>

--
Regards,
Atish
