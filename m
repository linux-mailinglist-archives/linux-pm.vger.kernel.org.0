Return-Path: <linux-pm+bounces-5110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BE87FD29
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FD81C21D01
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8497F46A;
	Tue, 19 Mar 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hdjF+s76"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749A7CF24;
	Tue, 19 Mar 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848997; cv=none; b=QeFZGOWX8dn9BBl6ToGLxY3s/eD0Q/WJH/BifPv5s7DSVZTBBc7QnAA4BN8P6U+SeRyt0BytJLAPEM1CFXqDVVyOfyrhiZUC75nmFtHYOxJimYFfRTkUSMRqzLQydvbeh/eCR0AwQzqP2uiJ+l3hxIHLngXo/YIcEe4dY3o5WE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848997; c=relaxed/simple;
	bh=XjwqH/orhjkZ0M+hpo2MkrPi3tiRJAGJANekrAToRFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzkMlpXGHccfl18tGeadHmZu4dI5wCazMkjVah3DupdBNVQKBtjUP5A66PgOhvWP4+UKupbA9pGa+/yorn4wd9LAayNtJCULj48uBnzoCKHblItulKZFnmKMN/1yu+MxMRxoU3AZeopjqYPXzUK/me/Y79fP9gP0QnA4+IXGNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hdjF+s76; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710848994;
	bh=XjwqH/orhjkZ0M+hpo2MkrPi3tiRJAGJANekrAToRFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hdjF+s76ZX6f82fXCMhywdS8f110HtGt1F3897ZRNTR7MnmZ4cagGI8KkjsPdtAKw
	 I8SKyoqHCcni81f3nxHK/uzeHyaJUfkHIvgUa+55kLJ7A/SygzjvtGZD379g/IormO
	 4OROGPL9qCBwueXMrWVCckjbtJHDWhBt+wFofBjhaAFJv0yHzykO+uMNXzaX2LRJx/
	 QVwha6X7FjO0x/7YliLPi1v/lb/GDAzvXjbX2HcHLtWQsV1t/pSdj7ya3dk1MJje62
	 3OMj/deS47o3lrwcjOQH8MZw9QS6uh9nAq25HZWAdL7+/tbuQXFOkvngTb+Pra4QNa
	 Jw61YfrVUOk+A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33F69378203E;
	Tue, 19 Mar 2024 11:49:54 +0000 (UTC)
Message-ID: <34e75ebd-b01c-430a-a051-47489492c189@collabora.com>
Date: Tue, 19 Mar 2024 12:49:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] arm64: dts: mediatek: mt8186: add default
 thermal zones
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-9-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240318212428.3843952-9-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 236 +++++++++++++++++++++++
>   1 file changed, 236 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 7b7a517a41..9865926459 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -13,6 +13,8 @@
>   #include <dt-bindings/power/mt8186-power.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>   
>   / {
>   	compatible = "mediatek,mt8186";
> @@ -2115,4 +2117,238 @@ larb19: smi@1c10f000 {
>   			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
>   		};
>   	};
> +
> +	thermal_zones: thermal-zones {
> +		cluster0-thermal {

Please use the names that are expected by the SVS driver.

Regards,
Angelo


