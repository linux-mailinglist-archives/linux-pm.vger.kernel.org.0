Return-Path: <linux-pm+bounces-25307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C903BA86BAC
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C821019E75B0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB69198851;
	Sat, 12 Apr 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tgp4H2sx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B251AAC9
	for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744444427; cv=none; b=SNpfPsFQiMdr3iPlX+1nvaIAzfEb9B86MET+kKJVxGUoaEL460HGJ5e7XWien2wGJbIMxkMZKR881XaEorcpq2tc0jIp0KuYf3fOlQ7fox7g+ONhDIO/3PoIoB3X99PBTamzBufFzbLGLShpmmUyUyq/l8GMvLClbPQF/9g3Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744444427; c=relaxed/simple;
	bh=GF7XQVEB7cf6bypb3+gbvXgsQgS1Zkp8WWsh1el6/s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Et5U1QTj3lm1J9ZtdDNWnY3SYtX6moUJYOQSHVDdsHUoeM2xZcZ1ZJORvaljLS5bLXm1n+qH36z1Sy0Va99yU5ojrf6xDYuTz3IblBkacAEVJr/lTkkxNRIL7TNqok/Dz9VyXJk8J6ocg0ICH6cirgWOoqtwGARNpyFNtAKZ0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tgp4H2sx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250412075337euoutp0129a3cb801b4c8d4af24c16a538d8f071~1gvSFJPRT2933029330euoutp01T
	for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 07:53:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250412075337euoutp0129a3cb801b4c8d4af24c16a538d8f071~1gvSFJPRT2933029330euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744444417;
	bh=+okiKaF78vSwt93i+78N55NQHBooGPmUv1vJFeh9orA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tgp4H2sxXDDUxQ6DmkoX6J2LO6IjBoq8RGmPF7ZkgH6p2mXiHS+mYOpmT/kxiGAyW
	 IaRjKGMFJCLoPOGuRN9Tv5u1EU9ECiHBi8Q3PtcaGezcAA+w/VJq5bNpi1kmGt1uFW
	 LmNZ5XDVHSUC8V76+v7o7qkK3xCqg/XVfADWGAbo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250412075336eucas1p2ecadca65aca0d64cefccf968235cbdf0~1gvRJqYoD2362323623eucas1p2X;
	Sat, 12 Apr 2025 07:53:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.02.20409.00C1AF76; Sat, 12
	Apr 2025 08:53:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250412075335eucas1p1182951499db6038021e78d9f4ecaac90~1gvQdG9NE3056730567eucas1p1o;
	Sat, 12 Apr 2025 07:53:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250412075335eusmtrp156928a9b250f82ecaa281ed6c0646229~1gvQcXEIB1456814568eusmtrp1C;
	Sat, 12 Apr 2025 07:53:35 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-87-67fa1c00d656
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.A2.19920.FFB1AF76; Sat, 12
	Apr 2025 08:53:35 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250412075334eusmtip1d40ddad77716aa880603d467db3a8ab2~1gvPtEH_X2732927329eusmtip1Y;
	Sat, 12 Apr 2025 07:53:34 +0000 (GMT)
