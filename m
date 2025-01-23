Return-Path: <linux-pm+bounces-20874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F53A1A408
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 13:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50741883843
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEEA20E302;
	Thu, 23 Jan 2025 12:16:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED9288CC;
	Thu, 23 Jan 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634617; cv=none; b=YOkqmBPCSS3k0tyEafDpqQC40UTfZ40MKKftq9x4Jfi9rS7HeZqdnGTVaTOngF8hdWUZWTlHz6whiII9VHnzr62RI9F6RMy3DaTNllHmTyHROKrzcCgjXsP2XI8NkkTBdCZXE7uFY2Ldo5lj+X3JXRRt2xtBamiRhIoOazR1CME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634617; c=relaxed/simple;
	bh=yLwUUzeSvSmXldYU6OqHdpQgkd63gnwoGcDdnEPqR7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjRRm+5lWNJqyKaMvqIUA4P35c7FzreFPaP02XLIWc71uT5q4pjx9mSj1yMU6woxW06SimSV7ji+HAakL3NQ3bNLWLGPqq2dac34Hx8z/k4iM+GlgFk/6VqXlL0rleNoMdPah4hiAy3digiY/IofOYjsuiErhSLNpR1YMXyLi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531861063;
	Thu, 23 Jan 2025 04:17:23 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A133F5A1;
	Thu, 23 Jan 2025 04:16:53 -0800 (PST)
Date: Thu, 23 Jan 2025 12:16:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: zuoqian <zuoqian113@gmail.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, viresh.kumar@linaro.org,
	cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Message-ID: <Z5IzMhTOhtujyH0n@bogus>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>

(for some reason I don't have the original email)

On Thu, Jan 23, 2025 at 02:12:14PM +0300, Dan Carpenter wrote:
> On Thu, Jan 23, 2025 at 07:53:20AM +0000, zuoqian wrote:
> > The CPU rate from clk_get_rate() may not be divisible by 1000
> > (e.g., 133333333). But the rate calculated from frequency is always
> > divisible by 1000 (e.g., 133333000).
> > Comparing the rate causes a warning during CPU scaling:
> > "cpufreq: __target_index: Failed to change cpu frequency: -5".
> > When we choose to compare frequency here, the issue does not occur.
> > 
> > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> > ---
> >  drivers/cpufreq/scpi-cpufreq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> > index cd89c1b9832c..3bff4bb5ab4a 100644
> > --- a/drivers/cpufreq/scpi-cpufreq.c
> > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > @@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
> >  static int
> >  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  {
> > -	u64 rate = policy->freq_table[index].frequency * 1000;
> 
> policy->freq_table[index].frequency is a u32 so in this original
> calculation, even though "rate" is declared as a u64, it can't actually
> be more than UINT_MAX.
>

Agreed and understood.

> > +	unsigned long freq = policy->freq_table[index].frequency;
> >  	struct scpi_data *priv = policy->driver_data;
> > +	u64 rate = freq * 1000;
>
> So you've fixed this by casting policy->freq_table[index].frequency
> to unsigned long, which fixes the problem on 64bit systems but it still
> remains on 32bit systems.  It would be better to declare freq as a u64.
>

Just trying to understand if that matters. freq is in kHz as copied
from policy->freq_table[index].frequency and we compare it with
kHZ below as the obtained clock rate is divided by 1000. What am I
missing ? If it helps, it can be renamed as freq_in_khz and even keep
it as "unsigned int" as in struct cpufreq_frequency_table.

-- 
Regards,
Sudeep

