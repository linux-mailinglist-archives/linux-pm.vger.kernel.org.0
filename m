Return-Path: <linux-pm+bounces-36509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE36BF31E3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EA63AFC05
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2B2D46B2;
	Mon, 20 Oct 2025 19:11:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FEF242D76;
	Mon, 20 Oct 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987464; cv=none; b=EyOQEwDjtPToLKNCK3gVDiaSKSVkbzSJyx7/frleVVZmifF+4Q0JCnFNjko8mUIbqrwtvP0Oyw/wmk9uNP4ZlpncDHnHnBTx4lVNbO7QcJ/y2qn8XzCbsD42xd11WMLtiBz/y4DTSue0asXkBdqsLRtQwetrIUq+qcch9Yogy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987464; c=relaxed/simple;
	bh=nieYJ4XJDwAF96WABbqXyE0cfBIwUORhTlynNpFjzOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1ZLC0g1GLSULkGOIQl01V8YkHxZhdIvD1EkwtwhRNSlP8DWdXen3+SHi9PfA+GPi6rLbpSl0c2sBBMVVYe8cKe6GS5K2fdnZHl8Qz+9V5pO6XLJZZxg/hAEFqHeiAZcY1gMaORgV6Ko9R4TaYZ81fFQ4PrLervmgSVMHBcdi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F418C1007;
	Mon, 20 Oct 2025 12:10:53 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3843D3F59E;
	Mon, 20 Oct 2025 12:11:00 -0700 (PDT)
Message-ID: <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
Date: Mon, 20 Oct 2025 20:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] smp: Introduce a helper function to check for
 pending IPIs
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
 <20251020141718.150919-2-ulf.hansson@linaro.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251020141718.150919-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ulf,

Only a comment on the naming rather than a full review.

On 10/20/25 15:17, Ulf Hansson wrote:
> When governors used during cpuidle, tries to find the most optimal
> idlestate for a CPU or a group of CPUs, they are known to quite often fail.
> One reason for this, is that we are not taking into account whether there
> has been an IPI scheduled for any of the CPUs that are affected by the
> selected idlestate.
> 
> To enable pending IPIs to be taken into account for cpuidle decisions,
> let's introduce a new helper function, cpus_may_have_pending_ipi().

To me, "may" indicates permission, i.e. is allowed, rather than
correctness. Would "likely" be better here, cpus_likely_have_pending_ipi()?

> 
> Note that, the implementation is intentionally as lightweight as possible,
> in favor of always providing the correct information. For cpuidle decisions
> this is good enough.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Implemented a common function, rather than making it arch-specific. As
> 	suggested by Thomas and Marc.
> 	- Renamed the function to indicate that it doesn't provide correctness.
> 	- Clarified function description and commit message.
> 
-- 
Thanks,

Ben


