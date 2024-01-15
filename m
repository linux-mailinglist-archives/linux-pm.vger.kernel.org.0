Return-Path: <linux-pm+bounces-2206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3982DC48
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE3F1F21BB2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924301798E;
	Mon, 15 Jan 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S04UjvDx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAF1798C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55969c01168so926068a12.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705332317; x=1705937117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3Au/gRaaczdqwoxq154l1Vb0TSRdBUZsRRgmxL/3EA=;
        b=S04UjvDxCv+YJv+ugX5uV3+beXSeeLRov+lehLqMSpkd8QTum/jqGWqjflt2haN3CS
         CgpZQfYEWBqrmyGJK7Q17nS+eP++ks0juctFVvZ7xw3MMVPVA6hIwGuydFHDg37hglOq
         2WyzuOIOvdzPfebTb/bYQxVkH+Pzach3nstMq9E2ysVmddap+CgvI585VE40ujQnrXjS
         IwRjXSZWZsOwRkPWaSSswZZ1xU2KjJD4waZniGCHroTmFWRpushu8Z6PoFCig8DkrYZ0
         x3oM+J8dBoyTpBi1faJR5FX2yD8Smgqm4DQIkhmh9vUG+pFcYtgg5IwB92VKv7niRhgN
         ejjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332317; x=1705937117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Au/gRaaczdqwoxq154l1Vb0TSRdBUZsRRgmxL/3EA=;
        b=rV7USWVhITUxf/JFen+Dp+qKtgV4m772JNcR1LGbWGRKTXIA96wnQPUQS2MeMtzPkB
         hlzpqcisdoMdmBTPIF6uwSSPmdpKkMnCYYUti73l04TwhxoSr+vx7sNMNgqtiESGGH4c
         9Jl8WWzKlnM2ItxTDTt/RrOFIRMK3LffpL/mwI62g8ggEFqPLO+/0msUiSrrtybSY3bK
         lsVPP+lE/ApzH22sVlYg/ePvgUqRrW4SEESNQDrxg1vwhTpQ9ipZQGv+sfDP3hI6frxf
         E2j+SmNoLuECCbrTzBwtPTee76MD7YWzUSvblpEatE9cC8M6LhQLi7cmtKUcfq2XyGk2
         um3g==
X-Gm-Message-State: AOJu0YwDSUXhs2Nrz77B1YvgbImzfIwDGw+n/0y0tRMwW7h06utGdy7f
	v2tL0D/Gl+zTseWxuGWQyNWGIyKVTndQdw==
X-Google-Smtp-Source: AGHT+IFVcJIOzgkm0o7Kllwec4Tc/GzqZS761LXVytipb32050OjQDT49hpCnD8tQxYIJBuIt52jzA==
X-Received: by 2002:a05:6402:1ca8:b0:558:b48a:b5f1 with SMTP id cz8-20020a0564021ca800b00558b48ab5f1mr6094220edb.7.1705332317286;
        Mon, 15 Jan 2024 07:25:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b23-20020a056402139700b0055920196ddesm2446466edv.54.2024.01.15.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:25:16 -0800 (PST)
Date: Mon, 15 Jan 2024 16:25:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 -next 2/3] ACPI: RISC-V: Add LPI driver
Message-ID: <20240115-94bdb396ea417ca1d834548d@orel>
References: <20240115101056.429471-1-sunilvl@ventanamicro.com>
 <20240115101056.429471-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115101056.429471-3-sunilvl@ventanamicro.com>

On Mon, Jan 15, 2024 at 03:40:55PM +0530, Sunil V L wrote:
> Enable Low Power Idle (LPI) based cpuidle driver for RISC-V platforms.
> It depends on SBI HSM calls for idle state transitions.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/Makefile  |  3 +-
>  drivers/acpi/riscv/cpuidle.c | 81 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/cpuidle.c
> 
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 8b3b126e0b94..7309d92dd477 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y 	+= rhct.o
> +obj-y					+= rhct.o
> +obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
> diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
> new file mode 100644
> index 000000000000..052ec3942902
> --- /dev/null
> +++ b/drivers/acpi/riscv/cpuidle.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <acpi/processor.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
> +#include <linux/suspend.h>
> +#include <asm/cpuidle.h>
> +#include <asm/sbi.h>
> +#include <asm/suspend.h>
> +
> +#define RISCV_FFH_LPI_TYPE_MASK	GENMASK_ULL(63, 60)
> +#define RISCV_FFH_LPI_RSVD_MASK	GENMASK_ULL(59, 32)
> +
> +#define RISCV_FFH_LPI_TYPE_SBI	BIT_ULL(60)
> +
> +static int acpi_cpu_init_idle(unsigned int cpu)
> +{
> +	int i;
> +	struct acpi_lpi_state *lpi;
> +	struct acpi_processor *pr = per_cpu(processors, cpu);
> +
> +	if (unlikely(!pr || !pr->flags.has_lpi))
> +		return -EINVAL;
> +
> +	if (!is_sbi_hsm_supported())
> +		return -ENODEV;
> +
> +	if (pr->power.count <= 1)
> +		return -ENODEV;
> +
> +	for (i = 1; i < pr->power.count; i++) {
> +		u32 state;
> +
> +		lpi = &pr->power.lpi_states[i];
> +
> +		/*
> +		 * Validate Entry Method as per FFH spec.
> +		 * bits[63:60] should be 0x1
> +		 * bits[59:32] should be 0x0
> +		 * bits[31:0] represent a SBI power_state
> +		 */
> +		if (((lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI) ||
> +		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> +			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
> +			return -EINVAL;
> +		}
> +
> +		state = lpi->address;
> +		if (!sbi_suspend_state_is_valid(state)) {
> +			pr_warn("Invalid SBI power state %#x\n", state);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> +{
> +	return acpi_cpu_init_idle(cpu);
> +}
> +
> +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +{
> +	u32 state = lpi->address;
> +
> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
> +						   lpi->index,
> +						   state);
> +	else
> +		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> +							     lpi->index,
> +							     state);
> +}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

