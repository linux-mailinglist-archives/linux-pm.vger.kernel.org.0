Return-Path: <linux-pm+bounces-37605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C46C3F196
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA53B0A4F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2E3195EA;
	Fri,  7 Nov 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZV4g5enh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC8317704;
	Fri,  7 Nov 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506739; cv=none; b=Mj2zws+iG0XLOYYbS8vsMTYvl7GXn+1L7EE8+AyfJqfpEcfOizhSMFt9WJZ6SK7vUb1K8Mvm0PSZBoIoWEt02fGo7gG5phsJcPV5EZZCQBHqJjbxN/puigPEy1jZ08nY1sU6BQTrXt1Qq2zItGy4uBjCfnQC5TsKIwYmE7bph0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506739; c=relaxed/simple;
	bh=i8bcLE32FSf57bRwMIQrvB0FS0CV25f/s7GHzJcLydY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5J3g1Y73D/KN6v0CWw7TRG9wHGudLUC/xlInMK83SWep5+nJ/GivRNpBvLsAWKn6qZgXWErJQQppDgDBU8oyuCqz72ZWEvfGm45ZtN7YPlRd0IoqhsvuFq3zVQwaFHDaTcmwW1R2CJzb8Ae49YIl5+XWs7lU1ghaPCd9eAQ954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZV4g5enh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762506735;
	bh=i8bcLE32FSf57bRwMIQrvB0FS0CV25f/s7GHzJcLydY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZV4g5enhu7yMNXiqcYlHi5Uh8Ct+jfotnXthdw+buHcJBzmP79S01Qv14L4479JWS
	 chqM3FT3ErebbYQ+XTWXCIK94+/zh40V7IRctnfNG+One7TnwGU9NbOjNfFRhbKc4w
	 bB1VEhGgtS/Iqp5ripBmfz32PRC7ggxC6ax1NQ8kk28jIi4a2+MnIcBogtW5Vverum
	 G6HcJHqBmyati/8X3w4V6TU6i2dIm/igLgYc2LhC8bKO3rWf7oqahRte1Lpc94d1qz
	 lhZoLf26ODR+ipMc/Xsl8yUmLmWN1N69Y//kNWC7Pk4hU+CgU9yXX18OIKyqql2lbn
	 wTlXeJc6o9IIw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7211717E12D5;
	Fri,  7 Nov 2025 10:12:14 +0100 (CET)
Message-ID: <7642d2bb-f246-41f9-bea8-6211fc2ad176@collabora.com>
Date: Fri, 7 Nov 2025 10:12:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] of: Add wrappers to match root node with OF device
 ID tables
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/25 20:07, Krzysztof Kozlowski ha scritto:
> Dependency/merging
> ==================
> All patches depend on the first patch, thus everything could go via
> Rob's tree with people's acks.
> 
> Description
> ===========
> Several drivers duplicate same code for getting reference to the root
> node, matching it against 'struct of_device_id' table and getting out
> the match data from the table entry.
> 
> There is a of_machine_compatible_match() wrapper but it takes array of
> strings, which is not suitable for many drivers since they want the
> driver data associated with each compatible.
> 
> Add two wrappers, similar to existing of_device_get_match_data():
> 1. of_machine_device_match() doing only matching against 'struct
>     of_device_id' and returning bool.
> 2. of_machine_get_match_data() doing the matching and returning
>     associated driver data for found compatible.
> 
> Best regards,
> Krzysztof
> 

Makes sense. Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
Angelo

> ---
> Krzysztof Kozlowski (13):
>        of: Add wrappers to match root node with OF device ID tables
>        cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
>        cpufreq: mediatek: Simplify with of_machine_get_match_data()
>        cpufreq: sun50i: Simplify with of_machine_device_match()
>        cpufreq: ti: Simplify with of_machine_device_match()
>        cpuidle: big_little: Simplify with of_machine_device_match()
>        firmware: qcom: scm: Simplify with of_machine_device_match()
>        irqchip/atmel-aic: Simplify with of_machine_get_match_data()
>        platform: surface: Simplify with of_machine_get_match_data()
>        powercap: dtpm: Simplify with of_machine_get_match_data()
>        soc: qcom: Simplify with of_machine_get_match_data()
>        soc: qcom: ubwc: Simplify with of_machine_get_match_data()
>        soc: tegra: Simplify with of_machine_device_match()
> 
>   drivers/cpufreq/cpufreq-dt-platdev.c               | 15 ++-----
>   drivers/cpufreq/mediatek-cpufreq.c                 | 12 +-----
>   drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 11 +----
>   drivers/cpufreq/ti-cpufreq.c                       | 13 +-----
>   drivers/cpuidle/cpuidle-big_little.c               | 11 +----
>   drivers/firmware/qcom/qcom_scm.c                   | 17 +-------
>   drivers/irqchip/irq-atmel-aic-common.c             | 15 ++-----
>   drivers/of/base.c                                  | 47 ++++++++++++++++++++++
>   .../platform/surface/surface_aggregator_registry.c | 13 +-----
>   drivers/powercap/dtpm.c                            | 16 +-------
>   drivers/soc/qcom/qcom_pd_mapper.c                  | 17 +-------
>   drivers/soc/qcom/ubwc_config.c                     | 14 ++-----
>   drivers/soc/tegra/common.c                         | 12 +-----
>   include/linux/of.h                                 | 13 ++++++
>   14 files changed, 82 insertions(+), 144 deletions(-)
> ---
> base-commit: e5efebeef746a24f45b98dbdfcf334285848b32a
> change-id: 20251106-b4-of-match-matchine-data-4a64bf046814
> 
> Best regards,



