Return-Path: <linux-pm+bounces-5019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D259C87E51B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619A31F2210A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89A28DAE;
	Mon, 18 Mar 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MvvLJnbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C726AD8
	for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751375; cv=none; b=Rlj+AxWYT/h4OylrUHnjbEgKZdIyebDjWdPWxLP3Jvwb4nM4Xmskr+3Qz6SF0brnBciPZ/uAiyyEWnWzAbgUzKi673cnwPCM5dCWGM6bnNjOz/W1mzNoe4vVk5qADd42Bh+IiF6KuwIlnWqNoNqd/96q71t6FBw1tZE3ew0Q0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751375; c=relaxed/simple;
	bh=4imErLRYet+QfkxRAvS09su/X9kUrEy0w1teZSmQDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acS2jsQ7vXPpulJiZrPs0oxoBG8usTsWLs8WwqWIoJEdCkIg52Ynux8AR+D3X749/KjAn/NuESiQbyX2gzN8eZlm14Ta9xcMF3UlJO+AohH4ydpJHtpbaiWh1fq+M/BKXQMWcbN6X3CaDwCznWvzoCon4aMKTRL0lr/Hk3MSNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MvvLJnbf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a46b28a77dso2291484eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710751372; x=1711356172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhgy0BV44U6MUS0edSkG0zSRuqtl0wS2Ryu/bpwa4dY=;
        b=MvvLJnbfTvKgEu+SUZlScJfk7lnv+32MAQzPmqy28LsMUp0VhLsnoFRXfsHrXFWU2o
         Fuo4ztOxagudsELJYVststUSBev4WVEE8Kim8YZAe0tsw+3VdT8UkmbPxetiDOKK2C/7
         Yw+R9L4j5xdga42R/IuU5TyjnVFV15KxePMw1qpbEoki2uWOqqRRQS6W8tlgnxSa0mRc
         lXSwHYps6RlE0fNtxs4C47JOk8BsNAtpIGuVV3e1ZugaqyaZAp5D/iz3tuE+crOQh/9v
         4ED/72c48qiRQamcSBWIXR1y3yrr4wOTZjV9YR7FeiJqpb3mgYGqrgsZu0RS38TNH80k
         8gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751372; x=1711356172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhgy0BV44U6MUS0edSkG0zSRuqtl0wS2Ryu/bpwa4dY=;
        b=peePGuu4xfN1gUbv3x8pBpi40OXnGGZwtvSs9nGPPxuMGdtb027d1ZjuEe2N5aECNs
         JSwuyBzERFTpOAJfu/Dh7wuFc+aeRdpGhfoK7cXbqiy6a05oJRwJy++6SbCpLGW8KM+C
         KmgeTCCdHZaFmSIp/itKlz8eSG1LPFCJQywPH7N8Xnd1pMi62CDeba397fZ+ESwsyBcX
         D8LhtYxdx0SDRurp2nieewIUI40fbhkc1/SdqqWvGztKzOPKC2h5A5V00uxeDn6t8fp4
         IeSzJOClUaevXeD5cg9JTIemD6NwBd+JeI1GLTBnrxvUuBO5shBGhe17kzkvMCvkT9e8
         aA+w==
X-Gm-Message-State: AOJu0YyK0aPliu4tV1A2UKEwz7FXHQnm83A/8IAgENk6Ag35nKILsQp5
	412ztnHLMsf2kAZuPcdrhm5XYN+QORS3ocie5Xd3a1Hcmt9eXPtw2nuzUqgPZsc=
X-Google-Smtp-Source: AGHT+IFlSDxV8XzLOTRRVV3EN50EyisCs0aw6Fd1xv9UX9glizAj5J9bSHq2YCmhdXfVceAmMS4uMw==
X-Received: by 2002:a05:6820:a0a:b0:5a4:b8df:43fb with SMTP id ch10-20020a0568200a0a00b005a4b8df43fbmr1427769oob.4.1710751371782;
        Mon, 18 Mar 2024 01:42:51 -0700 (PDT)
Received: from sunil-laptop ([106.51.185.90])
        by smtp.gmail.com with ESMTPSA id bw18-20020a056820021200b005a1401bd081sm1849250oob.10.2024.03.18.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:42:51 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:12:41 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Drew Fustini <drew@pdp7.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 2/3] ACPI: RISC-V: Add LPI driver
Message-ID: <Zff+ga6khpPOWSVz@sunil-laptop>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
 <20240118062930.245937-3-sunilvl@ventanamicro.com>
 <ZffSG6LKCjkX+/vO@x1>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZffSG6LKCjkX+/vO@x1>

On Sun, Mar 17, 2024 at 10:33:15PM -0700, Drew Fustini wrote:
> On Thu, Jan 18, 2024 at 11:59:29AM +0530, Sunil V L wrote:
> > Enable Low Power Idle (LPI) based cpuidle driver for RISC-V platforms.
> > It depends on SBI HSM calls for idle state transitions.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/acpi/riscv/Makefile  |  3 +-
> >  drivers/acpi/riscv/cpuidle.c | 81 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/acpi/riscv/cpuidle.c
> > 
> > diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> > index 8b3b126e0b94..7309d92dd477 100644
> > --- a/drivers/acpi/riscv/Makefile
> > +++ b/drivers/acpi/riscv/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-y 	+= rhct.o
> > +obj-y					+= rhct.o
> > +obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
> > diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
> > new file mode 100644
> > index 000000000000..624f9bbdb58c
> > --- /dev/null
> > +++ b/drivers/acpi/riscv/cpuidle.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024, Ventana Micro Systems Inc
> > + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> > + *
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <acpi/processor.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/suspend.h>
> > +#include <asm/cpuidle.h>
> > +#include <asm/sbi.h>
> > +#include <asm/suspend.h>
> > +
> > +#define RISCV_FFH_LPI_TYPE_MASK	GENMASK_ULL(63, 60)
> > +#define RISCV_FFH_LPI_RSVD_MASK	GENMASK_ULL(59, 32)
> > +
> > +#define RISCV_FFH_LPI_TYPE_SBI	BIT_ULL(60)
> > +
> > +static int acpi_cpu_init_idle(unsigned int cpu)
> > +{
> > +	int i;
> > +	struct acpi_lpi_state *lpi;
> > +	struct acpi_processor *pr = per_cpu(processors, cpu);
> > +
> > +	if (unlikely(!pr || !pr->flags.has_lpi))
> > +		return -EINVAL;
> > +
> > +	if (!riscv_sbi_hsm_is_supported())
> > +		return -ENODEV;
> > +
> > +	if (pr->power.count <= 1)
> > +		return -ENODEV;
> > +
> > +	for (i = 1; i < pr->power.count; i++) {
> > +		u32 state;
> > +
> > +		lpi = &pr->power.lpi_states[i];
> > +
> > +		/*
> > +		 * Validate Entry Method as per FFH spec.
> > +		 * bits[63:60] should be 0x1
> > +		 * bits[59:32] should be 0x0
> > +		 * bits[31:0] represent a SBI power_state
> > +		 */
> > +		if (((lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI) ||
> > +		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> > +			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
> > +			return -EINVAL;
> > +		}
> > +
> > +		state = lpi->address;
> 
> It seems that acpi_lpi_state.address is u64, so shouldn't state be u64
> instead of u32?
> 
SBI suspend state is only 32 bits represented by lower 32 bits of
lpi->address.

Thanks,
Sunil

