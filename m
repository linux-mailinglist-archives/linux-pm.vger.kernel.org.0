Return-Path: <linux-pm+bounces-20779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50819A18769
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 22:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E993A7E09
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE91F8676;
	Tue, 21 Jan 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVW5j8cl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35E1F78F4
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495732; cv=none; b=U4Pnn4QEpU1gXeSpbnyUz69AhCZiabjqA72GjsW/0gfZuIMpSLgDuT7vhCcPCi5q+p9LWXbaWaSz9eYuxdEQa+WYxABdqNYYH/G2QZQZmfMl99FfK9/3ZvsBzmH6Ph+RNF6bn4C8ydXVk4PUSLJTjcP/M+Iid11E7DKzCjPs4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495732; c=relaxed/simple;
	bh=YWOdttEA5qz5XH0YwTEokio91vUDAn70CAlbxe6lwK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XwNHlJjjA5Gz6d6/b75sKwhVHq1qdJ1ByN5QPDpggfMZudQoFpplvkVp/RvNPm5yaHWNbCSumtTiyYvOn3x1QDhOzDfqG0DdJj5s5JHTAu+w6SEP65/Dq+WrupEsZ9A/ffpcBNUePx8WPaiI4FE/wnBdBZC3wlWP1wboIq8BKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kVW5j8cl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250121214208euoutp012a4fe8ea0c2f660ae1fe7bf1a746afcf~c0yjXznt92094620946euoutp01C
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 21:42:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250121214208euoutp012a4fe8ea0c2f660ae1fe7bf1a746afcf~c0yjXznt92094620946euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737495728;
	bh=zATnD0mujL6nA2E2a4u8aZajmJ1QlSjvbOm3YCS/4Ck=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kVW5j8clyZ+t62FUacK0oggBZlhgFC+QfpMXt9whAZw6iQn2Zxzkd6LzWj+61X4Rm
	 QjxgRkWWwKtTZ4bIs+MmuAxZnPgs74bidHeobn/nwrXP6BoVf8/mJKKK2usfFKZ+jU
	 N024RZsUGbU5J9dcNVrp7KwgQ7Al5lF/LYVVRLfY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250121214208eucas1p2a013ad3c50e099f3ad84f1beb88c42ce~c0yi1MSNQ2251922519eucas1p2X;
	Tue, 21 Jan 2025 21:42:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.B3.20409.FA410976; Tue, 21
	Jan 2025 21:42:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250121214207eucas1p12d3b4c29e18fdd3e9e8cbf18c183ecb4~c0yibpzb21525115251eucas1p1r;
	Tue, 21 Jan 2025 21:42:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250121214207eusmtrp1d2b399de460986cb68440e6f471796ac~c0yiaqqlr1779817798eusmtrp1d;
	Tue, 21 Jan 2025 21:42:07 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-e5-679014af8597
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.28.19920.FA410976; Tue, 21
	Jan 2025 21:42:07 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121214206eusmtip1902af554a3615632b87fedbe46fe7a5b~c0yhFZf2E0473304733eusmtip10;
	Tue, 21 Jan 2025 21:42:06 +0000 (GMT)
