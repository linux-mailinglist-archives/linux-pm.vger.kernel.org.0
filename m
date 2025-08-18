Return-Path: <linux-pm+bounces-32544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A2B2A562
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C96581159
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FA258EC3;
	Mon, 18 Aug 2025 13:19:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347F322A28;
	Mon, 18 Aug 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523198; cv=none; b=Y9K/oCZbtMRJPrXP5QhBeER27LUogU+F8Hor8Qfg7qsRcjHTe4AVMbffzxSFhs63j7D/K5mD8r6nfVgXjv7Orsi+q5D+5gMdxlKWX4pX9aRXHPmwpIm5axe5Z936bCe5LcLhyHFr/IlDRhPRhQ3oLfnbTj1UHjvvf/TPXgzjP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523198; c=relaxed/simple;
	bh=93ilWYv2pvnna99x75PdQXPZeAiucpWd/yIZ274yqrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNUTaOXNpmrZGYBvZ6K8TqTidDXTomDXb1bG9c1jTqJH0DDkdrVpU2C6pf1eAbNK7ULoP7unldUQfKf5xhhpLCoTdFTgXR1RrOwH69len9n+WdF+sTV89zbTo0gZXZ5nkG+Yw7zyPfb6ZFE5Y2AMXq8VrIViXWdUZOXlU0rK84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A393A1596;
	Mon, 18 Aug 2025 06:19:47 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98FA3F738;
	Mon, 18 Aug 2025 06:19:51 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:19:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org,
	johan+linaro@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	quic_mdtipton@quicinc.com
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Rework quirks framework header
Message-ID: <aKMob3SLE8AofNHw@pluto>
References: <20250815102736.81450-1-cristian.marussi@arm.com>
 <20250818053535.owst4ilq2oxfgqnq@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818053535.owst4ilq2oxfgqnq@lcpd911>

On Mon, Aug 18, 2025 at 11:05:35AM +0530, Dhruva Gole wrote:
> Hi,
> 
> On Aug 15, 2025 at 11:27:35 +0100, Cristian Marussi wrote:

Ho Dhruva,

> > Split and relocate the quirks framework header so as to be usable also by
> > SCMI Drivers and not only by the core.
> 
> Could you elaborate a bit more on this reasoning? I am not fully
> convinced as to why I shouldn't just include quirks.h in the other scmi
> drivers as well?
> 

You can include quirks.h directly BUT you will have to use an ugly

	#include ../drivers/firmware/arm_scmi/quirks.h

...AND also you will endup exposing a couple of internal functions used
by the quirk framework like:

void scmi_quirks_initialize(void);                                               
void scmi_quirks_enable(struct device *dev, const char *vend,                    
                        const char *subv, const u32 impl);  

..so I split out the interface needed for quirking and relocated the
file to include/quirks
	
> Oh or perhaps you mean to say scmi driver like scmi cpufreq / clk-scmi
> etc.. which lie outside the firmware/arm_scmi folder? If so then that's
> not coming out clearly in this patch commit message.

Yes when I say SCMI drivers I mean general drivers that use the SCMI
stack BUT that are not part of the SCMI core....basically those drivers
that use the API in include/linux/scmi_protocol.h

Anyway...it seems like the only user of quirks in the SCMI drivers has
just disappeared...so maybe this small patch can just wait...

> 
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/clock.c  |  2 +-
> >  drivers/firmware/arm_scmi/driver.c |  1 +
> >  drivers/firmware/arm_scmi/quirks.h | 33 +++-------------------
> >  include/linux/scmi_quirks.h        | 44 ++++++++++++++++++++++++++++++
> >  4 files changed, 50 insertions(+), 30 deletions(-)
> >  create mode 100644 include/linux/scmi_quirks.h
> > 
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index afa7981efe82..5599697de37a 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -7,11 +7,11 @@
> >  
> >  #include <linux/module.h>
> >  #include <linux/limits.h>
> > +#include <linux/scmi_quirks.h>
> >  #include <linux/sort.h>
> >  
> >  #include "protocols.h"
> >  #include "notify.h"
> > -#include "quirks.h"
> >  
> >  /* Updated only after ALL the mandatory features for that version are merged */
> >  #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index bd56a877fdfc..6f5934cd3a65 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/processor.h>
> >  #include <linux/refcount.h>
> >  #include <linux/slab.h>
> > +#include <linux/scmi_quirks.h>
> >  #include <linux/xarray.h>
> >  
> >  #include "common.h"
> > diff --git a/drivers/firmware/arm_scmi/quirks.h b/drivers/firmware/arm_scmi/quirks.h
> > index a71fde85a527..260ae38d617b 100644
> > --- a/drivers/firmware/arm_scmi/quirks.h
> > +++ b/drivers/firmware/arm_scmi/quirks.h
> > @@ -4,49 +4,24 @@
> >   *
> >   * Copyright (C) 2025 ARM Ltd.
> >   */
> > -#ifndef _SCMI_QUIRKS_H
> > -#define _SCMI_QUIRKS_H
> > +#ifndef _SCMI_QUIRKS_INTERNAL_H
> > +#define _SCMI_QUIRKS_INTERNAL_H
> 
> Or as per your commit message wording, better to call it
> _SCMI_QUIRKS_CORE_H ?
> 

