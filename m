Return-Path: <linux-pm+bounces-24895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2484A7E7C5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7461887288
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31892153C2;
	Mon,  7 Apr 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o5AwoJjX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA17214A9D
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045339; cv=none; b=AOHNkze97R5AivM6NMcehPdLdZuAakPguDRDA7OfKoORQN0eQ3rpyXj3ZWa5t+h8dC6EToCFnTXoP5ZIU5gRVrzfZv/8sT/otyEk2hAxpfrRFbTqeMLlTUaVCS9JYlcsJV3w2dd9Sc5O31VOZzkzvUrOhFJvnkj/wemq61/nW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045339; c=relaxed/simple;
	bh=0fUXWdghi2FdJM6PqtP2POa7NlwIAfQy6MMj8TF8lnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=TIcDpQYdbKjnswII1akMif8FXzznlgff9XL1imnXCiIwFtwQ/Husrn9sZlADpFvDVRKWvvK2ubZSyEsvCVd/3yenwZGnzLTwRMr2TknryFuM43MYMPWDs3KdJ1uOEEunamviW/M3Dv+xG9fIYH5Gn6nt3sCdxnTPvV7/1fVrjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o5AwoJjX; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250407170215euoutp021f00601a1291f629a102ac05c241e60a~0F-4By_bW1435014350euoutp02s
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 17:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250407170215euoutp021f00601a1291f629a102ac05c241e60a~0F-4By_bW1435014350euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744045335;
	bh=Wx7W+DQtE3tBl3vxbMnxTddlv8f0yFYC1U6aTzeVb6w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o5AwoJjX8UBD89ax7lPNB+gyHAnvT4Lv+tpHAYW4dL8EJrF/oXt+eOcBQeGwkj1iP
	 94G6YffcHkQq9PHODzDIfLcgep5Bbi34LNS8TCP6EUJDZuJVOp9h55Iqiec41Z1w33
	 Ip6tWd76uwtAg5Weg81ks9GbHbNZbR48YQWU2Vxk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250407170214eucas1p257e74f7d0eef7096e193c741bba73ab6~0F-3crtq62761927619eucas1p2h;
	Mon,  7 Apr 2025 17:02:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.79.20409.61504F76; Mon,  7
	Apr 2025 18:02:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250407170214eucas1p1008eb61b6523c8f9575d32155a2e1371~0F-287LCs0399003990eucas1p1Z;
	Mon,  7 Apr 2025 17:02:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250407170214eusmtrp23ed491866bee2d9060576f6f951b1beb~0F-26asqW1189311893eusmtrp2K;
	Mon,  7 Apr 2025 17:02:14 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-03-67f40516c392
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.12.19920.61504F76; Mon,  7
	Apr 2025 18:02:14 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250407170213eusmtip26a0f938d563a45d6a42ceae192de0b22~0F-17f7hk2342923429eusmtip2f;
	Mon,  7 Apr 2025 17:02:13 +0000 (GMT)
Message-ID: <21983f8d-681d-4fed-ae44-42eee44c7f14@samsung.com>
Date: Mon, 7 Apr 2025 19:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with
 CLKGEN reset support
