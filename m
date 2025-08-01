Return-Path: <linux-pm+bounces-31763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36351B183BC
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7244E628D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71F2641E3;
	Fri,  1 Aug 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZmTgxucd"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3804A1D;
	Fri,  1 Aug 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058454; cv=none; b=jK6Q830BeJVzLQAos4bMmcbDryuLpc8DQjD7gi4gRyiLYCt8pVQ0aseerUjOSWGg5E9mDBTexULcl11eC2ylhwHChGLoGO7cZHKverwXPdN4GCHYcxRAU4jylwPtQSDNCkklr5+cKD6ZPegtFrXPLeeu10hEVDLrS7t1D01pmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058454; c=relaxed/simple;
	bh=xWlSL6dS68FFkoSFvMZZSwXW0kvJTeoFWHyzBrtEB48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=upaObRfBXP2UT0FyCD6DHgd1zed7ZhK4KByUiQeINV5j7mf/P6B9O6mYPD0DJFBXOqC8AeQDo4q6R4R9JqojYZqeZBz1ZeeeNZwhh2g3Ryz7fWby8cPH/vE425QiOcJiHjoFSUyU4gZO434BU9GjvkCQ4JbRARP6uObzixh7V7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZmTgxucd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE2D543A21;
	Fri,  1 Aug 2025 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754058450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuY6/HSh6y6ghHTCNicd1M2f7zD07d8qiGFWh9pxQfI=;
	b=ZmTgxucd39smaH/63V7RsE58gOzzqQ5Y8ChKpgAh9cG91AS41UvRS9kxFs8Fj4KuJTvA6b
	S4qm9JfQKAh7Aqn3xQzw8XXQthOl+EndZRmQqP5S5eXV2d0vEGKWjiBh2Az6Hq+dXFe3fd
	cIC//AjIRyiCLJYZWTXIB06x9jqcnw6WJH5yfGvMmB2X3UG7zWAniVIP8WuqaZmBF0bHBw
	179HcSPCxGV93V8ji/1GPDNBUT+6k6DkvFrv+jxE/wY5aZGycvl77q0k2fJhSfFA7+c/19
	L5Z+U8yvTR1OPCAsf9cOpoKTjyeFy7Vd1WdSCXfkRIvihR1LEMLxPxS7/HfdrA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,  Gregory Clement
 <gregory.clement@bootlin.com>,  Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>,
  Zhang Rui <rui.zhang@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>,
  linux-arm-kernel@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] dt-binding: thermal: Convert
 marvell,armada-ap806-thermal to DT schema
In-Reply-To: <20250702230030.2892116-1-robh@kernel.org> (Rob Herring's message
	of "Wed, 2 Jul 2025 18:00:29 -0500")
References: <20250702230030.2892116-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 01 Aug 2025 16:27:28 +0200
Message-ID: <87qzxv5d7z.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsvggsrghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rob,

Sorry for the delay, I don't know why I forgot these.

...

> +properties:
> +  compatible:
> +    enum:
> +      - marvell,armada-ap806-thermal
> +      - marvell,armada-ap807-thermal
> +      - marvell,armada-cp110-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: overheat interrupt
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    description: Cell represents the channel ID. There is one sensor per
> +      channel. O refers to the thermal IP internal channel.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

IIRC on these Marvell designs, there was one (or more, I don't remember)
Application Processor (AP) and several Co-Processors (CP).

[On the AP]
The AP8XX overheat interrupt was not directly wired to the GIC but was
going through another intermediate IRQ controller named SEI (System
Error Interrupt).

      Thermal overheat IRQ -> SEI -> GIC

[On the CP]
There was one interrupt controller per CP11X named ICU, which would be
connected to the top level GIC through MSIs. The ICU was however split
into several sub-controllers reaching different areas on the GIC.

                                      MSI
      Thermal overheat IRQ -> ICU SEI -> GIC

As the OS could not guess the internal connexions, I believe we had to
include in the bindings the parent IRQ chip we were connected to. In the
case of the thermal over heat interrupts, they were all going through an
SEI controller (System Error Interrupt) which, if I still remember
correctly, was not the default parent, hence the use of
interrupts-parent/interrupts-extended in the examples.

This is all a bit cloudy in my mind, but I believe these properties
matter and with 'additionalProperties: false' and without
interrupts-parent/interrupts-extended allowed, a real world DT
snippet would not pass the binding checks.

> +examples:
> +  - |
> +    thermal-sensor@80 {
> +        compatible =3D "marvell,armada-ap806-thermal";
> +        reg =3D <0x80 0x10>;
> +        interrupts =3D <18>;

I do not know how accurate the example must be, but maybe the example
shall reflect the SEI connection as well.

> +        #thermal-sensor-cells =3D <1>;
> +    };

Thanks,
Miqu=C3=A8l

