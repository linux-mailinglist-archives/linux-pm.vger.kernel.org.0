Return-Path: <linux-pm+bounces-31859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4978B19C65
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3C3AFC70
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325F2356D2;
	Mon,  4 Aug 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pVPoUrdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860B233722;
	Mon,  4 Aug 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754292179; cv=none; b=jeHPk9i3Q16TWARD+cyECbRg/himoLF9NcojAn0XcR9gxrYShfZ4xWV1PhHiaFZhsQFITNJo7bLmxXa+ErKO+nbw4E4CnXvX8wb9EMYhzi7GRU6kKNbwForbGMohk3k2OPO+l5UhUvuEEUUt9s/yVscz/eDTpjGuFJ4o/XYwt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754292179; c=relaxed/simple;
	bh=I8MGzJx1jjFTw5eow+nX1J2zm8Gzr/92+RO8LD1Zhb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xi1X/6MO60GlSeA0kFaETbzq9BVIzAmjbFJmLRKlRbROnFce8HFDl9DXBi5F73uBOkIRwapLOQ92AEOm6gEGL3w5lOheu+0vGilyrny8GsUG2nYO2FKZ9xd3VdAy2W504+mOE4QDivmMmv/LvXCUXUNKJlskBiqBEAzbuDkKrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pVPoUrdp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31AA1438DF;
	Mon,  4 Aug 2025 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754292169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i18NPnv5eIUf6UbsI/khDMHH0nd6uxFV8xlsBSgXCP4=;
	b=pVPoUrdp9u9L5F0YNFRXy/hoYu5wW9UM+VQzEkzatsRDj/oy2153NEgYFKAZn5+SYkbz0w
	57YrnYt01cllo/jlXfqOk1DgSyGgQq3NAWPfgR9PLKBJs5Bw9SM8xuAVpRj+c/RjnuAeLb
	JRXqk0R0A2mwHD+stOhsLZNXHX1J+5/Jn80ttBZaDKcJV3HOKfVGD87dLh/wIvmiQLkS8W
	jX+YslVsKZ2epzqSQQPWl8ZeBqUWAOh2XJeaWC1xN0UEOngtp7O/7mkAsd18bTeUsuiWCV
	MxsxbSd62ml9mtLAP/hXA5GaVxWbuUXp3lYxbLKGLCdI4rAaUKxMCIPvAOFqcg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,  Gregory Clement
 <gregory.clement@bootlin.com>,  Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>,
  Zhang Rui <rui.zhang@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>,
  linux-arm-kernel@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] dt-binding: thermal: Convert
 marvell,armada-ap806-thermal to DT schema
In-Reply-To: <CAL_Jsq+fV-W+PqZpvns5oFNyGXxKYYrHe1ipG7gj6dN-c2JJ6g@mail.gmail.com>
	(Rob Herring's message of "Fri, 1 Aug 2025 15:22:20 -0500")
References: <20250702230030.2892116-1-robh@kernel.org>
	<87qzxv5d7z.fsf@bootlin.com>
	<CAL_Jsq+fV-W+PqZpvns5oFNyGXxKYYrHe1ipG7gj6dN-c2JJ6g@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 04 Aug 2025 09:22:47 +0200
Message-ID: <877bzjo8jc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsvggsrghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 01/08/2025 at 15:22:20 -05, Rob Herring <robh@kernel.org> wrote:

> On Fri, Aug 1, 2025 at 9:27=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
>>
>> Hi Rob,
>>
>> Sorry for the delay, I don't know why I forgot these.
>>
>> ...
>>
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - marvell,armada-ap806-thermal
>> > +      - marvell,armada-ap807-thermal
>> > +      - marvell,armada-cp110-thermal
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  interrupts:
>> > +    description: overheat interrupt
>> > +    maxItems: 1
>> > +
>> > +  '#thermal-sensor-cells':
>> > +    description: Cell represents the channel ID. There is one sensor =
per
>> > +      channel. O refers to the thermal IP internal channel.
>> > +    const: 1
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>> > +
>> > +additionalProperties: false
>>
>> IIRC on these Marvell designs, there was one (or more, I don't remember)
>> Application Processor (AP) and several Co-Processors (CP).
>>
>> [On the AP]
>> The AP8XX overheat interrupt was not directly wired to the GIC but was
>> going through another intermediate IRQ controller named SEI (System
>> Error Interrupt).
>>
>>       Thermal overheat IRQ -> SEI -> GIC
>>
>> [On the CP]
>> There was one interrupt controller per CP11X named ICU, which would be
>> connected to the top level GIC through MSIs. The ICU was however split
>> into several sub-controllers reaching different areas on the GIC.
>>
>>                                       MSI
>>       Thermal overheat IRQ -> ICU SEI -> GIC
>>
>> As the OS could not guess the internal connexions, I believe we had to
>> include in the bindings the parent IRQ chip we were connected to. In the
>> case of the thermal over heat interrupts, they were all going through an
>> SEI controller (System Error Interrupt) which, if I still remember
>> correctly, was not the default parent, hence the use of
>> interrupts-parent/interrupts-extended in the examples.
>>
>> This is all a bit cloudy in my mind, but I believe these properties
>> matter and with 'additionalProperties: false' and without
>> interrupts-parent/interrupts-extended allowed, a real world DT
>> snippet would not pass the binding checks.
>
> 'interrupt-parent' is implicitly allowed anywhere. Who is the parent
> is outside the scope of the binding given it can vary.

Ok, good to know.

>> > +examples:
>> > +  - |
>> > +    thermal-sensor@80 {
>> > +        compatible =3D "marvell,armada-ap806-thermal";
>> > +        reg =3D <0x80 0x10>;
>> > +        interrupts =3D <18>;
>>
>> I do not know how accurate the example must be, but maybe the example
>> shall reflect the SEI connection as well.
>
> No one has cared about converting the Marvell bindings, so *shrug*.

I was still mentioning the same interrupt-parent property here ("the SEI
connection"), not how accurate the values were. So if we do not care
about interrupt-parent because it is allowed anyway,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for the conversion,
Miqu=C3=A8l