Message-ID: <9bc1ebee-7a41-4465-8015-c156fb6b74cf@samsung.com>
Date: Sat, 12 Apr 2025 09:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: thead,th1520: Add clocks
 and resets
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFq=BF5f2i_Sr1cmVqtVAMgr=0FqsksL7RHZLKn++y0uwg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87oMMr/SDa5P4bdYs/cck8X8I+dY
	Le5d2sJk8WJvI4vFy1n32Cwu75rDZvG59wijxbbPLWwWa4/cZbe4e+8Ei8X/PTvYLf5d28hi
	cXxtuEXL/iksDnwem1Z1snncubaHzWPzknqPlrXHmDz6/xp4vN93lc2jb8sqRo/Pm+QCOKK4
	bFJSczLLUov07RK4Mh7+Vi14olXxf8lCtgbG+UpdjJwcEgImEp0H9zOC2EICKxgl3l5M72Lk
	ArK/MEqsm7qBFcL5zCjxa+FNNpiOLQtfMEMkljNKbN7zkAnCecsoceLIMXaQKl4BO4lnL/6C
	2SwCqhL3N2xigYgLSpyc+QTMFhWQl7h/awZYjbBAhMSOz5fAbBEBDYk9D8+zgtjMAg+YJJbO
	koewxSVuPZnPBGKzCRhJPFg+H6iGg4NTIFDi0cNYiBJ5ieats8GOkxBYzikxtbmBEeJqF4np
	5z8wQdjCEq+Ob2GHsGUkTk/uYYGw8yUebP3EDGHXSOzsOQ5lW0vcOfeLDWQXs4CmxPpd+hBh
	R4nO15vATpAQ4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKrVJKb29MItPbdiG9MERqVZSGEyC8mP
	s5A8Mwth7wJGllWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBqe30v+NfdjAuf/VR7xAj
	EwfjIUYJDmYlEV4Nxl/pQrwpiZVVqUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgt
	gskycXBKNTD1WQsrNK4pqp8W9s1+kfT3MAkLV2mewvDV6ksKr+sbbF5g8GVFF8vc84EOp58c
	8W5YNl+Qz2HznH7bz7uvxds52scre7kpXbiiMbtHQzGg70Gc5c15q55da8z34bCLjvvy8/TF
	xFV30xkK6nbM/sd16douRaeoR2v1ZqVIxfXYP1edNWOL3IkeVkW/T57zs8RPvlA5Lxl+49fp
	ABtFo1sM/1SO7Fqz+9QUvh/r2zM2Bbtq/0z3yf1svSvrttK5JfuOzDlv2iLfo/acKUbzbUT1
	XJ8Zr71X+3Ez7xM/oJ/yIfMM23T7SauEhLKyd3DrX974YD1T+kPvA47xkb4T8/0f1xpcXrz8
	ReOF/Jdz331SYinOSDTUYi4qTgQAJT5+Z9wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7r/pX+lG+zeJWexZu85Jov5R86x
	Wty7tIXJ4sXeRhaLl7PusVlc3jWHzeJz7xFGi22fW9gs1h65y25x994JFov/e3awW/y7tpHF
	4vjacIuW/VNYHPg8Nq3qZPO4c20Pm8fmJfUeLWuPMXn0/zXweL/vKptH35ZVjB6fN8kFcETp
	2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTz8rVrw
	RKvi/5KFbA2M85W6GDk5JARMJLYsfMHcxcjFISSwlFFiY8dkRoiEjMS17pcsELawxJ9rXWwQ
	Ra8ZJc63zmAGSfAK2Ek8e/GXHcRmEVCVuL9hEwtEXFDi5MwnYLaogLzE/VszwGqEBSIkdny+
	BGaLCGhI7Hl4nhVkKLPAAyaJr9/WQW3oYZY4fmENG0gVs4C4xK0n85lAbDYBI4kHy+cDdXBw
	cAoESjx6GAtiMguoS6yfJwRRLS/RvHU28wRGoVlIzpiFZNAshI5ZSDoWMLKsYhRJLS3OTc8t
	NtQrTswtLs1L10vOz93ECIznbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4NRh/pQvxpiRWVqUW
	5ccXleakFh9iNAUGxURmKdHkfGBCySuJNzQzMDU0MbM0MLU0M1YS53W7fD5NSCA9sSQ1OzW1
	ILUIpo+Jg1OqganZeNeeDWsOe3rWmCu/u2Uu5RNwl1cjN5A9xXZNAW/z04n1dgUiT1xfun8x
	TD1nki6R+e+EDIv5htXbEjUYFC23ieuX2R2ufCE5e/29JbEyPJy+P9WNhDmWfbOREfXj/Kn1
	5WnsnguPNj6oP8ZmsEzs6LzWjBPmPBnHzk+MVr02pU9+V5GrY+5vixur0j29bqrf7/76rfLd
	hvfS88SVpzw82WmaMT8le+f6/9M0gvVandkSvuq5365fNX3R1sdJohmvHt96vzvYdskHReWe
	udp8BvMnrvlXfHJD8qpchsUu9ilaF6Q3PXaMlMh/Ij1h3a/Njh+kRU4aXWx5G3zDsORf/59n
	Vvtvhihwffo/v1KJpTgj0VCLuag4EQDH0QWFcAMAAA==
X-CMS-MailID: 20250412075335eucas1p1182951499db6038021e78d9f4ecaac90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf
References: <CGME20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf@eucas1p2.samsung.com>
	<20250409093025.2917087-1-m.wilczynski@samsung.com>
	<20250409093025.2917087-2-m.wilczynski@samsung.com>
	<CAPDyKFpoSwKAmiWyvNt1fVyu6=NU1oVOmQLVuzX_bG=-5KrM2Q@mail.gmail.com>
	<75f97336-6cb5-47fc-ac88-5fe7842e2838@samsung.com>
	<CAPDyKFq=BF5f2i_Sr1cmVqtVAMgr=0FqsksL7RHZLKn++y0uwg@mail.gmail.com>



