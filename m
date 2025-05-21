Return-Path: <linux-pm+bounces-27454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22175ABF389
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D728B4A79EE
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D323264F9C;
	Wed, 21 May 2025 11:57:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A96264614
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828626; cv=none; b=sh37s9oLObv3TkNoMkIsde0mNSr4XR5fpwD/cQZfSnzYKdqDbwTArXHKmuPmTXzHLaVZWHhQZgZ+76zg1rhc5exs5oVtBuWLbgqQhR2Cfki61cuI2R4NMWa+KZC8FdJBZ2ch2NdCly3t/WXnrlHnCK7w/fUvAGDDx+SKSxzJZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828626; c=relaxed/simple;
	bh=FTQjxJ4lVkXXHckjRtChgAJuCCiAmABzoY+H+2UALeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eor4cXWcOH6mtcRuTlSI94tY8IA13+Nfg4/ObqItbLvKDsAMUr74M/xqGHpWfeN19gN40Yshs9OqCTRFRlL4j125RcyRInV9jOtU46I0G/IQcqKfWdEt687lcEdjib5VNVQ3mCGYZd4XmRXLX2lv4KqBzY6XbH/3RbBSbxFFMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB58D1515;
	Wed, 21 May 2025 04:56:49 -0700 (PDT)
Received: from [10.57.64.80] (unknown [10.57.64.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 354D23F5A1;
	Wed, 21 May 2025 04:57:02 -0700 (PDT)
Message-ID: <1e7cb553-be71-4403-bc25-64457ec3e3d4@arm.com>
Date: Wed, 21 May 2025 12:57:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Relax SMCCC dependency
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
 <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
 <2393836.usQuhbGJ8B@phil>
 <CAPDyKFpTaRZqdpwFnC5DgLjJAf1YawJ1L5OVgwfjnfs7iNyUhQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAPDyKFpTaRZqdpwFnC5DgLjJAf1YawJ1L5OVgwfjnfs7iNyUhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-21 12:41 pm, Ulf Hansson wrote:
> On Tue, 20 May 2025 at 20:38, Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> Am Dienstag, 20. Mai 2025, 19:10:17 Mitteleuropäische Sommerzeit schrieb Robin Murphy:
>>> Most 32-bit Rockchip platforms do not use PSCI, so having to select
>>> ARM_PSCI to satisfy a dependency chain to retain working power domain
>>> support is a bit weird and non-obvious. Now that the offending SMCCC API
>>> is properly stubbed out for optional usage, we can relax this again.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Of course this needs patch1 of this series to get applied
>> first.
>>
>> I think for bisectability, doing this directly in patch1 might
>> be less dangerous though?
>>
> 
> If it helps, I can pick both patches via my pmdomain tree, to make
> sure patch1 really gets applied prior to patch2.

Perhaps I should have been less lazy and written a brief cover letter, 
but indeed, given the dependency my hope was for these to both go 
together through the same tree - it's just an open question of which 
tree that should be :)

Cheers,
Robin.

> Mark, Sudeep, Lorenzo do you see any problems with this?
> 
> [...]
> 
> Kind regards
> Uffe


