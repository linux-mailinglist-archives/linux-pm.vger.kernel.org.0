Return-Path: <linux-pm+bounces-38056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC8C5E6C4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 022EB383CF6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDDE33556E;
	Fri, 14 Nov 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiHuM5Q9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EE335549;
	Fri, 14 Nov 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138397; cv=none; b=JnT0N0VeAnchB67Lxx5K1zWuKpWH0CGQ6KjvIrmBDDTDH69h/7lGB/HiZzJC6T/WASN1tWE4TmqUuZgmvp1+q8NIrynrl05H1F+rp+lF5+fSNxOfvQ1KCrae5e02FXUv92OwK0Avai8nRuFWuDveZUdVm1DSr3Udfc7H/g2rOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138397; c=relaxed/simple;
	bh=bLsvvHPDpo7u9K8rvsM02ueTdodp270jX2AjxuPSOVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXfd/WJJga/03L1tsbt9DSVDQCeFbgN+4qKYJ2xGsYBqidIPuB08qqUMcXepLP3ENBnNcqLXJ1J4dQ0/tsbG1F0qnjhqL6dR0H8AAOYggYFNj6sTjkCEfRT++ndHoIjEm2+LgSeDULwuq8wtfjWFJmWRwyDBure/hvkst3fzg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiHuM5Q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8814AC4CEF5;
	Fri, 14 Nov 2025 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763138396;
	bh=bLsvvHPDpo7u9K8rvsM02ueTdodp270jX2AjxuPSOVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiHuM5Q9ROv7GzsPSbypcQLkjsyQw7zUp80ynEPMqDZYukhnpJt0JIXbufYpj3oiJ
	 PVueWfvhKe4kUx5KIYS4Xte4v4BEpW8iHB0nkm4x9VB6TI27yYpj8McDCU/+mQ1b/L
	 m1gvZds85tHQgBfvjGcVYXf06kWV0p9vGn6sjBOqkR0+DSBu8Halsif6kLw4aEJDut
	 EQQ8GD6gf2KDtCiaVwM/2WX/+uKIptN3BIkE+wIekjuhxJQ2VJuE3aoAmKv/mB/ews
	 RZyq67l/ziPikXwmtK+M1lmB4NmUzUeejp2/5AQYXBjo2nMsm+7/AI8jelS1st3VdX
	 zQFQMUwWx82sQ==
Date: Fri, 14 Nov 2025 10:39:54 -0600
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed
 battery
Message-ID: <20251114163954.GA3399895-robh@kernel.org>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
 <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
 <176303119683.3716572.16868393928566655866.robh@kernel.org>
 <ee36d7d1-ef47-4a35-9aff-baa6ed32105a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee36d7d1-ef47-4a35-9aff-baa6ed32105a@gmail.com>

