Return-Path: <linux-pm+bounces-38893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87222C92791
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367443A78F2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0CB2144CF;
	Fri, 28 Nov 2025 15:49:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0079CD
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344965; cv=none; b=pq6HF1OmpciX7QqB3ZqPXdVllKnc/SGjf1hRE+xE19kXk2oU9tRciVnx+O4sTrnR9BUcm5mSsHuJ24AHDd0ndVXEFxM/R/UNkyYAwj+NLcJUkapE+12nEiSYxLxiqwJjNjdUecY/asXZf920/q5X5jCZNVqGguOyb7eC5PDBDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344965; c=relaxed/simple;
	bh=vUgwlSX8LhMHU6GNkPsihdB8ncBJBSDvQzoA6BFbaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKkWEgkhzXPvS61YzfVmjU2b/OqZee9GP+ZG9Ayldrsbt1kfIitnYLkwIQbl/5QhAx0108KMjpRE3F8Nos9hZqRhFAYRQjj3yDrvc0l+wPuozK9nzQY1oMebRTfL4S46ypL1Ln3XELDEKEeBSH5cJage6oCR1mqY0ypOmpy1vSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775F7176A;
	Fri, 28 Nov 2025 07:49:15 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DED913F66E;
	Fri, 28 Nov 2025 07:49:19 -0800 (PST)
Date: Fri, 28 Nov 2025 15:49:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, dakr@kernel.org,
	beata.michalska@arm.com, ionela.voinescu@arm.com,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	vincent.guittot@linaro.org, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com,
	wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
Message-ID: <aSnEfTJ3WRx6iJU5@arm.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <176409538230.296584.10511015168201991664.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176409538230.296584.10511015168201991664.b4-ty@arm.com>

On Tue, Nov 25, 2025 at 06:29:53PM +0000, Catalin Marinas wrote:
> On Wed, 19 Nov 2025 16:13:53 +0800, Lifeng Zheng wrote:
> > Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
> > even though they're eligible.
> > 
> > Changelog:
> > 
> > v6:
> > 
> > [...]
> 
> Applied to arm64 (for-next/topology), thanks!
> 
> [1/3] arm64: topology: Skip already covered CPUs when setting freq source
>       https://git.kernel.org/arm64/c/a04fd8bcd6aa
> [2/3] cpufreq: Add new helper function returning cpufreq policy
>       https://git.kernel.org/arm64/c/709a16bebc54
> [3/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
>       https://git.kernel.org/arm64/c/1ea7e37e26b3

I think Beata still has to review the last patch in the series, so I'll
drop it for now from -next. Sorry about this.

-- 
Catalin