Message-ID: <ce69a49d-6221-458d-b0e5-0f3507f1aeac@samsung.com>
Date: Tue, 21 Jan 2025 22:42:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 05/18] pmdomain: thead: Add power-domain driver for
 TH1520
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250121-mature-marigold-ammonite-b379d2@krzk-bin>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BUdRTH53f37r2XrZXLyuM3lDJD6GwPQbCGn63D4APmpjbJWGH9Iwvc
	li1es+uSFpOWyAAtiQaEN1aQYYBWV97bQtA2gCykgCwKRvLIMFgeEizUgIixe6n473O+55zf
	Od8zP0og+YnwppSJJ1hVojzelxDhxvalnh2V7jmKnQ8fINQxUIKh+sccia41d2OoqK1biIat
	dRi6szhLoOsPb5NoovlzHPVX6Eh0tr2SQDZumEA9PVUkmtMOC1FfYyGB7NltABntaQQytA2R
	6MpcPY5KTY0ApWeWCVHvz2FoaLgDR7Y+rQClc67oaZOJRKv91Tj69pGZRHXTF4TIYohEaeZc
	PHQrM3vvHMlM22w405qxQDLNfxXjTAM3RDLahluAqdFnEsz9/iaCudwZwYx8acGY2tLTTJqh
	HWPOP9nJzP54l2C+qtMDxnp2gDwieV+0J5aNV6awqoCQKFHcyNIiSC70PrlimSfPgCmPLOBC
	QfpVqC0eFGQBESWhKwAcG50HfLAA4PLlX4V8YAcwPf33tYBytnToUh3dErocwKqVz3ieATCn
	INDBYjoEFuufYg7G6W0wr9ZE8rob7Lw0hjvYg/aBI4MFTn0zHQG7Oked7E6/CAee/O2cK6Cb
	hDA/t0roSAhoLzg4VuR8lKCD4Gh5kVN3oUNhQ8HUeo0P/H6m0GkH0r0iePXSHwLe5wHITV9b
	581w0lJH8vw8vPm1Fuc5CY7Wz6/XpMIGrWWdZfB+9zLhMC9Y266yMYCX98LWSZ2Av8kmeG/G
	jV9hE7xo/GZdFsOMdAlfvR3mabP/G9pdYcRygC+34SrcBpPcBjPc/3OLAa4HXqxGnaBg1UGJ
	7Mf+anmCWpOo8I9JSqgBa5/85qplwQTKJ+f8WwBGgRYAKYGvu9jjT61CIo6Vn/qEVSUdV2ni
	WXULeI7Cfb3EJeZzCgmtkJ9gP2LZZFb1bxajXLzPYNrYgJDXxmt2VNtLMP0b01+EHsy3Lh7t
	MATE7k2RLi9mLyy4Bu/2xF/RkP2l70oOH/iNisoP++6QaBzvG/ug1nw+h4i54Te1Jfy6Tjfp
	53N7zhS8dFL36S6vW9If9lHHwsdRTdDLx21Rwe133gtr00PPD61DWW7ioNzMSCpKekRGpDRt
	9e+SXeHyXDt/uVq7Ij1d/Wh/WJlV+ZZsKmLVoowtqN0Coidwo5mw79FtC85rbH/7hcB94Z7R
	K34lQz6aY7KA1IwHd73GmLntR5OtryufNUSW7eruvXEhzkX4OMZ6MHrCvL+3p3V3uEbcIw2T
	dfVX9D3zTiGRir95Ko0aAKu+uDpOHviSQKWW/wMA5DAUUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0ybZRTG8/a7QiT7KCDvCIJ0I6DJCi0U3hKGeGH5lugii2SJxsCX7aNs
	AsW2LGxO3QabwCqC7sIqFGToDIhoYaVF2GLLuExdHczWLQILMGLXdeUymEMY0qKR/355cp7z
	nHNyaEw4QoTR+ws1vKqQyxeR/vhPTwZGt7UHVyviF+oj0KCjSYAu/a2j0De91wWooe86gcaG
	OwXo5oKHRN/e/ZVCf/Yew5H963oKlfa3k8ipGyORzfYdhWa1YwQa6a4j0fzHfQAZ58tI1NY3
	SqEvZi/hqNnUDdDJiq8IdONaBhodG8SRc0SLoZO6TWi1x0ShJ/bvcfT5gysU6rxfQ6CBtj2o
	7MppPD2C9fx+gmLvO504ay1/SLG9i404a9aNUqzW/DNgDS0VJPuHvYdk9UOZ7PipAQHb0fwh
	W9bWL2A/WYlnPZd/I9mqzhbADpc6qNeFb4pTVcpiDf9snlKt2S56S4KkYokciaWJcrEkIfnt
	FKlMFJeWuo/P33+QV8Wl5Yjzxh8vgKK6sJLlgTnqKHCFVAKahkwiHKw/Ugn8aSHzJYDnjHN4
	JfBb08Oh/ZTzXw6Cy/ZK0stCxgWgdrLIywFMGmxsWRV4GWei4ZkOE7WuB8Kh81M+bwgTCcdv
	1/r0ICYT/jJ0x8fBzHPQsfKI8AZjTA8BrR3z5PoUqwBetph8aRgTCm9PNfgSSEYK71xsILzs
	x6RDc62L8G6AMTGwXS9cL4+EXe46rBoIdRvm0G3opPvfodvgaAR4Cwjmi9UFigK1RKzmCtTF
	hQrxXmWBAax9l7H/cYcJ6O/Nii1AQAMLgDQmCg4ImdEqhAH7uEOHeZUyW1Wcz6stQLZ2ixos
	LGSvcu09CzXZkqR4mSQxSR4vkycliEIDdozYcoWMgtPw7/B8Ea/6zyeg/cKOCswZycasaadk
	V5Cj1SJf3DW8aNuR+GpFbOC7ZnFz04XT54kYh/8kpbcJf5hq2mp2XEyfKdHfump1es5Gzhky
	olJfqrLKDMjxV/Sm8jhGXbO85WpWSmC0QkEwh5XW1iVzSnaMK/mjQ5GTCzfcsTnhjW7FSsKJ
	qjTVAZT5TOuj4/Stl4+V2rl+FEx7RJuz0g5O7JY+FTrUaTAyEdQ95GLe099kP5vcbOLCMSyq
	9f2JH3Nfmzrj3g6jPnh6SR7R7fZEi2f8yiaMe17IQNNLb+w8u3UuZyRW/mLXucGuLSl3W6av
	lR6RN+WWVx+Ye8CxrziLdtZumymh2/BPOWnm8YciXJ3HSZ7HVGruH6+XgHjmAwAA
