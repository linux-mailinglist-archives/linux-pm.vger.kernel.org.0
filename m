Return-Path: <linux-pm+bounces-15800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D179A146E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2011C20DEF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B781CEADB;
	Wed, 16 Oct 2024 20:52:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64D18CBF2;
	Wed, 16 Oct 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111953; cv=none; b=buUzQVsEi8ZdZ7eXZzzQvlVt2tWKlwMeuBvPOFK8Ts2UqfBtq8eQ833NkgzwZhA+ITlxqF2w9zwbGo4qQZJI+jwajcSvsQp1Pin7hzC7x6ms2wGNSGLNvMcNlLB2Z/a0BHYg3jZhCBachtnEE+Kr55yo3eN5Uz2OIRxhqj4Nh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111953; c=relaxed/simple;
	bh=3EqYGbI+bMfTypvkrfFd6Ho2LtNLC/GdIbIiEaDAHgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCmMkSAr1KyCweQbvyKuCiJYeOx0L9UJCxaODFzdqIOHBaCa/0RY1wMxJ6+Ln2jmVY87alKRBIF64734LibjjwjBMcY3e4GUTq6AA71V9+LlPRdGDOO/YBhB5UQWQlcTy+lqTWuvvfVLSFumTkM5mgRRZTyzATfG2i6VjJPMHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9C8FEC;
	Wed, 16 Oct 2024 13:53:01 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5BB23F528;
	Wed, 16 Oct 2024 13:52:27 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:51:57 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 0/4] Add support for AArch64 AMUv1-based average freq
Message-ID: <ZxAnbflwMuIWpKCW@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <Zw-cje76QgQIN5kq@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-cje76QgQIN5kq@arm.com>

On Wed, Oct 16, 2024 at 11:59:25AM +0100, Catalin Marinas wrote:
Hi Catalin,
> Hi Beata,
> 
> On Fri, Sep 13, 2024 at 02:29:40PM +0100, Beata Michalska wrote:
> > This series adds support for obtaining an average CPU frequency based on
> > a hardware provided feedback. The average frequency is being exposed via
> > dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> > The architecture specific bits are being provided for AArch64, caching on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serving as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks.
> > 
> > The changes have been rather lightly (due to some limitations) tested on
> > an FVP model. Note that some small discrepancies have been observed while
> > testing (on the model) and this is currently being investigated, though it
> > should not have any significant impact on the overall results.
> > 
> > Note that [PATCH 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
> > can be merged independently.
> 
> What's the plan with the rest of the patches? Are you going to respin?
> The first patch would need an ack from Rafael or Viresh if we are to
> merge them via the arm64 tree.
>
I am still waiting on any feedback on [PATCH 1/4] - changes to cpufreq, as that
one drives the changes in arch specific bits. There is also an ongoing discussion
on how to handle idle cpu cases - so I would say we still need to agree on few
details.

---
BR
Beata
> Thanks.
> 
> -- 
> Catalin

