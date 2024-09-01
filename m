Return-Path: <linux-pm+bounces-13305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1441967B7A
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E3EB210D5
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF7170A0C;
	Sun,  1 Sep 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="bRuPnwAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDTua4LC"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF228387;
	Sun,  1 Sep 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211898; cv=none; b=IkLMqH3VMP6HYeu1q0vEkHykXsbd1WFuf1KJE5PhV1/FwIGAgBiNrszG9spBQcQP5aq2mbroKgFYQ+vT/aGi19R0+1Ht5oSpJsZ8OQ7bfVPCDssw9ZohqZeS0FhGsnedh6ALi5jLgmt/j7fQz9XKd11e0aqqj5fMfskHFhgEGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211898; c=relaxed/simple;
	bh=8JBsROsXQzqZCJvcYV7efifwX8YKzKk5Cm3R6v5gLPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZooIgHLsW5g4Xl/k2h/qr1Wg6xlLmoU+1nPiyO6niIALzr6IWHxYsZQUwZulas67Vf/FIAgR9vLiP+VLMKVUr+pjftxmACtu5sPGE+k+9IQ+MyQmY08Wv/M3mk0LdSiL0cA459Ue9dBu92ipl2S7I6S3wZbTE0hARbcFfkmtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=bRuPnwAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDTua4LC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C35D513801FF;
	Sun,  1 Sep 2024 13:31:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 01 Sep 2024 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725211892;
	 x=1725298292; bh=Io+Az8Fo1EHe2xteOU7VUdj15krM6oAV2RGenEQ/Vdk=; b=
	bRuPnwARInxBH3bLIPpnMFPbjsxZ0qSPNymxc118d+6ZtshEgQjx1oOfgovHPsXB
	zSV+6kBEy3qIaBPzdxapVrd2WXczUn16kEwndDJKUjSUmkWshRzTmYle3vUMdN06
	ngY8V6PRj960cTXm0SnWgfX8pDfHR+kZb0OhW5HEhrogGhS3l6fy9YbPTExm5ndD
	Lqf1ww8pxVLrlMpjwU8fZV5DtDVpTKJTRU2lsRZvI6ubk00/pRHxGyN99Q1XhFhC
	dxix9o8uAWwzZC1WdXSeMGA7qxDEHUSMcjWFktBW4xcz3FWt2CJKmO1NwAkecTX1
	ePjyAgVnrvVgG89QDQoYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725211892; x=
	1725298292; bh=Io+Az8Fo1EHe2xteOU7VUdj15krM6oAV2RGenEQ/Vdk=; b=a
	DTua4LCvLAIMBSQHt7cLp15UufpHFu66bHabv0L93aWTl+T1LKOQcK6H7sRdd+Xr
	FsiBK1mcO8VMm/EXjx+P7bnva1EGT00XNq6oiWRgvvIjbgqpROxxuGc1s3aXjeFt
	2GQrAuPkR4HFZTcW3rk0rHOqycnT9/xzj+EeTXcZzZXLK5gPB0UUgPTIGpRBkVZe
	gCBr/k1k+CH+vTwjXMuE0jL2iI5kieq1b58kX9xIvs2KrkbX1817ekureUKmrzH4
	DP1EdxsRcpEFA8iiC7On1+d29yadX2REF7kc3JFZV5aAGg+bIOwtUuF/eqNEzSYA
	53DRz6ZNWs7eJjui8G7OA==
X-ME-Sender: <xms:9KTUZgST8MMU3IH5H35HfxmvJdS8yoAmaqph1wVRGuQd9cpxsoaGNA>
    <xme:9KTUZtxMKtlThTZTxc5cX1UO5Hz1bCpjJRw1nejjPNKfZFBwUxL1OStonodmbi4Ei
    8z0tBN1wmDWsY45q9Q>
X-ME-Received: <xmr:9KTUZt25QBJsAYbCI8_8OuJKnQDjxjC1hFdxtG6brRkqK982fmfdHtfAerHejrDozhVr9zo_HMcf5K9Je9bFdP1mjuyXH4WNLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhoug
    gvrhhluhhnugesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteeg
    tddvvdfhtdekgefhfeefheetheekkeegfeejudeiudeuleegtdehkeekteenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshho
    uggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtohhlihhnrdhirdhkihhnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthho
    pehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiird
    hluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrvghnvghsrghsqdhs
    ohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhjrghnihht
    ohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9KTUZkAdKy_YBpDGUapDMSxRn_fi0vf0ATa4ypmnZ6L8kvMM-Xz8AA>
    <xmx:9KTUZpi45oQKGy7U5A-aeEdaMfsz1XahFtlC7o1zbjYdwZZ3kNYQdg>
    <xmx:9KTUZgrFG12_zzwv0uOB3Lc3jf6ulxaPimv03Tb3mr4BKVoxqObN0w>
    <xmx:9KTUZshyr1uxVpZkA20EAqG6BN6GdkTrb72wl-_bObo9YDJu_XjXOQ>
    <xmx:9KTUZgMOQq7FFOjapLCD9Io2ViENnMXxGelEpk9mxFq1DVeStgQVEpAo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 13:31:31 -0400 (EDT)
Date: Sun, 1 Sep 2024 19:31:29 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thermal/drivers/renesas: Remove trailing space
 after \n newline
Message-ID: <20240901173129.GD3708622@ragnatech.se>
References: <20240901162719.144406-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240901162719.144406-1-colin.i.king@gmail.com>

On 2024-09-01 17:27:19 +0100, Colin Ian King wrote:
> There is a extraneous space after a newline in a dev_err message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/renesas/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 1e93f60b6d74..ddc8341e5c3f 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -447,7 +447,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>  				       IRQF_SHARED, dev_name(dev), common);
>  		if (ret) {
> -			dev_err(dev, "irq request failed\n ");
> +			dev_err(dev, "irq request failed\n");
>  			goto error_unregister;
>  		}
>  
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

