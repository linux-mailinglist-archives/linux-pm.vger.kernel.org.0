Return-Path: <linux-pm+bounces-34152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91624B48C60
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 13:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398FE178D6D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA52E5D32;
	Mon,  8 Sep 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="K7j2MwVO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750881D5150;
	Mon,  8 Sep 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331607; cv=pass; b=Ev/2eHFN8XWJB5SpGmD96kwy/fZX3DTY+dSNMKfQhj1dJ6B+RkQDMGP6ojIFFUYMUrqsl3iUsUBb4gShIzYB/aMBiCUtndE2Sz8sl2q7jP4kCZCVoTpdFpVTCGxiWAVHXu0dgtM2Qy+JdLlHzPFSCJYtNARhRMGueph5OAZST6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331607; c=relaxed/simple;
	bh=7zokCaSsHK1OO5NiBsZNa1inJBlW3NJSXtUZeqoDd3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjpYn5BDBi922xy1PRYYvrIwWyNuNjNhmx6Nm1M6GF7EcuGEIMrxIR7p0I4pBxDk0m1EdUoEMsTuQiAKZbwGNg3RQfABswze8d+qPqhTW7011c1i+uDZt70rs7GxPUvE01OYeHMPsvJKG3k60mER3yRTB5iIJ1c1e45B0nK5hvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=K7j2MwVO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757331570; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FpCFBjdunJYDQZO8Sl/1iHbM7xvTYEJrMQj5hU2aBLeV0rARUKpM900iW7LP0F6cy2vHmR4IoPY4Jr4p01yZ/K9/w3Ot1YPJVkR9escP+pIC75Gr6fDDYsuRg2sqOWV7DB0raCV1etLYPwWW1Q5GveBa9lHHNS8ihJe7y5UQkqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757331570; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gRQoLoiYkRP6MlyyPTW+Dors9FVZA1czDggHKxBtKHA=; 
	b=ngTV6qSGZ1it10nRAXb/Len20ts3aHPOGvtjvwih6zWBIvOwx9G642MHAvD7kUWNe3YBQk/QgaOG4nbdlxkt4w8/baP+1euQrha8vieNhhMcC8hej7Spi3pswTHde7JbjR3/z5S/TpPeRGpHg9EQF4SpiS6NpdR39MJJ3aoFmpc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757331570;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=gRQoLoiYkRP6MlyyPTW+Dors9FVZA1czDggHKxBtKHA=;
	b=K7j2MwVOdbC52N2WSfnVp6idXCa82wamXcxmV86qoPrle3HzOg8eAb8ERRnwpLc5
	KktAgYRMTwXVnuntuB+XZh4urwAFYjYywjiqI/rE1YjDaiqnJ8/juZNNJog5/fonWoA
	K5ONU00oIHmw1nCxBSKvG/lYDRhuxrwzXbNRiBg0=
Received: by mx.zohomail.com with SMTPS id 1757331569123372.0975001366197;
	Mon, 8 Sep 2025 04:39:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
Subject:
 Re: [PATCH RFC 02/10] dt-bindings: devfreq: add mt8196-gpufreq binding
Date: Mon, 08 Sep 2025 13:39:22 +0200
Message-ID: <13857717.uLZWGnKmhe@workhorse>
In-Reply-To: <751d3abc-cf40-40a2-a580-7c0ba425ac25@collabora.com>
References:
 <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-2-7b6c2d6be221@collabora.com>
 <751d3abc-cf40-40a2-a580-7c0ba425ac25@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 8 September 2025 13:15:03 Central European Summer Time AngeloGioacchino Del Regno wrote:
> Il 05/09/25 12:22, Nicolas Frattaroli ha scritto:
> > On the MediaTek MT8196 SoC, the GPU has its power and frequency
> > dynamically controlled by an embedded special-purpose MCU. This MCU is
> > in charge of powering up the GPU silicon. It also provides us with a
> > list of available OPPs at runtime, and is fully in control of all the
> > regulator and clock fiddling it takes to reach a certain level of
> > performance. It's also in charge of enforcing limits on power draw or
> > temperature.
> > 
> > Add a binding for this device in the devfreq subdirectory, where it
> > seems to fit in best considering its tasks.
> > 
> > The functions of many of the mailbox channels are unknown. This is not
> > the fault of this binding's author; we've never received adequate
> > documentation for this hardware, and the downstream code does not make
> > use of them in a way that'd reveal their purpose. They are kept in the
> > binding as the binding should be complete.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   .../bindings/devfreq/mediatek,mt8196-gpufreq.yaml  | 116 +++++++++++++++++++++
> >   1 file changed, 116 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1fe43c9fc94bb603b1fb77e9a97a27e92fea1ae8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/devfreq/mediatek,mt8196-gpufreq.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MFlexGraphics Performance Controller
> 
> Doesn't MFG stand for MediaTek Flexible Graphics? (or did they update the name?)
> 
> Perhaps it's a good idea to also add that reference... I think it's a little more
> readable and understandable compared to "MFlexGraphics" :-)

"MFlexGraphics" is what the abbreviation section in the datasheet calls "MFG".
I don't see "Flexible Graphics" at all in the datasheet, but it's an obvious
inference of what the name means.

I think keeping "MFlexGraphics" is better for people grepping for what
the datasheet calls it.

