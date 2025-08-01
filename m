Return-Path: <linux-pm+bounces-31759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24278B182FD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C3B3AAFA9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3824166F;
	Fri,  1 Aug 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o9uBs5Vm"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522A8F49;
	Fri,  1 Aug 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056597; cv=none; b=oWymYibRjfRB3FCEYwRtBTdBHSYrvFQxLDVSkTxCddXoBwOn2Jf96PBCpUNjE6hKnVin8HtsfdyfbC/BgjHSeIzDTq6J3kuhCI99C1pGn7t2p5LfX3LhbvfcCCY1Y3ksMOr864GjB2k9CrJIfzlPpCTisMoJhgDw+1Gw5T0NJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056597; c=relaxed/simple;
	bh=KNIYwYpHSf5WqHvEIcENvX6ddz10vIi+H1KyrmB5LsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4iFoowJY/sCBo7hfr9p/qsDPhlag2/DPlfbf5QnRWcM4hYKjTdBsBvDaqT8+gvBmXlJ+NfjKquYFPvC3Oqg/zUR/gW2pei0poSU4ixTIZfWaYsZHI6DGxjyReNF4+zaCHpkNA7Mzb5GLOWld0nDa19A1kiCz7A2EyWNa9e6Cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o9uBs5Vm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C14C42EF5;
	Fri,  1 Aug 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754056592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06yD9n9RnAQjnGDx6zdMOn3Brhc6UbZVbeYRQe2WZQk=;
	b=o9uBs5VmlesEBu2nF/BPh2gYxg/9wlYpNxMdjKy1zxvRC3OCrUXefoy6rFbVKPRoNCXtFs
	pWDYTRY4WsQP1WFPLDoCWwFy9zr0n2EjIef+bSmJmO0sxA7I38b/+mKZ4chHsoDDyYUP7Z
	cO4goUl/W7MM9vRFLd5CJhidNGFX/j9bruBhg0gmSO2zQipq+D1Btt6XYR/akXFdiBuVs6
	c/e3f0e0MMYmRJ7Egwy9pg0paBO+xys9TE7Tlh0RVQDsMO/2Ttx0nWh6ZjzZW1jflIYncP
	P9sWrAJHvEwnt1O2ygaBjMLnt9qnC+94AZMikcHtviJc8StgzNLq7NDMAxKa1g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  linux-pm@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Convert marvell,armada370-thermal
 to DT schema
In-Reply-To: <20250702225530.2858649-1-robh@kernel.org> (Rob Herring's message
	of "Wed, 2 Jul 2025 17:55:27 -0500")
References: <20250702225530.2858649-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 01 Aug 2025 15:56:31 +0200
Message-ID: <87bjoz6t80.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepkhhriihkodgut
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rob,

On 02/07/2025 at 17:55:27 -05, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convert the Marvell Armada 3xx/XP thermal binding to schema.
>
> Drop the AP80x and CP110 as they have long been deprecated and have
> been replaced by a new binding.

Totally fine with that, but then I would go even further and also drop
the legacy binding implying a size of 4 on the second reg range?

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

...

> +examples:
> +  - |
> +    thermal@d0018300 {
> +        compatible =3D "marvell,armada370-thermal";
> +        reg =3D <0xd0018300 0x4
> +               0xd0018304 0x4>;
> +    };

This example is showing a legacy binding. Even if we decide to keep
supporting it, I think you would prefer to replace the second line:

           reg =3D <0xd0018300 0x4
  -               0xd0018304 0x4>;
  +               0xd0018304 0x8>;

Thanks,
Miqu=C3=A8l

