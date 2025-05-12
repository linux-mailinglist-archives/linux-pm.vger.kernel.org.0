Return-Path: <linux-pm+bounces-27040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA0AB35CD
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 13:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C85F7A2456
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BAE291166;
	Mon, 12 May 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ZEZoO2tC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o71VIvkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B92900BE;
	Mon, 12 May 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048735; cv=none; b=WkWmsUM4CihpXsxBEM1QXnKYqXXJwWWI19EQ+P3sg9H22Z8s6P5Di2reOWi+akuRVMx87pBj+Ohvdbwi8gS4ppi1OEJia1iG+sQp3zYLyqP5x/qkCsgjW06zPPATmU5jHfcz+hP0klDiIpDRFJ+SfjmiPRwM7DZpUKdg4MIN91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048735; c=relaxed/simple;
	bh=jBZdiSf1gf5BKRqqB+Fpy8grw8nZle3zN8U9da1iFnI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W/jr+hocfti/oAuHA1vLyvIPr8YQHxfRHSai+mfEe4z3HKKc+goY8o+SBTjt5VWJKHNjjkmOQyE6AOVdZkULENophmsn+xH2HBQzdKmTEcBNhRHxioxMgaUALiyx0FhTkiUjHC8W7zEE5/z4vFQzpUCZy9QXoeT/9KSzGiw0qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ZEZoO2tC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o71VIvkb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE918114012E;
	Mon, 12 May 2025 07:18:51 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 07:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747048731; x=1747135131; bh=8R1AryTPhNH6vqIqKW5/6ef09cTbxqCZ
	txeiuNj7wb0=; b=ZEZoO2tCNmwSdnwnJxE/d1l9NlLFeCFYdL0qlb6qL6xIlCPf
	hF2iarJizQyLFm8x2KzLfRavW+65RwLZHkD2macXXgtP6ZkCR07kM0AsMWAp4mP5
	b1eHvSoBA+6Y1KRtwiiXn1clD7x2diHeX+E3o0yc5ySfTSSL5vLIoE/gmVtSk1ja
	O+2RKLohnsiXP8AftrNWX5Df2sNZ78C9D8Mx8vx1N27ZNQ9mclwYCS5j1KNa5y0C
	WqCsmTLdTq/BdKv00MQha/vAZFHY62liGcGHS4aPPjj7oKo0bApwiTeKYHgDElX/
	PKUzBACRUNmz8yku5JBHwNrVOlPEndAcwsBcZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747048731; x=
	1747135131; bh=8R1AryTPhNH6vqIqKW5/6ef09cTbxqCZtxeiuNj7wb0=; b=o
	71VIvkbuLT3kGsowGOJJcwdT42sXnEfrYjJ481iyRenFZs/DjdVBy1erScpkFt89
	V1mJO2Qawd1M/+e5lOfWEMYqfjig2Ouw6Wa8HDebNGC43Bgrq3nNLDGrY6DZMCaB
	MgbEcqwwLuVMnKkI6hmhYUxjAhvJeAQbxxwe4tYjfYYVEl4m4aqY7SOzrEmiqcJA
	YCG99UzfVsP3WUWe3s4550bBnG3SRs23K1+XUeFuSDlm7UZvXsuPVvfCLfispM03
	QbC+S0LuaBVPM+MmzRmbSHUseByDwzim/FBz3QN6b93bmoLvzY/SEZzShopzdecr
	TSXuPMMCQI3EZ8C36Grbw==
X-ME-Sender: <xms:GtkhaMuxhIixs7p21gBf1a0Z3lGaLN01jbE7aoEXMUjV0ATKxr3m1g>
    <xme:GtkhaJcxVpGSL22cNbzohzJd4xiwMe3KVqA6nHUL9mZ1CDii7lQHmbNRdtxEZHq54
    BeKmKBo9M8LPqBzbKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:GtkhaHwf1fLs4ujDzYRV9p3oA3Lt4JG2bsbNc20DSXmw_eocXzmFsg>
    <xmx:GtkhaPM7O7JUWdN5Wd4NEAF-FcE-62VNd7UGjUafuz50M1xr5tBgQg>
    <xmx:GtkhaM-cXFV8dPcEYGmRkbX2dgNTmYprkObOHjphG973E1qh_XFlPA>
    <xmx:GtkhaHVaCx-SAYUC_qxcEr6LGzVJp6dM-85d--eaFsj7mQ3c6yV6JQ>
    <xmx:G9khaM_l9MfNgcxlpMCOrs9zCtzwYcG-SDIeitwMfLz4Wlb9mB0NWHtw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0A6521C20067; Mon, 12 May 2025 07:18:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T54af4484963dacde
Date: Mon, 12 May 2025 13:18:29 +0200
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
Message-Id: <50f35475-958e-481a-83f8-f19fc2259191@app.fastmail.com>
In-Reply-To: <aCDVgI4_LtE6OfO-@blossom>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
 <20250511-smc-6-15-v5-5-f5980bdb18bd@svenpeter.dev>
 <aCDVgI4_LtE6OfO-@blossom>
Subject: Re: [PATCH v5 05/10] mfd: Add Apple Silicon System Management Controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Sun, May 11, 2025, at 18:51, Alyssa Rosenzweig wrote:
>> +struct apple_smc_key_info {
>> +	u8 size;
>> +	u32 type_code;
>> +	u8 flags;
>> +};
>
> This still has the padding problem from v4. With that fixed,

I somehow managed to drop two !fixup commits before sending this out :-(
One of them was moving type_code to the beginning and the other some cosmetic
changes (mainly starting descriptions with uppercase letters) to macsmc.h.
Will be fixed for the next version for real this time.


>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Thanks,


Sven

