Return-Path: <linux-pm+bounces-28055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57333ACCD4E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BB716F884
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196F1DE881;
	Tue,  3 Jun 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p6R6G1I/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6713D8B1
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976364; cv=none; b=KvpE4eqOM6Tn9Su/Tb4F9l1czG70c09iQH8Q/fYxQ+N2FF0/ilY1EmPcP7kbgevxGKNCAzpBnH0ylDWpci9i0JY6KFMau48ykVSmTh5uK7NCnZvA5MGTPGBi/m/kvJcWmy2rIj5/eiR39lC7AzHFR5PmwBaIPRLUZgLsl6/dGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976364; c=relaxed/simple;
	bh=jU9dqXzJ/B2/saKgXQkuraibY8ps+BTSs/N0EFDVbu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ISV+BTwL/X5s3NTAk/lkTyV7+adX8GVs3sil2coMa4t7LjasJN5f0mnTPv+Iluiz9vP+LyrT0cHKDZa0mvI41bDpdyKMjT9JvHPXmyG7Plso38alSORVVpb2eGEqeWlzZr7gS6bpmpAwkGodBfsewUBdY8pYJOQJFs4cIRyGaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p6R6G1I/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250603184559euoutp01832143bb39d1905bebc07bf5aaabbdf3~FnLtvnu2L0203202032euoutp01V
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:45:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250603184559euoutp01832143bb39d1905bebc07bf5aaabbdf3~FnLtvnu2L0203202032euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748976359;
	bh=uQI33aeDB3YvTs31NM2w9GJCDXa/2VEkwRCdI0P0nAY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=p6R6G1I/UJlWGGgHhiFgapjrXWtpYAp0wFUx+fMIeVC0whJhUVE4iLcwGu6uJQPDX
	 tbymJJR4kt4AxTqJInTfFfiW/lTUg8oDgKpcT8YaXuF+Wcy7NCxP5XcIu6LOegllpE
	 FPNMEGF9lWfUX5vjxWznVNzeajEcJYE5LuvBrQxA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250603184558eucas1p179c610c48e6f475d839e9e25585cbe2a~FnLs7Ny4R3131431314eucas1p1h;
	Tue,  3 Jun 2025 18:45:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250603184557eusmtip2e68f8fe1c77ac8990d75a102efcf9f08~FnLr3jqqk0715807158eusmtip2N;
	Tue,  3 Jun 2025 18:45:57 +0000 (GMT)
Message-ID: <c49ae9f2-3c3c-4253-be85-8fe5bbb4b42e@samsung.com>
Date: Tue, 3 Jun 2025 20:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] riscv: dts: thead: Add GPU power sequencer node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250603-gleaming-mammoth-of-kindness-538add@kuoka>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250603184558eucas1p179c610c48e6f475d839e9e25585cbe2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333
X-EPHeader: CA
X-CMS-RootMailID: 20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222408eucas1p20f62cea4c9c64bb5dda6db1fd38fb333@eucas1p2.samsung.com>
	<20250530-apr_14_for_sending-v3-6-83d5744d997c@samsung.com>
	<20250603-gleaming-mammoth-of-kindness-538add@kuoka>



On 6/3/25 15:22, Krzysztof Kozlowski wrote:
> On Fri, May 30, 2025 at 12:23:53AM GMT, Michal Wilczynski wrote:
>> Add the device tree node for the T-HEAD TH1520 GPU power sequencer
>> (gpu_pwrseq) to the th1520.dtsi file.
>>
>> This node instantiates the thead,th1520-gpu-pwrseq driver, which
> 
> Explain the hardware, not what drivers do.
> 
>> is responsible for managing the GPU's power-on/off sequence. The node
>> specifies the gpu-clkgen reset, which is one of the resources
>> controlled by this sequencer.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index bdbb1b985b0b76cf669a9bf40c6ec37258329056..6170eec79e919b606a2046ac8f52db07e47ef441 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -238,6 +238,12 @@ aon: aon {
>>  		#power-domain-cells = <1>;
>>  	};
>>  
>> +	gpu_pwrseq: pwrseq {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://protect2.fireeye.com/v1/url?k=a53ea5d3-c4434f50-a53f2e9c-74fe48600158-c81092475ef416b3&q=1&e=d333d06b-0b06-493e-a358-e29ca542dfe7&u=https%3A%2F%2Fdevicetree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-basics.html%23generic-names-recommendation
> 
>> +		compatible = "thead,th1520-gpu-pwrseq";
>> +		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
>> +		reset-names = "gpu-clkgen";
> 
> What is the point of pwrseq if there is no consumer/user of it? Looks
> like simple placeholder and anyway maybe the future consumer should just
> use reset directly.

Yeah I think you're right, I wanted to explore adding the pwrseq
provider in separate node per discussion in v2 [1]. But for the v4 I
think I'll revert to the v2 way of handling this reset [2].

[1] - https://lore.kernel.org/all/CAPDyKFpi6_CD++a9sbGBvJCuBSQS6YcpNttkRQhQMTWy1yyrRg@mail.gmail.com/
[2] - https://lore.kernel.org/all/20250414-apr_14_for_sending-v2-2-70c5af2af96c@samsung.com/

> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

