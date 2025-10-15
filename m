Return-Path: <linux-pm+bounces-36206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6816BDFE41
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 19:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892C43AFD8A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05382FFF9D;
	Wed, 15 Oct 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Bl/e5l7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kK+hkijt"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4552FFDFA;
	Wed, 15 Oct 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549589; cv=none; b=M/2OaXOHi1IBI+ZS9S6Eh5VhHm/MdGRHUtqsOTEgZ4jLfFcCg3iV5oPfti/T8GEsfAhj+PjBk5uwvtgDN5+SnDuO4rU4KoMS95i9nhqXg6SVXY8CqhJpaySW+MVsVAJuV60G9CRjGcpca5nNhdqexxvS+gMFI0DMIThfbMEGjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549589; c=relaxed/simple;
	bh=85CV8PNCwtAjXfzdL2Yq2usOEFHJrQAflgQpbV1FMA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQbtxHWi70ZDOLwuMcsGCcbQV3D1VdGVCflvLoJDt5oyntIkqsQXxDXDuoCBY0RXmEuGtsTXcnOcwX8CLRe7MB7y6E8VYIjBqRK3W9FJ0SuWZFpFZC4u9Ym4ikpctwqh3JenuaNVzHZ6eFW5vQy+L+9uXlyBljaDZeeT5GzVnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Bl/e5l7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kK+hkijt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3882D7A010C;
	Wed, 15 Oct 2025 13:33:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 13:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760549586;
	 x=1760635986; bh=8QjXh8E1okcV/Gh4eC+R3CGH60JCknIAHdghkbl4JUc=; b=
	Bl/e5l7gmK+t3tWfxGUPrD5IgsTwIzbHdy3JQFMhsREHsTIfp3ObV9bXnWdOnw6o
	OCxHv4BtUFZvUROPQyGhwQ7q+Wj+NWAVL9WbNUDM8nLBi7RhdorZ50yPP4v5IS1W
	dcJ+ctnvtLj4tsxuI+SOJElFIJ+uP6Ra9MfClYRu7PMf8LWvSkx892GjXZjEA7Qn
	0hlSrdbZkQFsJYUJ9b6a89DGr9jNUsdgNC0O4fmtxxpxFtMjlBT0/Es+yygD/bEM
	/XwgkBrcLWwqdOKylm93ElMRc63nKCvXG0IbCd+tZ+T7o2DkoH3j/aSUWktUYrZh
	NUVVJKnojZtyM8pequ/Fig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760549586; x=
	1760635986; bh=8QjXh8E1okcV/Gh4eC+R3CGH60JCknIAHdghkbl4JUc=; b=k
	K+hkijtJhqoKw522j4wj4PInpA1JS7awNZpFlqtbXukUYRufORoKzbFsAQXA6Sfp
	8EvNwjdkINizCaP/YllfWybMJ1h6TOWwSCJ413fjM+HIRkjmjJXiN0x7lIAKv2Xg
	2fPsl8H1y+LmrSg4a4lBRMcuPhEkkPYLRmwOcWKOlh6Ufb7ZWkrdt8eYfnOau5Ln
	p2YpuVpnKQSthZcsTFgS2JksHfhrzO4LKZ1vJYXPiIO34BfAkXCC19AcBMWWCMFy
	AVQE6IMVf04fbZ0YcU1k9j6fAWtlBijxfGt+YdHH4Fyt3idRsbD6AO744NorsUn+
	BxuEmGilMhytG4AifYkuA==
X-ME-Sender: <xms:0drvaP-_Wt3iY60sbFQvwcHvRSlP5JivdENQKNhhbmkvZN3q-hxTJQ>
    <xme:0drvaAqPw_YTKtm4KSU39pAuUXIJaFahLnlmdM4OzKTqK6blcvYJvlh-jdsBSb9rI
    8pqiiAbb7X5f57BbJGIvX5TuXDDMt-LcdJY1vOMJxmb3sgCP6sK6ic>
X-ME-Received: <xmr:0drvaBQTf86BgR9JJLyZDkWCXuT3RVGKsLhiTlSkOTW-lRitcWhJATq5HObiDKWPk01afLA7pINT1OxGL0JOHvA7cNgso5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgr
    shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrg
    htvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheet
    heekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhn
    rghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmrghrvghkrdhvrghsuhhtodhrvghnvghsrghssehmrghilhgsohigrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghn
    ihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghgvvghrth
    dorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopehluhhkrghsiidrlhhu
    sggrsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrghhnuhhsrdgurghmmhesghhmrghilh
    drtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:0drvaLPNUBfd2stwPESjWtaqnzhTG7euPR6LuZNgmVTTTrDeHVMzcg>
    <xmx:0drvaHhjQSpyzsUeSy3RhPFmGC-rbulrIdqG8swJXSKsWVChZQd8Tg>
    <xmx:0drvaAkRofcmiMDCzStlroaToC_T9IYDf9y5hh18qckFAfKrMMbqIA>
    <xmx:0drvaLiP1Bpyobm7gRMGfhQz9YeRBtXj6Jjhdz4l7KevoN800QpWlg>
    <xmx:0trvaE68LyEqm-ykZ4ESd0hoPygPl0Du0D3WgDBkmieGXYQ-XoQoBhZR>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 13:33:04 -0400 (EDT)
Date: Wed, 15 Oct 2025 19:33:03 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Message-ID: <20251015173303.GA607688@ragnatech.se>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>

On 2025-10-15 17:58:52 +0200, Marek Vasut wrote:
> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs
> as well as RZ/G2. Update the driver comment. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
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
> V2: Fix up the commit message, include RZ/G2
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 3223de238d014..a143b087a8ea7 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  R-Car Gen3 THS thermal sensor driver
> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver

Super nit: I would write "Gen3, Gen4 and RZ/...". Compared to v1 you 
updated the commit message not the comment here. Not a big deal all the 
information is there.

With or without this,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>   *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
>   *
>   * Copyright (C) 2016 Renesas Electronics Corporation.
> -- 
> 2.51.0
> 

-- 
Kind Regards,
Niklas Söderlund

