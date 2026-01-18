Return-Path: <linux-pm+bounces-41055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123DD3950A
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63F0F300BEDF
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BCA27FD44;
	Sun, 18 Jan 2026 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="TEChiSp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GD+pLgX7"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0820156CA;
	Sun, 18 Jan 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740590; cv=none; b=Ad0yUHMwzoRAIPuaPDT1ltUqOsEp8SEqV53ZtFUFAYM1A7ounabm83dJhT1VMbkXC/THAKHL0Lfk4R75UEsrqH8zOCPBXXt3CbA/uvAaSTVZRA0EElIqkB9ggOdLecvfnVkthYYqPsB/0ljQzCtm61dK307EzBgGV1/JE9ca9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740590; c=relaxed/simple;
	bh=9XU9sqG5+Jc/HZvMepTxtwIU6OvOmxvvfCo3ZxzBGAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPUN510uiQlqZz9X8Q6aKpbwi6CJ3BVTZXytjnL7O2NSQ6D/bCYHIvhZVBXtQvn9LIfjKVWZ0SFUPLJi/VsABAMPc58xanOVY/2XDYQaX1efXnGBCziyCs2UTO8GhxGGGFbItHcYjtwbBXNNjP/uF8qSd+l7CFHQ1IFszpj1bE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=TEChiSp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GD+pLgX7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CF12EC0514;
	Sun, 18 Jan 2026 07:49:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 18 Jan 2026 07:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768740587; x=1768826987; bh=EIrtRDzUCs
	Icv+cXJ2ii4UIhy257jrQnZhJ5DnszFqI=; b=TEChiSp55WvVAEcZW/mX80l8ek
	dSduueouoxmBk/8F5XG8J2qkuHV/lRozsl0uvTNYg4TXx2W9PBDKNZLHky34zU6I
	gk3Onqd+5TxRLZSXF3lxaBrjUyoKV7Pcheo91OnVGvvbadFycJt2mjc32iqGVZOV
	Ahx8v/cx6dpxLv9aURxuQqvGk43HL6fznhKwUNPj7AOdKJWGIz20Tw2oWTn9wL7M
	BUon5y+4gTcXf93Tfef18+wU4kilUylNEYI3h6CG11tCSo9XcTlHUGQb2Sx94c6w
	/C5qoUj0SZ+w8JAdLM3ByhdVNol0bxlOIDN9DQHNbwf1xVS68+FcHGcqp+XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768740587; x=1768826987; bh=EIrtRDzUCsIcv+cXJ2ii4UIhy257jrQnZhJ
	5DnszFqI=; b=GD+pLgX77MfZrmN4zctZIdSx4x2zgnPGM+cjeLj3kGUSfhcWAP0
	f2IETepg+RyVQ8rGZfoUGJOW4CnwfQTloH6kPkMBxBVYXEAnOw8ekAuo5WUQJtbu
	kg5194yxX6iWHmrhW0ZqdgHIskBzpTttk1K9IOFPT2Aw6xGEJbR9K+99GBjHacMY
	SX5QuN0WeW+6OSV6ZQzekzVuO4yE/hKfBZMV/yLuOYS1nDh+HVKArv0cVTnsio+0
	L3qIIuEyk2wMqnV1dHO0DkkbjsKMMYWSQKHxcmExWiLaGTSwHSEcsuD72jdjjg6t
	Ft1aeplrfyClbOpsNvEbb+rzaOitlxzzNrA==
X-ME-Sender: <xms:6tZsaYBEwPLNFXMosvlMhab6yFyW1LCHMscZABANcVJrvD4IQIkipQ>
    <xme:6tZsae5juQc_JZiQEtHCe-nCuBbGhGNSfeoiFnrqGnlORl8lDXK9Q52nDJjwUUxcJ
    YxMPAVxFfGW9rTAVZUt55DPR1ZBjyFoifBMYd-QlCwYU2Fo6k6WB_g>
X-ME-Received: <xmr:6tZsaZedzY8tEYlcj3zYTCgGfoOh_vEBMQu1Eujzc1Bx5YHWGhNYjJZY-_TJpkriqdzkeWsQsQEW_5G7NrSolaXVxug5VY8zRgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohifihhntghhvghnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitg
    hhrggvlhdrrhgvvghvvghstdejjeesghhmrghilhdrtghomhdprhgtphhtthhopehsrhgv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheplhgvvgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:6tZsactZ4HWaomlkGmbWNa_mCHfP337rrbc2bp9CdtvRBMkHs4fLRA>
    <xmx:6tZsaRlvVb0VvsqdV908cwjLSgW-PNm6zxWiAHFz9HRcGx036MdwkA>
    <xmx:6tZsaXTR1UGarEGXwiQ0hY-mQ7Hh6Vp6EbSR8OesNoBfOANfD7FMAA>
    <xmx:6tZsafLkkiMtCQqp-jyFxv6jxiluGSMcXWiSySB-UVF85gxvlGVkXg>
    <xmx:69ZsabMpkF9PSitWVIzhv6tMCzvcnYoDN7fa0O33DZtulev2DJlQ3z8r>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 07:49:45 -0500 (EST)
