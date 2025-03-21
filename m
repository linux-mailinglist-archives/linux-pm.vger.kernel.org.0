Return-Path: <linux-pm+bounces-24379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2231A6BD5A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1752D188B51A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A831DB12D;
	Fri, 21 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTbTqF9A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EC1BBBFD;
	Fri, 21 Mar 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568078; cv=none; b=fDjRvwUJtHkrM85Qy+XCFCO8Trtf3SPg4EY8d+AG/eFHfPW9U9U4UUSTXvJngQ3b8h5/Fkb2bFHwspmLjbyBqP8xRogOp7/nxaA+D5AsYCHIn+evULvHBlQ6Vn09vfa4U0mT/NezwMgS/IQqrjNNb57RUjVtNdayx9CM1gaWLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568078; c=relaxed/simple;
	bh=zyk/9qyf/13ksj1qkC9QTG9vOLXhbZDwkWpoHz2iK18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYBb2K+Q5opcV4di2wa9Hma5yzsZpDNQ7sVBmVRt0pbGJUeHzoVAdjT4nbcvTi9e+mimmekGIAuAXfO22WSbLB4SiIDVf/3FF4e+wnfqBSt83ZeZigeDjHCdXnCHDRoFUXVRBMIvhQ53BZ/01l+zWJWIoiKRi5S7N8ThMkCwtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTbTqF9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AEAC4CEE3;
	Fri, 21 Mar 2025 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742568076;
	bh=zyk/9qyf/13ksj1qkC9QTG9vOLXhbZDwkWpoHz2iK18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FTbTqF9A0FLqceBf4syWDKY56HuCVR74TupaXR6D9HFmArTZsSgKvWfRtcIWWUTVp
	 KYwnoEvwJ4ehKuxQA75TeS4TtCkBaDMNCRa2l7VWjIe8bHoNU+2EEBmeMV2SC10vKZ
	 bvo/wrUDgcYh5Xyy4+d0lVFlYFZNig4UpdeDv8YmgYhQIgiSfBK7NkzugWXNKMY1mf
	 zRoMicEDYQvR5Flqedx0fXpIAZnCTHXhD3Dj0/KHtzmZXgySsniiV4PtfwDfEIertz
	 m/QU0TALqgWvpL5onPngUmIf1vf+fMhsoESnePNUV3UVtheFW/DOFJPBq64HT8p2RS
	 vNblR/Yq0RUZQ==
Message-ID: <806cafb1-7bab-4001-9b28-3f412ca2fd89@kernel.org>
Date: Fri, 21 Mar 2025 09:41:13 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
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
References: <20250218190822.1039982-1-superm1@kernel.org>
 <20250218190822.1039982-2-superm1@kernel.org>
 <127a93b0-647f-bb0c-2bf4-649fc4d1f25e@linux.intel.com>
 <a2e33d66-22ee-475b-817b-b52c6890859c@kernel.org>
 <58c49901-24b2-2209-9583-09e6b080cc08@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <58c49901-24b2-2209-9583-09e6b080cc08@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/2025 08:58, Ilpo Järvinen wrote:
> On Thu, 20 Mar 2025, Mario Limonciello wrote:
> 
>> On 3/19/2025 09:01, Ilpo Järvinen wrote:
>>> On Tue, 18 Feb 2025, Mario Limonciello wrote:
>>>
>>>> From: Perry Yuan <Perry.Yuan@amd.com>
>>>>
>>>> Introduce a new documentation file, `amd_hfi.rst`, which delves into the
>>>> implementation details of the AMD Hardware Feedback Interface and its
>>>> associated driver, `amd_hfi`. This documentation describes how the
>>>> driver provides hint to the OS scheduling which depends on the capability
>>>> of core performance and efficiency ranking data.
>>>>
>>>> This documentation describes
>>>> * The design of the driver
>>>> * How the driver provides hints to the OS scheduling
>>>> * How the driver interfaces with the kernel for efficiency ranking data.
>>>>
>>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    Documentation/arch/x86/amd-hfi.rst | 127 +++++++++++++++++++++++++++++
>>>>    Documentation/arch/x86/index.rst   |   1 +
>>>>    2 files changed, 128 insertions(+)
>>>>    create mode 100644 Documentation/arch/x86/amd-hfi.rst
>>>>
>>>> diff --git a/Documentation/arch/x86/amd-hfi.rst
>>>> b/Documentation/arch/x86/amd-hfi.rst
>>>> new file mode 100644
>>>> index 0000000000000..5d204688470e3
>>>> --- /dev/null
>>>> +++ b/Documentation/arch/x86/amd-hfi.rst
>>>> @@ -0,0 +1,127 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +======================================================================
>>>> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
>>>> +======================================================================
>>>> +
>>>> +:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
>>>> +
>>>> +:Author: Perry Yuan <perry.yuan@amd.com>
>>>> +:Author: Mario Limonciello <mario.limonciello@amd.com>
>>>> +
>>>> +Overview
>>>> +--------
>>>> +
>>>> +AMD Heterogeneous Core implementations are comprised of more than one
>>>> +architectural class and CPUs are comprised of cores of various efficiency
>>>> and
>>>> +power capabilities: performance-oriented *classic cores* and
>>>> power-efficient
>>>> +*dense cores*. As such, power management strategies must be designed to
>>>> +accommodate the complexities introduced by incorporating different core
>>>> types.
>>>> +Heterogeneous systems can also extend to more than two architectural
>>>> classes as
>>>> +well. The purpose of the scheduling feedback mechanism is to provide
>>>> +information to the operating system scheduler in real time such that the
>>>> +scheduler can direct threads to the optimal core.
>>>> +
>>>> +The goal of AMD's heterogeneous architecture is to attain power benefit
>>>> by sending
>>>> +background thread to the dense cores while sending high priority threads
>>>> to the classic
>>>> +cores. From a performance perspective, sending background threads to
>>>> dense cores can free
>>>> +up power headroom and allow the classic cores to optimally service
>>>> demanding threads.
>>>> +Furthermore, the area optimized nature of the dense cores allows for an
>>>> increasing
>>>> +number of physical cores. This improved core density will have positive
>>>> multithreaded
>>>> +performance impact.
>>>
>>> Hi Mario,
>>>
>>> Please fold these paragraphs to 80 characters so that they're easier to
>>> read as textfiles (the table can obviously exceed that but there should be
>>> no reason for the text paragraphs to have excessively long lines).
>>>
>>> My apologies for taking so long to get to review this series.
>>
>> No problem.  Thanks for looking.  I'll get a new version ready to put out
>> after the next merge window.
>>
>>> Most of my
>>> comments are quite minor but there's also 1-2 things that seem more
>>> important. It seemed to me that there is some disconnetion between the
>>> promises made in the Kconfig description and what is provided by the patch
>>> series.
>>
>> Some of the series was pared down to go in multiple parts to make it easier to
>> review with follow ups for the dynamic stuff planned for the next iteration.
>>
>> You see some artifacts of that comments and Kconfig.  I figured it was better
>> to leave as is for those given they get to the intent, but I can change if you
>> think it's better to adjust them when the next part lands instead.
> 
> Okay, I thought that might be because such a split to multiple series. I
> think you can leave those as is as I assume to intention is to immediately
> follow up with the other parts (and not like wait a few kernel releases
> or so)?
> 

The next part was going to be submitted by another team.  Let me check 
offline with them on their intended timing and I will make a call what 
to do.

