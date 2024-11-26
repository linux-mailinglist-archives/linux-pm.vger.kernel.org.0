Return-Path: <linux-pm+bounces-18120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277909D964E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BAC16782E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D901C8FBA;
	Tue, 26 Nov 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLLcg3GQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7911185;
	Tue, 26 Nov 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621020; cv=none; b=qngFZa2NEhHF+IhNKpHWXQriJp5M8V+3SRPHIjRqxVLg6TWKJZTMAJNgLFlY3DtcrUeCVve8NVNhD5eqs+U2Cudb1AhonBNKiqNf+TPQti/U8NRRvjCdmp0zie/CpPqmny+W9z/KJ7hOG7paRXk17OcWKas8OcpVlNcfBILiTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621020; c=relaxed/simple;
	bh=pUWdZ6jxOCTRPS8yC3hdSTdixCm1nvL0Sd0s8pDzsTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBXxsUK5DJPYLuSIAC8A+AI/JH2O73Zw6o/5CcoqkRyAQ4ehiw/6JMfYhabL2rt/HkkfqqVwJhYw/e9X7JK14sf3BliIytLktKGIC11fUdbyCXVtoQbX8HtnGx+Wr3LGq0DSWrmaCAwwSI6WeLzaoHnmYZ3mwcBG+B5D2JjcPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLLcg3GQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732621019; x=1764157019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pUWdZ6jxOCTRPS8yC3hdSTdixCm1nvL0Sd0s8pDzsTc=;
  b=hLLcg3GQ4momEz60DhNyxaXHaVLUTzGH/UJQPJHj6hsCY7LrG4aWZ4fX
   7HGgchHBa/YVqTuhWEpXPM7l6DzqI5HCEj6ZdsK0g9WI0hmub82AT5D08
   P77z/yOkRsUDdcjMSURpSetwv+5nZYbc35aA8tbScU+PeusySVEU3nQlv
   AzVyP6NxVEpiuCLYQZ3a75EH+afgYYof1iig6p9NDzdI137qlp8jbGXtC
   I2lHDQvTGZFV3hVW7VAIp1MTptRYpe7MSQDZWXRPsj5KZQd57mGAnhU5z
   DvmbpfuVEfMfSmmrsFfGiwrNPCLPyz5ZnHFV8iy/OSNhnYA+ucmlyveJ9
   g==;
X-CSE-ConnectionGUID: SnZRud76T8+A0N+gDk5LQQ==
X-CSE-MsgGUID: i/Var80kRv+n1b5LVnTk9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32922382"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="32922382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:36:58 -0800
X-CSE-ConnectionGUID: rOgyn9C3Srik6pe/Sc9bCA==
X-CSE-MsgGUID: Mktzgut5QlSGukI8Fkvu2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="96013702"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:36:56 -0800
Message-ID: <1023ee1a-1fc5-498f-be5b-a59a7317ef5a@linux.intel.com>
Date: Tue, 26 Nov 2024 12:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/8] x86/smp: Allow calling mwait_play_dead with
 arbitrary hint
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-5-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0iBCKmp-Hs25chq_-z7-VB_+MqTPVmowACJkTz7KOUtEg@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0iBCKmp-Hs25chq_-z7-VB_+MqTPVmowACJkTz7KOUtEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> The MWAIT instruction needs different hints on different CPUs to reach
>> the most specific idle states. The current hint calculation* in
>> mwait_play_dead() code works in practice on current hardware, but it
>> fails on a recent one, Intel's Sierra Forest and possibly some future ones.
>> Those newer CPUs' power efficiency suffers when the CPU is put offline.
>>
>>  * The current calculation is the for loop inspecting edx in
>>    mwait_play_dead()
>>
>> The current implementation for looking up the mwait hint for the deepest
>> cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
>> calculates the mwait hint based on the number of reported substates.
>> This approach depends on the hints associated with them to be continuous
>> in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
>> is not met on the recent Intel platforms.
>>
>> For example, Intel's Sierra Forest report two cstates with two substates
>> each in cpuid leaf 5:
>>
>>   Name*   target cstate    target subcstate (mwait hint)
>>   ===========================================================
>>   C1      0x00             0x00
>>   C1E     0x00             0x01
>>
>>   --      0x10             ----
>>
>>   C6S     0x20             0x22
>>   C6P     0x20             0x23
>>
>>   --      0x30             ----
>>
>>   /* No more (sub)states all the way down to the end. */
>>   ===========================================================
>>
>>    * Names of the cstates are not included in the CPUID leaf 0x5, they are
>>      taken from the product specific documentation.
>>
>> Notice that hints 0x20 and 0x21 are skipped entirely for the target
>> cstate 0x20 (C6), being a cause of the problem for the current cpuid
>> leaf 0x5 algorithm.
>>
>> Allow cpuidle code to provide mwait play dead loop with known, mwait
>> hint for the deepest idle state on a given platform, skipping the cpuid
>> based calculation.
>>
>> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>
> I'm going to risk saying that the changelog doesn't match the code
> changes in the patch any more.
>
> The code changes are actually relatively straightforward: The bottom
> half of mwait_play_dead() is split off, so it can be called from
> multiple places.
>
> The other places from which to call it are cpuidle drivers
> implementing :enter_dead() callbacks that may want to use MWAIT as the
> idle state entry method.  The ACPI processor_idle driver and
> intel_idle will be updated by subsequent patches to do so.
>
> The reason for it is mostly consistency: If the cpuidle driver uses a
> specific idle state for things like suspend-to-idle, it is better to
> let it decide what idle state to use for "play_dead" because it may
> know better.
>
> Another reason is what mwait_play_dead() does to determine the MWAIT
> argument (referred to as a "hint"), but IMO it belongs in a changelog
> of a later patch because this one doesn't actually do anything about
> it.  In fact, it is not expected to change the behavior of the code.

The commit message here is to justify the change. I thought that giving
some context is important. Do you suggest moving this under a
different commit or don't mention the SRF and C6 states at all?


