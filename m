Return-Path: <linux-pm+bounces-32976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD142B3382F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860D717D503
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF62989A2;
	Mon, 25 Aug 2025 07:49:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B0296BA2;
	Mon, 25 Aug 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108179; cv=none; b=eX1K6X0eG+3CKz0kGvdFbdc5x6ZePv3L++VuPJwM7TzI30Y67gEo/KtF81I1WEdl5wYXnjqHr+HDZFh4EgPx1m/0GVE+hL70hoStBNyUDhOQH+sL6JAmszNXBbnXsE0cKWPjtD70bgmgek9gxGht2eG1F56GAyrMNAwfQyZqN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108179; c=relaxed/simple;
	bh=gpvvIhgK3CSmSlad3uSKgPLTFsvughmdc/Vio0DYLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkKuxQR4hSvn9Y4XBSRTaBGdeVQlm3lMFxLgser9D+QsDHt1/NhQqjJbVtrLfhouHQLQyF46saSoX8M9Gl1Cbe5GxKtQNRjlIeshXZLu5HLO6cTt6qEDHBipRWCYRUqCEN6EkCH4uZaijjIESWnNgr6VMDAKLMCvFGwbT57Tvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2496B1655;
	Mon, 25 Aug 2025 00:49:29 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170993F738;
	Mon, 25 Aug 2025 00:49:35 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:49:15 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: Add driver flag to avoid initial frequency
 verification
Message-ID: <aKwVe4WSG7JApUAi@arm.com>
References: <20250823001937.2765316-1-pmalani@google.com>
 <20250823001937.2765316-3-pmalani@google.com>
 <20250825045641.o2thjvs3xyuxavyk@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825045641.o2thjvs3xyuxavyk@vireshk-i7>

On Mon, Aug 25, 2025 at 10:26:41AM +0530, Viresh Kumar wrote:
> On 23-08-25, 00:17, Prashant Malani wrote:
> > Some cpufreq drivers have a get() function which can return an unreliable
> > frequency. This can cause issues when switching governors. For instance,
> > a CPU would be on performance governor and have it's frequency (and
> > policy->cur) set to max. When the governor is switched to userspace, the
> > policy->cur is re-used, but it is checked against the frequency returned
> > by the driver's get() function. If it's different, the frequency will
> > get set to the new (incorrect) value.
> > 
> > To avoid this, add a flag that avoids this verify step on governor start
> > if the cpufreq driver opts in to it.
> > 
> > Since there are no users of this flag, no functional changes are
> > introduced here.
> > 
> > Cc: Beata Michalska <beata.michalska@arm.com>
> > Signed-off-by: Prashant Malani <pmalani@google.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |  3 ++-
> >  include/linux/cpufreq.h   | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index b8937737d096..72e6552a40ea 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2482,7 +2482,8 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
> >  
> >  	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> >  
> > -	cpufreq_verify_current_freq(policy, false);
> > +	if (!(cpufreq_driver->flags & CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START))
> > +		cpufreq_verify_current_freq(policy, false);
> 
> I don't think it is okay to do this to hide a driver's failure to
> return the right frequency. What about all the other places where
> get() is still used ? Won't that cause similar issues elsewhere ?
> 
> The driver must be fixed for this, not the core. The core is doing the
Agreed.

---
BR
Beata
> right thing here, asking the driver to return the current frequency.
> If the driver is unsure, it can just return the current frequency from
> policy->cur instead.
> 
> -- 
> viresh

