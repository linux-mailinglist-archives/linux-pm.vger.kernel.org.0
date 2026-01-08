Return-Path: <linux-pm+bounces-40422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D6D01505
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 07:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF4C3067DD0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 06:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB627F75F;
	Thu,  8 Jan 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4akPVMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA3223328
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855149; cv=none; b=oBUOKku5XPTXcqT1Ws7mAPQopXVewKKe544/r30XuZLa15zKsxQHggpAq+XjYGK6dm3VtNAYAN56D7Ll7MZxelQ6coq7IZCbZOVqDDDJesG21+rcJCedEHh2l8grYNtbyrQBPumoWtL6eFHlr5p2t168Osgt/YDhhKF/ldM2bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855149; c=relaxed/simple;
	bh=KYWavFhptYq/+KkoSSqiFI0kX9Ue8uzJ7XFMKzMqwLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSPlcthRgWIKcO83rAwCjPgI+5vCsDoFF8SoeGqeSWSy6lGGHvQvABw0YdOptIomwbrY/rWnXPJsZxtXzQ+u1mbp/mdOMZHNPidcCNUs9b8VdLTHwb/vWs9QgqYlRJSrm5wiubizFWQINa2AMQK8Q6JVyaJ6wE0G3hyyFNwhuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4akPVMu; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso1824479a91.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 22:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767855147; x=1768459947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ui1md6GLIAbVR5qdoR2S2qe4tIaQfGaBLcdNaqS2s2A=;
        b=i4akPVMuOlkc5FLrbMsC1p8ePrESAVd3UprZl9C0bzyEll7PtPqTEtaOmilkduk+1m
         I3ORqypWAraplHoiBO+ZbnOP6UmDoCg3LeptkmL9p4okHe4QahnumOgYRhbHQ2+XKL8U
         orL7j6Ve44WCe1JYRzKQPfm+vF78mJKq3D8aJhK+SGzgyDfI+6byusB5H1N2PJjAZFrI
         L+ZpoHkVv3XmhESJGDydzaw4+y/aXXABEMpVyTXZqOlxiJE46blCAA8wkDehyv/M0QTC
         lSguA6b9Jeb6xt94GI6e7NFS68cWE5y72lVOs3VsptniwNeTl5vjJGCQOfKfAbcLp7w7
         K1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855147; x=1768459947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui1md6GLIAbVR5qdoR2S2qe4tIaQfGaBLcdNaqS2s2A=;
        b=w9SDPY56MqVQk3+lCPy82hRpYvzZCVbnlClNyydc3QIFZspZk3gppqyYkQKZ5f532l
         qLxPv5ITw93m/eRPslcd3PgVx5+ZdxMAmzeQF1kAV6P7wQi8VCXv9E6S/FkQrN1RrlYh
         MBx/Vk+LSd+H3v2EVLFZAs/LnaDa+o716SzPPgXDtBDeeYVMJXq/h/ckU+n1u2IEZj6t
         L1V7Bzq9r9yNjGCbTr7yZ/S56gkQpcgH9FrxS4Uzk1QrK6YRaeXw6O6UqQkC5ZO5n/SW
         oq58pXvIWadQceLEWD+FKdIic/9CxJc61NB/vCDHHFyLDSvBbdbZs5C6009ywN2uc+Mh
         JbfA==
X-Forwarded-Encrypted: i=1; AJvYcCWMZyfkU88RaXIF67lSPHgittAFYxpAXDdkRo/jUp07jgm9cNW8LGEEQ8Mt+VJxGh4Syk0hNibj6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR305vbjDwJAYjXv9ezVrKw8i/r/Bg/OFRyMEQeicx5fL/SfX9
	JAjoDLkoDBWsBfXGLXzTqIGuGw95Qa40wfHsYfHsv37kItAl4H0ualSAXphHvisfXis=
X-Gm-Gg: AY/fxX4u6Sg9To1oYJPEkXUma7tHlu5Xf0clWHqIbUDW1AJ7GOgqB6dttWFNwCrse61
	xzHbQDM74zJQF5pfCqQX2zaei9ToEWm4aonai91BIQl0YIlsLWafDgMf4JDRHRAdVuQwPvYY38A
	kioBX7Z6l3k5Kn180uEqmXs2051aGLTsee5SQDw43MKstQ+oaNDP6gODxd7IrfY4KUJ0J8APB3m
	BqT5raGur419+xIA7LB2fdJ5ffJMx9+e2ciZd0GG6myOAD5xq4XPjEyGDCdP1ysuOT2HqzvRmJs
	YeA28K+9pgjPpp8y3LtWmNaZHKC7q1qHRyahBpvGmieEYaB/dck+ymXiNzD/6BnI7ZS4N2xdzm6
	mHfOQqxWWWXritqdWzYfymDI87gXifxkRpbd0uFeqxoT9db9caxg06ICRJ/pVKBJmyUHxNomHR2
	wGf+xNrSZexns=
