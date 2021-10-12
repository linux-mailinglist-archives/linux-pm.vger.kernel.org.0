Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5A42ACE9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhJLTFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 15:05:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38644 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhJLTFX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Oct 2021 15:05:23 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maMdv-0007d3-Gg; Tue, 12 Oct 2021 20:36:51 +0200
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
Subject: Re: [PATCH v9 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Tue, 12 Oct 2021 20:36:50 +0200
Message-ID: <5247988.8z7lCFx90T@diego>
In-Reply-To: <20211012095857.1314214-5-anup.patel@wdc.com>
References: <20211012095857.1314214-1-anup.patel@wdc.com> <20211012095857.1314214-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anup,

Am Dienstag, 12. Oktober 2021, 11:58:53 CEST schrieb Anup Patel:
> We add defines related to SBI HSM suspend call and also
> update HSM states naming as-per latest SBI specification.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks like this patch depends on your SRST patch.
("RISC-V: Use SBI SRST extension when available").

Looking at the history this seems to have been last posted in june 2021
with the conversation stalling around july.

I guess as this was so long ago, that patch might've dropped out of
peoples inboxes and a resend might be in order?


Heiko

> ---
>  arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
>  arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 289621da4a2a..ab9782f8da52 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -62,15 +62,32 @@ enum sbi_ext_hsm_fid {
>  	SBI_EXT_HSM_HART_START = 0,
>  	SBI_EXT_HSM_HART_STOP,
>  	SBI_EXT_HSM_HART_STATUS,
> +	SBI_EXT_HSM_HART_SUSPEND,
>  };
>  
> -enum sbi_hsm_hart_status {
> -	SBI_HSM_HART_STATUS_STARTED = 0,
> -	SBI_HSM_HART_STATUS_STOPPED,
> -	SBI_HSM_HART_STATUS_START_PENDING,
> -	SBI_HSM_HART_STATUS_STOP_PENDING,
> +enum sbi_hsm_hart_state {
> +	SBI_HSM_STATE_STARTED = 0,
> +	SBI_HSM_STATE_STOPPED,
> +	SBI_HSM_STATE_START_PENDING,
> +	SBI_HSM_STATE_STOP_PENDING,
> +	SBI_HSM_STATE_SUSPENDED,
> +	SBI_HSM_STATE_SUSPEND_PENDING,
> +	SBI_HSM_STATE_RESUME_PENDING,
>  };
>  
> +#define SBI_HSM_SUSP_BASE_MASK			0x7fffffff
> +#define SBI_HSM_SUSP_NON_RET_BIT		0x80000000
> +#define SBI_HSM_SUSP_PLAT_BASE			0x10000000
> +
> +#define SBI_HSM_SUSPEND_RET_DEFAULT		0x00000000
> +#define SBI_HSM_SUSPEND_RET_PLATFORM		SBI_HSM_SUSP_PLAT_BASE
> +#define SBI_HSM_SUSPEND_RET_LAST		SBI_HSM_SUSP_BASE_MASK
> +#define SBI_HSM_SUSPEND_NON_RET_DEFAULT		SBI_HSM_SUSP_NON_RET_BIT
> +#define SBI_HSM_SUSPEND_NON_RET_PLATFORM	(SBI_HSM_SUSP_NON_RET_BIT | \
> +						 SBI_HSM_SUSP_PLAT_BASE)
> +#define SBI_HSM_SUSPEND_NON_RET_LAST		(SBI_HSM_SUSP_NON_RET_BIT | \
> +						 SBI_HSM_SUSP_BASE_MASK)
> +
>  enum sbi_ext_srst_fid {
>  	SBI_EXT_SRST_RESET = 0,
>  };
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 685fae72b7f5..5fd90f03a3e9 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -97,7 +97,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
>  
>  	rc = sbi_hsm_hart_get_status(hartid);
>  
> -	if (rc == SBI_HSM_HART_STATUS_STOPPED)
> +	if (rc == SBI_HSM_STATE_STOPPED)
>  		return 0;
>  	return rc;
>  }
> 




