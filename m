Return-Path: <linux-pm+bounces-2109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2C82ABCC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 11:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ABE282041
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067312E6E;
	Thu, 11 Jan 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U8DS6LvC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E314267
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so564799466b.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704968391; x=1705573191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFpe6quqGni9rXpbkR8i3EOKdmU+rRM5UIvhZyNTIx4=;
        b=U8DS6LvCbGfwQ0WdgUshwoXZAwBck+cCy5BNTN3yHy6mY0ESfS07hv5+zG/8JnKAjB
         BES6pSRHW4q8F+spzopAnvUS+wHvtjV/W4ZCerjNEZzVPhJ1rRqFo2csbMysouavwwmd
         j3TADBp0FTziUpckkW0oud1QzYfFZTaafxJmofsLLPScID2Ina69GdmDr3f8tCedHeSW
         i/56d85vgA57mRkU/tV2XLZV2wNLHlvwe/nN+Ms4eHzU1svmoBJ8wSnl5F2CAvr1VDvj
         yNKl7gNsXa8muvSaqo2P50slDNV9T8ft0zGr3qt73AEvTYKNRxS06FJmEpgg+IYGw/x1
         C2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968391; x=1705573191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFpe6quqGni9rXpbkR8i3EOKdmU+rRM5UIvhZyNTIx4=;
        b=mlyVNr3SevxPoQ9xAtsNYjrDStRIGFgqnE+du7nlIwhUL1Ez/3X0ZrtSbSKKH6FeHg
         oehVN2V0FNQuPGkYr0SywebGWP1E1zEODttpjswFxHR0Mq1XZk9iQFedNH/GrZSaPutI
         t+oC2qI+JnwdidJhu+FLatCbwF8UgSZzzVnbMDWMfPYw5q+PMRzHZ35C3RNmerzlKEwH
         V+wu4MKb4+kga6B02YdrZEPG29AELbtxxYZLmX2blmAOp/LNJ+7t1Sf70++TG5eRNDBh
         1A4af+vhlu4/2vc2CtQ59KeZy/8KoPewtzaEgyJedtzdjP47qxMaDPcPoDKR7XN/HxAT
         lt7A==
X-Gm-Message-State: AOJu0Yz3LyuEZOR7No+8E4h+ngAYDRH8lqvPT3GA93EdTzMvWHg/32kb
	V5oZEkT7D60B0gThxGqvDDi+5ebW18pBXwWpUQwIEIaUOUY=
X-Google-Smtp-Source: AGHT+IFBiFizSgukfmU2Pf8DgRLe/lNPDSpgXIEvVijwWkTDP8QaOfuxfYm/bTSm93if/g/LI4WU0w==
X-Received: by 2002:a17:907:93d1:b0:a28:f817:6a7c with SMTP id cp17-20020a17090793d100b00a28f8176a7cmr377770ejc.3.1704968390975;
        Thu, 11 Jan 2024 02:19:50 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c13-20020a170906170d00b00a2c047c6847sm393036eje.113.2024.01.11.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:19:50 -0800 (PST)
Date: Thu, 11 Jan 2024 11:19:49 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 2/2] cpuidle: RISC-V: Add ACPI LPI support
Message-ID: <20240111-d37d338a6b1aa71e944ebe05@orel>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111093058.121838-3-sunilvl@ventanamicro.com>

On Thu, Jan 11, 2024 at 03:00:58PM +0530, Sunil V L wrote:
> Add required callbacks to support Low Power Idle (LPI) on ACPI based
> RISC-V platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 78 +++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index e8094fc92491..cea67a54ab39 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -632,3 +632,81 @@ static int __init sbi_cpuidle_init(void)
>  	return 0;
>  }
>  device_initcall(sbi_cpuidle_init);
> +
> +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +
> +#include <linux/acpi.h>
> +#include <acpi/processor.h>
> +
> +#define RISCV_FFH_LPI_TYPE_MASK		0x1000000000000000ULL
> +#define RISCV_FFH_LPI_RSVD_MASK		0x0FFFFFFF00000000ULL

GENMASK might look nicer and the type mask is 0xF000000000000000ULL,
where 0x1000000000000000ULL means that the type is an SBI identifier.
We need both defined

#define RISCV_FFH_LPI_TYPE_MASK              0xF000000000000000ULL
#define RISCV_FFH_LPI_TYPE_SBI               0x1000000000000000ULL

as I point out below.

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
> +	/*
> +	 * The SBI HSM suspend function is only available when:
> +	 * 1) SBI version is 0.3 or higher
> +	 * 2) SBI HSM extension is available
> +	 */
> +	if (sbi_spec_version < sbi_mk_version(0, 3) ||
> +	    !sbi_probe_extension(SBI_EXT_HSM)) {
> +		pr_warn("HSM suspend not available\n");

The comment and these lines match what's done in sbi_cpuidle_init().
How about a static helper function to avoid duplication?

> +		return -EINVAL;
> +	}
> +
> +	if (pr->power.count <= 1)
> +		return -ENODEV;
> +
> +	for (i = 1; i < pr->power.count; i++) {
> +		u32 state;
> +
> +		lpi = &pr->power.lpi_states[i];
> +
> +		/* Validate Entry Method as per FFH spec.
> +		 * bits[63:60] should be 0x1
> +		 * bits[59:32] should be 0x0
> +		 * bits[31:0] represent a SBI power_state
                                        ^ an

> +		 */

Comment block needs opening wing (/*)

> +		if (!(lpi->address & RISCV_FFH_LPI_TYPE_MASK) ||

This should be (lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI

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
> +
> +#endif
> -- 
> 2.34.1
>

Thanks,
drew