From: Michal Wilczynski <m.wilczynski@samsung.com>
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
In-Reply-To: <ef17e5d1-b364-41e1-ab8b-86140cbe69b2@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZduzneV0x1i/pBnsua1g8u/OV1WLr71ns
	Fmv2nmOymH/kHKvFvUtbmCxe7G1ksWg+tp7N4uWse2wWH3vusVpc3jWHzeJz7xFGi22fW9gs
	1h65y25x8ZSrxd17J1gsXl7uYbZom8Vv8X/PDnaLf9c2slgcXxtu0bJ/CouDqMf7G63sHm9e
	vmTxONzxhd3j3olprB6bVnWyedy5tofNY/OSeo+WtceYPPr/Gni833eVzaNvyypGj0vN19k9
	Pm+SC+CN4rJJSc3JLEst0rdL4Mp4ueQ2a0FnQMXXzrQGxu8OXYycHBICJhLn+t8zg9hCAisY
	JbpPm0LYXxglGqYHdzFyAdmfGSX+f57IAtNwfv9JJojEckaJnw93skM4bxkl2vfPBRvFK2An
	sfPXAzCbRUBF4tikyUwQcUGJkzOfgE0SFZCXuH9rBjuILSwQJ3Fj20mwGjYBI4kHy+ezgtgi
	Ap4SM643MoLYzAIXmCVOXzeAsMUlbj2ZD1bPKWAvsfv4LBaIuLxE89bZzCAHSQj84pQ4dWsD
	K8TZLhLL575ih7CFJV4d3wJly0j83wkxSEIgX+LB1k/MEHaNxM6e41C2tcSdc7/Yuhg5gBZo
	SqzfpQ8RdpR4/Ho/I0hYQoBP4sZbQYgT+CQmbZvODBHmlehoE4KoVpOY2tMLt/Tcim1MExiV
	ZiEFyiwkj81C8swshL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKbT0/+Of9nB
	uPzVR71DjEwcjIcYJTiYlUR4LU99ShfiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2h/a7qQQHpi
	SWp2ampBahFMlomDU6qBSUHpG0va5RwzH4ddX7ae09FOND39hOVBTInJ7ud3dBML/T7t36u2
	L/Eb91St/1zvuyK+XJMt2eT2dY/x2xzVjUsOvGqa5GvjModd7Mtbjfev5ibnBZ5J2Bb0p/yu
	6PZcXaVW38ef2tewfzU4bxMUfV+F9w1bf/shlhL3S++39TZt+us+416Te1B7qbXJjB3e742z
	/y87+DPbIUNzuWasg+Uk62LVcz/6GjOPv3H/djIgceWSm8IbjBy2STyX9Ky8p8b2/Rtb8rkL
	MVWVs9dNX6Dlu8iwZZFhhV6pu0tb9Qudk98sGLtvuWaciymcz+Y9I6/kTJGs/OsjU2Zdn13C
	lRYQUJL61floWXt0rbqfEktxRqKhFnNRcSIAWGM1cRYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7pirF/SDSY/YbF4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsPvbcY7W4vGsOm8Xn3iOMFts+t7BZ
	rD1yl93i4ilXi7v3TrBYvLzcw2zRNovf4v+eHewW/65tZLE4vjbcomX/FBYHUY/3N1rZPd68
	fMnicbjjC7vHvRPTWD02repk87hzbQ+bx+Yl9R4ta48xefT/NfB4v+8qm0ffllWMHpear7N7
	fN4kF8AbpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
	oJfxcslt1oLOgIqvnWkNjN8duhg5OSQETCTO7z/J1MXIxSEksJRRYsrzT8wQCRmJa90vWSBs
	YYk/17rYIIpeM0rcn34CrIhXwE5i568HYDaLgIrEsUmTmSDighInZz4BaxYVkJe4f2sGO4gt
	LBAncX7XKlYQm03ASOLB8vlgtoiAp8SM642MIAuYBS4wS/T/PsgOse0qi8Sl1jeMIFXMAuIS
	t57MB9vAKWAvsfv4LKANHEBxdYn184QgSuQlmrfOZp7AKDQLyR2zkHTPQuiYhaRjASPLKkaR
	1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAksu3Yz807GOe9+qh3iJGJg/EQowQHs5IIr+WpT+lC
	vCmJlVWpRfnxRaU5qcWHGE2BYTGRWUo0OR+YxvJK4g3NDEwNTcwsDUwtzYyVxHndLp9PExJI
	TyxJzU5NLUgtgulj4uCUamDyqYswfmfZd7vms7rdpm2Jr3mZYm5WTbxpfd3K111+q3VgsV91
	0rV7my7ttW37kVOqmpHYvP1Pc4mLrO/bXVd9PhVOyzrLo7Zvi0jYufdCsicE95yx3Pyy+vNS
	7fadBk+LrJmm7lnZlxa7deKshPxt61NOykxM+HydL/Zlu5HPa8vei9d439WcvjXR/kSvRjbT
	zxkW89gXPo9hVdv2K4j993LjfefbZc9aCdwu4RXpu6VxxsN933OHbf0yT/ZOP5zzPEJeeGKC
	8va8Z25TfQRE9C5tOnVXOFRd9PEx3zeyKSGcy43Xrtx1RevnzLlPdj1+pn5AXkN13au2Aj++
	wxYHJr3aPSksd4Zr+8YEGRMxJZbijERDLeai4kQABp/puqsDAAA=
X-CMS-MailID: 20250407170214eucas1p1008eb61b6523c8f9575d32155a2e1371
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
	<ef17e5d1-b364-41e1-ab8b-86140cbe69b2@samsung.com>



