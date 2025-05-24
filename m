Return-Path: <linux-pm+bounces-27625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DCAC31CD
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5725E3B4D05
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0E1A2545;
	Sat, 24 May 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fwtb9Q68"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F016D9C2;
	Sat, 24 May 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748125922; cv=none; b=mmUP2Z5oA21aNrzuN5uirqVX0/DQJHSAndNYc2+GJunYVC99TqmmNdQc9r/J+/8o9vSFJbL0kDxxmm4Kl/5Y6q6pyb5eUVkpYC7NiET7aD1YYTBLtO3gQcQfUvSm9YQ69n3JLqzf+K3Ku7xalcEGXV40/UDOlpmil9lqsIF3Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748125922; c=relaxed/simple;
	bh=+rG7oX5eth85rNKkvEQbRhRSKSFrL6Rki09gLGBzzl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAENZOLPr96Dn6jkT9ejM3m2kCdZhDh+2zdDm6s2cdC7/aC+F/enWEye9JWdkA7YruaYwRdT0oVmxP+ILk+x1NRMxrZ8fGK1VaYmnTy9CG4uFsN6a5Sm7J30Of/kFc3vnfouLG0bSi7p297kzCH938622sHS7eY8CeaFprH/rIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fwtb9Q68; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DABF443308;
	Sat, 24 May 2025 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748125918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ctA+pw0iwq71a2CU5/HfDOmg6L4QLY/4rAetftgLJfE=;
	b=Fwtb9Q68LXYuMwGTgH6ki4eecalXw93ok0fpht6jqEJQqsUwkNw6d9gLJheTHHSLrlshv1
	6osgGSYStO3i+7WLQZOM5iLG0nYzU1EFmbOfoiX735m7189RufFLKZOIyRYG3hGz1m2Crb
	CmqJsDd5uYtC904ZtaQQZCSE0doyPP4zBVV+uh3uEpQDle6QAuLXwCncqTWZhSgnRbfVwO
	f29VJhVdgyTiuhUMoEKT7xPTK0tT+3Ir9Eo1ngvRB9wOlO9WNj3Tap5BYQLWhFBtIsCZ+c
	iMfT/VMaDkjjhDYEM+Ztnd/jpcnrU4m20/ZL6q4sju40JLwOh9/bjPbgyYNc3A==
Date: Sun, 25 May 2025 00:31:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de,
	Ryan.Wanner@microchip.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/11] Enable Power Modes Support for
 SAMA7D65 SoC
Message-ID: <174812590116.1278122.18254321478152467419.b4-ty@bootlin.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdeludculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 14 Apr 2025 14:41:17 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for low power modes for the SAMA7D65 SoC and
> the required components and changes for low power modes.
> 
> The series includes changes in the asm code to account for the addtional
> clocks that are in this SoC.
> 
> [...]

Applied, thanks!

[04/11] dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
        https://git.kernel.org/abelloni/c/0a68f5be7883
[05/11] dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
        https://git.kernel.org/abelloni/c/bf1c27c6d540

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

