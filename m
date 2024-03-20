Return-Path: <linux-pm+bounces-5157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B98814B5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4195B282A76
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AA524B7;
	Wed, 20 Mar 2024 15:37:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DBF4D107;
	Wed, 20 Mar 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949067; cv=none; b=pkGtvOKLkzI6+HtETzStrE6wT0z7U8Wf7ygUU88uvxzqIpDHwDrCVgXB7iEZxTKTBYmt2Z3amMPlekrIk2j9AODJm+KaXG4McwP9yGzFnZd52+4gMRmNBpmtr15/qsoDa+oh8aAuau6ZCKIYZbBYFQJdZJbEQgbqRoluYjrqivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949067; c=relaxed/simple;
	bh=GX3wHvEKI8/4Ai1Ub8/EJN4vsGERZuQiIQ3nehWyWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIvvCl9iSZlLC1PiQviHWAJQ/USFzhLfqEgheUynU7gtTO1gWKFs9kP/5PzuonEYNaRmnR3B73GlCWfUhhUlesY5Ce9uNTrtA/n/eftKA/C/s4ca1LP7XBTxyBEOlFNyium1qU4p+UHcihHxuPaVxOURJSztJbDTL/W26mMh+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2BF1007;
	Wed, 20 Mar 2024 08:38:17 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05FAD3F64C;
	Wed, 20 Mar 2024 08:37:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:37:38 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: opp: Describe H616 OPPs and
 opp-supported-hw
Message-ID: <20240320153738.3e2410bf@donnerap.manchester.arm.com>
In-Reply-To: <20240320150228.GA1705913-robh@kernel.org>
References: <20240318011228.2626-1-andre.przywara@arm.com>
	<20240318011228.2626-4-andre.przywara@arm.com>
	<20240320150228.GA1705913-robh@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 10:02:28 -0500
Rob Herring <robh@kernel.org> wrote:

Hi Rob,

thanks for having a look.

