Return-Path: <linux-pm+bounces-9933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D8916015
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF17B23939
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67402146D75;
	Tue, 25 Jun 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FCuDxx/Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A48146D41;
	Tue, 25 Jun 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300840; cv=none; b=Hy8jIOekjBrGbCL2sNS4soF54+74ij6UPPjodtrVpFBpvfsrm4L2ZApdJVC1zekZWSoePxwu+7lNIORFSlu0bm6fbGVl05BhNG6zo6cZhBBSAoX38+IM1DYWkehIde5Kqqbqh96qHNosGEe3upWDzaxqeSNrwQygYojNd8xwpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300840; c=relaxed/simple;
	bh=TOOLtg9NdLC3amlRs5oAthSb+JcnWvvwrH8FQr7fzgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nxB9ZYLJYCbg1F8ShvqUlyKIU5VTeblROiKyaEzS8kLdwn5dyhwPhL6kH9vw1YagCdndCk4jwvwqo8w8yccGwRabtLsIAgfP1rmhOZ5k6PjNeyHuUx75pd8SYT4Pw0Fgf0ev/Vp2CUZethdh8AnrSVsV5n980+VN/y2Ekr2BHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FCuDxx/Q; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P5mYDQ016543;
	Tue, 25 Jun 2024 09:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	SG7KzjbjhdvAXuc6OOHdlN12i54PFnhondM4sQ5LyrA=; b=FCuDxx/Q15C/701T
	gpINrzfOzW307N3lQqD+frLlXBDbvpXIxXz7aoSKTXrJcTnSv5G9+FzLbuRhk4ZH
	MNnDGga/lugzfMqpy+flAGGjiwV7gcNftJy/XX+2B8o8NtrrqOwsU84KsZBBFBFm
	VUIg/JfTQb3wq7FvUdwApZpN5g8gf/2tjzJGGQZwFixhvyFagH2baTxGdQLlR4RA
	a7bZ4vhzzmdxc407Kse5YxKs2I0QeJvBvOmOkA7gUO7raMjiy5ITbzNNjVzauiSj
	RhnZ/Owgs0/XmuWh7q62VvdW0bvaoQqKBkVUKZUGkNfvlyOGcMXtsQqFZp+Do0Ur
	eWMoZw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx860g922-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:33:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 547E94004F;
	Tue, 25 Jun 2024 09:32:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F162421073E;
	Tue, 25 Jun 2024 09:31:34 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 09:31:34 +0200
Message-ID: <75198095-5f3f-434b-8948-d99876e923e9@foss.st.com>
Date: Tue, 25 Jun 2024 09:31:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM: dts: st: add thermal property on stih410.dtsi
 and stih418.dtsi
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
 <20240320-thermal-v3-2-700296694c4a@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240320-thermal-v3-2-700296694c4a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01



On 3/20/24 22:33, Raphael Gallais-Pou wrote:
> "#thermal-sensor-cells" is required and missing in thermal nodes.
> Add it.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/stih410.dtsi | 1 +
>  arch/arm/boot/dts/st/stih418.dtsi | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
> index 29e95e9d3229..a69231854f78 100644
> --- a/arch/arm/boot/dts/st/stih410.dtsi
> +++ b/arch/arm/boot/dts/st/stih410.dtsi
> @@ -270,6 +270,7 @@ thermal@91a0000 {
>  			clock-names = "thermal";
>  			clocks = <&clk_sysin>;
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
>  		};
>  
>  		cec@94a087c {
> diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
> index b35b9b7a7ccc..0f0db988a907 100644
> --- a/arch/arm/boot/dts/st/stih418.dtsi
> +++ b/arch/arm/boot/dts/st/stih418.dtsi
> @@ -113,6 +113,7 @@ thermal@91a0000 {
>  			clock-names = "thermal";
>  			clocks = <&clk_sysin>;
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
>  		};
>  	};
>  };
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

