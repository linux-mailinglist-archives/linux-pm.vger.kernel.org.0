Return-Path: <linux-pm+bounces-38073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE80C5EA2F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DA53B3F82
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32034251D;
	Fri, 14 Nov 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dY2vzCw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314E34028D;
	Fri, 14 Nov 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142231; cv=none; b=hD1mIiP8CIyDBh1vRPyBZp0GZtGG+UM+iLQgsLnyqDGYoJ/ryDhkzcAh9GvLyj/DqWYx59pPR2+A0ArVRXf4JhZx3JqBKl+wSHm0UOt/pEh6+kuEn+y42dux3Kx5cq49jDlVNCDh3r6VM7yy9CAepDnE+sZVh5F/6S6FaNMuDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142231; c=relaxed/simple;
	bh=SYGVWFG9cxnzcJbgEB6mbjt47b8Dp8+LhLxjvwrR3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYeEfzDcUa1tBM+8JHOn0kAaRh1cV5iKtG65GZ3nWSiVIpWlvCB9TD6UOrnkiUiqB1eo3YX8xnSfjoShPxszWE3rpvnGhxZnx1Y0NwZ5B/bSlOnvABIlM5HNS7NSU8VwSbyxKFoM1AdKmSqPV1cD6j2Eaxd4WTXxI6OzTUbQ/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dY2vzCw/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IuhO4fRt6aud6pJlxkp0PpqbniY1ovisOhBXF/n8Fic=; b=dY2vzCw/nPzLxrwDwDVNTz89Tl
	EFaFgM+MAzDBAsmGXSj0J6XqPFre7tvBqI7SP3woJ1iXrlhCdzsv9tlPotIaZJpj6X3699NM1+JyG
	JuAo0k01ONfPXCg7Zr8RUDgrawczYAttEwALYCMEDEklQrtsi4Ncv69j9DqrCAfgtTPtNCVb3TYm0
	84bvwzKYC5AZyqDayICLYySgPp/3VWLLqg3hAnQDe2BqkUMs6huY28fFzp9bQLbXzRxkrvTSCopv/
	aNQi8FhRL90A3D3Uc28xWpZh/f5CZtmt4t+p/Sdz4IIpJR9CxhkGO8iWU2wRQj0RKTRWIeuOODIeN
	LZ92F2dA==;
Date: Fri, 14 Nov 2025 18:40:17 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org, Michael
 Turquette <mturquette@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, linux-leds@vger.kernel.org, Pavel
 Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>
Subject: Re: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed
 battery
Message-ID: <20251114184017.20d647da@kemnade.info>
In-Reply-To: <20251114163954.GA3399895-robh@kernel.org>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
	<ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
	<176303119683.3716572.16868393928566655866.robh@kernel.org>
	<ee36d7d1-ef47-4a35-9aff-baa6ed32105a@gmail.com>
	<20251114163954.GA3399895-robh@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 10:39:54 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Nov 14, 2025 at 11:04:27AM +0200, Matti Vaittinen wrote:
