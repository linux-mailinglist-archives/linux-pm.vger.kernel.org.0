Return-Path: <linux-pm+bounces-24704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D33A77DFE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098C03AFE29
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF78204C25;
	Tue,  1 Apr 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M6VzVDrT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EF204C15
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518306; cv=none; b=fKFnTh4TE1sr0twbxvTbl+xeVKf1n4D/pYs55nabR6sKPKnqdaA6Hy1/niy2bPqiqwy/lOHarjOdFPP675ZXXzT4wbjj2r96kEbgI4AMN3qP+Ehnl9tcF5E2TK6BPcDhzmdru4rwmH+qG/4Ux9mFRWyew7Hu443byCly1fXFcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518306; c=relaxed/simple;
	bh=Uy7qsjdC0ECzrNp66Spy2t2Na970UJ6MjIl/IBeNc+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=siV9J7hHXvbmOwC52aIjvTq6bRVn6XxNMcqcicoxkfNGX2Oz0C1gJFawUKgqmAU8vzFGUHw2ERq8WWcTPd3il8pCta4CTGZnMvWA0E5a+bUQtjEDdUS41DNqAr01EZdOpjphIsIpJMwTm6tghbGzeY4AVGg93frf7Q844s5qpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M6VzVDrT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250401143815euoutp02cca7c85b19f9aaaf641dc932dec5a4fc~yOKcRf7k91253012530euoutp02T
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 14:38:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250401143815euoutp02cca7c85b19f9aaaf641dc932dec5a4fc~yOKcRf7k91253012530euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743518295;
	bh=SDsWtV73qvuMIdHiDqANtX+1Rido/jLdHSnNDNiIGlc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=M6VzVDrTjO5ncrZpmUs9262CDsI3osC9kKQvdtSNQetiQe0fYGTqHkpZX43T5IhBU
	 7CWLwJaWzhfZS65VL9C62IdT/lW+A0mwx4yKZ1iJbJlMF0iG/bymVVcc5XVvUbCG1W
	 bTMtpJJJyH48au+1tFFByiVNskk+xFqRwTkD0PY4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250401143815eucas1p23732e94d5e8f2887a2490c6a748ba05d~yOKbixsnF3032830328eucas1p28;
	Tue,  1 Apr 2025 14:38:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.8B.20397.65AFBE76; Tue,  1
	Apr 2025 15:38:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250401143814eucas1p16a2149cfa8a89e060d396fa283742765~yOKasDsev2332523325eucas1p1J;
	Tue,  1 Apr 2025 14:38:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250401143814eusmtrp1662570be4f10bcaf303bf559c09258ea~yOKaq3F4T1600116001eusmtrp1k;
	Tue,  1 Apr 2025 14:38:14 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-95-67ebfa56b07a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.FF.19654.65AFBE76; Tue,  1
	Apr 2025 15:38:14 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250401143813eusmtip167fc2356ca3d35bfe985370a2fc506fa~yOKZrHUYJ3233532335eusmtip1H;
	Tue,  1 Apr 2025 14:38:13 +0000 (GMT)
Message-ID: <ef17e5d1-b364-41e1-ab8b-86140cbe69b2@samsung.com>
Date: Tue, 1 Apr 2025 16:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with
 CLKGEN reset support
