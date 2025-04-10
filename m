Return-Path: <linux-pm+bounces-25100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB04A840FF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93F8189FE6B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67239281357;
	Thu, 10 Apr 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pk+nnR3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7726A1D0
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281783; cv=none; b=oJSJpwDe2WxIahZI1dcnPWLyOBXOxZ38Y9OMAofYS9Zwcryi1amXhNstX088Gz2ZN8UD5gQKWzhyaYjHUzOkoS6Li35QdKzd1KFODkZSM4ec34myDm8/XL+R7U8j7tPul34L5VNExPh1EWNBp0TaejJtcTTHS+27YG1GJ+MUGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281783; c=relaxed/simple;
	bh=Srtta9cGgCFg++cVV09zEVE846z5qF8qC76tlEbf7Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FobSQ+TSoBWB+j3AfvcpO5rD02sg3XLn6uDw3JoHRA39Sdy4Wn85wZ7z6Vqttz/i28+bZWMcBquMIK25U4meILyioe1yianITJ208uuOZ8bW40QA9dyHcwkKGYCO47Qd5YAdlBx4xDiIoL2STTkj1yaQlQZx8M5kfqFWN7vKw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pk+nnR3l; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250410104254euoutp01d4f897d864ba62c2873aaed2806e9e1d~07whKPjTN0442204422euoutp01y
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 10:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250410104254euoutp01d4f897d864ba62c2873aaed2806e9e1d~07whKPjTN0442204422euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744281774;
	bh=nb5PBMN992cQrfZoW1L1vIqwCTRi/cgZ29CTyxTafgg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pk+nnR3lwa9Pmbgeq9yAeS66NRe3AxWxoGQXAVW97JYncbbDdmXSfyV2nqLmirjXw
	 RGsfZQdDE9GA2edTSrLVFFGBIwB2vvPzhRXuDoyR/59me93QgNFPtHGfH1jAGRArl8
	 H12gaRXsnnyh27bt64aE9ASlN2OMBxa/wpJ4P4TU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250410104253eucas1p23b40ef8384b0114a446b04d0f0620f87~07wglSOeq2331023310eucas1p2V;
	Thu, 10 Apr 2025 10:42:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2F.3B.20409.DA0A7F76; Thu, 10
	Apr 2025 11:42:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250410104253eucas1p2a8d4c9b9d95af9b2040e9a86230b5755~07wgBMXG22331023310eucas1p2U;
	Thu, 10 Apr 2025 10:42:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250410104253eusmtrp2a487d0181ab9cf886f44b36beca22ed5~07wgAWPVt1782417824eusmtrp2I;
	Thu, 10 Apr 2025 10:42:53 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-ec-67f7a0ad1082
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.7A.19654.DA0A7F76; Thu, 10
	Apr 2025 11:42:53 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250410104252eusmtip2b23662068a11a1d5810de1be34ca6be7~07wfWH59V0811708117eusmtip2G;
	Thu, 10 Apr 2025 10:42:52 +0000 (GMT)
Message-ID: <75f97336-6cb5-47fc-ac88-5fe7842e2838@samsung.com>
Date: Thu, 10 Apr 2025 12:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: thead,th1520: Add clocks
 and resets
