Return-Path: <linux-pm+bounces-23200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B5A4A481
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365591701DE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449341CB9F0;
	Fri, 28 Feb 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncCt9+6O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F21C84C3;
	Fri, 28 Feb 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776994; cv=none; b=dotLZquAwEWZp3SzlN9+rtjfKvq0VmLhRJt5n6z1wCMa+N2EM0HzdxPdOeDTaIFujprQAfJCBA2Vsl5msJiYRd8Q5wQDUwDr7zrKwxqcapuagz7cEz7bKAvQbULZXmuv0U42uAyHE/EFeQ5TUMpsZ034VPSNv9736SWTi27kWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776994; c=relaxed/simple;
	bh=7/U8iCK7D2OmaLt/mLjSMyZ4HHGedptSkAghoSNVdR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9Qk7L+Rb3LAXuikW1CvJOfTnIw9+euP9WIHApRV6dWpdkT+Bb8Vtf/OID9VEtbTTrY0jEUl+b766drJw52WM4eXEKCDNOGbK+Y7x4u+FvSOw5e4THq81UwMf43Hk9CaATT1RMZqzJlg6cC6h5ZP+ThOQQX2fNhDCx5rAbUCR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncCt9+6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4504AC4CED6;
	Fri, 28 Feb 2025 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740776993;
	bh=7/U8iCK7D2OmaLt/mLjSMyZ4HHGedptSkAghoSNVdR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncCt9+6O2jp3/i9DzHgh2AiW0gV8u83t8GiagV54aYXYuX4ucGyeDhfhUcylciR9e
	 QgX9KI+t75Knp5nMwry11emnGByFvS6Rw7hhT6dsKMmhzaSHUm2wIdrWfwRPBfrLgD
	 TMHG8Rql1XtDoLPuejlV/Ukndp+C5rt+/z4KGsbd3nHCogN0XpN9XS4nJoRzO804ny
	 Ptxhjq3nBW7PYhTDXfn2mvAW3x1p1A2cDNkEFendNZVmwb+R3L+UR8VBb+i29Tn8Wc
	 IcXlVID0YMj+1qBMD7K8soE3wPlyi6sQIdP39Eu1NZRz1sdezNKOHj4rUyY0tUXFOm
	 J3iJ6ZlLJP/sw==
Date: Fri, 28 Feb 2025 15:09:51 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org,
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250228210951.GA3720389-robh@kernel.org>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-shampoo-uprising-44ae0d3bd68b@spud>

On Fri, Feb 28, 2025 at 07:03:05PM +0000, Conor Dooley wrote:
> On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
> > to measure the junction temperature. The device provides real-time temperature
> > measurements for thermal management, utilizing a single dedicated channel
> > (channel 1) for temperature sensing.
> > 
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> > v1 -> v2:
> >  * Fix reg property specifier to get rid of yamlint warnings
> >  * Fix IRQ name to reflect TSU expectations
> > 
> >  .../thermal/renesas,r9a09g047-tsu.yaml        | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > new file mode 100644
> > index 000000000000..e786561ddbe3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/renesas,r9a09g047-tsu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G3E Temperature Sensor Unit (TSU)
> > +
> > +maintainers:
> > +  - John Madieu <john.madieu.xa@bp.renesas.com>
> > +
> > +description:
> > +  The Temperature Sensor Unit (TSU) is an integrated thermal sensor that
> > +  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU provides
> > +  real-time temperature measurements for thermal management.
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r9a09g047-tsu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      Interrupt specifiers for the TSU:
> > +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> > +      - S12TSUADCMPI1: Comparison result interrupt signal (level)
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: adi
> > +      - const: adcmpi
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 0
> > +
> > +  renesas,tsu-calibration-sys:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the system controller (sys) that contains the TSU
> > +      calibration values used for temperature calculations.
> > +
> > +  renesas,tsu-operating-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description: |
> > +      TSU operating mode:
> > +      0: Mode 0 - Conversion started by software
> > +      1: Mode 1 - Conversion started by ELC trigger
> 
> Can you make this "software" and "elc" or something please, unless
> people will genuinely find "0" and 1" to be more informative.
> And why doesn't the property have a default?

Or just make it boolean.

Who/what decides the mode? If a user is going to want to change this, 
then it should be a runtime control, not a DT property.

Rob