...well mayeb yes....I have not bother to change the filename
anyway ....

> >  
> > -#include <linux/static_key.h>
> > +#include <linux/device.h>
> >  #include <linux/types.h>
> >  
> >  #ifdef CONFIG_ARM_SCMI_QUIRKS
> >  
> > -#define DECLARE_SCMI_QUIRK(_qn)						\
> > -	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
> > -
> > -/*
> > - * A helper to associate the actual code snippet to use as a quirk
> > - * named as _qn.
> > - */
> > -#define SCMI_QUIRK(_qn, _blk)						\
> > -	do {								\
> > -		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
> > -			(_blk);						\
> > -	} while (0)
> > -
> >  void scmi_quirks_initialize(void);
> >  void scmi_quirks_enable(struct device *dev, const char *vend,
> >  			const char *subv, const u32 impl);
> >  
> >  #else
> >  
> > -#define DECLARE_SCMI_QUIRK(_qn)
> > -/* Force quirks compilation even when SCMI Quirks are disabled */
> > -#define SCMI_QUIRK(_qn, _blk)						\
> > -	do {								\
> > -		if (0)							\
> > -			(_blk);						\
> > -	} while (0)
> > -
> >  static inline void scmi_quirks_initialize(void) { }
> >  static inline void scmi_quirks_enable(struct device *dev, const char *vend,
> >  				      const char *sub_vend, const u32 impl) { }
> >  
> >  #endif /* CONFIG_ARM_SCMI_QUIRKS */
> >  
> > -/* Quirk delarations */
> > -DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
> > -DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
> > -
> > -#endif /* _SCMI_QUIRKS_H */
> > +#endif /* _SCMI_QUIRKS_INTERNAL_H */
> > diff --git a/include/linux/scmi_quirks.h b/include/linux/scmi_quirks.h
> > new file mode 100644
> > index 000000000000..11657bd91ffc
> > --- /dev/null
> > +++ b/include/linux/scmi_quirks.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * System Control and Management Interface (SCMI) Message Protocol Quirks
> > + *
> > + * Copyright (C) 2025 ARM Ltd.
> > + */
> > +#ifndef _SCMI_QUIRKS_H
> > +#define _SCMI_QUIRKS_H
> > +
> > +#include <linux/static_key.h>
> > +#include <linux/types.h>
> > +
> > +#ifdef CONFIG_ARM_SCMI_QUIRKS
> > +
> > +#define DECLARE_SCMI_QUIRK(_qn)						\
> > +	DECLARE_STATIC_KEY_FALSE(scmi_quirk_ ## _qn)
> > +
> > +/*
> > + * A helper to associate the actual code snippet to use as a quirk
> > + * named as _qn.
> > + */
> > +#define SCMI_QUIRK(_qn, _blk)						\
> > +	do {								\
> > +		if (static_branch_unlikely(&(scmi_quirk_ ## _qn)))	\
> > +			(_blk);						\
> > +	} while (0)
> > +
> > +#else
> > +
> > +#define DECLARE_SCMI_QUIRK(_qn)
> > +/* Force quirks compilation even when SCMI Quirks are disabled */
> > +#define SCMI_QUIRK(_qn, _blk)						\
> > +	do {								\
> > +		if (0)							\
> > +			(_blk);						\
> > +	} while (0)
> 
> Did you happen to run checkpatch on this?
> 8<---------------------------------------------------------------------------
> WARNING: Argument '_qn' is not used in function-like macro
> #142: FILE: include/linux/scmi_quirks.h:32:
> +#define SCMI_QUIRK(_qn, _blk)                                          \
> +       do {                                                            \
> +               if (0)                                                  \
> +                       (_blk);                                         \
> +       } while (0)
> 
> total: 0 errors, 2 warnings, 0 checks, 116 lines checked
> --------------------------------------------------------------------------->8
>

Oh yes I did on all the series...BUT this specific error on this branch
of the #if was already present in the original patch that added the
Quirk framework...I did not know how to avoid this warning and given it
is pretty much harmless I just ignored it...

> 
> > +
> > +#endif /* CONFIG_ARM_SCMI_QUIRKS */
> > +
> > +/* Quirk delarations */
> > +DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
> > +DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
> > +
> > +#endif /* _SCMI_QUIRKS_H */
> > -- 
> > 2.50.1
> > 
> 

Thanks for the review.
Cristian

