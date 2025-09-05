Return-Path: <linux-pm+bounces-34026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B5B46409
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B721C86356
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB0283121;
	Fri,  5 Sep 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="aJEUvpQm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRZ7ZsQ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40861E55A;
	Fri,  5 Sep 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102351; cv=none; b=WBfZspVF1EFOsAfhFUD9y/V9+Y9yWc9H1f4GV0gmarExm66i3Hysd6j8nWbLg0Zv/fSi5dSjHWNGrMkVLzlElJI+Ao3X5MgtY5Dvj5y+6MrdVUJbKDTQOwTsehYT84lmkVkzGG7jG8kItZL41uk0w+EjUoTIz15xSNQ283XJsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102351; c=relaxed/simple;
	bh=P69v0RjJ/1HhflldI2zS//OsaLLhmdwzpEbl3SC1MoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8soS2bSz2VuGAnf4/ryukfMmsRJho1pCyU8gs4z2N9l+g/ksukixNsgSfOIpIvGlKWI/7PDYEi6yIspb1JGkTw/BlomHKlmJPUEHiDlZssWCJeS9uGlwdOWSQbYsZ9+FITAdORwflbHJR/C/J6jb8Tn84HC4v4iU3eepoUvldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=aJEUvpQm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRZ7ZsQ5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6034DEC0369;
	Fri,  5 Sep 2025 15:59:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 15:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757102348;
	 x=1757188748; bh=Ihr2nGMrA7SrxtqaATN/qj9edQvgu9qlvw8CXfM7AHg=; b=
	aJEUvpQm0fTZOAWzprgDF3Vk5XXmdejTjBuZVB4F4o5OXNN54d12ZOz9tgEa5SRk
	+TV+6WQ63HVNfurO8OjUyIiWuO257j6NdIo1FwAJnlu7lzQ2ASziPXuboMozTv/4
	t3hIvOtO5xywwTH1Hsxqi6iNCEaz0HgRMWr1t3zEs3LdM9l3g9OJKWgsBoziMcLC
	sU0PYd0Mi42ihP6pl3f2JWPDmrcsuW/KfbkDZtySyzTsWVsFxENpKxud/MVAzYR0
	fZB4bChMvVPgXWkjrftM+EP8vO0TUteifZj9ETnHhhfQh4GIcOB7oaRzdr0+QaIX
	9N5D/N3zPn6ahGqDNQY4NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757102348; x=
	1757188748; bh=Ihr2nGMrA7SrxtqaATN/qj9edQvgu9qlvw8CXfM7AHg=; b=P
	RZ7ZsQ50MVu+Xpc1TRra0H7put71OygcTmoyi2KAorv4nq5py+KfE3oP7xN23KSH
	nK5Wmp88YT1myDxXjBDN5Jv+bK6CJmGpq286RXjoBvUYO347YVhBamFtJaf/S0U6
	lNmps/NU6twsdzjRKKgnqQXCg7vCBacoMumQrXwL3IcSvFQBPBuDNyOAGTo6cVt9
	2Umgoj6w5DRY43Z0wuPig9P5iPVVaeliTSy+hqpsjrhQK50IptlK/3uP9+9H+FXE
	YpBbFV6mZXBiR0kX1L61RHVXBGVAcrkPz7anfbge9MApCXTjDFSIz8QD2a6Zv8cW
	fS6Na+OFhPkr8r+TpDgdA==
X-ME-Sender: <xms:C0G7aGvA-9VnF09n4T4T6oDo61ULzUXUMyvMOoO3nyVIiZKBbvIMdQ>
    <xme:C0G7aGE_NfmHzPIIJ0Nj3lAYTRYqBHPkyWLWmkvOmsqwLo2MI81mvs5-Ko206Sl0a
    oTJvijw5uM3tvE7MG8>
X-ME-Received: <xmr:C0G7aHzYqo-gfeEeuF5x1xqz3iJf8a5ZES9dTPxwMSxi-d2b9yKOlSGt9Mr6EuymYfyNyEzq6VU4DseXxdS7Vf5QWgO2jNNk2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgrshcu
    ufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvg
    gthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheetheek
    keegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrght
    vggthhdrshgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrvghkrdhvrghsuhhtodhrvghnvghsrghssehmrghilhgsohigrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgv
    lhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghgvvghrthdorh
    gvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopehluhhkrghsiidrlhhusggr
    segrrhhmrdgtohhmpdhrtghpthhtohepmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtg
    homhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
    oheplhhinhhugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C0G7aA2RlI1LXPe5W92YM4PaBXtrusDCM5Ichdv_BpS8X7Iai_HBxA>
    <xmx:C0G7aHpXWzged01duQ2rar9iZcQ_M9b3rHeKL4zJ42Xo-TUf49Uz9Q>
    <xmx:C0G7aNUTmvNE701JTvr_Fj6Y36bLbPlOnAsxbkxsgKZDPvrBYaW2Bw>
    <xmx:C0G7aArRPFUdwShFj8U86DxNtYMOYwh06AqDD3c54q0GfgH0qKNv4Q>
    <xmx:DEG7aDiKY1y7g7ibaACkiyaylctgFz47WOa_N8NUPEvJOuQG4ez-4L48>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 15:59:06 -0400 (EDT)
Date: Fri, 5 Sep 2025 21:59:04 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in
 Kconfig entry
Message-ID: <20250905195904.GA2033628@ragnatech.se>
References: <20250905193322.148115-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905193322.148115-1-marek.vasut+renesas@mailbox.org>

Hi Marek,

Thanks for your patch.

On 2025-09-05 21:32:56 +0200, Marek Vasut wrote:
> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
> Update the Kconfig entry.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/thermal/renesas/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
> index dcf5fc5ae08e4..f4af8c7f28b05 100644
> --- a/drivers/thermal/renesas/Kconfig
> +++ b/drivers/thermal/renesas/Kconfig
> @@ -10,13 +10,13 @@ config RCAR_THERMAL
>  	  thermal framework.
>  
>  config RCAR_GEN3_THERMAL
> -	tristate "Renesas R-Car Gen3 and RZ/G2 thermal driver"
> +	tristate "Renesas R-Car Gen3/Gen4 and RZ/G2 thermal driver"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	depends on OF
>  	help
> -	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
> -	  the Linux thermal framework.
> +	  Enable this to plug the R-Car Gen3/Gen4 or RZ/G2 thermal sensor
> +	  driver into the Linux thermal framework.
>  
>  config RZG2L_THERMAL
>  	tristate "Renesas RZ/G2L thermal driver"
> -- 
> 2.50.1
> 

-- 
Kind Regards,
Niklas Söderlund

