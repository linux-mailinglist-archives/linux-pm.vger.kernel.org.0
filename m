Return-Path: <linux-pm+bounces-27636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6CAC3A9F
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 09:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7993B2282
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2B1DF26A;
	Mon, 26 May 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aSAlUf7t"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0381DED70;
	Mon, 26 May 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244567; cv=none; b=UE6Hh1JihmcpDwqxS98jbkjJH8yBUYXCnDo8yS962yG9wNh6y+pcOHTJWoFmcD7KQue2/rYLPygcWFV5WDTmiRrfkmT5f8ue5ImgGExWPGy/exNIxDiK5y1BCI8D5e22UjuZI5+bXRo+P1OQ0bE/1IVBKN2TUdQWV2kq1u7B+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244567; c=relaxed/simple;
	bh=Je1BUTAfAJfyt/23jMozzcm9hrIkBVEtPRP5MXr66YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rV7wYgs0rCJc52SQ1IsiyoyjhC1QX1pfENfTQhCEBuK9NFkzbrVzf8L2F7nuqxNOYj5JCrW/KcF98N06yy4susL32UJcE31KM2YOa82LboGfY1Lvl5Wdv8GSZA21axY7r1VA9aoXAuF64d8VmYKm2BOhBJIAIB81jXBM1VpAQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aSAlUf7t; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 660DC43A5B;
	Mon, 26 May 2025 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748244557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zb65VUFaC3xu3xLyC+q/Y9QOfFVKsDX4tlUv2crmwV4=;
	b=aSAlUf7tUiqHJzsn2lhfPhYcFFkRTUFbo52Dzwpirmygk7yx5FN1GVXM+mtTsyXon7Hw59
	UhADCs4R8i5USXcp3P9cicdaSkNxGVnviZuHEEptLEPU2Yf1o/XTXUbdayMB7gwWnXJHc/
	Mi/bPmlTXYsIjwLDHW/28NPYlY7jGkM6B1uzzRWk0nh5empIZx4bY9tBtamH/PhY0xBYL1
	zOScoSD9Nj61yNkJnybofqFa8Om4iv0jExy2kTwQCnd/YjHiSgxqimbdyLMY4gssdniLnP
	bJ/+aOO/p+dQyK/lGM5d/q2Ao9FNdsJgnT+03SgDIVYioh4dchkjwjNxjylGsg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Support Opensource
 <support.opensource@diasemi.com>,  Shawn Guo <shawnguo@kernel.org>,
  Sascha Hauer <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,  Niklas
 =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,  Geert
 Uytterhoeven
 <geert+renesas@glider.be>,  Magnus Damm <magnus.damm@gmail.com>,  Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  linux-kernel@vger.kernel.org,
  kernel-janitors@vger.kernel.org,  linux-pm@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
  linux-renesas-soc@vger.kernel.org,  linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: Constify struct thermal_zone_device_ops
In-Reply-To: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
	(Christophe JAILLET's message of "Sun, 25 May 2025 11:40:04 +0200")
References: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 26 May 2025 09:29:16 +0200
Message-ID: <87v7pn3k4z.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieelvdculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhjrghilhhlvghtseifrghnrgguohhordhfrhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhlu
 hgsrgesrghrmhdrtghomhdprhgtphhtthhopehsuhhpphhorhhtrdhophgvnhhsohhurhgtvgesughirghsvghmihdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 25/05/2025 at 11:40:04 +02, Christophe JAILLET <christophe.jaillet@wanad=
oo.fr> wrote:

> 'struct thermal_zone_device_ops' are not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>   28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o
>
> After:
> =3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>   28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/thermal/armada_thermal.c                        | 2 +-

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> # For Armada

Thanks,
Miqu=C3=A8l

