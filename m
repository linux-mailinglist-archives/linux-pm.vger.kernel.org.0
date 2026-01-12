Return-Path: <linux-pm+bounces-40650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE2D11866
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 10:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C352300A7A8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B60C26F2BE;
	Mon, 12 Jan 2026 09:36:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB42673A5;
	Mon, 12 Jan 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210615; cv=none; b=V7Y308IjD9WGy9Zn22yVaEsIGjmoKc4GOCzTLEOeeedqpKoVS8jCeM3IleDtBM7NRiCJt2KtWjvP3fOdwWu1nE81yNiddWOSbHq9rqkF50VkFKwBCbhgEeUqXjtKDdLjANm4vYPxOGjnuaEhp0nm1pYuMZHRtA3ZEHTngpw2JVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210615; c=relaxed/simple;
	bh=eDrU7IoUD9uMNzgUGRUaY4NBQo7b3SP+gjYSD4Bgp54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfRXtop151ftNP/0liYaIAtcKCEbAh70sAT9vg47kPuHedmwZg9yh3tDtj53dN9aXQA52Vk6ohYHLoFmcLUnMVNjzhKnrbntdgXigXMmToSG2emH9U+ke1MFlsUWXrapCwv7ToLPjJR8/kyncZ4qo5/0KMhMo2SMi1TpgdHAM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911E3339;
	Mon, 12 Jan 2026 01:36:46 -0800 (PST)
Received: from [10.57.48.185] (unknown [10.57.48.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11C633F694;
	Mon, 12 Jan 2026 01:36:50 -0800 (PST)
Message-ID: <08af7447-1ea8-4513-907e-1902a661261f@arm.com>
Date: Mon, 12 Jan 2026 10:36:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: fix cleared E0POE bit after
 cpu_suspend()/resume()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, pavel@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, joey.gouly@arm.com,
 stable@vger.kernel.org
References: <20260107162115.3292205-1-yeoreum.yun@arm.com>
 <846e1998-b508-4433-9db6-3a52ff23552f@arm.com>
 <aV6YPyLV1quaOkyw@e129823.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <aV6YPyLV1quaOkyw@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2026 18:30, Yeoreum Yun wrote:
> Hi Kevin,
>
> [...]
>
>>> @@ -144,6 +148,10 @@ SYM_FUNC_START(cpu_do_resume)
>>>  	msr	tcr_el1, x8
>>>  	msr	vbar_el1, x9
>>>  	msr	mdscr_el1, x10
>>> +alternative_if ARM64_HAS_TCR2
>>> +	ldr	x2, [x0, #104]
>>> +	msr	REG_TCR2_EL1, x2
>>> +alternative_else_nop_endif
>> Maybe this could be pushed further down cpu_do_resume, next to DISR_EL1
>> maybe (since it's also conditional)? Otherwise the diff LGTM:
> Sorry but IIUC, currently there is no DISR_EL1 save/restore not yet?

It's zeroed at the end of cpu_do_resume, but yes it's not saved.

> and I think current place is good where before restore SCTLR_EL1 which
> before MMU enabled.

Fair enough, and I can see that other registers are not restored in the
same order as they're saved, so we're not breaking an existing pattern.
Either way Catalin took the patch so this is settled :)

- Kevin

