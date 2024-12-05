Return-Path: <linux-pm+bounces-18600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EE9E4E64
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E178F16167F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271A1B0F37;
	Thu,  5 Dec 2024 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4S6usSu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0701AB517;
	Thu,  5 Dec 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383889; cv=none; b=kwkh59D3pFWQwGAR61cAjy2P1W8BaSd4o8i/WHLqYlmwrj4mvVS/vPuw/gE+0kYeHuwm449U/v1xbX5tDcg8cN/wuEXVOV73q4lqr2VmJVPjmC/nW2rbnUejHA1Ye0Sdwq19Mh8TU1X9YMMLuIbsMTLbLvPzFhMfV/RSeqnvBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383889; c=relaxed/simple;
	bh=tl7z5khqHwgfmMC1yiN0DCsWW590Zda7OF1raNXX9wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gB18VIcCndzTzi/cOFwZGGdC92MN248Q2yRf1hm6zE9VjOJ6dwZwX4HVK4rLFZ4ypFVv2fgCjwpmFFVmK576bdu+UrYgLoh3tiEldBi7ZhUYAWLZ/YgIaF2ifigUykOyCcpV4tQv4EnsjnTepbZ/6NED4I+LEcU+vQNCyYmpuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4S6usSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC662C4CED1;
	Thu,  5 Dec 2024 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383888;
	bh=tl7z5khqHwgfmMC1yiN0DCsWW590Zda7OF1raNXX9wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4S6usSuH5khmzNH0uwBG77QC78odPh/2kq0qMDeGd/ANo+7o2nuziV3Jq2mSUKpf
	 dYh0PvwQehqhnJyfTH3JzGBmNODJ3u2eAe148ta1ZpfjuBKmVMLPV4NocVHUKWoVjq
	 47LRw2chq/03glgPtpgZXYl56+3EnT6q6xyJn9sTqzfZ48rgWzZmnLyyw4+uiPb8Z3
	 8bee0JOBwaP+qne5ecQ3OM4X//OzcNyaQoh8nCp1Qan5gXLNjtt4b1rpc52tBzQ9OD
	 5o1V2PKEQhmjkiZvIZH3ExgEzAXYvfmGOHDhvJiqDnUjXCX2xfcJdJyJ+DQQSyx7c2
	 QzyjbZrPQP62g==
Message-ID: <5206c6a1-0473-40c2-b651-5dbca1204729@kernel.org>
Date: Thu, 5 Dec 2024 08:31:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/14] clk: thead: Refactor TH1520 clock driver to
 share common code
To: Michal Wilczynski <m.wilczynski@samsung.com>,
 Stephen Boyd <sboyd@kernel.org>, airlied@gmail.com, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, drew@pdp7.com, frank.binns@imgtec.com,
 guoren@kernel.org, jassisinghbrar@gmail.com, jszhang@kernel.org,
 krzk+dt@kernel.org, m.szyprowski@samsung.com,
 maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com,
 mripard@kernel.org, mturquette@baylibre.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, ulf.hansson@linaro.org, wefu@redhat.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
 <CGME20241203134150eucas1p24ba8d2fbf2af5b8f9abe503b4334127d@eucas1p2.samsung.com>
 <20241203134137.2114847-2-m.wilczynski@samsung.com>
 <94a57c718a09a20d148101884bf2e5f2.sboyd@kernel.org>
 <94356242-7c94-4da5-a9ad-684d03ddedd6@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <94356242-7c94-4da5-a9ad-684d03ddedd6@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2024 14:54, Michal Wilczynski wrote:
> 
> 
> On 12/3/24 20:56, Stephen Boyd wrote:
>> Quoting Michal Wilczynski (2024-12-03 05:41:24)
>>> diff --git a/drivers/clk/thead/Makefile b/drivers/clk/thead/Makefile
>>> index 7ee0bec1f251..d7cf88390b69 100644
>>> --- a/drivers/clk/thead/Makefile
>>> +++ b/drivers/clk/thead/Makefile
>>> @@ -1,2 +1,2 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>> -obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520-ap.o
>>> +obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520.o clk-th1520-ap.o
>>
>> Can the -ap driver be extended instead? Or are the clks in a different
>> IO region?
> 
> The Video Output (VO) clocks reside in a different address space as
> defined in the T-HEAD manual 4.4.1 [1]. Therefore, creating a separate
> driver made sense to maintain clarity and adhere to the existing

There is no such rule, no convention even. But there is a rule and
convention of re-using drivers.

> convention of having one driver per subsystem, similar to the

You have here two drivers per subsystem, so even if there was such a
rule, you just broke it.

> AP-specific driver.
> 
> [1] - https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
>>
>>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
>>> index 17e32ae08720..a6015805b859 100644
>>> --- a/drivers/clk/thead/clk-th1520-ap.c
>>> +++ b/drivers/clk/thead/clk-th1520-ap.c
>>> @@ -5,297 +5,9 @@
>>>   *  Authors: Yangtao Li <frank.li@vivo.com>
>>>   */
>>>  
>>> -#include <dt-bindings/clock/thead,th1520-clk-ap.h>
>>
>> Presumably this should stay here.
>>
>>> -#include <linux/bitfield.h>
>>> -#include <linux/clk-provider.h>
>>> -#include <linux/device.h>
>>> -#include <linux/module.h>
>>> -#include <linux/platform_device.h>
>>> -#include <linux/regmap.h>
>>

...

>>> +static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
>>> +{
>>> +       return container_of(hw, struct ccu_common, hw);
>>> +}
>>> +
>>> +static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
>>> +{
>>> +       struct ccu_common *common = hw_to_ccu_common(hw);
>>> +
>>> +       return container_of(common, struct ccu_mux, common);
>>> +}
>>> +
>>> +static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
>>> +{
>>> +       struct ccu_common *common = hw_to_ccu_common(hw);
>>> +
>>> +       return container_of(common, struct ccu_pll, common);
>>> +}
>>> +
>>> +static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
>>> +{
>>> +       struct ccu_common *common = hw_to_ccu_common(hw);
>>> +
>>> +       return container_of(common, struct ccu_div, common);
>>> +}
>>> +
>>> +static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
>>> +{
>>> +       struct ccu_common *common = hw_to_ccu_common(hw);
>>> +
>>> +       return container_of(common, struct ccu_gate, common);
>>> +}
>>> +
>>> +extern const struct clk_ops ccu_div_ops;
>>> +extern const struct clk_ops clk_pll_ops;
>>> +extern const struct regmap_config th1520_clk_regmap_config;
>>
>> Why is the regmap config exported?
> 
> The regmap_config is exported to allow reuse across multiple drivers.
> Initially, I passed the clock VOSYS address space using the reg property
> and created the regmap from it, enabling other drivers to utilize the
> same configuration. Later, I switched to a regmap-based syscon approach
> but haven’t moved the regmap_config back to the AP driver.


It anyway in your original code cannot be exported. If you want to use
syscon, then use syscon, not exporting regmaps manually.




Best regards,
Krzysztof

