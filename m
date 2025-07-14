Return-Path: <linux-pm+bounces-30806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C6B041FD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FBD189123E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9382561A7;
	Mon, 14 Jul 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DWqN3P1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2B14A60F;
	Mon, 14 Jul 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504095; cv=none; b=QngLU1MTd6z4vStNVsI6HePMgjaZbeCi1TPiutGvr8jdCMS0YmSicJFDGid6egnAe9zhYy00gFf9+Ahqe97ce9ArGklXFSIi8PraQW39nMFQ2G0OLthgenY3UXKGfIzNShCgt9AIaBwGlnOPvvSrZ0xa0TbeyHYhf/mIYH/Q6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504095; c=relaxed/simple;
	bh=Fz/d3uILd9FczXZOmPm/sOeGs9pVqLhoY4n9Jd808lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNZUIb/fCEJMgBCFmzPG4FVdkcLbJ9UgS/kMGbemHoVY7ue5YWAqqd3oVmCzlGZ/D1wpxgsyFOs42EArhAElB26BPfuwMobMMS/3pEokjd2i0Lzvk9GZxsi+nu8Ai2q1ZPcqfH857Lyz1ZwMhuxl9vpOZialAa+K2RmoRMwMpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DWqN3P1g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752504092;
	bh=Fz/d3uILd9FczXZOmPm/sOeGs9pVqLhoY4n9Jd808lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DWqN3P1gZB07xBDPA94x9vftku2YsQluF4nLOPZsKQcPfqd989ajB1sq6zTe8whzK
	 xhdSryo4lp8qEa3OgV+z5FTy1b09RHlPqknRNW8+hoSLzWhoU9gceoOSa94iVbQDqm
	 4hD2aNkCHMmzrRGd++OSkCz9S6sDoVS23Wo9rBH5PNzubIbgJqQqn4YiHTW8wEuMfw
	 awiyxdXkvilc8qYRSecHdRcWwAH6bhpV4NGj7UsHcUW8UtM6oUVA1BV4MOSIjoRPL2
	 +uXF4GISJoWiXJqa30pZasMQwSxrxczPgw4N2vZwpOVXzvHudLDMkPPRh0MxOr+fWi
	 bYp6HXUxT6pkQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B5F017E0DD7;
	Mon, 14 Jul 2025 16:41:31 +0200 (CEST)
Message-ID: <fd561a8c-f1a7-41c2-a686-abc89f5fa555@collabora.com>
Date: Mon, 14 Jul 2025 16:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
 <20250714-mt8196-cpufreq-v2-1-cc85e78855c7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250714-mt8196-cpufreq-v2-1-cc85e78855c7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/25 16:08, Nicolas Frattaroli ha scritto:
> The MediaTek MT8196 SoC has new cpufreq hardware, with added memory
> register ranges to control Dynamic-Voltage-Frequency-Scaling.
> 
> The DVFS hardware is controlled through a set of registers referred to
> as "FDVFS"; one is a location from which a magic number is read to
> ensure DVFS should be used, the other is a region to set the desired
> target frequency that DVFS should aim towards for each performance
> domain.
> 
> Instead of working around the old binding and its already established
> meanings for the reg items, add a new binding. The FDVFS register memory
> regions are at the beginning, which allows us to easily expand this
> binding for future SoCs which may have more than 3 performance domains.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        | 86 ++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..26bf21e05888646b4d1bdac95bfba0f36e037ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/mediatek,mt8196-cpufreq-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek CPUFreq for MT8196 and related SoCs

title: MediaTek Hybrid CPUFreq for MT8196/MT6991 series SoCs

> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +description:
> +  MT8196 uses CPUFreq management hardware that supports dynamic voltage
> +  frequency scaling (dvfs), and can support several performance domains.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8196-cpufreq-hw
> +
> +  reg:
> +    items:
> +      - description: FDVFS magic number register region

As already said in the other commit, we might just be able to avoid adding the
magic number register region :-)

> +      - description: FDVFS control register region
> +      - description: OPP tables and control for performance domain 0
> +      - description: OPP tables and control for performance domain 1
> +      - description: OPP tables and control for performance domain 2
> +
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Must be 1.

The description is redundant and doesn't add any real information, I think you
should drop it.

Bindings maintainers, please, opinions?

> +    const: 1
> +

Everything else looks good to me.

Cheers,
Angelo

> +required:
> +  - compatible
> +  - reg
> +  - "#performance-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a720";
> +                enable-method = "psci";
> +                performance-domains = <&performance 0>;
> +                reg = <0x000>;
> +            };
> +
> +            /* ... */
> +
> +            cpu6: cpu@600 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-x4";
> +                enable-method = "psci";
> +                performance-domains = <&performance 1>;
> +                reg = <0x600>;
> +            };
> +
> +            cpu7: cpu@700 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-x925";
> +                enable-method = "psci";
> +                performance-domains = <&performance 2>;
> +                reg = <0x700>;
> +            };
> +    };
> +
> +    /* ... */
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        performance: performance-controller@c2c2034 {
> +            compatible = "mediatek,mt8196-cpufreq-hw";
> +            reg = <0 0xc2c2034 0 0x4>, <0 0xc220400 0 0x20>,
> +                  <0 0xc2c0f20 0 0x120>, <0 0xc2c1040 0 0x120>,
> +                  <0 0xc2c1160 0 0x120>;
> +            #performance-domain-cells = <1>;
> +        };
> +    };
> 

