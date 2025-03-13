Return-Path: <linux-pm+bounces-23991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8537A5FDD0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542F98804D0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D2152E02;
	Thu, 13 Mar 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K5GQKXw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756A225D6
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887129; cv=none; b=tWJToCpj8B9RKnBxzj5wwPAlT92qH2zE/UYD8gZBy9ldIiKouBZGWkIA/7H2VfWuFxBTtGSc13QZd0VWNt2AGSMYyqTRhvOeUSjuBRs4MI+Kcmlp2UBQt5HybmIfVz4lWU5RNMBjcbCRlV9leQXo9qh2Fx3kjWotsQC03dhuSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887129; c=relaxed/simple;
	bh=HqzG7jGRRK4KmeDziW6iwOPxaTmHRDYm1A7LHk/FrA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlpKbUBvNeuq6OqOZMRMLw5oEho9wjSwUfGRNJxYFpalpkFmrjrVoh9kWQEVnOZi1+xMjW0v8hUh/gKRKHt4szWZJqqewpod9hUSZKDRkk58G0hqn9cS1xkWJQMtu5zZLcYLILT0HlqyTy0990WgUXRG9DzPnIdDk8SwW1L7D2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K5GQKXw0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741887123;
	bh=HqzG7jGRRK4KmeDziW6iwOPxaTmHRDYm1A7LHk/FrA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5GQKXw0+C6nefK2dpjbWjdMRkYFPbtbovwBTPSnD+CBCApTkx19jbL1BbcARmvgs
	 C6b6rcyz0T9EE+vcTfJlVM9LLdZSyAHxarpYZXMeB59QEEeyReHZReQ5iCTC1jjIU2
	 ZiFDIiV2JY7roftjhfDJAhBjZJ6wkXUHRG9T2oS7uXu3uQP/1RItiZZjaz5gUgmMR7
	 eUq60ukl+BmwUWmOZ6CXaTmoC79LfwehkqhzIFDNDU3rmnvVmmSX9z6wQf/jD8wc3J
	 nGW4AOaof3VfYtKhur/NHXKj1dSqkAMC48dzY0XBYTXP/4BYTQryGgVbFM/Q4wqNAB
	 oOOi34wdY8DDw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A60E17E0E8E;
	Thu, 13 Mar 2025 18:32:03 +0100 (CET)
Message-ID: <dcc62684-0579-4d03-a430-d4a276153ca1@collabora.com>
Date: Thu, 13 Mar 2025 18:32:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip
 points
To: Nicolas Pitre <npitre@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/03/25 16:43, Nicolas Pitre ha scritto:
> Provide the "switch on" thermal trip point to be used by the power
> allocator governor.
> 

As far as I know, the power allocation is not supposed to be SoC-global, as that
does play with sustainable power values...

Sustainable power depends on multiple factors - besides the power that is actually
sustainable by intrinsic properties of the silicon, this mostly depends on the PCB
that it is soldered to.

Translated, this depends on the heat capacity of the copper layer(s) and of the
eventual additional passive heatsink, which is a physical property relative to a
board and not to the SoC by itself.

....which means.... that those nodes shall go to board specific devicetrees and
not to the SoC devicetree :-)

Unless I'm wrong - but if I am, please explain why :-)

Cheers,
Angelo

> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 338120930b..262eab8fd3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -472,6 +472,12 @@ cpu-little0-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
>   
>   			trips {
> +				cpu_little0_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little0_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -510,6 +516,12 @@ cpu-little1-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
>   
>   			trips {
> +				cpu_little1_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little1_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -548,6 +560,12 @@ cpu-little2-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
>   
>   			trips {
> +				cpu_little2_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little2_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -586,6 +604,12 @@ cpu-little3-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
>   
>   			trips {
> +				cpu_little3_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_little3_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -624,6 +648,12 @@ cpu-big0-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
>   
>   			trips {
> +				cpu_big0_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_big0_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
> @@ -658,6 +688,12 @@ cpu-big1-thermal {
>   			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
>   
>   			trips {
> +				cpu_big1_switch_on: trip-switch-on {
> +					temperature = <68000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>   				cpu_big1_alert0: trip-alert0 {
>   					temperature = <85000>;
>   					hysteresis = <2000>;