On Fri, Nov 14, 2025 at 11:04:27AM +0200, Matti Vaittinen wrote:
> On 13/11/2025 12:53, Rob Herring (Arm) wrote:
> > 
> > On Thu, 13 Nov 2025 10:52:19 +0200, Matti Vaittinen wrote:
> > > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > > 
> > > The BD72720 PMIC has a battery charger + coulomb counter block. These
> > > can be used to manage charging of a lithium-ion battery and to do fuel
> > > gauging.
> > > 
> > > ROHM has developed a so called "zero-correction" -algorithm to improve
> > > the fuel-gauging accuracy close to the point where battery is depleted.
> > > This relies on battery specific "VDR" tables, which are measured from
> > > the battery, and which describe the voltage drop rate. More thorough
> > > explanation about the "zero correction" and "VDR" parameters is here:
> > > https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
> > > 
> > > Document the VDR zero-correction specific battery properties used by the
> > > BD72720 and some other ROHM chargers.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > 
> > > ---
> > > NOTE:
> > > Linus' rb-tag holds only if there's no further comments from Rob.
> > > 
> > > Revision history:
> > >   v3 =>:
> > >   - No changes
> > > 
> > >   v2 => v3:
> > >   - Constrain VDR threshold voltage to 48V
> > >   - Use standard '-bp' -suffix for the rohm,volt-drop-soc
> > > 
> > >   RFCv1 => v2:
> > >   - Add units to rohm,volt-drop-soc (tenths of %)
> > >   - Give real temperatures matching the VDR tables, instead of vague
> > >     'high', 'normal', 'low', 'very low'. (Add table of temperatures and
> > >     use number matching the right temperature index in the VDR table name).
> > >   - Fix typoed 'algorithm' in commit message.
> > > 
> > > The parameters are describing the battery voltage drop rates - so they
> > > are properties of the battery, not the charger. Thus they do not belong
> > > in the charger node.
> > > 
> 
> // snip
> 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.example.dtb: battery (simple-battery): 'degrade-cycle-microamp-hours', 'rohm,volt-drop-0-microvolt', 'rohm,volt-drop-1-microvolt', 'rohm,volt-drop-2-microvolt', 'rohm,volt-drop-3-temp-microvolt', 'rohm,volt-drop-soc-bp', 'rohm,volt-drop-temperatures-millicelsius', 'rohm,voltage-vdr-thresh-microvolt' do not match any of the regexes: '^ocv-capacity-table-[0-9]+$', '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml
> > 
> 
> Odd. I am pretty sure I didn't see this when I ran the make
> dt_binding_check. Not 100% sure what happened there. I get this error now
> though when including all the bindings to the check.
> 
> Do I get this right - these errors result from the properties used in
> example not being included in the battery.yaml? So, this means that the
> check is done based on the binding (battery.yaml) where the compatible
> (simple-battery) is defined - not based on the properties which are present
> in this file where the example resides, (and which references the
> battery.yaml)?
> 
> ...
> 
> Oh... Now that I wrote it I feel like an idiot.
> 
> This approach couldn't work for the validation, right? Let's assume I had a
> VDR battery, and I added a static-battery -node for it. Running the
> validation would pick the battery.yaml based on the compatible (just as it
> does here), and be completely unaware of this vdr-battery.yaml. I have no
> idea why I thought this would work. Probably because I only thought this
> from the documentation POV.
> 
> So, as far as I understand, the only viable options are expanding the
> existing battery.yaml with these properties (which I hoped to avoid, see
> below)
> 
> >> The right place for them is the battery node, which is described by the
> >> generic "battery.yaml". I was not comfortable with adding these
> >> properties to the generic battery.yaml because they are:
> >>    - Meaningful only for those charger drivers which have the VDR
> >>      algorithm implemented. (And even though the algorithm is not charger
> >>      specific, AFAICS, it is currently only used by some ROHM PMIC
> >>      drivers).
> >>    - Technique of measuring the VDR tables for a battery is not widely
> >>      known. AFAICS, only folks at ROHM are measuring those for some
> >>      customer products. We do have those tables available for some of the
> >>      products though (Kobo?).
> 
> or, to add new compatible for the "vdr-battery".
> AFAICS, adding new compatible would require us to wither duplicate the used
> properties from battery.yaml here (as battery.yaml mandates the
> "simple-battery" - compatible) - or to split the battery.yaml in two files,
> one containing the generic properties, other containing the "simple-battery"
> -compatible and referencing the generic one. Then the "vdr-battery" could
> also reference the generic one.
> 
> Any suggestions for the next path to follow?

Probably the latter option. You could do the former and make the new 
properties conditional on the "vdr-battery" compatible. That's fine with 
small differences, but gets messy as there are more properties and 
variations.

But is "VDR" a type of battery though? Is there a certain type/chemistry 
of battery we should be describing where VDR is applicable? I don't 
think it scales well if we define battery compatibles for every 
variation of charger algorithm. Honestly I don't mind just adding 1 
property. I care more if we allow undocumented properties than 
allowing documented but invalid for the platform properties. When it 
becomes 10, 20, 30 properties, then I might start to care. If that 
happens, either we are doing a poor job of generically describing 
battery parameters or chargers and batteries are tightly coupled and 
can't be described independently.

Rob

