Return-Path: <linux-pm+bounces-27518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98804AC10D8
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E574F3AD323
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59D299939;
	Thu, 22 May 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="B9bi2B7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLmBJdr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE01494DF;
	Thu, 22 May 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930522; cv=none; b=doaGAPbQQ17bpJd01v9Ta+ij+rjDGm9f1076NZZcmWOSLG/XTrUASfEZPCL5Ag3gdHNJXk5K5rxKdRcDVEcdFMGeL93/5PX35D653RIpeTWTT8vArD8d5cIEgGqenYHnMre7KPvLkb5cDrEjginCl3cZvT3Rrjwn/71LHVR4ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930522; c=relaxed/simple;
	bh=tQIbf2HlOErPFVkOx0MHQsWayH4MzvMxKiwqgNM+gIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LQ6RlSAlS9QnlioysmXdV7aHl3osgV/gPj/Qq6EjFVAPenqR5jD5wgyA42wVEPpV/jXz8xv2Y8UHgDXtulZElXdqINpET+AaS2TkoTEvsQ8KyRx6HPFLZeXdxU2OrDMejW/pZIevuc3sU6kFT1VkhAFV6zqL+hy/4EQ2CBAacXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=B9bi2B7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uLmBJdr8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CE1B1140132;
	Thu, 22 May 2025 12:15:18 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Thu, 22 May 2025 12:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747930518; x=1748016918; bh=MBTpQbywQFLmTTQkFgXTxm8iWE7BxybC
	g7tJBMmOGUE=; b=B9bi2B7CnXLp+kb3svPCNRju5PNb1KDnU3lYD+Av3i6+nC9u
	ZvsKUnNz8B3qR+bpqQhrRkJ/tNK/EPeHwR3q0HvbrP4o5t0ZI9NOBGq8SAd97b4U
	IRk0o5K6L/EVV3clXwO75WQyPrYaN+AOVlkaJAgWowzoiV9WHZwKnpxyMIB96H2u
	Xz1JKahUhemA57TD5aQlD12gabc5tSKsLg1m5JKrSPZrhx6UwNv4kcHAi91tBJGk
	QVrN9HXlxmP8FOOigVYyOxreG4sndqgq9mdd7SgoRWykdarUtQr/3KKd/di1oLmT
	Bu01KhgXsmm+Y3YkYzmBzq37R3DpLTPkpbMyag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747930518; x=
	1748016918; bh=MBTpQbywQFLmTTQkFgXTxm8iWE7BxybCg7tJBMmOGUE=; b=u
	LmBJdr8kFFwLUwi/cjQSCYXQVB9Uz1AyTJsKsdyUvCLeV4Cajkel7vYFbr44H8H2
	2wN6DGAWhh0bX6dVycyKg0CVxvxqVL660C+WECr9YRhSk/fdJH59JJvU+dkLQqjx
	r65gVedaz3Rd1TAa+86Y35yvz+1WFbs4KS8AFegqg6cBGiEcCFV5xjPZ4ZWS9Ols
	AYNOnNxia1ESHyABFa1SymftWehQlH8CDYfTqottz1EMpfTVpjzMdh7cOcRCXc51
	zL3TFaEUM2SiA7uYx6AKQhvK04FNd8ew5BffznD3NgMN9p1yCsoAxD1KJgoBZYyQ
	ul24bFzAir4OBJUQFh94g==
X-ME-Sender: <xms:lE0vaMLwUSNRHe9rOlIek5IH5yF1gV8ngvEu7TxwvM_2pAWd44KyeQ>
    <xme:lE0vaMLq_x5JbBPSX3_vyoDwGlpR8hotcQFKCwrTyPXFDdIsKBSn-ICtAL5soh1sD
    PEY4DxEt_yo36F9Pfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeigedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugedu
    udeuudeuhfefheegveekueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvght
    vghrrdguvghvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghp
    thhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehsvggsrghsthhirghnrd
    hrvghitghhvghlsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepnhgvrghlsehg
    ohhmphgrrdguvghvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoh
    eptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdought
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrgiisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lU0vaMuYGb6UxDNM1d0uvsMQ1SVzVN0tQzwa7-l5gpNzDQ3Ywa-1YA>
    <xmx:lU0vaJbcMxqM-lsGnAR5bi1sA-GIq1fseQpq0MuUrw8aihaAhFgVaw>
    <xmx:lU0vaDZ0z2pFdHEn4tFzNMqjza0UtBIudtqWGeF_bzARYUjoBzHDFg>
    <xmx:lU0vaFCba1PF5PlMgKRZ3JWfKdbvKkCHSNIDnChfdYzrmXHTxSSsdQ>
    <xmx:lk0vaFK4eE6CWoBCW1Z_aUsWMLN7jZMKiOpnCa_bOWHa5-zsFSGz4dof>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D14D01060063; Thu, 22 May 2025 12:15:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6f92ed75002c46d1
Date: Thu, 22 May 2025 18:14:56 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Hector Martin" <marcan@marcan.st>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Marc Zyngier" <maz@kernel.org>, "Russell King" <rmk+kernel@armlinux.org.uk>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Message-Id: <706858ca-7ebf-4419-a096-3907aab923bf@app.fastmail.com>
In-Reply-To: 
 <gk656zq44i6ls6bbcb6qpd42typzkw3hqbft6b6rvfaw5aocsd@2fsiokbcnbtf>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
 <20250515-smc-6-15-v6-7-c47b1ef4b0ae@svenpeter.dev>
 <gk656zq44i6ls6bbcb6qpd42typzkw3hqbft6b6rvfaw5aocsd@2fsiokbcnbtf>
Subject: Re: [PATCH v6 07/10] power: reset: macsmc-reboot: Add driver for rebooting via
 Apple SMC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On Thu, May 22, 2025, at 15:06, Sebastian Reichel wrote:
> Hi,
>
> On Thu, May 15, 2025 at 06:21:19AM +0000, Sven Peter via B4 Relay wrote:
>> From: Hector Martin <marcan@marcan.st>
>> 
>> This driver implements the reboot/shutdown support exposed by the SMC
>> on Apple Silicon machines, such as Apple M1 Macs.
>> 

[...]

>> +
>> +static int macsmc_reboot_probe(struct platform_device *pdev)
>> +{
>> +	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
>> +	struct macsmc_reboot *reboot;
>> +	int ret, i;
>> +
>> +	/* Ignore devices without this functionality */
>> +	if (!apple_smc_key_exists(smc, SMC_KEY(MBSE)))
>> +		return -ENODEV;
>
> Is that a leftover? I would expect that you do not have the
> 'apple,smc-reboot' sub-device described in DT for such a case.

Yup, that's another leftover, will remove it for v7 as well.

>
> Otherwise
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Thanks for the review!


Sven

