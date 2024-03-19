Return-Path: <linux-pm+bounces-5108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F987FD24
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97005B21C3B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7767F470;
	Tue, 19 Mar 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Amh5jQdj"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6337F46A;
	Tue, 19 Mar 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848868; cv=none; b=MiL/PSO8W61coOrYBeVxNhsvq7GiPyQW60NrA2xk+ET3Wjs659zRA2/Fn36ubXX2ZopbuPB0e9IX+ckvLTtVxHKjSKdaJ+UJYCvOIpT6cbiw4PEA9uQXhP3MDjv9D2XxFoxbinfmmzpVh6G6zEkSQmduotNrfgO3A8RzXuUDNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848868; c=relaxed/simple;
	bh=qP5gXkLN9BbD+xAGyMSyZHGa30YnfxKKydf78AcNovs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoWTJiitMKGNJAlOemuRunVsLzaYCFF4vecDblFHzZXGE3FRahaX8FPn1mikbsukEpP12QvVsLeydwK9II/6JjeIbbjQObOCDKcQGSym4zX+oQ5rPgtcxGn4RuUG9D6nypdGD4zzZt5hOBZbnckLflTWdEKeSg6ptvjpoGc4vRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Amh5jQdj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710848865;
	bh=qP5gXkLN9BbD+xAGyMSyZHGa30YnfxKKydf78AcNovs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Amh5jQdjBcqhcjs7kG7HE2t/lX8p12H9abwdZrLqx/uRR1MOoV+lS1U0ShGDaqHi0
	 P41UQP4qdmLFVglubo0f48fGH587hCJNRM2U5j2j6z8Su6Gx4w+qfPrsh/mTiOOYGM
	 HUmll1+xjDg3c6D1PxSdOi4Esv5K+5QkIK05gQoUIaRa8V0RmYFnA1ZJso1FkGJb3P
	 vZnccgM5Q9r16A9479VmQZLhd17XiZ1D6O0sYQRwUV7k2V1TD1wmAK9U/arAfheueS
	 AcuKJFF+QK5+GvzK/NAC+CBamuk3I7RoXn5WNpIn0DxcFMOnfOCZDpKq38clt7FPwr
	 eM9F/W55w/a7w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94C1C378203E;
	Tue, 19 Mar 2024 11:47:44 +0000 (UTC)
Message-ID: <2752f476-db91-46a5-a32f-458b7067063d@collabora.com>
Date: Tue, 19 Mar 2024 12:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] arm64: dts: mediatek: mt8186: add lvts
 definitions
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-7-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240318212428.3843952-7-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Values extracted from vendor source tree.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 2fec6fd1c1..7b7a517a41 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -1355,6 +1355,18 @@ spi0: spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> +		lvts: lvts@1100b000 {

This is not generic and LVTS ain't special.

thermal-sensor@1100b000

Also, please use the correct length - you're clashing with the SVS iospace.

> +			compatible = "mediatek,mt8186-lvts";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			clock-names = "lvts_clk";
> +			resets = <&infracfg_ao MT8186_INFRA_THERMAL_CTRL_RST>;
> +			nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
> +			nvmem-cell-names = "e_data1","e_data2";
> +		};
> +
>   		pwm0: pwm@1100e000 {
>   			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
>   			reg = <0 0x1100e000 0 0x1000>;
> @@ -1668,6 +1680,14 @@ efuse: efuse@11cb0000 {
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   
> +			lvts_e_data1: data1 {

Please always run `make dtbs_check`

Regards,
Angelo

> +				reg = <0x1cc 0x14>;
> +			};
> +
> +			lvts_e_data2: data1-1 {
> +				reg = <0x2f8 0x14>;
> +			};
> +
>   			gpu_speedbin: gpu-speedbin@59c {
>   				reg = <0x59c 0x4>;
>   				bits = <0 3>;

-- 
AngeloGioacchino Del Regno
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


