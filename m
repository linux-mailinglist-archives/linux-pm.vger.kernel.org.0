Return-Path: <linux-pm+bounces-27006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67049AB27A2
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A073B38C8
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC331D5CFE;
	Sun, 11 May 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="dBVe67lX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eARh53/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC41C862B;
	Sun, 11 May 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746958513; cv=none; b=pZVNy2p/S4W+GUg4rZtN5l2iu7S2txmsg73HlOXYh79o0Mp84e4EVs6mK37IbeVzQ67y3vYnhrFlVhRRNrYNl3bwFijEuQVLLqU2KmdH96eeOdVPSyCV1VWyUUNta7n7YJV8sc0GsjhgJHiod9db/V/YRQ3L2aohWmCjjYy5qys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746958513; c=relaxed/simple;
	bh=tCmDfNwDsZk/3rZfK3h1oUOzUlRnrxuzRcHS6LPaiQ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fpOgo0uX6fC5i2K5mygKVwH6b4yRKjs1FRsTFa0DyHhA2C+Hj/jaSjmgVgkotUWtBhuKvB/g2BXhjSQgZvO9hSAbQsJd7r1LMX+Kx3Uzvkl2X8hUSRoxQStiyFS7bXrwVgBs5hYMzCAYHQ4Fn1UHluaA3bAtqtYdhyXtfV6Cbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=dBVe67lX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eARh53/i; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E41911400F6;
	Sun, 11 May 2025 06:15:10 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Sun, 11 May 2025 06:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1746958509; x=1747044909; bh=cV+CqJ2sR58/2GW2HDcotcUwO0tRQwcr
	M95nei+5RVc=; b=dBVe67lXrNSWSmfmKAbaBz4/sqEcMnCBISmSB32wPnaJBdj4
	+G1pyzvsyCnhq10UP92fVtGmjM5ueVoNOmp+uu9utLnTTiYWlvFkZVdnwnTBIfkz
	Ji+pUNNmgQK3OWgVD6DD3iuqWh7ftAi22kGaX4Yq4faOlglSSwvfHy3sI/DWP75j
	0kgxc6feGAVxTVBPDNcCDjhB9ukrkzd6bYtRcfsj5jmx6IvNbvTgfJAu6pnkN+Rv
	/mFB/UpIwJzK975Jhb71VMshgWMuJbw+q1vELE9Iv0UB9jCSk6Q3veU229zUwVte
	XmkmTnbPJknwv85vaikliZ6tfWXYZEwumAVdtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746958509; x=
	1747044909; bh=cV+CqJ2sR58/2GW2HDcotcUwO0tRQwcrM95nei+5RVc=; b=e
	ARh53/ipxqudoE7Kx5TComMShvZsuDuvuIpZkzKavyOXP4VFgRtuu8gQLZaiCRMc
	8VxIQID21/kk/nJlTYkSmIDgAIYRnXNKe3VrMHftnhFEXSsOA2dF8w8Wnz48MHOw
	JGe76DkS21VozvW1xTmDLUzXdjI5Q9iXdkkO9EtbInxemgifibhY3gCjItBSeYNx
	rBVr12iTq2l6lcNmfZxzVM5H0RZpxsOSi5swvV+om/IpeuORqVpccY6xDTdUX3EH
	MHFTJVJevXsO2mccsa6Nmif0u4WaFda3IKPA7CvRAjbTQC+uGZPlf0ZJ2urGA/PY
	NgL2PGYT6THdVlJDzzMew==
X-ME-Sender: <xms:q3ggaO0qrEf7AfPcxgAhV_4QTRZrwThYeSBOtnpoBPpOvAZ-djIx6w>
    <xme:q3ggaBFRUZMDlh9ceevrv2RCzzXyDaO7FceMfX6QVhfKB5NF-WjiICVU1HuE7nmWe
    VQByCJnWafxEhZdVt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleekudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhmkhdokh
    gvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrghhlsegs
    ghguvghvrdhplhdprhgtphhtthhopeifrghhrhgvnhhsthesghhmgidrnhgvthdprhgtph
    htthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehjsehjrghnnhgruhdr
    nhgvthdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgriieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q3ggaG4igTnPWHT2ytCAlkCxt2qsSTjbTCgVlWXLGA2Aap9ZBRFtQA>
    <xmx:q3ggaP3oNedhlr9WMSbKBbbZoOQ-Zp7jU6WhxYL_XZLzcw3tRkv6gQ>
    <xmx:q3ggaBFGx0ys088vMTLjsa5tvs94U616_aItSTuxW3lYg5tokEOYfw>
    <xmx:q3ggaI-3XpB95lGxgwa76HNTTGouranUQEu9Qq6z9lPDtp7Ipmtq_Q>
    <xmx:rXggaLfR6dFUBzPlbcQeP94Q1N4fjgXUnLJzjJef-Tf-n02itAHvXc7c>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3EA41C20067; Sun, 11 May 2025 06:15:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tee5e6786d5fc82a3
Date: Sun, 11 May 2025 12:14:46 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Hector Martin" <marcan@marcan.st>,
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
Message-Id: <5a0263f4-1073-45a8-a8aa-76028a2d0b6e@app.fastmail.com>
In-Reply-To: <678528db-67bc-4bb7-a866-7b8aeb4f4510@gmx.net>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-7-f5980bdb18bd@svenpeter.dev>
 <678528db-67bc-4bb7-a866-7b8aeb4f4510@gmx.net>
Subject: Re: [PATCH v5 07/10] power: reset: macsmc-reboot: Add driver for rebooting via
 Apple SMC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Stefan,

On Sun, May 11, 2025, at 12:07, Stefan Wahren wrote:
> Hi Sven,
>
> Am 11.05.25 um 10:18 schrieb Sven Peter via B4 Relay:

[...]

>> +/* Helpers to read/write a u8 given a struct nvmem_cell */
>> +static int nvmem_cell_get_u8(struct nvmem_cell *cell)
>> +{
>> +	size_t len;
>> +	u8 val;
>> +	void *ret = nvmem_cell_read(cell, &len);
> in case this series needs a respin, please rename the pointer (e.g. 
> buf). This is very unusual, because ret is usually of type int.

That's indeed odd, I'll rename it.


Thanks,


Sven

