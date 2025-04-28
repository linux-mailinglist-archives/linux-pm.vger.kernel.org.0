Return-Path: <linux-pm+bounces-26329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F93A9F8D1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AB51888B45
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461E2951B0;
	Mon, 28 Apr 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJjtSrK/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5D1A072A;
	Mon, 28 Apr 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865828; cv=none; b=JcHKApxjcu8yhYqu4mgLkYZznQbRwFxzb6BIZZax68jLB73Axxv4dtjY9TFaKkWjwQZoNcR2fzSJS6TUNxZVUBW0cyU6cRZJXmH/xc4KRbJihzOqgTvSqXWj4bEs1pA6w8ixP09rNf9nL5mp5n07RK7SKF5184xT/vJZ8aCx+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865828; c=relaxed/simple;
	bh=roBx4174EPVNwqb/2muJ+YfV1TCurFebANGCAVMu5pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKLb8dJrlVa/aTLJTZWjlAX/2PuwULbC7RRJoSUU4NbMJRw6aAznYikP/ST83np0TGq7fR/ZyIlORKkhcb4SwmCqRK+gDywrZvP5reGOpxe/yP0IeLhvWGH80usJfZMG5Oe9YPC+FJIyMvJJC467U0RtcVYskVQjMGZFCyF6/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJjtSrK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83518C4CEE4;
	Mon, 28 Apr 2025 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865825;
	bh=roBx4174EPVNwqb/2muJ+YfV1TCurFebANGCAVMu5pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJjtSrK/fy0kRj//K3SWS51EEUW+Au2yU6I3MdDlEZMhN2K6YHpoUn9Aeles/poUA
	 lKdXgguwk8ylYI4WICR4Eo07aKHnfmTRETcVe92cxbijAcmIr1hq5FgzXk9BMAtnZQ
	 Emlu2rNA9lmdm1nbwL39hsnVN/RadZnnhYKc5af4eSeRLZ2KvEaaLA2a1E7tDK04KY
	 MVCz6jrplDtGJ3+H7P+3qQCW1KjmmE2KZtVMOguJViu7FwqH+DGg8gn2AKyq8d+Y86
	 nDwMOneQN+41BJ6ugHZWu5KVexTQzvwRK6kO/4/l/+3WLKbNbgZebt8RjoqwAsztEw
	 4XaH8+c029klw==
Message-ID: <b2bf3ab3-38b6-4da3-a850-ff768139901d@kernel.org>
Date: Mon, 28 Apr 2025 13:43:42 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250423014631.3224338-1-superm1@kernel.org>
 <20250423014631.3224338-2-superm1@kernel.org>
 <aA_LZZRVnWdv6IdH@char.us.oracle.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aA_LZZRVnWdv6IdH@char.us.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2025 1:39 PM, Konrad Rzeszutek Wilk wrote:
> ..snip..
>> +Implementation details for Linux
>> +--------------------------------
>> +
>> +The implementation of threads scheduling consists of the following steps:
>> +
>> +1. A thread is spawned and scheduled to the ideal core using the default
>> +   heterogeneous scheduling policy.
>> +2. The processor profiles thread execution and assigns an enumerated
>> +   classification ID.
>> +   This classification is communicated to the OS via logical processor
>> +   scope MSR.
>> +3. During the thread context switch out the operating system consumes the
>> +   workload(WL) classification which resides in a logical processor scope MSR.
>> +4. The OS triggers the hardware to clear its history by writing to an MSR,
>> +   after consuming the WL classification and before switching in the new thread.
>> +5. If due to the classification, ranking table, and processor availability,
>> +   the thread is not on its ideal processor, the OS will then consider
>> +   scheduling the thread on its ideal processor (if available).
> 
> Can you expand on 5) please?  The one patch in this patchset that
> touches the process file just does an WRMSR.

Hi, thanks for looking.

This scheduler change is not first part of the series and is going to be 
a follow up series.

I left it in the documentation as it explains the intended implementation.