> On Mon, Mar 18, 2024 at 01:12:23AM +0000, Andre Przywara wrote:
> > From: Martin Botka <martin.botka@somainline.org>
> > 
> > The Allwinner H616 uses a similar NVMEM based mechanism to determine the
> > silicon revision, which is required to select the right frequency /
> > voltage pair for the OPPs.
> > However it limits the maximum frequency for some speedbins, which
> > requires to introduce the opp-supported-hw property.
> > 
> > Add this property to the list of allowed properties, also drop the
> > requirement for the revision specific opp-microvolt properties, since
> > they won't be needed if using opp-supported-hw. When using this
> > property, we also might have multiple OPP nodes per frequency, so relax
> > the OPP node naming to allow a single letter suffix.
> > 
> > Also use to opportunity to adjust some wording, and drop a sentence
> > referring to the Linux driver and the OPP subsystem.
> > 
> > Shorten the existing example and add another example, showcasing the
> > opp-supported-hw property.
> > 
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../allwinner,sun50i-h6-operating-points.yaml | 89 ++++++++++---------
> >  1 file changed, 47 insertions(+), 42 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> > index 51f62c3ae1947..d5439a3f696bc 100644
> > --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> > +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> > @@ -13,25 +13,25 @@ maintainers:
> >  description: |
> >    For some SoCs, the CPU frequency subset and voltage value of each
> >    OPP varies based on the silicon variant in use. Allwinner Process
> > -  Voltage Scaling Tables defines the voltage and frequency value based
> > -  on the speedbin blown in the efuse combination. The
> > -  sun50i-cpufreq-nvmem driver reads the efuse value from the SoC to
> > -  provide the OPP framework with required information.
> > +  Voltage Scaling Tables define the voltage and frequency values based
> > +  on the speedbin blown in the efuse combination.
> >  
> >  allOf:
> >    - $ref: opp-v2-base.yaml#
> >  
> >  properties:
> >    compatible:
> > -    const: allwinner,sun50i-h6-operating-points
> > +    enum:
> > +      - allwinner,sun50i-h6-operating-points
> > +      - allwinner,sun50i-h616-operating-points
> >  
> >    nvmem-cells:
> >      description: |
> >        A phandle pointing to a nvmem-cells node representing the efuse
> > -      registers that has information about the speedbin that is used
> > +      register that has information about the speedbin that is used
> >        to select the right frequency/voltage value pair. Please refer
> > -      the for nvmem-cells bindings
> > -      Documentation/devicetree/bindings/nvmem/nvmem.txt and also
> > +      to the nvmem-cells bindings in
> > +      Documentation/devicetree/bindings/nvmem/nvmem.yaml and also the
> >        examples below.
> >  
> >    opp-shared: true
> > @@ -41,21 +41,23 @@ required:
> >    - nvmem-cells
> >  
> >  patternProperties:
> > -  "^opp-[0-9]+$":
> > +  "^opp-[0-9]+(-[a-z])?$":
> >      type: object
> >  
> >      properties:
> >        opp-hz: true
> >        clock-latency-ns: true
> > +      opp-microvolt: true
> > +      opp-supported-hw:
> > +        description: |
> > +          A single 32 bit bitmap value, representing compatible HW, one
> > +          bit per speed bin index.
> >  
> >      patternProperties:
> >        "^opp-microvolt-speed[0-9]$": true
> >  
> >      required:
> >        - opp-hz
> > -      - opp-microvolt-speed0
> > -      - opp-microvolt-speed1
> > -      - opp-microvolt-speed2
> >  
> >      unevaluatedProperties: false
> >  
> > @@ -77,58 +79,61 @@ examples:
> >              opp-microvolt-speed2 = <800000>;
> >          };
> >  
> > -        opp-720000000 {
> > +        opp-1080000000 {
> >              clock-latency-ns = <244144>; /* 8 32k periods */
> > -            opp-hz = /bits/ 64 <720000000>;
> > +            opp-hz = /bits/ 64 <1080000000>;
> >  
> > -            opp-microvolt-speed0 = <880000>;
> > -            opp-microvolt-speed1 = <820000>;
> > -            opp-microvolt-speed2 = <800000>;
> > +            opp-microvolt-speed0 = <1060000>;
> > +            opp-microvolt-speed1 = <880000>;
> > +            opp-microvolt-speed2 = <840000>;
> >          };
> >  
> > -        opp-816000000 {
> > +        opp-1488000000 {
> >              clock-latency-ns = <244144>; /* 8 32k periods */
> > -            opp-hz = /bits/ 64 <816000000>;
> > +            opp-hz = /bits/ 64 <1488000000>;
> >  
> > -            opp-microvolt-speed0 = <880000>;
> > -            opp-microvolt-speed1 = <820000>;
> > -            opp-microvolt-speed2 = <800000>;
> > +            opp-microvolt-speed0 = <1160000>;
> > +            opp-microvolt-speed1 = <1000000>;
> > +            opp-microvolt-speed2 = <960000>;
> >          };
> > +    };
> > +
> > +  - |
> > +    opp-table {
> > +        compatible = "allwinner,sun50i-h616-operating-points";
> > +        nvmem-cells = <&speedbin_efuse>;
> > +        opp-shared;
> >  
> > -        opp-888000000 {
> > +        opp-480000000 {
> >              clock-latency-ns = <244144>; /* 8 32k periods */
> > -            opp-hz = /bits/ 64 <888000000>;
> > +            opp-hz = /bits/ 64 <480000000>;
> >  
> > -            opp-microvolt-speed0 = <940000>;
> > -            opp-microvolt-speed1 = <820000>;
> > -            opp-microvolt-speed2 = <800000>;
> > +            opp-microvolt = <900000>;
> > +            opp-supported-hw = <0x1f>;
> >          };
> >  
> > -        opp-1080000000 {
> > +        opp-792000000-l {
> >              clock-latency-ns = <244144>; /* 8 32k periods */
> > -            opp-hz = /bits/ 64 <1080000000>;
> > +            opp-hz = /bits/ 64 <792000000>;
> >  
> > -            opp-microvolt-speed0 = <1060000>;
> > -            opp-microvolt-speed1 = <880000>;
> > -            opp-microvolt-speed2 = <840000>;
> > +            opp-microvolt = <900000>;
> > +            opp-supported-hw = <0x02>;
> >          };
> >  
> > -        opp-1320000000 {
> > +        opp-792000000-h {
> >              clock-latency-ns = <244144>; /* 8 32k periods */
> > -            opp-hz = /bits/ 64 <1320000000>;
> > +            opp-hz = /bits/ 64 <792000000>;
> >  
> > -            opp-microvolt-speed0 = <1160000>;
> > -            opp-microvolt-speed1 = <940000>;
> > -            opp-microvolt-speed2 = <900000>;
> > +            opp-microvolt = <940000>;
> > +            opp-supported-hw = <0x10>;  
> 
> So far, we've avoided multiple entries for a single frequency. I think 
> it would be good to maintain that.

Fair, I wasn't super happy with that either, but it still seemed better
than the alternatives.

> Couldn't you just do:
> 
> opp-supported-hw = <0>, <0x10>, <0x02>;
> 
> Where the index corresponds to speed0, speed1, speed2.
> 
> If not, then I don't understand how multiple entries of opp-supported-hw 
> are supposed to work.

If I got this correctly, multiple cells in opp-supported-hw are to
describe various levels of hierarchy for a chip version, so like silicon
mask, metal layer revision, bin, I guess? The binding doc speaks of "cuts,
substrate and process", not really sure what that means exactly.

I think currently we cannot easily combine microvolt suffixes and
opp-supported-hw in one OPP node? I think it bails out if one
microvolt-speed<x> property is missing, but I have to double check.
But IIRC v1 of this series somehow pulled that off, so we can maybe bring
it back? To end up with:
	opp-792 {
		opp-hz = <792000000>;
		opp-microvolt-speed1 = <900000>;
		opp-microvolt-speed4 = <940000>;
		opp-supported-hw = <0x12>;
	};
	opp-1512 {
		opp-hz = <1512000000>;
		opp-microvolt = <1100000>;
		opp-supported-hw = <0x0a>;
	};

I chose the way that's described in this patch because it seemed shorter,
but I am afraid none of the versions is really nice here. What they in
fact are is quite different OPP tables for each speedbin, with a
different set of frequencies, for unknown reasons. Is there a way to select
one of multiple *tables*, each with their individual, but simple set of
voltage/freq pairs?

This is what they look like in table format, btw:
         0       1       2       3       4
480     900     900     900     900     900
600     -       -       -       -       900
720     900     -       900     900     -
792     -       900     -       -       940
936     900     -       900     900     -
1008    950     940     950     950     1020
1104    1000    -       1000    1000    -
1200    1050    1020    1050    1050    1100
1320    1100    -       1100    1100    1100
1416    1100    -       1100    1100    -
1512    -       1100    -       1100    -

I was wondering if we should fill those gaps, by putting in the voltage
from the next higher OPP? Then we could use the microvolt suffixes, except
for the last two frequencies, where we use opp-supported-hw?

Cheers,
Andre

