Return-Path: <linux-pm+bounces-35273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75658B9994D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD05F2A690F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C092F9D8B;
	Wed, 24 Sep 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QuG46zSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A22F9993;
	Wed, 24 Sep 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713446; cv=none; b=uBnlw25pg4SWjTHpH/kEX4JEwwG08323iq2fvEDVdK/rWMHQTocL64vIhIZH6hVvRCD+C6COzVEndoBwHpy31/D2mC9sFb3qPRq+gUJEHe7557ApD3M1wXh0+Q5YkTqB87mYXFLwm2Jvypo19Y+lRvxthn+zw+GTB06jRGoTV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713446; c=relaxed/simple;
	bh=zAejJcsR74t5qZJ7rjpWSVUmAm/GDBIrDrA/WIcoYEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR4psmV1Z98QxOu1RAb2Of4iJo3JnPsGR8+KvqCCt3JmwY4dcNFruSAGnHs9zpNYYI3rBdcFpRcnpKEkB0ErW67QeZBS//u9i4Y4U5X3oqRVOafmZf9M9kRL2nA0Pukp3l2l12LSuqyio2yQdMZQ46UjQguvJfeWyptmMGb2hPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QuG46zSO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758713442;
	bh=zAejJcsR74t5qZJ7rjpWSVUmAm/GDBIrDrA/WIcoYEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QuG46zSOaR9X4edxtW+pQ+3UH7B0FcrFvBxe7Vu2/CCarOOCmn5RvqMyETMNLE5Tj
	 sUYiZCLg71vRI1BbB6aTfIgCBvDQuP5NAbTCPKq2lGB0VN563Jyg+zLAlX3H03CdCi
	 EeGgtGZL4auDTismc2lxfaK9fjIMJWRm2+o1gjmUt/x4ka+NouSoBNnv3kdEIZ4DS3
	 qjGWGExCRy0SSX21dBZmYlHnq3+8J2IupiofzMjM/fQB2pAGZsRP5wMWone9L6h1uh
	 4V+IzMSqztrRXMwUCnlFA9+JsbWCqxcxyRHXiMWDxv0wsctZ72gfkq2KZZAl7Ylf41
	 kzxsin8p9aL9w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A001C17E07EE;
	Wed, 24 Sep 2025 13:30:41 +0200 (CEST)
Message-ID: <4603e18e-e9c9-4f0e-9c0c-8cbad3567ea8@collabora.com>
Date: Wed, 24 Sep 2025 13:30:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] dt-bindings: power: Add MT8196 GPU frequency
 control binding
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-2-6cd63ade73d6@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923-mt8196-gpufreq-v4-2-6cd63ade73d6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 13:39, Nicolas Frattaroli ha scritto:
> On the MT8196 and MT6991 SoCs, the GPU power and frequency is controlled
> by some integration logic, referred to as "MFlexGraphics" by MediaTek,
> which comes in the form of an embedded controller running
> special-purpose firmware.
> 
> This controller takes care of the regulators and PLL clock frequencies
> to squeeze the maximum amount of power out of the silicon.
> 
> Add a binding which models it as a power domain.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 117 +++++++++++++++++++++
>   1 file changed, 117 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..03721244a737ce0914a89cc0aedd88fa3b6b2038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/mediatek,mt8196-gpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MFlexGraphics Power and Frequency Controller
> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +description: |

This vertical bar is not needed. Please drop it.

Cheers,
Angelo

> +  A special-purpose embedded MCU to control power and frequency of GPU devices
> +  using MediaTek Flexible Graphics integration hardware.
> +

