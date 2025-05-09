Return-Path: <linux-pm+bounces-26964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FBFAB1A3C
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BF8B271C2
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2132356C3;
	Fri,  9 May 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="DaE/t9us";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csaqIxHM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40521517C;
	Fri,  9 May 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807271; cv=none; b=uz7hWUORx/h7BwjyjPmn56KA+HVLbG8TsvfvJnqti6DLXsjIKJSENgfuYJmmYQoGAWA8KQOs0aYaHTFcwaNS+hnqbYgYxsuhuVsx4bbgJJMA5y3RY34GQFLs0sqb5+aAB8JwuwcoSRHpKRAxadzziHAP7HK7tVzpqWKHRptnUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807271; c=relaxed/simple;
	bh=ReBd0VghedSq6F65PBL5sD14utQA43skxapmkjoJDiA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ppxwz3w9JQzEBpJ/cc43NGRc5qjZ5k3q5AnBpkYcx7rmAm/QjnmWN1YWUeyHbZjvh5Z1/H+EAs41sS1bG5+leBzuWa76GEEFhyTXk9t0PcWr0DJNnAGXRYy/mvUMIAb2YfPrSYmQYmLrrth1Zzkhm2pQaPntvM/HFFniFe0wjts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=DaE/t9us; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=csaqIxHM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FC21114011B;
	Fri,  9 May 2025 12:14:28 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1746807268; x=1746893668; bh=OXbezUHKcYvu1Ptzr6+1Xx+ex3X8GOpu
	nRzS3Jp2Cx0=; b=DaE/t9uss9mpBJoxg8WG84xuq9HK3gkZs7C10WZatQSUBvcW
	N7LQWH2kCi+VAVRsNjj3kWjcdUU6b2p4Hc0huz+0LN46xMdIpEGJYNAQ38ORqhOb
	ExrTby5c0RLt0NIe5AZ3+kw4zwrD+nLzTYYWx/4UHz+AJ4mBd2cOk+Ach49rRA39
	MCt2IdNJKFLWyqxJvsngKoNvtTXT0ma+SkVrv1u2liE+7Wcy3IzM6X1bwwgNj7GX
	S2aGVQ1Ue2vPsfdxJ2U9jt1i71C1O70Rulee4QpqLnEhAfLsp1QnDZxLpj0hrfMd
	sfIZJfJG+bdyVahYVVMiL8UMnqcDo5hP7d5FwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746807268; x=
	1746893668; bh=OXbezUHKcYvu1Ptzr6+1Xx+ex3X8GOpunRzS3Jp2Cx0=; b=c
	saqIxHMcu+VEiQmjFN4OZFefjyF47XLBIMrCPMbfHpIqkHCvwSSJGaFLiybkaV5d
	Jz9hSQR/49ozNx020jkMYxI+81Ohvp2Ibyohj31qnq4jEKsMvoLKyf+YEmuFgRc3
	C/7/PA5u6CPQQp4Jele7AkZCvtORwTBnDHLhL475VMUAzsn34f2DwyO9dY9+ktW5
	DIyKbS+Thw1jg0i2siLWI+Z5BZqskjUeOKJC1G1X6Poq3eYq8D5MEgdyAwjYgMJ7
	pNOsDCawDTd4Gn7KXwtG56/lFMPydrktp0v+PS9zN6x3iJ+Y2oN8kWNuzVowlY+M
	8vEQl64Pa4Nsg/ZcEPWwg==
X-ME-Sender: <xms:4ykeaCJOg2jKgtx7pKFznBIP6u7nmFfH3ZzoxhtlUVhUiLltKKog8w>
    <xme:4ykeaKLsaENKTxDUu4N1BGOZVGZ7VtDQpIbt-15tSGdrteaRt25QLiWZNNYbA3Onl
    xbbD9GJeARVwsGuY-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeftdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhmkhdokh
    gvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrghhlsegs
    ghguvghvrdhplhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtth
    hopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgriieskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4ykeaCul_pCvPXQDFfMwRyhKptftWme9TqBcC63VhwBW4LYz6JsDKQ>
    <xmx:4ykeaHZhWFevFxHrPdMCFEF5MBsiGKQejjaTiJys0MTt1kczdZoNRw>
    <xmx:4ykeaJZHPQEdBgNbzM7NINTFQD42j66G5LNH_BbwrLL13tFtJZWnaQ>
    <xmx:4ykeaDDblii-Ktq1U2trbst6o-SBPUSkjI9lL_W-3cntbNWMWCU-Qw>
    <xmx:5CkeaH7A37GhqngamR_x-oDBc0s_YAmK8Aaxd2kNXJqprE5kDLwul7qM>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7072E1C20069; Fri,  9 May 2025 12:14:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4bf42f97a4fae5f2
Date: Fri, 09 May 2025 18:13:09 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>,
 "Hector Martin" <marcan@marcan.st>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Message-Id: <196f84ea-6567-4fe3-9bee-743bb289223e@app.fastmail.com>
In-Reply-To: <aB39iJm9759RYAKW@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-6-500b9b6546fc@svenpeter.dev>
 <aB39iJm9759RYAKW@blossom>
Subject: Re: [PATCH v4 6/9] power: reset: macsmc-reboot: Add driver for rebooting via
 Apple SMC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

thanks for the review!

On Fri, May 9, 2025, at 15:05, Alyssa Rosenzweig wrote:
>> +	for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++)
>> +		if (mode == ac_power_mode_map[i])
>> +			len += scnprintf(buf+len, PAGE_SIZE-len,
>> +					 "[%s] ", ac_power_modes[i]);
>> +		else
>> +			len += scnprintf(buf+len, PAGE_SIZE-len,
>> +					 "%s ", ac_power_modes[i]);
>
> Nit: { braces } at least on the for loop...

Will fix that.

>
> (And might be more concise as
>
>     for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++) {
>         bool match = (mode == ac_power_mode_map[i]);
>         len += scnprintf(buf+len, PAGE_SIZE-len,
>                  match ? "[%s] " : "%s ", ac_power_modes[i]);
>     }
>
> though IDK how people feel about it.)

imho it's less readable that way but I don't have a strong opinion
either way.

>
>> +		mdelay(100);
>> +		WARN_ON(1);
>
> ...What?

This is done in a few drivers in drivers/power/reboot. If we haven't
rebooted after 100ms something's wrong with SMC. I'll add a comment.

drivers/power/reset/tps65086-restart.c:	WARN_ON(1);
drivers/power/reset/atc260x-poweroff.c:	WARN_ONCE(1, "Unable to power off system\n");
drivers/power/reset/mt6323-poweroff.c:	WARN_ONCE(1, "Unable to power off system\n");
drivers/power/reset/gpio-restart.c:	WARN_ON(1);
drivers/power/reset/regulator-poweroff.c:	WARN_ON(1);



>
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "Failed to register power-off handler\n");
>> +
>> +
>> +	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART_PREPARE,
>> +					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);
>
> Nit: squash double blank-line

will do.


thanks,


Sven

