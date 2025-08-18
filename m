Return-Path: <linux-pm+bounces-32545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D955B2A58D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF942A04C1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81433A021;
	Mon, 18 Aug 2025 13:21:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE3322769;
	Mon, 18 Aug 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523284; cv=none; b=UAVJFNNnyYAG5lHeCoHmQWHF3SPHa1cShUkFWNLNUQDZWLuEIzZaqvvVqWEewWSsNf4VAoiWcfZu+k7Q/4jd83F15C1GgxXRXAFeOulz6P94/J3ZKknb+J0wxJEwYvwudZ7fqeCvfyZURpBhF9ukg0tpvtu8j1DNq9ExTyf1FdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523284; c=relaxed/simple;
	bh=2PrcDQqaJqc7i3YiHze05+cpzxCLal5ntjoquK6x2k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0PunRt1H1W2191DPIsIEAnkZ20ux1LMlejB5MPxi35JcBestNViI9dZ4m/qqxW7CN07vHedv7834IaodYvDjMjDh8DxXq+zIXhBy4MQSWcSR/0CUCSCpe9NcaR5ETKUJDklSUV7jdEy6AdBCGTH2ZZ856ALJXaA5/1EhJZraEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803B41596;
	Mon, 18 Aug 2025 06:21:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC6493F738;
	Mon, 18 Aug 2025 06:21:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:21:14 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org,
	johan+linaro@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	quic_mdtipton@quicinc.com,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 2/2] [NOT_FOR_UPSTREAM] cpufreq: scmi: Add quirk to
 disable checks in scmi_dev_used_by_cpus()
Message-ID: <aKMoyp5xw9xSj2v1@pluto>
References: <20250815102736.81450-1-cristian.marussi@arm.com>
 <20250815102736.81450-2-cristian.marussi@arm.com>
 <20250818062044.zawqkalphvxjwt2w@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818062044.zawqkalphvxjwt2w@lcpd911>

On Mon, Aug 18, 2025 at 11:50:44AM +0530, Dhruva Gole wrote:
> On Aug 15, 2025 at 11:27:36 +0100, Cristian Marussi wrote:
> > From: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > Broadcom STB platforms were early adopters of the SCMI framework and as
> > a result, not all deployed systems have a Device Tree entry where SCMI
> > protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> > CPU Device Tree node(s) referencing protocol 0x13 as their clock
> > provider.
> > 
> > Leverage the quirks framework recently introduce to match on the
> > Broadcom SCMI vendor and in that case, disable the Device Tree
> > properties checks being done by scmi_dev_used_by_cpus().
> > 
> > Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> > Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > [Cristian: Moved quirk directly into scmi_dev_used_by_cpus]
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > 
> > ----
> > @Florian: I reworked this minimally to avoid the global as I was mentioning.
> > No change around the version match either...so the NOT_FOR_UPSTREAM tag.
> > (also the if (true) i smaybe a bit idiotic...)
> > Please check if it is fine and modify as you see fit.
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c     | 9 +++++++++
> >  drivers/firmware/arm_scmi/quirks.c | 2 ++
> >  include/linux/scmi_quirks.h        | 1 +
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index ef078426bfd5..9b7cbc4e87d9 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/pm_qos.h>
> >  #include <linux/slab.h>
> >  #include <linux/scmi_protocol.h>
> > +#include <linux/scmi_quirks.h>
> >  #include <linux/types.h>
> >  #include <linux/units.h>
> >  
> > @@ -393,6 +394,12 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
> >  	.set_boost	= cpufreq_boost_set_sw,
> >  };
> >  
> > +#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS			\
> > +	({							\
> > +		if (true)					\
> > +			return true;				\
> > +	})
> > +
> 
> Probably another checkpatch warning to fix:
> 8<--------------------------------------------------------------------
> WARNING: Macros with flow control statements should be avoided                                                                                                                                                     
> #50: FILE: drivers/cpufreq/scmi-cpufreq.c:397:                                                                                                                                                                     

Yes I saw this too....but seemed harmless and anyway Quirks are really
very peculiar piece of code...

Thanks
Cristian

