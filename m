Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC604299C0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhJKXS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 19:18:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59528 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJKXSz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 19:18:55 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ma4XD-0001SF-O2; Tue, 12 Oct 2021 01:16:43 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH v8 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Tue, 12 Oct 2021 01:16:42 +0200
Message-ID: <4300884.9bbH7Ay9ha@diego>
In-Reply-To: <20211011081820.1135261-2-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com> <20211011081820.1135261-2-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anup,

Am Montag, 11. Oktober 2021, 10:18:13 CEST schrieb Anup Patel:
> We force select CPU_PM and provide asm/cpuidle.h so that we can
> use CPU IDLE drivers for Linux RISC-V kernel.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig                |  7 +++++++
>  arch/riscv/configs/defconfig      |  1 +
>  arch/riscv/configs/rv32_defconfig |  1 +
>  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/process.c       |  3 ++-
>  5 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8de2afb460f7..d02f1f5a2431 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV
>  	select CLONE_BACKWARDS
>  	select CLINT_TIMER if !MMU
>  	select COMMON_CLK
> +	select CPU_PM if CPU_IDLE
>  	select EDAC_SUPPORT
>  	select GENERIC_ARCH_TOPOLOGY if SMP
>  	select GENERIC_ATOMIC64 if !64BIT
> @@ -564,5 +565,11 @@ source "kernel/power/Kconfig"
>  
>  endmenu
>  
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>  source "arch/riscv/kvm/Kconfig"
>  source "drivers/firmware/Kconfig"

another issue, the "arch/riscv/kvm/Kconfig" line above comes from a
commit that is not in the riscv-tree at all but in the kvm-tree [0],
making this patch fail to apply onto riscv/for-next alone.

If you have multiple independent patch series in flight, like shown in
the github branch you references, it might be easier to base each on
top of the relevant branch cleanly and after one gets applied rebase
the other ones.

That way you're not dependent on the others going in first and also
people can test patch series individually without too much hassle.

Thanks
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/commit/?h=next&id=99cdc6c18c2d815e940e81b9b477d469bdd41788


