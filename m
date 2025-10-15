Return-Path: <linux-pm+bounces-36203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B4BDF80D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAB304E1CE8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ED2326D4F;
	Wed, 15 Oct 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="pPbgLUeu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbWf5DqA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596B274FD0;
	Wed, 15 Oct 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543907; cv=none; b=f59ONwbTsws0lqZ4LUKd/M4YsSpbxwKg+jlpcJoDyuZGYqJgrMPwv+PMZ7zflu9vXVRfj1gr2+m+76PS91Rm4oSVNNVX2CiX9o6jzg/WfjOgORkxQeH9JzjM9GOzWP+2CJJQfqCAmc3XyevYmXqnRdj4sLxWRLPOPBCk4UbA+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543907; c=relaxed/simple;
	bh=9l5pycmYyWeYfogH3fTACKG5dgTGhaJH84tIHct0vPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DORL7UM4yJoCGQOYb1XaF7eF6XduihyUOzOj9e3QkprQtfR7taiuNRMbHc7zbJbsDtAc1FvRML5LeUQ07UqG1HO1hoCPMtnwIDDGwbNdmKS1aRK3Cpr82NtU4Dr+XBg8oQr0DAG+yXO+iV/AJLgG9IYYi9tr3yfY7amyyQMsXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=pPbgLUeu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbWf5DqA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CAD211D0011C;
	Wed, 15 Oct 2025 11:58:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 11:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760543903;
	 x=1760630303; bh=lVvaOJQZr7InIGqAb8bZi/qIpd6EgmRl6D9LmZZh1QQ=; b=
	pPbgLUeuXnjuhlkGUP/5IR/XtBJa3xgTmdbP6zIXtv1hXanKX4xCSXC++NTOSZsv
	kpM9CTnugxs021YVF50FKqCQxenLGVN5ogOeiBNaA3o7/Sz6+gZlz845nSSESu9s
	kTIb7MD3HjuFd9TDBaew09nVZ8Ph3FvaqEDPzNBPQCDa6CnkIiVhdXcpzNYQrUei
	pFS5NTUgrauzVvsUmWNIatbT60Xb6ia44BwH77G6jQ6zwCnwfb46xkbhrPEnnCCH
	eEYBruVZtOBsBha7VMEXa6prV+Le616BxtS+qJHH+SE4U+sDVtod8g5QM5N/iEv/
	FpDStuU/L5qhEI0yPbnllw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760543903; x=
	1760630303; bh=lVvaOJQZr7InIGqAb8bZi/qIpd6EgmRl6D9LmZZh1QQ=; b=J
	bWf5DqARsYqksIWczTgql6Kt+uhD3YdQcTdPzBKJdfZ6NPyKOCL+RDuZgH/U6Bic
	BkumfE5ZgBKglfkIFGcmle1igjtc6m0a6dNecElMfz2fPjMFQB0IRkqBd7k1dmH4
	y8vMAV7b8CR80+HB8Zb0TukHfxdDlLctg0xBhq/BrxPNfqJ+wmPPPfnpKdkzV3Sy
	YdoJXRL8XfQRO/JFyL9m2tibe+NyTg65NAxi4zKvHHEgWg5EzbKbvV0A2fsArHXW
	0Dxi9KjTnO6B82VeKNJxXuSFb8Ea5Iz0bNWa9W8C3Xmxhs7Jc50SQMeQZsj6lvUn
	sBEYx1Ec1J0mw4OtR0Bgg==
X-ME-Sender: <xms:n8TvaPJefqEJNlTwBr2qldoeOmHNhan3248S7rUHpyuxrdLcqaxtiw>
    <xme:n8TvaIGOwLx24ADttieWO_4AZvTVbSb_4uI_Oluya2A1dibkfHr9OhVAzg8PoDye5
    PnO_CgsYARlbkRq37tWJ8hCMUf1J62hcb6SoHtFHGcnQmuGgR2Cvcs>
X-ME-Received: <xmr:n8TvaL_CcBwaf2fYHkPe44l8XGdstWgCD4qlAdla0yri_tHmHyU1miHeBQU90xuHO86rGPqy46lpW8Y6Mn04o8cNkPnRaOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:n8TvaII7sKZVfpIzA_0MoDm_Af-RRqYvOmncYB0m9rx6Xo0snhhu3A>
    <xmx:n8TvaJseX6-mfzf2wOlMLSolEq0P2eIzzA5Ki4xjiFwRWZqk1AmMiw>
    <xmx:n8TvaPAwrznGpITb34IvTQvOUqwMWgWBqYuHJI9GRO99x_Ia743K9Q>
    <xmx:n8TvaBOvdaYzAfp70OWSQR_O3XTwLYZCibg4RkKz2MkRW_mRBG0Kqw>
    <xmx:n8TvaP3JHYlKwq9tfEK2XpKYf2YE5tM6YORZCVgCYPlru4PsbhCaQ116>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:58:22 -0400 (EDT)
Date: Wed, 15 Oct 2025 17:58:21 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/rcar_gen3: Document Gen4 support in
 driver comment
Message-ID: <20251015155821.GF439570@ragnatech.se>
References: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015141014.156437-1-marek.vasut+renesas@mailbox.org>

Hi Marek,

Thanks for your work.

On 2025-10-15 16:09:51 +0200, Marek Vasut wrote:
> The R-Car Gen3 thermal driver supports both R-Car Gen3 and Gen4 SoCs.
> Update the driver comment. No functional change.
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

Super nit: I would write "Gen3, Gen4 and RZ/..."

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