To: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFpoSwKAmiWyvNt1fVyu6=NU1oVOmQLVuzX_bG=-5KrM2Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87prF3xPN9h9w8xizd5zTBbzj5xj
	tbh3aQuTxYu9jSwWL2fdY7O4vGsOm8Xn3iOMFts+t7BZrD1yl93i7r0TLBb/9+xgt/h3bSOL
	xfG14RYt+6ewOPB5bFrVyeZx59oeNo/NS+o9WtYeY/Lo/2vg8X7fVTaPvi2rGD0+b5IL4Iji
	sklJzcksSy3St0vgylj4bwVLwVK1ikXPehgbGE/JdjFyckgImEjcmdvP2MXIxSEksIJR4uD0
	M2wQzhdGiZn/9zOCVAkJfGaUmPKBG6ZjRnsbVNFyRokZZxYxQzhvGSXWz2oC6+AVsJO4/nQZ
	K4jNIqAq0fb8CDNEXFDi5MwnLCC2qIC8xP1bM9hBbGGBCIkdny+B2SICnhIzrjeC3cQssJdJ
	4lvnIrBBzALiEreezGcCsdkEjCQeLJ8PFucUCJTo2b6LEaJGXqJ562ywiyQEFnNKtPbOY4O4
	20Xi/b1eFghbWOLV8S3sELaMxP+dEEMlBPIlHmz9xAxh10js7DkOZVtL3Dn3C2gOB9ACTYn1
	u/Qhwo4Sna83sYKEJQT4JG68FYQ4gU9i0rbpzBBhXomONiGIajWJqT29cEvPrdjGNIFRaRZS
	qMxC8uQsJM/MQti7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCCO/3v+JcdjMtf
	fdQ7xMjEwXiIUYKDWUmE19Pwe7oQb0piZVVqUX58UWlOavEhRmkOFiVx3kX7W9OFBNITS1Kz
	U1MLUotgskwcnFINTM0bLh3e/4RJ8bStrtHNk+s+x2zidzuaHbqMoYh9Te3hA/U74ydkWExe
	qXup58DZi05ON7Y6icQs3rbWX4z7mN30de6nGrRs6v94tX45It3gsmOv9Zva/R9izYQ3scZk
	+TcduRPv7vNE8VHx3l2arXeyI2YuN92jx83p5r34QJxYd7DQChZ2t7NvFH8+Uz93oEd4wpXP
	xumfAxtnzXjyI2L2h7WWGddXXPq//emLpEk2uj87D+ftYawuVPxVx+hjwOM7p6L5+al0bsdb
	n25mrRTIYrH/etFxsnBo5/3+dRbFInsFFFyOcfV6rfJTvllzKeVMnQ3/BKuWByXVL6+d9Tl0
	8NDmKarpVqI1Jb6/g5RYijMSDbWYi4oTASkYyLnfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7prF3xPN1i4VMBizd5zTBbzj5xj
	tbh3aQuTxYu9jSwWL2fdY7O4vGsOm8Xn3iOMFts+t7BZrD1yl93i7r0TLBb/9+xgt/h3bSOL
	xfG14RYt+6ewOPB5bFrVyeZx59oeNo/NS+o9WtYeY/Lo/2vg8X7fVTaPvi2rGD0+b5IL4IjS
	synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1j4bwVL
	wVK1ikXPehgbGE/JdjFyckgImEjMaG9jA7GFBJYyStxfzAcRl5G41v2SBcIWlvhzrQuohguo
	5jWjxNSz7WAJXgE7ietPl7GC2CwCqhJtz48wQ8QFJU7OfAJWIyogL3H/1gx2EFtYIEJix+dL
	YLaIgKfEjOuNjCBDmQX2Mkn86+tmhdgwgUni9KFzYFOZBcQlbj2ZzwRiswkYSTxYPh8szikQ
	KNGzfRdQNwdQjbrE+nlCEOXyEs1bZzNPYBSaheSOWUgmzULomIWkYwEjyypGkdTS4tz03GIj
	veLE3OLSvHS95PzcTYzAiN527OeWHYwrX33UO8TIxMF4iFGCg1lJhNfT8Hu6EG9KYmVValF+
	fFFpTmrxIUZTYFhMZJYSTc4HppS8knhDMwNTQxMzSwNTSzNjJXFetivn04QE0hNLUrNTUwtS
	i2D6mDg4pRqYNp93sNQ43RJU9Hurt+vhY5wX2tZe2xWqV71yqeLjx0Jxers/R2gczGa2v3nh
	5GGv3RnHOG5173FbF8n+Jo1Tcfbpvv4FXQH37JfY/NCbOdFJ7f2hd1OEXiWu3iTx4gn/pOky
	q3OMv22/7D3nUbtxtcDxk3d2MuYdmdTiq7N2gXHIxu1CfcfXHgtpEbp19tQ3llVGAhK7Jidr
	t1+xufjBdifLfM7/Ieoq3btWS8sfv//ArJ1fRfeEJcdNbR7+295RJSFlf/J7U6xSj+SFVIil
	Xlm6oSLOdkLyhPollV1P75m+vTOL44fcxrXSgW0BX06Karqd7P+zvbvj7qQ/3EufyEX98Wsv
	EZxdVbfU985yKyWW4oxEQy3mouJEAE/o13lxAwAA
X-CMS-MailID: 20250410104253eucas1p2a8d4c9b9d95af9b2040e9a86230b5755
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