> 
> > +
> > +maintainers:
> > +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^performance-controller@[a-f0-9]+$'
> > +
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8196-gpufreq
> > +
> > +  reg:
> > +    items:
> > +      - description: GPR memory area
> > +      - description: RPC memory area
> > +      - description: SoC variant ID register
> > +
> > +  reg-names:
> > +    items:
> > +      - const: gpr
> > +      - const: rpc
> > +      - const: e2_id
> 
> We should find a better name for that "e2_id".

Agreed, but we don't have a register map that includes this address
and would give us a different name. I think it's some sort of silicon
revision.

> 
> > +
> > +  clocks:
> > +    items:
> > +      - description: main clock of the embedded controller (EB)
> > +      - description: core PLL
> > +      - description: stack 0 PLL
> > +      - description: stack 1 PLL
> > +
> > +  clock-names:
> > +    items:
> > +      - const: eb
> > +      - const: mfgpll
> > +      - const: mfgpll_sc0
> > +      - const: mfgpll_sc1
> > +
> > +  mboxes:
> > +    items:
> > +      - description: FastDVFS events
> > +      - description: frequency control
> > +      - description: sleep control
> > +      - description: timer control
> > +      - description: frequency hopping control
> > +      - description: hardware voter control
> > +      - description: gpumpu (some type of memory control, unknown)
> > +      - description: FastDVFS control
> > +      - description: Unknown
> > +      - description: Unknown
> > +      - description: Unknown, but likely controls some boosting behaviour
> > +      - description: Unknown
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: fast_dvfs_event
> 
> Any problem if we avoid underscores in names?
> 

No but I'm not sure what the canonical naming style is for mailbox
channels. "fastdvfsevent" is hard to read.

> > +      - const: gpufreq
> > +      - const: sleep
> > +      - const: timer
> > +      - const: fhctl
> > +      - const: ccf
> > +      - const: gpumpu
> 
> "some type of memory control" .. it's really a MPU. For memory protection. :-)
> Besides, I don't think we have to touch anything in the gpumpu for freq control
> via gpueb.
> 

Gotcha, so should I leave it out of the GPUFreq binding's used channels?

Would leave a gap, but that's probably fine.

> > +      - const: fast_dvfs
> > +      - const: ipir_c_met
> > +      - const: ipis_c_met
> 
> MET is a hardware event tracer / profiler... and I'm fairly sure that we have no
> real reason to support it (at least, not like that, and not in a first submission).
> 
> Ah btw: ipir ipis .. ipi-receive ipi-send
> 

Gotcha, will remove those as well.

> > +      - const: brisket
> 
> Brisket is... something. There's one for the GPU, one for CPU, and one for APU.
> Not sure what it exactly does, but seems to be or control a FLL (freq locked loop).
> 
> > +      - const: ppb
> 
> PPB = Peak Power Budget
> 
> The PPB needs its own "big" driver (the PBM - Power Budget Manager) in order to do
> anything - as in - this manages a SoC-global peak power setting based on the
> available maximum deliverable instantaneous (and/or sustainable) power from the
> board's power source and it is mainly used for smartphone usecase (battery!).
> 
> In order to work, the PPB HW (yet another mcu) needs to be initialized with tables
> for CPU and GPU (and APU? and something else too?), and with other data explaining
> the maximum instantaneous power that can delivered at a certain battery percentage.
> 
> Important point is... I doubt that PPB is being initialized by the bootloader, on
> all of Genio, Kompanio and Dimensity chips, so this should be disabled by default.
> 
> You can keep it, especially now that you have a description for it - and because it
> does indeed exist, but I doubt that we're using this anytime soon.

If it's going to be used by a separate driver, wouldn't it be better if we don't make
this channel part of the channels the GPUFreq driver uses?

> 
> Cheers,
> Angelo
> 

Kind regards,
Nicolas Frattaroli

> > +
> > +  shmem:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the shared memory region of the GPUEB MCU
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - mboxes
> > +  - mbox-names
> > +  - shmem
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
> > +
> > +    gpufreq: performance-controller@4b09fd00 {
> > +        compatible = "mediatek,mt8196-gpufreq";
> > +        reg = <0x4b09fd00 0x80>,
> > +              <0x4b800000 0x1000>,
> > +              <0x4b860128 0x4>;
> > +        reg-names = "gpr", "rpc", "e2_id";
> > +        clocks = <&topckgen CLK_TOP_MFG_EB>,
> > +                 <&mfgpll CLK_MFG_AO_MFGPLL>,
> > +                 <&mfgpll_sc0 CLK_MFGSC0_AO_MFGPLL_SC0>,
> > +                 <&mfgpll_sc1 CLK_MFGSC1_AO_MFGPLL_SC1>;
> > +        clock-names = "eb", "mfgpll", "mfgpll_sc0",
> > +                      "mfgpll_sc1";
> > +        mboxes = <&gpueb_mbox 0>, <&gpueb_mbox 1>, <&gpueb_mbox 2>,
> > +                 <&gpueb_mbox 3>, <&gpueb_mbox 4>, <&gpueb_mbox 5>,
> > +                 <&gpueb_mbox 6>, <&gpueb_mbox 7>, <&gpueb_mbox 8>,
> > +                 <&gpueb_mbox 9>, <&gpueb_mbox 10>, <&gpueb_mbox 11>;
> > +        mbox-names = "fast_dvfs_event", "gpufreq", "sleep", "timer", "fhctl",
> > +                     "ccf", "gpumpu", "fast_dvfs", "ipir_c_met", "ipis_c_met",
> > +                     "brisket", "ppb";
> > +        shmem = <&gpufreq_shmem>;
> > +    };
> > 
> 
> 