> > On 13/11/2025 12:53, Rob Herring (Arm) wrote:  
> > > 
> > > On Thu, 13 Nov 2025 10:52:19 +0200, Matti Vaittinen wrote:  
> > > > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > 
> > > > The BD72720 PMIC has a battery charger + coulomb counter block. These
> > > > can be used to manage charging of a lithium-ion battery and to do fuel
> > > > gauging.
> > > > 
> > > > ROHM has developed a so called "zero-correction" -algorithm to improve
> > > > the fuel-gauging accuracy close to the point where battery is depleted.
> > > > This relies on battery specific "VDR" tables, which are measured from
> > > > the battery, and which describe the voltage drop rate. More thorough
> > > > explanation about the "zero correction" and "VDR" parameters is here:
> > > > https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com/
> > > > 
> > > > Document the VDR zero-correction specific battery properties used by the
> > > > BD72720 and some other ROHM chargers.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > 
> > > > ---
> > > > NOTE:
> > > > Linus' rb-tag holds only if there's no further comments from Rob.
> > > > 
> > > > Revision history:
> > > >   v3 =>:
> > > >   - No changes
> > > > 
> > > >   v2 => v3:
> > > >   - Constrain VDR threshold voltage to 48V
> > > >   - Use standard '-bp' -suffix for the rohm,volt-drop-soc
> > > > 
> > > >   RFCv1 => v2:
> > > >   - Add units to rohm,volt-drop-soc (tenths of %)
> > > >   - Give real temperatures matching the VDR tables, instead of vague
> > > >     'high', 'normal', 'low', 'very low'. (Add table of temperatures and
> > > >     use number matching the right temperature index in the VDR table name).
> > > >   - Fix typoed 'algorithm' in commit message.
> > > > 
> > > > The parameters are describing the battery voltage drop rates - so they
> > > > are properties of the battery, not the charger. Thus they do not belong
> > > > in the charger node.
> > > >   
> > 
> > // snip
> >   
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.example.dtb: battery (simple-battery): 'degrade-cycle-microamp-hours', 'rohm,volt-drop-0-microvolt', 'rohm,volt-drop-1-microvolt', 'rohm,volt-drop-2-microvolt', 'rohm,volt-drop-3-temp-microvolt', 'rohm,volt-drop-soc-bp', 'rohm,volt-drop-temperatures-millicelsius', 'rohm,voltage-vdr-thresh-microvolt' do not match any of the regexes: '^ocv-capacity-table-[0-9]+$', '^pinctrl-[0-9]+$'
> > > 	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml
> > >   
> > 
> > Odd. I am pretty sure I didn't see this when I ran the make
> > dt_binding_check. Not 100% sure what happened there. I get this error now
> > though when including all the bindings to the check.
> > 
> > Do I get this right - these errors result from the properties used in
> > example not being included in the battery.yaml? So, this means that the
> > check is done based on the binding (battery.yaml) where the compatible
> > (simple-battery) is defined - not based on the properties which are present
> > in this file where the example resides, (and which references the
> > battery.yaml)?
> > 
> > ...
> > 
> > Oh... Now that I wrote it I feel like an idiot.
> > 
> > This approach couldn't work for the validation, right? Let's assume I had a
> > VDR battery, and I added a static-battery -node for it. Running the
> > validation would pick the battery.yaml based on the compatible (just as it
> > does here), and be completely unaware of this vdr-battery.yaml. I have no
> > idea why I thought this would work. Probably because I only thought this
> > from the documentation POV.
> > 
> > So, as far as I understand, the only viable options are expanding the
> > existing battery.yaml with these properties (which I hoped to avoid, see
> > below)
> >   
> > >> The right place for them is the battery node, which is described by the
> > >> generic "battery.yaml". I was not comfortable with adding these
> > >> properties to the generic battery.yaml because they are:
> > >>    - Meaningful only for those charger drivers which have the VDR
> > >>      algorithm implemented. (And even though the algorithm is not charger
> > >>      specific, AFAICS, it is currently only used by some ROHM PMIC
> > >>      drivers).
> > >>    - Technique of measuring the VDR tables for a battery is not widely
> > >>      known. AFAICS, only folks at ROHM are measuring those for some
> > >>      customer products. We do have those tables available for some of the
> > >>      products though (Kobo?).  
> > 
> > or, to add new compatible for the "vdr-battery".
> > AFAICS, adding new compatible would require us to wither duplicate the used
> > properties from battery.yaml here (as battery.yaml mandates the
> > "simple-battery" - compatible) - or to split the battery.yaml in two files,
> > one containing the generic properties, other containing the "simple-battery"
> > -compatible and referencing the generic one. Then the "vdr-battery" could
> > also reference the generic one.
> > 
> > Any suggestions for the next path to follow?  
> 
> Probably the latter option. You could do the former and make the new 
> properties conditional on the "vdr-battery" compatible. That's fine with 
> small differences, but gets messy as there are more properties and 
> variations.
> 
just keep in mind, that several kobo devices have one pmic in one board
revision and another one in the other (e.g. Kobo Nia rev A vs rev C).
But probably the same battery. So if the "vdr-battery" is a compatible
just to allow a more properties,
then "simple-battery" should be allowed as fallback. 

Regards,
Andreas

