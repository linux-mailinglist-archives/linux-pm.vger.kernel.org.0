Return-Path: <linux-pm+bounces-40357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AABCFD385
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0A23041A47
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FB3246F3;
	Wed,  7 Jan 2026 10:29:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DF2FB97A;
	Wed,  7 Jan 2026 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781797; cv=none; b=f56/Sv2CWXKv4gYl/+Y7MUqv/sfDmD8BTSxgQghm1YOVNF8eTea3emvKSa8sXPw2pSAO5260TwP134WPjMiXBP8+3IIYmt25dFpl7pw7we+umKg3b/xsJ4Ylx5EK6og4Ds9RnGZsfEABjyMaFWiaqp/yftD4mXXEytDPlL9I0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781797; c=relaxed/simple;
	bh=lrAOtjj6ZPql2HtOImPIzTnLqQq9xgwqtghe1PyhM8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDTDZBo/24xFjGCo9LtIaV2/KxUTqoKBmf+oeZq2QjGWzqME5As+3durSuY8vFruldkP97YVdI4d7GrEPL3mgJO6RR+TOdOsCyUBDcBtFyXrjpl8EZjO9c/g+rmxo6m2yvJ2iQB+dWqUjcjXLNrHz34/dpFI4EJ23qIiSQ4FazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A4D497;
	Wed,  7 Jan 2026 02:29:47 -0800 (PST)
Received: from [10.57.49.120] (unknown [10.57.49.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DAC43F6A8;
	Wed,  7 Jan 2026 02:29:51 -0800 (PST)
Message-ID: <f555454a-3eb9-4537-8f69-66ec36931966@arm.com>
Date: Wed, 7 Jan 2026 11:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, joey.gouly@arm.com
References: <20260105200707.2071169-1-yeoreum.yun@arm.com>
 <af65f271-5af9-432d-bec9-e44638db9b9f@arm.com>
 <aV4uDW2p+WBCitwl@e129823.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <aV4uDW2p+WBCitwl@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/01/2026 10:57, Yeoreum Yun wrote:
>>> @@ -97,8 +97,11 @@ SYM_FUNC_START(cpu_do_suspend)
>>>  	mrs	x9, mdscr_el1
>>>  	mrs	x10, oslsr_el1
>>>  	mrs	x11, sctlr_el1
>>> -	get_this_cpu_offset x12
>>> -	mrs	x13, sp_el0
>>> +alternative_if ARM64_HAS_TCR2
>>> +	mrs	x12, REG_TCR2_EL1
>>> +alternative_else_nop_endif
>>> +	get_this_cpu_offset x13
>>> +	mrs	x14, sp_el0
>>>  	stp	x2, x3, [x0]
>>>  	stp	x4, x5, [x0, #16]
>>>  	stp	x6, x7, [x0, #32]
>>> @@ -109,7 +112,7 @@ SYM_FUNC_START(cpu_do_suspend)
>>>  	 * Save x18 as it may be used as a platform register, e.g. by shadow
>>>  	 * call stack.
>>>  	 */
>>> -	str	x18, [x0, #96]
>>> +	stp	x14, x18, [x0, #96]
>> If TCR2_EL1 isn't supported, we store and reload an unused arbitrary
>> value. I think it'd be better to make it all conditional and add it at
>> the end, something like:
>>
>>     alternative_if ARM64_HAS_TCR2
>>         mrs    x2, REG_TCR2_EL1
>>         str    x2, [x0, #104]
>>     alternative_else_nop_endif
>>
>> Same idea on the resume path. This also avoids the noise of renaming
>> existing registers.
> IMHO, I think it would be better to sustain the change since
> it seems more simpler to maintain  and x12 is temporary regsiter
> so leaking whatever was in x12 does not really feel like a concern...

Leaking is not a concern, but I don't think it's really easier to
maintain. We can have all the conditional registers grouped together,
like DISR_EL1 and soon SCTLR2_EL1. This avoids renaming a bunch of
registers every time we save/restore a new register here.

- Kevin

