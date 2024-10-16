Return-Path: <linux-pm+bounces-15757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4C9A07ED
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032B21C21049
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F52071EB;
	Wed, 16 Oct 2024 10:59:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F21C1724;
	Wed, 16 Oct 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076371; cv=none; b=mwUodxUNnJJFpaiHOOTfLoWDMHLAyMnkcC+xK3NSKXqfAmuIicxTnXxu/miOQDHKRC7w59TBHpzkhKZ1fhtJVf73+op5gotJCcPiIC/5MqpbKHnTJqsis7AdfVvNiLFp1p7DFn9j+c4DOx8fI7lKrB+R5dHwZ/q298RfDdvI7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076371; c=relaxed/simple;
	bh=AewB8jTNjDQGLluYNK7Yved4ijvMxXqWIBDXW6YuSD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTgCLgzPHLJhUxESzOOUNKQ2WHmwrte96aZfMbSM6BGM2a0GyHxrIG5pD27nvhUdafI5g7+nHiH7NKzrcArm/eU5vLwWj1qYC1NM6n1ApiGdfQrEpZ6O0rMZg4GPI7YhitMRgzMH5ZAvUg0bRYVC1ZscvZ6SXz+4ih4hpECf/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC956C4CEC5;
	Wed, 16 Oct 2024 10:59:27 +0000 (UTC)
Date: Wed, 16 Oct 2024 11:59:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 0/4] Add support for AArch64 AMUv1-based average freq
Message-ID: <Zw-cje76QgQIN5kq@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913132944.1880703-1-beata.michalska@arm.com>

Hi Beata,

On Fri, Sep 13, 2024 at 02:29:40PM +0100, Beata Michalska wrote:
> This series adds support for obtaining an average CPU frequency based on
> a hardware provided feedback. The average frequency is being exposed via
> dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> The architecture specific bits are being provided for AArch64, caching on
> existing implementation for FIE and AMUv1 support: the frequency scale
> factor, updated on each sched tick, serving as a base for retrieving
> the frequency for a given CPU, representing an average frequency
> reported between the ticks.
> 
> The changes have been rather lightly (due to some limitations) tested on
> an FVP model. Note that some small discrepancies have been observed while
> testing (on the model) and this is currently being investigated, though it
> should not have any significant impact on the overall results.
> 
> Note that [PATCH 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
> can be merged independently.

What's the plan with the rest of the patches? Are you going to respin?
The first patch would need an ack from Rafael or Viresh if we are to
merge them via the arm64 tree.

Thanks.

-- 
Catalin