On 4/10/25 14:34, Ulf Hansson wrote:
> On Thu, 10 Apr 2025 at 12:42, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>>
>>
>> On 4/9/25 12:41, Ulf Hansson wrote:
>>> On Wed, 9 Apr 2025 at 11:30, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>>>>
>>>> Prepare for handling GPU clock and reset sequencing through a generic
>>>> power domain by adding clock and reset properties to the TH1520 AON
>>>> firmware bindings.
>>>>
>>>> The T-HEAD TH1520 GPU requires coordinated management of two clocks
>>>> (core and sys) and two resets (GPU and GPU CLKGEN). Due to SoC-specific
>>>> requirements, the CLKGEN reset must be carefully managed alongside clock
>>>> enables to ensure proper GPU operation, as discussed on the mailing list
>>>> [1].
>>>>
>>>> Since the coordination is now handled through a power domain, only the
>>>> programmable clocks (core and sys) are exposed. The GPU MEM clock is
>>>> ignored, as it is not controllable on the TH1520 SoC.
>>>>
>>>> This approach follows upstream maintainers' recommendations [1] to
>>>> avoid SoC-specific details leaking into the GPU driver or clock/reset
>>>> frameworks directly.
>>>>
>>>> [1] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>> ---
>>>>  .../bindings/firmware/thead,th1520-aon.yaml   | 28 +++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>> index bbc183200400..8075874bcd6b 100644
>>>> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>>> @@ -25,6 +25,16 @@ properties:
>>>>    compatible:
>>>>      const: thead,th1520-aon
>>>>
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: GPU core clock
>>>> +      - description: GPU sys clock
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: gpu-core
>>>> +      - const: gpu-sys
>>>
>>> These clocks don't look like they belong to the power-domain node, but
>>> rather the GPU's node.
>>>
>>> Or is this in fact the correct description of the HW?
>>
>> Hi,
>> Thank you for your input. Based on my understanding of Stephen
>> presentation the power-domain layer could act as a middleware layer
>> (like ACPI) that could own resources. That being said it was also stated
>> that the proposed approach should work with already existing device
>> trees, which implies that the DT should remain as is.
>>
>> So I could get the resources using attach_dev and detach_dev, but there
>> are two problems with that:
>>
>> 1) The GPU driver will try to manage clocks/reset on it's own using those functions
>>    if I provide non-stub working clocks and reset:
>> static const struct dev_pm_ops pvr_pm_ops = {
>>         RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume,
>>                        pvr_power_device_idle)
>> };
>>
>> So obviously I should invent a way to tell the drm/imagination driver to
>> NOT manage. One obvious way to do this is to introduce new flag to genpd.flags
>> called let's say GENPD_FLAG_EXCLUSIVE_CONTROL, which would tell the consumer
>> driver that the power management is being done only done from the PM
>> middleware driver.
> 
> Something along those lines. Although, I think the below twist to the
> approach would be better.
> 
> Some flag (maybe just a bool) should be set dynamically when the
> ->attach_dev() callback is invoked and it should be a per device flag,
> not a per genpd flag. In this way, the genpd provider driver can make
> runtime decisions, perhaps even based on some DT compatible string for
> the device being attached to it, whether it should manage PM resources
> or not.
> 
> Additionally, we need a new genpd helper function that allows the
> consumer driver to check if the PM resources are managed from the PM
> domain level (genpd) or not.
> 
> If it sounds complicated, just let me know I can try to help put the
> pieces together.

Thanks, this sounds doable

> 
>>
>> 2) The GPU node doesn't want to own the gpu-clkgen reset. In fact nobody
>>    seems to want to own it, even though theoretically it should be owned by
>>    the clk_vo as this would describe the hardware best (it's resetting the
>>    GPU clocks). But then it would be trickier to get it from the PM driver,
>>    making the code more complex and harder to understand. Nonetheless I
>>    think it would work.
> 
> I guess it doesn't really matter to me. Perhaps model it as a reset
> and make the GPU be the consumer of it?

GPU driver maintainers already stated that they only want to consume a
single reset line, that would be 'gpu' [1]. The 'gpu-clkgen' is an orphan in
this situation, or a part of a SoC specific-glue code, so theoretically
since the PM driver in our case is also a SoC glue driver we could leave
the 'gpu-clkgen' in PM DT node.

[1] - https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@imgtec.com/
> 
>>
>> If this sounds good to you I will work on the code.
> 
> Sure, let's give this a try - I am here to help review and guide the best I can.

Thank you very much for your support, it’s invaluable!

> 
> [...]
> 
> Kind regards
> Uffe
> 