X-CMS-MailID: 20250121214207eucas1p12d3b4c29e18fdd3e9e8cbf18c183ecb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0@eucas1p1.samsung.com>
	<20250120172111.3492708-6-m.wilczynski@samsung.com>
	<20250121-mature-marigold-ammonite-b379d2@krzk-bin>



On 1/21/25 11:02, Krzysztof Kozlowski wrote:
> On Mon, Jan 20, 2025 at 06:20:58PM +0100, Michal Wilczynski wrote:
>> The T-Head TH1520 SoC contains multiple power islands that can be
>> programmatically turned on and off using the AON (Always-On) protocol
>> and a hardware mailbox [1]. The relevant mailbox driver has already been
>> merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
>> Introduce support for T-head TH1520 Mailbox driver");
>>
>> This commit introduces a power-domain driver for the TH1520 SoC, which
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://protect2.fireeye.com/v1/url?k=2123f702-40a8e22d-21227c4d-74fe485cbfe7-afb876722bdc8fc5&q=1&e=e5dabc89-5f0c-4819-9008-76faafc3c1bc&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17.1%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L95
> 
>> is using AON firmware protocol to communicate with E902 core through the
>> hardware mailbox. This way it can send power on/off commands to the E902
>> core.
> 
> ...
> 
>> diff --git a/drivers/pmdomain/thead/Makefile b/drivers/pmdomain/thead/Makefile
>> new file mode 100644
>> index 000000000000..adfdf5479c68
>> --- /dev/null
>> +++ b/drivers/pmdomain/thead/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_TH1520_PM_DOMAINS)		+= th1520-pm-domains.o
>> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
>> new file mode 100644
>> index 000000000000..d913ad40fb76
>> --- /dev/null
>> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
>> @@ -0,0 +1,174 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2021 Alibaba Group Holding Limited.
>> + * Copyright (c) 2024 Samsung Electronics Co., Ltd.
>> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
>> + */
>> +
>> +#include <linux/firmware/thead/thead,th1520-aon.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +
>> +#include <dt-bindings/firmware/thead,th1520-aon.h>
> 
> So here it is used... I don't understand why power domain is under
> firmware. Please move it to proper directory and name the file exactly
> the same as bindings doc which this belongs to.

The power-domain driver has no bindings doc. It's a child driver of the AON
node.

> 
> 
>> +
>> +struct th1520_power_domain {
>> +	struct th1520_aon_chan *aon_chan;
>> +	struct generic_pm_domain genpd;
>> +	u32 rsrc;
>> +};
>> +
>> +struct th1520_power_info {
>> +	const char *name;
>> +	u32 rsrc;
>> +};
>> +
>> +static const struct th1520_power_info th1520_pd_ranges[] = {
>> +	{ "vdec", TH1520_AON_VDEC_PD },
> 
> Why TH1520_AON_XXX aren't the indices?

These power-domain constants are defined by the AON firmware protocol,
which dictates the exact IDs (e.g., 1 for NPU). They are not just array
indices; we must use these specific values to communicate with the
firmware correctly. Using array indices starting with 1 would be
unusual.

> 
>> +	{ "npu", TH1520_AON_NPU_PD },
>> +	{ "venc", TH1520_AON_VENC_PD },
>> +	{ "gpu", TH1520_AON_GPU_PD },
>> +	{ "dsp0", TH1520_AON_DSP0_PD },
>> +	{ "dsp1", TH1520_AON_DSP1_PD }
>> +};
> 
> Best regards,
> Krzysztof
> 
> 

