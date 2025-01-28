Return-Path: <linux-pm+bounces-20998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF4A205B2
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FBC7A290A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6D1DC994;
	Tue, 28 Jan 2025 08:10:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA619309C;
	Tue, 28 Jan 2025 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738051848; cv=none; b=i1J8N7j1Ny+26TMh0OktPaTJaKdrp3TAFGoiomWfDzwP21/vZa/fKsS/Kk4VbJsW4oDysfZ9uqCuiEQOVrwvmteymUi9oXkp+80yRWFr5V63O6EoypJ21cApb+wOT0VJoQB8I2sX83uolncNxLdClMWmYoOxsxFRARWvYxFUV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738051848; c=relaxed/simple;
	bh=j2TiKkVSb5PBmqktbpgOCn6ybsu5cpEoBbeAGFdy7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpRJuCfv4rZuLxsRIH1AA1zEUb/MRSXT0xCrOwNAlQNHtcFEOH/5VqUN17Tdj1NZXRh+DcmSO1c3ow/v8jyBqhx2yLfjLRsez9hetIfWttUy+Bn2bGWcroooVW5aajBVTfUuf6AIpsZmH7RIBWFPiiVi5qq1ZxGPix/P5+hxBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C098497;
	Tue, 28 Jan 2025 00:11:11 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8AC3F694;
	Tue, 28 Jan 2025 00:10:40 -0800 (PST)
Date: Tue, 28 Jan 2025 09:09:55 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <Z5iQ02AIDalsUXe-@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
 <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>
 <Z5K4aDaZIbhRCbOP@arm.com>
 <20250124033333.jrqbhuyd6qtogn2c@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124033333.jrqbhuyd6qtogn2c@vireshk-i7>

On Fri, Jan 24, 2025 at 09:03:33AM +0530, Viresh Kumar wrote:
> On 23-01-25, 22:45, Beata Michalska wrote:
> > That would mean we are opting for presenting '0' value (whatever that means)
> > instead of trying alternative ways of getting 'current' frequency ?
> > This is still the scaling_cur_freq.
> 
> A return value of 0 should typically mean something went wrong
> somewhere and didn't return the right value to us.
If smth goes wrong, an error should be returned, shoulnd't it?
> 
> - For the print message, I think we should just print the value
>   instead of UNKNOWN. Let the user / developer decide what to do with
>   it.
Are you refering to the x86 show_cpuinfo behaviour altered by this patch ?
> 
> - As for trying other mechanism to find the frequency now, maybe you
>   are right and looking for an alternate way is the right way to go.
>   And that would be consistent with existing behavior too.
> 
That would mean that changes to show_scaling_cur_freq are fine ?

Just trying to clarify things.
Thank you.

---
BR
Beata
> -- 
> viresh