To: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, alex@ghiti.fr,
	aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, jszhang@kernel.org, krzk+dt@kernel.org,
	m.szyprowski@samsung.com, mturquette@baylibre.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, wefu@redhat.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZduzned3wX6/TDfbPZ7R4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsPvbcY7W4vGsOm8Xn3iOMFts+t7BZ
	rD1yl93i4ilXi7v3TrBYvLzcw2zRNovf4v+eHewW/65tZLE4vjbcomX/FBYHUY/3N1rZPd68
	fMnicbjjC7vHvRPTWD02repk87hzbQ+bx+Yl9R4ta48xefT/NfB4v+8qm0ffllWMHpear7N7
	fN4kF8AbxWWTkpqTWZZapG+XwJVxa/5J5oJp3hXde7+zNTC+seli5OSQEDCRuPVjNguILSSw
	glFi6i3FLkYuIPsLo8Tho3OZIZzPjBI/mxawwnR8Xt7CCJFYziix4N5pVgjnLaPE8o0HmUCq
	eAXsJG6/W8YGYrMIqEjc+3KZGSIuKHFy5hOwfaIC8hL3b81gB7GFBeIkbmw7CdYrIuApMeN6
	IyOIzSxwgVni9HUDCFtc4taT+WA1bAJGEg+Wzwe7iFMgUOLsiTVMEDXyEtvfzgE7W0LgH6fE
	1a5bbBBnu0jMXfIByhaWeHV8CzuELSNxenIPC4SdL/Fg6ydmCLtGYmfPcSjbWuLOuV9AvRxA
	CzQl1u/Shwg7Sjx+vZ8RJCwhwCdx460gxAl8EpO2TWeGCPNKdLQJQVSrSUzt6YVbem7FNqYJ
	jEqzkAJlFpInZyF5ZhbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU+rpf8e/
	7mBc8eqj3iFGJg7GQ4wSHMxKIrwRX1+mC/GmJFZWpRblxxeV5qQWH2KU5mBREuddtL81XUgg
	PbEkNTs1tSC1CCbLxMEp1cBUMEPn+y3++3N+Pb/U7WERVR318gBHyux3dnO3inDvmRjM1pK0
	642pMt9K73XrVum1TqtLsmtIc+Z0mxmWtHUa891vT66LPHJp9xe7ZuLW8W7CGt4bs62zEm//
	ZfUOVqw/E/51+uaHiYzJDAHrHsxrnusd/MYtNHBjY9rzZcrWBx0W5ai7PvPTM2Mx0Kkti+Re
	YsrSylVSVKxy9MAOLdZWu+C1tj7Rmq/eF6u12FW3L3sxd+eWubfLgmYe17+nUMMoUXJMqX6F
	y4vw2YvlFa7sl3LynTZVRuaopNfWvJeZms4VTJNlixe/PLvJ2ztE8Pm2q4s8Alq4yjv+hf+q
	mVtz32RnI6OmOOvPZrtrPkosxRmJhlrMRcWJAA892kQYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7phv16nG/xqZrd4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsPvbcY7W4vGsOm8Xn3iOMFts+t7BZ
	rD1yl93i4ilXi7v3TrBYvLzcw2zRNovf4v+eHewW/65tZLE4vjbcomX/FBYHUY/3N1rZPd68
	fMnicbjjC7vHvRPTWD02repk87hzbQ+bx+Yl9R4ta48xefT/NfB4v+8qm0ffllWMHpear7N7
	fN4kF8AbpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
	oJdxa/5J5oJp3hXde7+zNTC+seli5OSQEDCR+Ly8hbGLkYtDSGApo8SM5wvZIRIyEte6X7JA
	2MISf651sUEUvWaUOND8nBkkwStgJ3H73TI2EJtFQEXi3pfLUHFBiZMzn4A1iwrIS9y/NQNs
	qLBAnMT5XatYQWwRAU+JGdcbwTYzC1xgluj/fZAdYsMCFonOM6/BpjILiEvcejKfCcRmEzCS
	eLB8Plg3p0CgxNkTa4DiHEA16hLr5wlBlMtLbH87h3kCo9AsJHfMQjJpFkLHLCQdCxhZVjGK
	pJYW56bnFhvpFSfmFpfmpesl5+duYgSmkW3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeCO+vkwX
	4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnARJZXEm9oZmBqaGJmaWBqaWasJM7LduV8mpBA
	emJJanZqakFqEUwfEwenVAPT1jul+/gW/Rf7IL5naurypLvr2E/LXOa9b3Dh3N9+htuXD7+f
	O89J8abB1uzCjQ1OTa0zO2ddylV+VO1W8nLJ+rD9y6vMxMtnme10t9S67h17LJazciXb1FRe
	f+MpGw2vKIt9E7iVfGK/1oP7K9m2bv+37B/L2TsXDZWmrylW5t01t/uYaKy4nN5Wx9fK7ycZ
	LhfosrjbtyRnxYMH63MOiYQLF17eKlGTOe1S44P107VtSy6y7NjbE7D7y3+j7uMb7118c2fN
	9ik5rZyKvEt/+t4xOfn+9C2PG+JZ0+PWiHOLf9v+sLLARPvEdD1Tje0V+7bdPHHnyNen8pM3
	fjhiv/o3e/uquPunjvcLvzHsnjlTiaU4I9FQi7moOBEAqbDea6wDAAA=
X-CMS-MailID: 20250401143814eucas1p16a2149cfa8a89e060d396fa283742765
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	<CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com>
	<20250303143629.400583-5-m.wilczynski@samsung.com>
	<de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>
	<4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com>
	<aacd03a071dce7b340d7170eae59d662d58f23b1.camel@pengutronix.de>
	<e90a0c77-61a0-49db-86ba-bac253f8ec53@samsung.com>
	<38d9650fc11a674c8b689d6bab937acf@kernel.org>
	<CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com>



