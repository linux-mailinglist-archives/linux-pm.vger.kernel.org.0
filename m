Return-Path: <linux-pm+bounces-37824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA6CC52234
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E784E8D7C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B213148A3;
	Wed, 12 Nov 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TeTaT22D"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512C313E3B;
	Wed, 12 Nov 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948374; cv=none; b=XhUqL9+KLF+FTfL7/ua0uJWP+fEgQZhhTw+gIvs9bp1LKAQULtzLOVbLaigeC/4FCIwHgR2kv4RSxfePMiWhiGWrAv+vddZvIqKr5HWOaFKCg1AZXNgl6Npv2/CldRtE+ZPlZ37/WZnK/BNMzNokjoBUBPPTGuqQqzvj48LMhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948374; c=relaxed/simple;
	bh=E6HjezHpr/eYmZXi+/xXABXVhexayoEiHe9ZqY+Gpng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOqqs+7yRe58tAOdB+hz/lRnprsSquQ02skg2M0QpmR455jXRQij/H/wa44+FKworA8KKPY6okOTHPImkp3eopaBcZD26OCzzxkKOFuzsqo7a50bQJbYQBmiesg4uzjI9uDD1oZNiFyph4E+dQErZ6+6ISgmb0e55UtCzt+xOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TeTaT22D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762948370;
	bh=E6HjezHpr/eYmZXi+/xXABXVhexayoEiHe9ZqY+Gpng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeTaT22DJTm759f0/H9mXM+ubPyd1ePNPC1034/JqWtk8+Ga8tZzX2DDXUl/OmEW0
	 9uHGrXsWuZmuxiVXmJwyON/tW+f7tC1lHjzhqPkEQk0louODcdoLLg2jUDyUsqTyRo
	 4TPplTsIhtGitO6e2Nm6J29fZCUzstP3RqeNwDTSQvbzkgQn/l7O/9bFEB6jItD65z
	 TvtPwEuZ54R8f3ATabV1XzPjjQBx2P6EZhfxlCXhhXxKi9/j//3OYe20L+g+3DRReZ
	 +VBEERL8iaTc2uzfml+vXq82jk/UlrA+1Gx4VYtNAJeeXsp7hbCD0J5zgOc0jRcoOw
	 TdYfTH8d9BmGg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D5D7B17E0927;
	Wed, 12 Nov 2025 12:52:48 +0100 (CET)
Message-ID: <f949c2a6-df24-41bb-aac7-f5567d03c5f5@collabora.com>
Date: Wed, 12 Nov 2025 12:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] of: Add wrappers to match root node with OF
 device ID tables
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
 linux-tegra@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/11/25 11:28, Krzysztof Kozlowski ha scritto:
> Changes in v2:

Note:

Looks ok based on code and based on testing on the following platforms:
  - tegra: Jetson Xavier NX Development Kit
  - qcom: sdm630 Sony Xperia XA2 (Nile), sc7180 Trogdor Lazor Chromebook
  - mediatek: MT6795 Xperia M5 (midstream kernel), MT8173 Elm Chromebook
              MT8365 Genio 350 (mt8365-evk)

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> - Drop cpufreq/ti change: not correct.
> - Drop soc/qcom/qcom_pd_mapper.c - objections from Dmitry and I think
>    better to drop the patch in such case.
> - I did not implement feedback for first patch to make the
>    of_machine_compatible_match() matching machines in arbitrary nodes,
>    because there is no such use case possible and no arguments were provided.
>    I also did not use cleanup.h in first patch because existing code
>    of_device_get_match_data() does not use it and I prefer uniformity.
> 
> - Add Ack/Rb tags.
> - Link to v1: https://patch.msgid.link/20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org
> 
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
> ---
> Krzysztof Kozlowski (11):
>        of: Add wrappers to match root node with OF device ID tables
>        cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
>        cpufreq: mediatek: Simplify with of_machine_get_match_data()
>        cpufreq: sun50i: Simplify with of_machine_device_match()
>        cpuidle: big_little: Simplify with of_machine_device_match()
>        firmware: qcom: scm: Simplify with of_machine_device_match()
>        irqchip/atmel-aic: Simplify with of_machine_get_match_data()
>        platform: surface: Simplify with of_machine_get_match_data()
>        powercap: dtpm: Simplify with of_machine_get_match_data()
>        soc: qcom: ubwc: Simplify with of_machine_get_match_data()
>        soc: tegra: Simplify with of_machine_device_match()
> 
>   drivers/cpufreq/cpufreq-dt-platdev.c               | 15 ++-----
>   drivers/cpufreq/mediatek-cpufreq.c                 | 12 +-----
>   drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 11 +----
>   drivers/cpuidle/cpuidle-big_little.c               | 11 +----
>   drivers/firmware/qcom/qcom_scm.c                   | 17 +-------
>   drivers/irqchip/irq-atmel-aic-common.c             | 15 ++-----
>   drivers/of/base.c                                  | 47 ++++++++++++++++++++++
>   .../platform/surface/surface_aggregator_registry.c | 13 +-----
>   drivers/powercap/dtpm.c                            | 16 +-------
>   drivers/soc/qcom/ubwc_config.c                     | 14 ++-----
>   drivers/soc/tegra/common.c                         | 12 +-----
>   include/linux/of.h                                 | 13 ++++++
>   12 files changed, 79 insertions(+), 117 deletions(-)
> ---
> base-commit: a4ebba34e722123f1c09ce3282e26f052fc8b27f
> change-id: 20251106-b4-of-match-matchine-data-4a64bf046814
> 
> Best regards,


