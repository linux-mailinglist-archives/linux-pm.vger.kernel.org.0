Return-Path: <linux-pm+bounces-30776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71375B039CA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C8E3B9057
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D7D23956A;
	Mon, 14 Jul 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wzm4jIIJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649718D;
	Mon, 14 Jul 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482863; cv=none; b=KANTA58afO/fAQovKIoa098O/NKkN4FwbZXP4PBfIX78sC4Ryi6hAFe1wd5GXWKdilt7ZuyvM0j9s7HS9zGsnZiyUIg0T/HLKZfIMAEP9Yxz4uK6VpeJAMpM0mHD5zdENHnSmX92fxdv8noUJBK+b2DWlQT3rtC67A1oL9QJMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482863; c=relaxed/simple;
	bh=2yuai8UnBb9zpoj2Dz89OXxlnRC1pzOFSWPiKRkdFpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4PlRXiADD7C5sP/ZbtfhLUCk8hd8eWXSFNgtkcVosfu8Ou8nbmc4RYg6DnsMKP+iKurZ4Yv8YRZwKlIz9pImmRwwaO4cJ2iQhZ71pKDfEfetreBJE9FXCI8ls2DCq72gJnt3kJ3rkcdQcuDL2XaB74qha1LqbWhUYXRkuUhUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wzm4jIIJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752482854;
	bh=2yuai8UnBb9zpoj2Dz89OXxlnRC1pzOFSWPiKRkdFpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wzm4jIIJtgJreaN92gm42sD6apc9wRY3xZ1FVNYWbhJdyNsOQ5Q2QlelUTgRDWdT1
	 freAjquBex0sEw9hjUvBpuL8JT0WGHkQXXrcZI0NxnAbxn5mKPsPQEE3qn433KL59C
	 gk/AASg+Ww7oar/9ABMOmCgdtmYBEq+iSjCsWjYt6diX0almRkMLN8XdnSDts+tdW6
	 pif5SfJrOYi6KT0FoHbPAyGzmIZH5MKi5r5vuBjoho0+whjaoKHq0JbxKA/Op/0Hdi
	 +gFiN36PItGgd9myBZxQ51R7NvyS4fCtVOZWTi7nLoyStTlkbav/wvIWmP6B/Wf3aL
	 fy9IlPEXbSnyw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49D4C17E056F;
	Mon, 14 Jul 2025 10:47:33 +0200 (CEST)
Message-ID: <4537173f-7f79-4629-a2ef-cbf1edd2ed81@collabora.com>
Date: Mon, 14 Jul 2025 10:47:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: mfd: syscon: Add mt8196 fdvfs syscons
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
 <20250711-mt8196-cpufreq-v1-1-e1b0a3b4ac61@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250711-mt8196-cpufreq-v1-1-e1b0a3b4ac61@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/07/25 16:57, Nicolas Frattaroli ha scritto:
> The MT8196 SoC uses two syscon ranges for CPU DVFS that are separate
> from each other. One, mt8196-fdvfs-config, is used to check for a magic
> number at that memory address to verify that fdvfs should be used. The
> other, mt8196-fdvfs, is used to configure the desired frequency for the
> DVFS controller for each CPU core.
> 

What is the reason why you're using syscons here?

Can't we simply assign the FDVFS MMIO to the cpufreq-hw node?

Or is there any reason why we can't declare it as mmio-sram? ...because I'm not
entirely sure but the FDVFS space should effectively be a [c]SRAM memory range...

Cheers,
Angelo

> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..5ee49d2ba0cdb72dd697a0fd71c8416ad4fd2c1e 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -88,6 +88,8 @@ select:
>             - mediatek,mt8135-pctl-a-syscfg
>             - mediatek,mt8135-pctl-b-syscfg
>             - mediatek,mt8173-pctl-a-syscfg
> +          - mediatek,mt8196-fdvfs
> +          - mediatek,mt8196-fdvfs-config
>             - mediatek,mt8365-syscfg
>             - microchip,lan966x-cpu-syscon
>             - microchip,mpfs-sysreg-scb
> @@ -194,6 +196,8 @@ properties:
>             - mediatek,mt8135-pctl-a-syscfg
>             - mediatek,mt8135-pctl-b-syscfg
>             - mediatek,mt8173-pctl-a-syscfg
> +          - mediatek,mt8196-fdvfs
> +          - mediatek,mt8196-fdvfs-config
>             - mediatek,mt8365-infracfg-nao
>             - mediatek,mt8365-syscfg
>             - microchip,lan966x-cpu-syscon
> 