On 3/26/25 12:24, Ulf Hansson wrote:
> On Tue, 25 Mar 2025 at 23:40, Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting Michal Wilczynski (2025-03-19 02:22:11)
>>>
>>>
>>> On 3/13/25 10:25, Philipp Zabel wrote:
>>>> On Do, 2025-03-06 at 17:43 +0100, Michal Wilczynski wrote:
>>>>>
>>>>> On 3/6/25 00:47, Stephen Boyd wrote:
>>>>>> Quoting Michal Wilczynski (2025-03-03 06:36:29)
>>>>>>> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
>>>>>>> clock gate is marked as "Reserved" in hardware, while core and cfg are
>>>>>>> configurable. In order for these clock gates to work properly, the
>>>>>>> CLKGEN reset must be managed in a specific sequence.
>>>>>>>
>>>>>>> Move the CLKGEN reset handling to the clock driver since it's
>>>>>>> fundamentally a clock-related workaround [1]. This ensures that clk_enabled
>>>>>>> GPU clocks stay physically enabled without external interference from
>>>>>>> the reset driver.  The reset is now deasserted only when both core and
>>>>>>> cfg clocks are enabled, and asserted when either of them is disabled.
>>>>>>>
>>>>>>> The mem clock is configured to use nop operations since it cannot be
>>>>>>> controlled.
>>>>>>>
>>>>>>> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]
>>>>>>>
>>>>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>>>> [...]
>>>>>>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
>>>>>>> index ea96d007aecd..1dfcde867233 100644
>>>>>>> --- a/drivers/clk/thead/clk-th1520-ap.c
>>>>>>> +++ b/drivers/clk/thead/clk-th1520-ap.c
>>>>>>> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
>>>>>> [...]
>>>>>>>
>>>>>>>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
>>>>>>>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
>>>>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
>>>>>>> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
>>>>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
>>>>>>> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
>>>>>>> +
>>>>>>> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
>>>>>>> +{
>>>>>>> +       struct ccu_gate *cg = hw_to_ccu_gate(hw);
>>>>>>> +       unsigned long flags;
>>>>>>> +
>>>>>>> +       spin_lock_irqsave(&gpu_reset_lock, flags);
>>>>>>> +
>>>>>>> +       ccu_disable_helper(&cg->common, cg->enable);
>>>>>>> +
>>>>>>> +       if ((cg == &gpu_core_clk &&
>>>>>>> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
>>>>>>> +           (cg == &gpu_cfg_aclk &&
>>>>>>> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
>>>>>>> +               reset_control_assert(gpu_reset);
>>>>>>
>>>>>> Why can't the clk consumer control the reset itself? Doing this here is
>>>>>> not ideal because we hold the clk lock when we try to grab the reset
>>>>>> lock. These are all spinlocks that should be small in lines of code
>>>>>> where the lock is held, but we're calling into an entire other framework
>>>>>> under a spinlock. If an (unrelated) reset driver tries to grab the clk
>>>>>> lock it will deadlock.
>>>>>
>>>>> So in our case the clk consumer is the drm/imagination driver. Here is
>>>>> the comment from the maintainer for my previous attempt to use a reset
>>>>> driver to abstract the GPU init sequence [1]:
>>>>>
>>>>> "Do you know what this resets? From our side, the GPU only has a single
>>>>> reset line (which I assume to be GPU_RESET)."
>>>>>
>>>>> "I don't love that this procedure appears in the platform reset driver.
>>>>> I appreciate it may not be clear from the SoC TRM, but this is the
>>>>> standard reset procedure for all IMG Rogue GPUs. The currently
>>>>> supported TI SoC handles this in silicon, when power up/down requests
>>>>> are sent so we never needed to encode it in the driver before.
>>>>>
>>>>> Strictly speaking, the 32 cycle delay is required between power and
>>>>> clocks being enabled and the reset line being deasserted. If nothing
>>>>> here touches power or clocks (which I don't think it should), the delay
>>>>> could potentially be lifted to the GPU driver."
>>>>>
>>>>> From the drm/imagination maintainers point of view their hardware has
>>>>> only one reset, the extra CLKGEN reset is SoC specific.
>>>>
>>>> If I am understanding correctly, the CLKGEN reset doesn't reset
>>>> anything in the GPU itself, but holds the GPU clock generator block in
>>>> reset, effectively disabling the three GPU clocks as a workaround for
>>>> the always-ungated GPU_MEM clock.
>>>>
>>>>> Also the reset driver maintainer didn't like my way of abstracting two
>>>>> resets ("GPU" and and SoC specific"CLKGEN") into one reset
>>>>
>>>> That is one part of it. The other is that (according to my
>>>> understanding as laid out above), the combined GPU+CLKGEN reset would
>>>> effectively disable all three GPU clocks for a while, after the GPU
>>>> driver has already requested them to be enabled.
>>>
>>> Thank you for your comments Philipp, it seems like we're on the same
>>> page here. I was wondering whether there is anything I can do to move the
>>> patches forward.
>>>
>>> Stephen, if the current patch is a no go from your perspective could you
>>> please advise whether there is a way to solve this in a clock that would
>>> be acceptable to you.
>>
>> It looks like the SoC glue makes the interactions between the clk and
>> reset frameworks complicated because GPU clks don't work if a reset is
>> asserted. You're trying to find a place to coordinate the clk and reset.
>> Am I right?
>>
>> I'd advise managing the clks and resets in a generic power domain that
>> is attached to the GPU device. In that power domain, coordinate the clk
>> and reset sequencing so that the reset is deasserted before the clks are
>> enabled (or whatever the actual requirement is). If the GPU driver
>> _must_ have a clk and reset pointer to use, implement one that either
>> does nothing or flag to the GPU driver that the power domain is managing
>> all this for it so it should just use runtime PM and system PM hooks to
>> turn on the clks and take the GPU out of reset.
>>
>> From what I can tell, the GPU driver maintainer doesn't want to think
>> about the wrapper that likely got placed around the hardware block
>> shipped by IMG. This wrapper is the SoC glue that needs to go into a
>> generic power domain so that the different PM resources, reset, clk,
>> etc. can be coordinated based on the GPU device's power state. It's
>> either that, or go the dwc3 route and have SoC glue platform drivers
>> that manage this stuff and create a child device to represent the hard
>> macro shipped by the vendor like Synopsys/Imagination. Doing the parent
>> device design isn't as flexible as PM domains because you can only have
>> one parent device and the child device state can be ignored vs. many PM
>> domains attached in a graph to a device that are more directly
>> influenced by the device using runtime PM.
>>
>> Maybe you'll be heartened to know this problem isn't unique and has
>> existed for decades :) I don't know what state the graphics driver is in
>> but they'll likely be interested in solving this problem in a way that
>> doesn't "pollute" their driver with SoC specific details. It's all a
>> question of where you put the code. The reset framework wants to focus
>> on resets, the clk framework wants to focus on clks, and the graphics
>> driver wants to focus on graphics. BTW, we went through a similar
>> discussion with regulators and clks years ago and ended up handling that
>> with OPPs and power domains.
> 
> Right, power-domain providers are mostly implementing SoC specific code.
> 
> In some cases, power-domain providers also handle per device SoC
> specific constraints/sequences, which seems what you are discussing
> here. For that, genpd has a couple of callbacks that could be
> interesting to have a look at, such as:
> 
> genpd->attach|detach_dev() - for probe/remove
> genpd.dev_ops->start|stop() - for runtime/system PM
> 
> That said, maybe just using the regular genpd->power_on|off() callback
> is sufficient here, depending on how you decide to model things.


Thanks Stephen, Ulf !

So the way forward I see:

1) The reset driver can be merged as-is, if Philipp is fine with this
code [2].
2) I will cook up the update to the thead power-domain driver which will
handle reset and clock management.
3) I think it would be best to convince the drm/imagination maintainers to
make the clock management in their consumer driver optional. This way if
there is a SoC specific sequence the clocks/resets will be managed from
generic PM driver which is SoC specific. Will talk to them.
4) Will remove the reset management from this series, and re-send.

[2] - https://lore.kernel.org/all/4205b786-fb65-468c-a3d8-bce807dd829a@samsung.com/
> 
>>
>> I believe a PM domain is the right place for this kind of stuff, and I
>> actually presented on this topic at OSSEU[1], but I don't maintain that
>> code. Ulf does.
>>
>> [1] https://osseu2024.sched.com/event/1ej38/the-case-for-an-soc-power-management-driver-stephen-boyd-google

Thanks ! Watched the presentation, very interesting. Hopefully I'll be
able to attend in person in Amsterdam this year if you're presenting :-)

> 
> Kind regards
> Uffe
> 

