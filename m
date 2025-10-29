Return-Path: <linux-pm+bounces-36998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5EC17BF0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 02:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488F51C831D1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA02D7DFB;
	Wed, 29 Oct 2025 01:05:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ABE2DA762
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699915; cv=none; b=jdY6syttpQElbCtWhbUUJF0g4rDeFRldGr4uWNL96xuDkvJa11JEHerxXv+0yQqL4sNT97kAfwXlmSO841OFvDEvLdfFuIY0nm1kkMqmPdllAmDXPKPrsFWFWZdoO0qLz5e8VL2aXrKIZU/SFoI6VFHg2OCTTfi+i49CbJ6iEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699915; c=relaxed/simple;
	bh=2gEXBV/GmnVYpOOK7VRqlBYbIREZJBxWWgWbeuGCpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzxdxIsufYGSc67xrK//GlTN853y32bWLj5OabCkXbyMYAcjCiBAtz6rxVVHug8HP1fRG7sMbi4HETT4q6lHzHIkYfmLYXT76/1Sz7hKh4weICjBE4q5uqnVwl0drGKyryozVnnX6027syG6/xme+DLUTi1OXoe3ztMWqayIRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408502972
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 18:05:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D277C3F63F
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 18:05:12 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:04:42 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 1/5] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <aQFoKoWIlf7xPzZX@e110455-lin.cambridge.arm.com>
References: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <20251017-mt8196-gpufreq-v8-1-98fc1cc566a1@collabora.com>
 <aQD5gwByEmX6GQK9@e110455-lin.cambridge.arm.com>
 <6599426.lOV4Wx5bFT@workhorse>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6599426.lOV4Wx5bFT@workhorse>

On Tue, Oct 28, 2025 at 09:51:43PM +0100, Nicolas Frattaroli wrote:
> On Tuesday, 28 October 2025 18:12:35 Central European Standard Time Liviu Dudau wrote:
> > On Fri, Oct 17, 2025 at 05:31:08PM +0200, Nicolas Frattaroli wrote:
> > > The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> > > control the power and frequency of the GPU. This is modelled as a power
> > > domain and clock provider.
> > > 
> > > It lets us omit the OPP tables from the device tree, as those can now be
> > > enumerated at runtime from the MCU.
> > > 
> > > Add the necessary schema logic to handle what this SoC expects in terms
> > > of clocks and power-domains.
> > > 
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 37 +++++++++++++++++++++-
> > >  1 file changed, 36 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > index 613040fdb444..860691ce985e 100644
> > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > @@ -45,7 +45,9 @@ properties:
> > >      minItems: 1
> > >      items:
> > >        - const: core
> > > -      - const: coregroup
> > > +      - enum:
> > > +          - coregroup
> > > +          - stacks
> > >        - const: stacks
> > 
> > I'm not sure how to parse this part of the change. We're overwriting the property
> > for mt8196-mali anyway so why do we need this? And if we do, should 'stacks'
> > still remain as a const?
> 
> The properties section outside of the if branches outside here
> specifies a pattern of properties that matches for all devices.
> 
> In this case, I changed it so that the second clock-names item
> may either be "coregroup" or "stacks".

Why would we want to do that for non-MT8196 devices? It doesn't make sense to me.
The overwrite in the if branch should be enough to give you want you want (i.e.
core followed by stacks and only that).

> Yes, the third "stacks"
> remains, though if you wanted to be extra precise you could
> then specify in the non-MT8196 cases that we should not have
> stacks followed by stacks, but I'd wager some checker for
> duplicate names may already catch that.
> 
> However, I don't think it's a big enough deal to reroll this
> series again.

I'm not asking you to re-roll the series but if you agree to drop that
part I can make the edit when merging it.

Best regards,
Liviu

> 
> Kind regards,
> Nicolas Frattaroli
> 
> > 
> > Best regards,
> > Liviu
> > 
> > >  
> > >    mali-supply: true
> > > @@ -110,6 +112,27 @@ allOf:
> > >          power-domain-names: false
> > >        required:
> > >          - mali-supply
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: mediatek,mt8196-mali
> > > +    then:
> > > +      properties:
> > > +        mali-supply: false
> > > +        sram-supply: false
> > > +        operating-points-v2: false
> > > +        power-domains:
> > > +          maxItems: 1
> > > +        power-domain-names: false
> > > +        clocks:
> > > +          maxItems: 2
> > > +        clock-names:
> > > +          items:
> > > +            - const: core
> > > +            - const: stacks
> > > +      required:
> > > +        - power-domains
> > >  
> > >  examples:
> > >    - |
> > > @@ -145,5 +168,17 @@ examples:
> > >              };
> > >          };
> > >      };
> > > +  - |
> > > +    gpu@48000000 {
> > > +        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
> > > +        reg = <0x48000000 0x480000>;
> > > +        clocks = <&gpufreq 0>, <&gpufreq 1>;
> > > +        clock-names = "core", "stacks";
> > > +        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +        interrupt-names = "job", "mmu", "gpu";
> > > +        power-domains = <&gpufreq>;
> > > +    };
> > >  
> > >  ...
> > > 
> > 
> > 
> 
> 
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