On 4/1/25 16:38, Michal Wilczynski wrote:
> 
> 
> On 3/26/25 12:24, Ulf Hansson wrote:
>> On Tue, 25 Mar 2025 at 23:40, Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> Quoting Michal Wilczynski (2025-03-19 02:22:11)
>>>>
>>>>
>>>> On 3/13/25 10:25, Philipp Zabel wrote:
>>>>> On Do, 2025-03-06 at 17:43 +0100, Michal Wilczynski wrote:
>>>>>>
>>>>>> On 3/6/25 00:47, Stephen Boyd wrote:
>>>>>>> Quoting Michal Wilczynski (2025-03-03 06:36:29)
>>>>>>>> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
>>>>>>>> clock gate is marked as "Reserved" in hardware, while core and cfg are
>>>>>>>> configurable. In order for these clock gates to work properly, the
>>>>>>>> CLKGEN reset must be managed in a specific sequence.
>>>>>>>>
>>>>>>>> Move the CLKGEN reset handling to the clock driver since it's
>>>>>>>> fundamentally a clock-related workaround [1]. This ensures that clk_enabled
>>>>>>>> GPU clocks stay physically enabled without external interference from
>>>>>>>> the reset driver.  The reset is now deasserted only when both core and
>>>>>>>> cfg clocks are enabled, and asserted when either of them is disabled.
>>>>>>>>
>>>>>>>> The mem clock is configured to use nop operations since it cannot be
>>>>>>>> controlled.
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>>>>> [...]
>>>>>>>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
>>>>>>>> index ea96d007aecd..1dfcde867233 100644
>>>>>>>> --- a/drivers/clk/thead/clk-th1520-ap.c
>>>>>>>> +++ b/drivers/clk/thead/clk-th1520-ap.c
>>>>>>>> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
>>>>>>> [...]
>>>>>>>>
>>>>>>>>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
>>>>>>>>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
>>>>>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
>>>>>>>> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
>>>>>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
>>>>>>>> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
>>>>>>>> +
>>>>>>>> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
>>>>>>>> +{
>>>>>>>> +       struct ccu_gate *cg = hw_to_ccu_gate(hw);
>>>>>>>> +       unsigned long flags;
>>>>>>>> +
>>>>>>>> +       spin_lock_irqsave(&gpu_reset_lock, flags);
>>>>>>>> +
>>>>>>>> +       ccu_disable_helper(&cg->common, cg->enable);
>>>>>>>> +
>>>>>>>> +       if ((cg == &gpu_core_clk &&
>>>>>>>> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
>>>>>>>> +           (cg == &gpu_cfg_aclk &&
>>>>>>>> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
>>>>>>>> +               reset_control_assert(gpu_reset);
>>>>>>>
>>>>>>> Why can't the clk consumer control the reset itself? Doing this here is
>>>>>>> not ideal because we hold the clk lock when we try to grab the reset
>>>>>>> lock. These are all spinlocks that should be small in lines of code
>>>>>>> where the lock is held, but we're calling into an entire other framework
>>>>>>> under a spinlock. If an (unrelated) reset driver tries to grab the clk
>>>>>>> lock it will deadlock.
>>>>>>
>>>>>> So in our case the clk consumer is the drm/imagination driver. Here is
>>>>>> the comment from the maintainer for my previous attempt to use a reset
>>>>>> driver to abstract the GPU init sequence [1]:
>>>>>>
>>>>>> "Do you know what this resets? From our side, the GPU only has a single
>>>>>> reset line (which I assume to be GPU_RESET)."
>>>>>>
>>>>>> "I don't love that this procedure appears in the platform reset driver.
>>>>>> I appreciate it may not be clear from the SoC TRM, but this is the
>>>>>> standard reset procedure for all IMG Rogue GPUs. The currently
>>>>>> supported TI SoC handles this in silicon, when power up/down requests
>>>>>> are sent so we never needed to encode it in the driver before.
>>>>>>
>>>>>> Strictly speaking, the 32 cycle delay is required between power and
>>>>>> clocks being enabled and the reset line being deasserted. If nothing
>>>>>> here touches power or clocks (which I don't think it should), the delay
>>>>>> could potentially be lifted to the GPU driver."
>>>>>>
>>>>>> From the drm/imagination maintainers point of view their hardware has
>>>>>> only one reset, the extra CLKGEN reset is SoC specific.
>>>>>
>>>>> If I am understanding correctly, the CLKGEN reset doesn't reset
>>>>> anything in the GPU itself, but holds the GPU clock generator block in
>>>>> reset, effectively disabling the three GPU clocks as a workaround for
>>>>> the always-ungated GPU_MEM clock.
>>>>>
>>>>>> Also the reset driver maintainer didn't like my way of abstracting two
>>>>>> resets ("GPU" and and SoC specific"CLKGEN") into one reset
>>>>>
>>>>> That is one part of it. The other is that (according to my
>>>>> understanding as laid out above), the combined GPU+CLKGEN reset would
>>>>> effectively disable all three GPU clocks for a while, after the GPU
>>>>> driver has already requested them to be enabled.
>>>>
>>>> Thank you for your comments Philipp, it seems like we're on the same
>>>> page here. I was wondering whether there is anything I can do to move the
>>>> patches forward.
>>>>
>>>> Stephen, if the current patch is a no go from your perspective could you
>>>> please advise whether there is a way to solve this in a clock that would
>>>> be acceptable to you.
>>>
>>> It looks like the SoC glue makes the interactions between the clk and
>>> reset frameworks complicated because GPU clks don't work if a reset is
>>> asserted. You're trying to find a place to coordinate the clk and reset.
>>> Am I right?
>>>
>>> I'd advise managing the clks and resets in a generic power domain that
>>> is attached to the GPU device. In that power domain, coordinate the clk
>>> and reset sequencing so that the reset is deasserted before the clks are
>>> enabled (or whatever the actual requirement is). If the GPU driver
>>> _must_ have a clk and reset pointer to use, implement one that either
>>> does nothing or flag to the GPU driver that the power domain is managing
>>> all this for it so it should just use runtime PM and system PM hooks to
>>> turn on the clks and take the GPU out of reset.
>>>
>>> From what I can tell, the GPU driver maintainer doesn't want to think
>>> about the wrapper that likely got placed around the hardware block
>>> shipped by IMG. This wrapper is the SoC glue that needs to go into a
>>> generic power domain so that the different PM resources, reset, clk,
>>> etc. can be coordinated based on the GPU device's power state. It's
>>> either that, or go the dwc3 route and have SoC glue platform drivers
>>> that manage this stuff and create a child device to represent the hard
>>> macro shipped by the vendor like Synopsys/Imagination. Doing the parent
>>> device design isn't as flexible as PM domains because you can only have
>>> one parent device and the child device state can be ignored vs. many PM
>>> domains attached in a graph to a device that are more directly
>>> influenced by the device using runtime PM.
>>>
>>> Maybe you'll be heartened to know this problem isn't unique and has
>>> existed for decades :) I don't know what state the graphics driver is in
>>> but they'll likely be interested in solving this problem in a way that
>>> doesn't "pollute" their driver with SoC specific details. It's all a
>>> question of where you put the code. The reset framework wants to focus
>>> on resets, the clk framework wants to focus on clks, and the graphics
>>> driver wants to focus on graphics. BTW, we went through a similar
>>> discussion with regulators and clks years ago and ended up handling that
>>> with OPPs and power domains.
>>
>> Right, power-domain providers are mostly implementing SoC specific code.
>>
>> In some cases, power-domain providers also handle per device SoC
>> specific constraints/sequences, which seems what you are discussing
>> here. For that, genpd has a couple of callbacks that could be
>> interesting to have a look at, such as:
>>
>> genpd->attach|detach_dev() - for probe/remove
>> genpd.dev_ops->start|stop() - for runtime/system PM
>>
>> That said, maybe just using the regular genpd->power_on|off() callback
>> is sufficient here, depending on how you decide to model things.
> 
> 
> Thanks Stephen, Ulf !
> 
> So the way forward I see:
> 
> 1) The reset driver can be merged as-is, if Philipp is fine with this
> code [2].
> 2) I will cook up the update to the thead power-domain driver which will
> handle reset and clock management.

Hi Ulf,
I'm working on the series right now and I wanted to ask you how you
prefer versioning to be handled. Would you like me to send a series as a
v1, or treat is as a continuation of this series [1] and send as a v9.
Would like to avoid any confusion. 

Thanks,
Michał

[1] - https://lore.kernel.org/all/20250311171900.1549916-1-m.wilczynski@samsung.com/

> 3) I think it would be best to convince the drm/imagination maintainers to
> make the clock management in their consumer driver optional. This way if
> there is a SoC specific sequence the clocks/resets will be managed from
> generic PM driver which is SoC specific. Will talk to them.
> 4) Will remove the reset management from this series, and re-send.
> 
> [2] - https://lore.kernel.org/all/4205b786-fb65-468c-a3d8-bce807dd829a@samsung.com/
>>
>>>
>>> I believe a PM domain is the right place for this kind of stuff, and I
>>> actually presented on this topic at OSSEU[1], but I don't maintain that
>>> code. Ulf does.
>>>
>>> [1] https://osseu2024.sched.com/event/1ej38/the-case-for-an-soc-power-management-driver-stephen-boyd-google
> 
> Thanks ! Watched the presentation, very interesting. Hopefully I'll be
> able to attend in person in Amsterdam this year if you're presenting :-)
> 
>>
>> Kind regards
>> Uffe
>>

