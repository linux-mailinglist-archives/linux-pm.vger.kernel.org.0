Return-Path: <linux-pm+bounces-41049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08CD38E8A
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 13:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86D630155E3
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313ED2DFA32;
	Sat, 17 Jan 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="b5agoghe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iM31dSo7"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E21684B4;
	Sat, 17 Jan 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768653171; cv=none; b=ksd/UkAbBkiPwcnq1MSMHtQ/PSofI8Ew5BjMRnUZXGoWyPgakcm0ehRScUIGoPcDjXrVE4md0ysxHWZ5tbCi7nQMX3FKClIOSaaJ1s2q5EBY7gfCABANQvnRtzeKs6KF8hBPrYFaO6c2nriWaZ5xNjfnX8owELsJFY+LCdkJMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768653171; c=relaxed/simple;
	bh=sr9HE2t6AKV8pW8uQSDNG0Xo8kqmM0bt+dhJgtrWXqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7cBaQGptNQ/1Q6ZaR9yPn8cDSfdR7ol3nm+BOGtdfSGIDTCDIYhHYDr6W85OMyq6WZexXv339shOfak055xvjaQaka7TK2sD837DQExW0mfz9FtQGyv4UMmIl8acKeoIaeN7a/ayjb9J+KCVGeCfHTGJIzgyjpciA0hPNt2Uy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=b5agoghe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iM31dSo7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08BB314005F8;
	Sat, 17 Jan 2026 07:32:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 17 Jan 2026 07:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768653169; x=1768739569; bh=8L40GxX58S
	7CkvQid1FvkGF3NrNusAOGvB1a5qsmUhk=; b=b5agoghei+XC3YU9yIN0HvH3fD
	7iGLJI+UrK7QHBQMTbWFx0qvqUitgwrrikEIcT0+jiej6oPfEhpichOsqYdb9d7F
	znD/c9m2rzQXXHLvkyTPQxqYX2eZZ3lNwemaaU9iasS6Q6RSxTCw0Y/XSJpN1Gct
	T5085Vi34TJRYFHC54THZKmh815Ic9TSdbxKV9hM8Aaydz1luXTDcoheZ4ZT1cs4
	PL2Hh3rKRuXiY8pFuMpyBfLvlKkuVGx6xP9A3HZmXWdHxPYDzi6QalZhWhs0tPW9
	UUZj28IBiPyWZ+VAAb3mbigy9tcsMuOt8neGhlM8MzV1ayZO4TKauR30UG5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768653169; x=1768739569; bh=8L40GxX58S7CkvQid1FvkGF3NrNusAOGvB1
	a5qsmUhk=; b=iM31dSo7NqAgwSdTfIYk6+9yvCK2gs9XN7XyrQCN4iU0FvCpR8z
	/IyHJmxkBiYq2qjohNkEAnHrnMVV7Xl4Xgd8GVx09ikhhopz3FB5eMbAhKiNJeet
	YvgVV2xT8hmGvi6YmBYsVTcncsYqcqOw99mauPh85mJDK3kaD7BHpJTBZeZ5922R
	nTBccoe6ujX0d6RPeyZcGAkngR859/yBp/RZx8hCXb6jtwkAXQlAKZW9IUPow+vm
	5vhlBL4kHIUr2GIA9vnXXnIvgfcmrvkAwqVlrosxMz2kotVbuNRpXsyIBi8pBDij
	aS74LJ2iVelpvCrS6b4pDWsPAR/oSp+Ip3g==
X-ME-Sender: <xms:cIFrafmj9dh9dTFF_0Myi4B8NjCso6-O9lhRz5aRKA1Pc1dW0ePhOw>
    <xme:cIFrabCX5uuEHISu8ABaBNoy0Qae6Qin3vu98reU8mYyHjtJMYLowEPeYb9RX62RM
    33mEzjOLpmISDXZmMwAK6yvLqJsKcTFPG-sXuGTmC_8c7aSN7rHNhs>
X-ME-Received: <xmr:cIFraRN4MZ1cmWI9_FAJpwFmQjd4wbScRXnubYKDh_r_S3-hY6I8SlLF2JqFFSqmPK4_jrUPVfQKVHraiODUMXBi-i_GwsktUh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedukedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgthhgrvghlrdhrvggvvhgvshdtjeejsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhvvghnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhope
    hlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:cIFraSO47e2aFImcnjy5_bvphqXunbfadMue2o--1ZL4QB8CHx-nuA>
    <xmx:cIFraZkcOfOyO0tdM2la3R_yZX31ZNs9HTgkgO-eHUM7K779QpQfQA>
    <xmx:cIFraQt28-CxnGJBFOWhtswlJf8AkD049iWMNHNMO39uZpyS99V26w>
    <xmx:cIFraco_pq_Dse5SF_d0m7GZthsNhTRig45KPEiv_VUzW-YB3j8LFg>
    <xmx:cYFraRXD_kyNszl39fo-88v_K5KJvpqdFeD_mwliSZY3d6iN6_2cMBCU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 07:32:47 -0500 (EST)
Date: Sat, 17 Jan 2026 13:32:47 +0100
From: Janne Grunau <j@jannau.net>
To: michael.reeves077@gmail.com
Cc: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>,
	Neal Gompa <neal@gompa.dev>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 2/2] mfd: macsmc: Wire up Apple SMC power driver
Message-ID: <20260117123247.GB58217@robin.jannau.net>
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
 <20260115-b4-macsmc-power-v3-2-c236e09874be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115-b4-macsmc-power-v3-2-c236e09874be@gmail.com>

On Thu, Jan 15, 2026 at 06:08:16PM +1100, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
> 
> Add the cell for the macsmc-power driver so it is probed by the
> MFD core.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Co-developed-by: for a single line change as simple as this is silly.
Please just keep Hector as author and just add your SOB

> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  drivers/mfd/macsmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
> index 1b7e7b3e785f..358feec2d088 100644
> --- a/drivers/mfd/macsmc.c
> +++ b/drivers/mfd/macsmc.c
> @@ -46,6 +46,7 @@
>  
>  static const struct mfd_cell apple_smc_devs[] = {
>  	MFD_CELL_NAME("macsmc-input"),
> +	MFD_CELL_NAME("macsmc-power"),
>  	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
>  	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
>  	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

This patch does not apply on top of v6.19-rc1. The base-commit helpfully
provided by b4 does not exists in my tree. I assume it's either a mfd or
linux-next commit? Please note the branch/tag this series applies to in
the cover letter if it is not the most recent -rc1 from Linus

Janne

