Return-Path: <linux-pm+bounces-28107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CFACDE31
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1814316B528
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0C28ECD0;
	Wed,  4 Jun 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a4gbI2uK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042513AD1C
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040847; cv=none; b=VEqZup2Ao4BzWNcggA5m26tqbPTujHNUiud6Hed1kE65nLlNcnNswV1hlIF+/BfLN4N1n45/LhbxNFBNG4UNFIF25eUjhBhmbLqNrChGdRdpstqH2kvvzUgQ0WlwAja+bnMjcKjkqWrc34fjpL0RihZC/P6xepI2bGgcf/TrsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040847; c=relaxed/simple;
	bh=JZodZ9P1TWqjuyQ7ANQr6qONcAswGVx2ceY2TIRVpsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VmNYKzNRoTJyRPePE3auKkAdr7m0TqTL+VaA6zDAcjtslY0pgyry+gv3aUSBiwchnFcNb0uhFP/kDinQ/uiwLUV8A3Td8k5IhwO5JMAmThy+qQcfo2+XpcgqDSrrSyxr+j9eY/vGjhjzes+Vs97fUgTwqQPQh7qSKcoJMa0yMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a4gbI2uK; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250604124043euoutp02e510f0b890ab4d1913ba74670ab03eb4~F12FYX9CY1935219352euoutp025
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 12:40:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250604124043euoutp02e510f0b890ab4d1913ba74670ab03eb4~F12FYX9CY1935219352euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749040843;
	bh=kAukIWR6u4Jom32Pa8uBS4iyUUF+BImaglA4PV9oEzQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a4gbI2uKh9qSnXTOnisyHBycy4qQuffoUBlkfZVmQG43tehnzN4fdakk6Y0isqje/
	 tqqU+P3e1u06PJ0Qzx2wVKoxUwR9kowkZGrAOL+XMoBDH2Qq7UffB8MS3ZIZBPjRpy
	 olmcUWBNOqbeovuk1A1whOHyaiVBG+9DqWHXci+E=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250604124042eucas1p18959bb4cf78c93c05cdaad2ee125c276~F12Eqw0oR1319513195eucas1p1z;
	Wed,  4 Jun 2025 12:40:42 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250604124041eusmtip29c8ca08943a9ca4c8ebeb77dd5466bfd~F12DrZDyv0267302673eusmtip2e;
	Wed,  4 Jun 2025 12:40:41 +0000 (GMT)
Message-ID: <a68e3bee-f4ad-4d73-a5a8-e39772c41711@samsung.com>
Date: Wed, 4 Jun 2025 14:40:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU
 node
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFpYfZNthdRN=pCv4FEdFCzrKEH4aFBy4ew-xLKtpbJ5Tg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250604124042eucas1p18959bb4cf78c93c05cdaad2ee125c276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944
X-EPHeader: CA
X-CMS-RootMailID: 20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944
References: <CGME20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944@eucas1p2.samsung.com>
	<20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
	<CAPDyKFpYfZNthdRN=pCv4FEdFCzrKEH4aFBy4ew-xLKtpbJ5Tg@mail.gmail.com>



On 6/3/25 14:27, Ulf Hansson wrote:
> On Fri, 30 May 2025 at 00:24, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
>> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
>> the GPU using the drm/imagination driver.
>>
>> By adding this node, the kernel can recognize and initialize the GPU,
>> providing graphics acceleration capabilities on the Lichee Pi 4A and
>> other boards based on the TH1520 SoC.
>>
>> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
>> controlled programatically.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index 6170eec79e919b606a2046ac8f52db07e47ef441..ee937bbdb7c08439a70306f035b1cc82ddb4bae2 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
>>                 #clock-cells = <0>;
>>         };
>>
>> +       gpu_mem_clk: mem-clk {
>> +               compatible = "fixed-clock";
>> +               clock-frequency = <0>;
>> +               clock-output-names = "gpu_mem_clk";
>> +               #clock-cells = <0>;
>> +       };
>> +
>>         stmmac_axi_config: stmmac-axi-config {
>>                 snps,wr_osr_lmt = <15>;
>>                 snps,rd_osr_lmt = <15>;
>> @@ -504,6 +511,21 @@ clk: clock-controller@ffef010000 {
>>                         #clock-cells = <1>;
>>                 };
>>
>> +               gpu: gpu@ffef400000 {
>> +                       compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
>> +                                    "img,img-rogue";
>> +                       reg = <0xff 0xef400000 0x0 0x100000>;
>> +                       interrupt-parent = <&plic>;
>> +                       interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&clk_vo CLK_GPU_CORE>,
>> +                                <&gpu_mem_clk>,
>> +                                <&clk_vo CLK_GPU_CFG_ACLK>;
>> +                       clock-names = "core", "mem", "sys";
>> +                       power-domains = <&aon TH1520_GPU_PD>;
>> +                       power-domain-names = "a";
> 
> If the power-domain-names are really needed, please pick a
> useful/descriptive name.

Yeah they are required. Even though this convention doesn't seem to be
enforced by the dt-binding it seems like it's hard-coded into the driver
330e76d31697 ("drm/imagination: Add power domain control"). So I don't
think I have any choice here.

> 
> [...]
> 
> Kind regards
> Uffe
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

