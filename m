Return-Path: <linux-pm+bounces-37036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2BDC1B20F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FF3664CE4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAA3590BD;
	Wed, 29 Oct 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="LASV/cyg"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A763590B6;
	Wed, 29 Oct 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745402; cv=pass; b=s5SEqGEAiGd8iNq+fcZ71NQdk5+sjQVBXBQB9G0FmrUuZuaSQBov5KNExnS/0+cG72sQOb09kPoAbyip3tcsju4VZDWGdBkh/V3XYcOGablVmR/OdtF6GZuVxJdUMKrWw9lGREfeN8H5RMo+Oj2z4+xjutPXn6WQ5pGfOWWvoAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745402; c=relaxed/simple;
	bh=RY7vIE6z4lot2dk7TULpGj0i+kPxWFQ2MUV3o/PNhJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQoPYN5C23f4cuLvcCfBbB0wm1np5wf/5D8rKfhNVW1lCEGaQ6m0nh/gp56jN+Dj6YVkuY55OSf3oVTb8Gr0m2revyqKwEmz9OmaWhJ2XBv8Vs8bShODsV5NNVCRnunChKqvF0YClacQr9wvMuTfD/3/M4cHGdsLc5Ok7htAxek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=LASV/cyg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761745368; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h81/onpIhYuOCsTcPr2Gb7oyfd6fwWRgmZfIiuKae/fi7j/hjGCuuYrBGarMhSDAKCfwA28rnso+zZQMxPUmCi6eIhjrL03Y3K4dB+UxWoUm7LhCNUinoLZEJ2QIkJvEq4SBnxRnP7Nu+W4141TMnPAWTtvWbDt1A9jK7ILPCTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761745368; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cCR0jfooCQaKWozmb+jsMis00qYqqul+/rxMzKmTmmU=; 
	b=QWwS5nxkTyBuPq20xvTojtXG88OqLd9AyJQQg+Dt7irE8knaTFpeqxTaQ8sQOcNAXK0X96MuqooGU2bzrb4/SAiTu5E2Jy7Qn2rU2Wntkq1nx2eSaJJtgyAYHXe6XmJbt8HnlVZzDqcObtE/yYanhq7g/0y6sfQHzOCsvdkgzbo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761745368;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=cCR0jfooCQaKWozmb+jsMis00qYqqul+/rxMzKmTmmU=;
	b=LASV/cygFhk1DIFxrCeAprpl0JheXlhFKTAMzj7BjyJr2bUJ4pkbvBMfygwZCfjw
	/9w/C72PZe2STjMJRGAydRx3ki3/vFUMx20PWlv1lI9zldmnqRU7v5aAGwm95ik7yH2
	IRpnEbpvBjbCdCs5vNnowjfeoKcb/hJFBLXS8Q7U=
Received: by mx.zohomail.com with SMTPS id 1761745366137989.9389961258449;
	Wed, 29 Oct 2025 06:42:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>, Rob Herring <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v8 1/5] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Date: Wed, 29 Oct 2025 14:42:35 +0100
Message-ID: <3127655.ElGaqSPkdT@workhorse>
In-Reply-To: <aQFoKoWIlf7xPzZX@e110455-lin.cambridge.arm.com>
References:
 <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <6599426.lOV4Wx5bFT@workhorse>
 <aQFoKoWIlf7xPzZX@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 29 October 2025 02:04:42 Central European Standard Time Liviu Dudau wrote:
> On Tue, Oct 28, 2025 at 09:51:43PM +0100, Nicolas Frattaroli wrote:
> > On Tuesday, 28 October 2025 18:12:35 Central European Standard Time Liviu Dudau wrote:
> > > On Fri, Oct 17, 2025 at 05:31:08PM +0200, Nicolas Frattaroli wrote:
> > > > The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> > > > control the power and frequency of the GPU. This is modelled as a power
> > > > domain and clock provider.
> > > > 
> > > > It lets us omit the OPP tables from the device tree, as those can now be
> > > > enumerated at runtime from the MCU.
> > > > 
> > > > Add the necessary schema logic to handle what this SoC expects in terms
> > > > of clocks and power-domains.
> > > > 
> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > > ---
> > > >  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 37 +++++++++++++++++++++-
> > > >  1 file changed, 36 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > > index 613040fdb444..860691ce985e 100644
> > > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > > @@ -45,7 +45,9 @@ properties:
> > > >      minItems: 1
> > > >      items:
> > > >        - const: core
> > > > -      - const: coregroup
> > > > +      - enum:
> > > > +          - coregroup
> > > > +          - stacks
> > > >        - const: stacks
> > > 
> > > I'm not sure how to parse this part of the change. We're overwriting the property
> > > for mt8196-mali anyway so why do we need this? And if we do, should 'stacks'
> > > still remain as a const?
> > 
> > The properties section outside of the if branches outside here
> > specifies a pattern of properties that matches for all devices.
> > 
> > In this case, I changed it so that the second clock-names item
> > may either be "coregroup" or "stacks".
> 
> Why would we want to do that for non-MT8196 devices? It doesn't make sense to me.
> The overwrite in the if branch should be enough to give you want you want (i.e.
> core followed by stacks and only that).

I built my understanding of why on the same reason of why we specify
a minItems of 1 but require it to be 3 in the if branch of the only
other compatible (rk3588): it describes what may be found in those
properties, not what is required by the specific compatible preceding
the generic valhall compatible. arm,mali-valhall-csf is currently
not described as a compatible that's allowed to appear stand-alone
without some other compatible before it to specify further which SoC
it's on, so it really just is whatever RK3588 needs vs. whatever
MT8196 needs at the moment.

Arguably though, there's no functional difference here, and I'm not
aware on any rules regarding this. My change may be problematic
however, because of the whole double stacks thing.

> > Yes, the third "stacks"
> > remains, though if you wanted to be extra precise you could
> > then specify in the non-MT8196 cases that we should not have
> > stacks followed by stacks, but I'd wager some checker for
> > duplicate names may already catch that.
> > 
> > However, I don't think it's a big enough deal to reroll this
> > series again.
> 
> I'm not asking you to re-roll the series but if you agree to drop that
> part I can make the edit when merging it.

If the other DT maintainers (especially Rob who gave it his R-b)
are okay with dropping it, then yes please do.

Kind regards,
Nicolas Frattaroli

> 
> Best regards,
> Liviu
> 
> > 
> > Kind regards,
> > Nicolas Frattaroli
> > 
> > > 
> > > Best regards,
> > > Liviu
> > > 
> > > >  
> > > >    mali-supply: true
> > > > @@ -110,6 +112,27 @@ allOf:
> > > >          power-domain-names: false
> > > >        required:
> > > >          - mali-supply
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: mediatek,mt8196-mali
> > > > +    then:
> > > > +      properties:
> > > > +        mali-supply: false
> > > > +        sram-supply: false
> > > > +        operating-points-v2: false
> > > > +        power-domains:
> > > > +          maxItems: 1
> > > > +        power-domain-names: false
> > > > +        clocks:
> > > > +          maxItems: 2
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: core
> > > > +            - const: stacks
> > > > +      required:
> > > > +        - power-domains
> > > >  
> > > >  examples:
> > > >    - |
> > > > @@ -145,5 +168,17 @@ examples:
> > > >              };
> > > >          };
> > > >      };
> > > > +  - |
> > > > +    gpu@48000000 {
> > > > +        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
> > > > +        reg = <0x48000000 0x480000>;
> > > > +        clocks = <&gpufreq 0>, <&gpufreq 1>;
> > > > +        clock-names = "core", "stacks";
> > > > +        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
> > > > +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
> > > > +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
> > > > +        interrupt-names = "job", "mmu", "gpu";
> > > > +        power-domains = <&gpufreq>;
> > > > +    };
> > > >  
> > > >  ...
> > > > 
> > > 
> > > 
> > 
> > 
> > 
> > 
> 
> 