Date: Sun, 18 Jan 2026 13:49:41 +0100
From: Janne Grunau <j@jannau.net>
To: Nick Chan <towinchenmi@gmail.com>
Cc: michael.reeves077@gmail.com, Sebastian Reichel <sre@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 1/2] power: supply: Add macsmc-power driver for Apple
 Silicon
Message-ID: <20260118124941.GB55832@robin.jannau.net>
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
 <20260115-b4-macsmc-power-v3-1-c236e09874be@gmail.com>
 <20260117122634.GA58217@robin.jannau.net>
 <42645fb0-3ae1-4ded-91db-f1435fa79a72@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42645fb0-3ae1-4ded-91db-f1435fa79a72@gmail.com>

On Sun, Jan 18, 2026 at 08:19:38PM +0800, Nick Chan wrote:
> 
> 
> On 17/1/2026 20:26, Janne Grunau wrote:
> > On Thu, Jan 15, 2026 at 06:08:15PM +1100, Michael Reeves via B4 Relay wrote:
> >> From: Michael Reeves <michael.reeves077@gmail.com>
> > 
> > I think the driver is overall similar to the downstream AsahiLinux
> > driver so please keep Hector as author.
> > 
> >> This driver provides battery and AC status monitoring for Apple Silicon
> >> Macs via the SMC (System Management Controller). It supports
> >> reporting capacity, voltage, current, and charging status.
> >>
> >> Co-developed-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> > 
> > The downstream driver a quite a few more Co-developed-by:/Sobs. When I
> > squashed the commits I decided to err on the safe side and included
> > commit authors from incremental patches as Co-developed-by: Why did you
> > drop those?
> > 
> >> Reviewed-by: Neal Gompa <neal@gompa.dev>
> >> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> >> ---
> >>  MAINTAINERS                         |   1 +
> >>  drivers/power/supply/Kconfig        |  11 +
> >>  drivers/power/supply/Makefile       |   1 +
> >>  drivers/power/supply/macsmc-power.c | 834 ++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 847 insertions(+)
> >>
> >> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
> >> new file mode 100644
> >> index 000000000000..9b3faefe7a45
> >> --- /dev/null
> >> +++ b/drivers/power/supply/macsmc-power.c
> >> @@ -0,0 +1,834 @@

...

> >> +static int macsmc_power_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
> >> +	struct power_supply_config psy_cfg = {};
> >> +	struct macsmc_power *power;
> >> +	bool has_battery = false;
> >> +	bool has_ac_adapter = false;
> >> +	int ret = -ENODEV;
> >> +	bool flag;
> >> +	u16 vu16;
> >> +	u32 val32;
> >> +	enum power_supply_property *props;
> >> +	size_t nprops;
> >> +
> >> +	if (!smc)
> >> +		return -ENODEV;
> >> +
> >> +	power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
> >> +	if (!power)
> >> +		return -ENOMEM;
> >> +
> >> +	power->dev = dev;
> >> +	power->smc = smc;
> >> +	dev_set_drvdata(dev, power);
> >> +
> >> +	INIT_WORK(&power->critical_work, macsmc_power_critical_work);
> >> +	ret = devm_work_autocancel(dev, &power->critical_work, macsmc_power_critical_work);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * Check for battery presence.
> >> +	 * B0AV is a fundamental key.
> >> +	 */
> >> +	if (apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16) == 0 &&
> >> +	    macsmc_battery_get_status(power) > POWER_SUPPLY_STATUS_UNKNOWN)
> >> +		has_battery = true;
> >> +
> >> +	/*
> >> +	 * Check for AC adapter presence.
> >> +	 * CHIS is a fundamental key.
> >> +	 */
> >> +	if (apple_smc_key_exists(smc, SMC_KEY(CHIS)))
> >> +		has_ac_adapter = true;
> >> +
> > 
> > I think a short circuit check for !(has_battery || has_ac_adapter) would
> > make sense here. The setup code for props is quite long. It should
> > return -ENODEV. ret is not -ENODEV. anymore since it was overwritten
> > with the return value of devm_work_autocancel()
> > 
> >> +	if (has_battery) {
> >> +		power->batt_desc = macsmc_battery_desc_template;
> >> +		props = devm_kcalloc(dev, MACSMC_MAX_BATT_PROPS,
> >> +				     sizeof(enum power_supply_property),
> >> +				     GFP_KERNEL);
> > 
> > I don't like the dynamic allocation for the props. I think we can
> > currently get way with static property arrays and so we should do that.
> > See my comments below
> 
> Dynamic allocation is needed to properly add support pre-M1 support,
> as the SMCs in them misses a few keys, yet in iOS 16 the charge limit
> (CHWA) keys are added. In a similar way, there really is no sane way
> to add any new properties for M1/M2/M3 with static allocation. So I
> would prefer if dynamic allocation is kept.

ack, I wasn't really thinking beyond the code in front of me. Let's go
with dynamic allocations. A check that nprops doesn't exceed
MACSMC_MAX_BATT_PROPS should be added then.

Janne

