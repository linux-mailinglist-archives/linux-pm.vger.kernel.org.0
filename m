Return-Path: <linux-pm+bounces-38648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C9C869E9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66A44350930
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A7270ED7;
	Tue, 25 Nov 2025 18:30:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6E2E7198
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095402; cv=none; b=QOseMHIUSXz34R5wgevYFGgtq0snCYTrspvP9f/sarSMCSQOhaANbg2jo0DfvEhfMv7nOlnq3HYvzVi0yzoHRiltPbIV6dcKqrny6c/Lni9OBz4GI7tlEIC1QPt4c+5azp+JWFWEpc04XyYG5UaOPbGzG5ImVkyuCSckzVWASJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095402; c=relaxed/simple;
	bh=cB23mTUlqUUufQDrAdoYkPSF0vbspmmSUbbqAVt85B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX3C2ibjjKQSB6oKEO0hxblHUZd3+XgxStEgjyGmDGKX7zmiH6L3c6lQs15EQhSSwO2vp9cunKAjhOd4u0YR6aGZksvAa48iX+SIgeL8Akx3qb/f0p9TTBctB4LZhdgSI2IZhZFrCWKTitRXXx8saDSNtWzQGEH6Si0S8f2wmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8DB01570;
	Tue, 25 Nov 2025 10:29:51 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43FAE3F6A8;
	Tue, 25 Nov 2025 10:29:56 -0800 (PST)
Date: Tue, 25 Nov 2025 18:29:53 +0000
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
Message-ID: <176409538230.296584.10511015168201991664.b4-ty@arm.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119081356.2495290-1-zhenglifeng1@huawei.com>

On Wed, 19 Nov 2025 16:13:53 +0800, Lifeng Zheng wrote:
> Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
> even though they're eligible.
> 
> Changelog:
> 
> v6:
> 
> [...]

Applied to arm64 (for-next/topology), thanks!

[1/3] arm64: topology: Skip already covered CPUs when setting freq source
      https://git.kernel.org/arm64/c/a04fd8bcd6aa
[2/3] cpufreq: Add new helper function returning cpufreq policy
      https://git.kernel.org/arm64/c/709a16bebc54
[3/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
      https://git.kernel.org/arm64/c/1ea7e37e26b3

-- 
Catalin


-- 
Catalin

