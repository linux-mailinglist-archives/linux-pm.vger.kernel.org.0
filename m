Return-Path: <linux-pm+bounces-18128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9B19D980E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01852B28E8B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD91D432F;
	Tue, 26 Nov 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ8SeIu3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2D2F32;
	Tue, 26 Nov 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626626; cv=none; b=hffbzqjeHf/DgHzviBfcgvi1iV1OSzO32ZdzohXLXu5JlLTmEdCbnqG/A53pnxfiftxaPx71UQXYlYEByJlY9zIYx17WYaqqjlGzU59gMibL4fcUhCUAoDRr6nnjgYIh5eShWNayPZEn9mA3bZtXr/+CEQGmI5tsBvCZxr9IYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626626; c=relaxed/simple;
	bh=1OD/sS92a2krXuM4uujLs3lV6TX2gz9Vq9QjNdCTj+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwEjfqQbzqz9/eZHPSnVKShMLrswYKd1Z0M3/Lb5cxLYFhIeLDRrtyOpdT/QbsUqyYh66I/J7mw1gqLXfwHOR/DV8+FRZAOYidt85e7Y9t/6AEP5IruiJ8xXw+L5zEXTZF/vdJGHh2Ivvz+mUQJ7yjJky7mP8zH0e7BfdxsxWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ8SeIu3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732626626; x=1764162626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1OD/sS92a2krXuM4uujLs3lV6TX2gz9Vq9QjNdCTj+g=;
  b=TQ8SeIu3v+4DyeTqdAxfAP9+/Aer4C1K/wjpuUMz328xWpVvCY6LOx3s
   bzLH2F41WgtiQoAU8yrflrsEn915/m/PqWRcTYEXJbMGeJSLTd7S8J8Nk
   Dp73qzzLeeYdsswK7u8KbkS/5CsvOlDG28q3hLZl6hWECcaO/tzy50YDr
   j4Z5JmxDn/utoh1Xxyin+qjwoF8wnr1Dy6+BptL6L5t3sIo+1yKSK6jES
   GAN3c1Y/I78PcSRzgRbVTdTIbq/hsqTtPKzowD5dJecN6LT/avUzdWhOJ
   wbiqGxb6Ls1yv+IsRCzXyEZuXs0cBpYf2uuA5KdmsA7Wm+8XVUmqLhthk
   A==;
X-CSE-ConnectionGUID: usVuv1mJSLaAkoYTbfgmmg==
X-CSE-MsgGUID: LCaJELWFSkigrFv3at13mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32942266"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32942266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:10:25 -0800
X-CSE-ConnectionGUID: C/+eW+SeRx+SjjCjwcyQyA==
X-CSE-MsgGUID: BtKDLzmfSGqMSmpMSO0lYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91779150"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:10:21 -0800
Message-ID: <706408b6-fd2c-475a-bde6-c95d0cab7360@linux.intel.com>
Date: Tue, 26 Nov 2024 14:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
 <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com>
 <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
 <a8d53d86-d658-4e18-bfd6-b37a2656b180@linux.intel.com>
 <CAJZ5v0iA==dmnPbs6BNV_taDD9hRWbwOhiCWsi0BjKzVVdihdg@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0iA==dmnPbs6BNV_taDD9hRWbwOhiCWsi0BjKzVVdihdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>>> If you first make intel_idle provide :enter_dead() for all CPUs on all
>>>>> platforms and implement it by calling mwait_play_dead_with_hint(), you
>>>>> won't need mwait_play_dead() any more.
>>>> Crossed my mind, but because mwait_play_dead doesn't filter on Intel
>>>> vendor specifically,
>>>
>>> In practice, it does.
>>>
>>> The vendor check in it is equivalent to "if Intel".
>>
>> Actually, what about INTEL_IDLE=n?
>> We might hit acpi_idle, which would call mwait_play_dead_with_hint() now, but
>> if we don't, don't we want to try mwait_play_dead before hlt or is it too
>> unrealistic to happen?
>
> In that case the hint to use would not be known anyway, so
> hlt_play_dead() is the right choice IMV.

Fair, it's not known, but we could fallback to the old, cpuid leaf 0x5 based
algorithm, which works on a lot of hardware.

That being said, I think it's cleaner to get rid of the old algorithm entirely
and rely on idle drivers to do the right thing from this point forward.

If we could bring the CPU out of the mwait loop into the hlt loop somehow (via
interrupt for example) we could remove the old kexec hack altogether.