On 4/9/25 12:41, Ulf Hansson wrote:
> On Wed, 9 Apr 2025 at 11:30, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>>
>> Prepare for handling GPU clock and reset sequencing through a generic
>> power domain by adding clock and reset properties to the TH1520 AON
>> firmware bindings.
>>
>> The T-HEAD TH1520 GPU requires coordinated management of two clocks
>> (core and sys) and two resets (GPU and GPU CLKGEN). Due to SoC-specific
>> requirements, the CLKGEN reset must be carefully managed alongside clock
>> enables to ensure proper GPU operation, as discussed on the mailing list
>> [1].
>>
>> Since the coordination is now handled through a power domain, only the
>> programmable clocks (core and sys) are exposed. The GPU MEM clock is
>> ignored, as it is not controllable on the TH1520 SoC.
>>
>> This approach follows upstream maintainers' recommendations [1] to
>> avoid SoC-specific details leaking into the GPU driver or clock/reset
>> frameworks directly.
>>
>> [1] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../bindings/firmware/thead,th1520-aon.yaml   | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>> index bbc183200400..8075874bcd6b 100644
>> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>> @@ -25,6 +25,16 @@ properties:
>>    compatible:
>>      const: thead,th1520-aon
>>
>> +  clocks:
>> +    items:
>> +      - description: GPU core clock
>> +      - description: GPU sys clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gpu-core
>> +      - const: gpu-sys
> 
> These clocks don't look like they belong to the power-domain node, but
> rather the GPU's node.
> 
> Or is this in fact the correct description of the HW?

Hi,
Thank you for your input. Based on my understanding of Stephen
presentation the power-domain layer could act as a middleware layer
(like ACPI) that could own resources. That being said it was also stated
that the proposed approach should work with already existing device
trees, which implies that the DT should remain as is.

So I could get the resources using attach_dev and detach_dev, but there
are two problems with that:

1) The GPU driver will try to manage clocks/reset on it's own using those functions
   if I provide non-stub working clocks and reset:
static const struct dev_pm_ops pvr_pm_ops = {
	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume,
		       pvr_power_device_idle)
};

So obviously I should invent a way to tell the drm/imagination driver to
NOT manage. One obvious way to do this is to introduce new flag to genpd.flags
called let's say GENPD_FLAG_EXCLUSIVE_CONTROL, which would tell the consumer
driver that the power management is being done only done from the PM
middleware driver.

2) The GPU node doesn't want to own the gpu-clkgen reset. In fact nobody
   seems to want to own it, even though theoretically it should be owned by
   the clk_vo as this would describe the hardware best (it's resetting the
   GPU clocks). But then it would be trickier to get it from the PM driver,
   making the code more complex and harder to understand. Nonetheless I
   think it would work.

If this sounds good to you I will work on the code.

Regards,
Michał

> 
>> +
>>    mboxes:
>>      maxItems: 1
>>
>> @@ -32,13 +42,27 @@ properties:
>>      items:
>>        - const: aon
>>
>> +  resets:
>> +    items:
>> +      - description: GPU reset
>> +      - description: GPU CLKGEN reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: gpu
>> +      - const: gpu-clkgen
>> +
> 
> Ditto for the reset.
> 
>>    "#power-domain-cells":
>>      const: 1
>>
>>  required:
>>    - compatible
>> +  - clocks
>> +  - clock-names
>>    - mboxes
>>    - mbox-names
>> +  - resets
>> +  - reset-names
>>    - "#power-domain-cells"
>>
>>  additionalProperties: false
>> @@ -47,7 +71,11 @@ examples:
>>    - |
>>      aon: aon {
>>          compatible = "thead,th1520-aon";
>> +        clocks = <&clk_vo 0>, <&clk_vo 1>;
>> +        clock-names = "gpu-core", "gpu-sys";
>>          mboxes = <&mbox_910t 1>;
>>          mbox-names = "aon";
>> +        resets = <&rst 0>, <&rst 1>;
>> +        reset-names = "gpu", "gpu-clkgen";
>>          #power-domain-cells = <1>;
>>      };
>> --
>> 2.34.1
>>
> 
> That said, it's still possible to make both the clocks and reset being
> managed from the genpd provider. I will comment on that separately for
> patch2.
> 
> Kind regards
> Uffe
> 