X-Google-Smtp-Source: AGHT+IHDhLngCXk0+vr5I8WQ83ajbpSXd1J3uu2NiCef0XJDNyI8VNxhq7B1GWkAhONpFP7xS/AZaQ==
X-Received: by 2002:a17:90b:3e43:b0:34c:cb3c:f544 with SMTP id 98e67ed59e1d1-34f68c50868mr4787427a91.14.1767855146587;
        Wed, 07 Jan 2026 22:52:26 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5302c61sm6658548b3a.42.2026.01.07.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:52:25 -0800 (PST)
Date: Thu, 8 Jan 2026 12:22:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: "rahul@summations.net" <rahul@summations.net>, 
	"anup@brainfault.org" <anup@brainfault.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "rafael@kernel.org" <rafael@kernel.org>, 
	"sboyd@kernel.org" <sboyd@kernel.org>, "jms@oss.tenstorrent.com" <jms@oss.tenstorrent.com>, 
	"darshan.prajapati@einfochips.com" <darshan.prajapati@einfochips.com>, "charlie@rivosinc.com" <charlie@rivosinc.com>, 
	"dfustini@oss.tenstorrent.com" <dfustini@oss.tenstorrent.com>, "michal.simek@amd.com" <michal.simek@amd.com>, 
	"cyy@cyyself.name" <cyy@cyyself.name>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, 
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
Message-ID: <paq3iilgrnuhf4aia7umhc6m26ghusyibptutvrpfm4wmoew3i@repcvxossgot>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com>
 <5nfljdaewlmafydt5a3jijjlr2krszbnadmjkpkgo7in364yzy@tiejhive2siv>
 <SH0PR01MB084174DCDA011CDD9D6557FFF9852@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB084174DCDA011CDD9D6557FFF9852@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>

On 08-01-26, 06:48, Joshua Yeong wrote:
> On Thursday, January 8, 2026 11:27 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 06-01-26, 17:21, Joshua Yeong wrote:
> > > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig index 
> > > 78702a08364f..9aaa1f71000e 100644
> > > --- a/drivers/cpufreq/Kconfig
> > > +++ b/drivers/cpufreq/Kconfig
> > > @@ -4,8 +4,8 @@ menu "CPU Frequency scaling"
> > >  config CPU_FREQ
> > >  	bool "CPU Frequency scaling"
> > >  	help
> > > -	  CPU Frequency scaling allows you to change the clock speed of 
> > > -	  CPUs on the fly. This is a nice method to save power, because 
> > > +	  CPU Frequency scaling allows you to change the clock speed of
> > > +	  CPUs on the fly. This is a nice method to save power, because
> > >  	  the lower the CPU clock speed, the less power the CPU consumes.
> > >  
> > >  	  Note that this driver doesn't automatically change the CPU @@ 
> > > -65,7 +65,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
> > >  	select CPU_FREQ_GOV_USERSPACE
> > >  	help
> > >  	  Use the CPUFreq governor 'userspace' as default. This allows
> > > -	  you to set the CPU frequency manually or when a userspace 
> > > +	  you to set the CPU frequency manually or when a userspace
> > >  	  program shall be able to set the CPU dynamically without having
> > >  	  to enable the userspace governor manually.
> > >  
> > > @@ -134,7 +134,7 @@ config CPU_FREQ_GOV_USERSPACE
> > >  	help
> > >  	  Enable this cpufreq governor when you either want to set the
> > >  	  CPU frequency manually or when a userspace program shall
> > > -	  be able to set the CPU dynamically, like on LART 
> > > +	  be able to set the CPU dynamically, like on LART
> > >  	  <http://www.lartmaker.nl/>.
> > >  
> > >  	  To compile this driver as a module, choose M here: the @@ -147,11 
> > > +147,11 @@ config CPU_FREQ_GOV_ONDEMAND
> > >  	select CPU_FREQ_GOV_COMMON
> > >  	help
> > >  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> > > -	  The governor does a periodic polling and 
> > > +	  The governor does a periodic polling and
> > >  	  changes frequency based on the CPU utilization.
> > >  	  The support for this governor depends on CPU capability to
> > >  	  do fast frequency switching (i.e, very low latency frequency
> > > -	  transitions). 
> > > +	  transitions).
> > >  
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called cpufreq_ondemand.
> > > @@ -367,4 +367,18 @@ config ACPI_CPPC_CPUFREQ_FIE
> > >  
> > >  endif
> >
> > Unrelated changes ?
> 
> Will remove the blank space in V2 patch.

You actually removed the unnecessary blank spaces at the end of many lines,
which is a good change but in a wrong patch. If you want to fix that, send it
separately.

-- 
viresh

