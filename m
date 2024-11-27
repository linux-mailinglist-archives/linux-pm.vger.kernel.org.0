Return-Path: <linux-pm+bounces-18184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E09DAF2A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 23:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F1164CED
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541EF194094;
	Wed, 27 Nov 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cWRCY25E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QY5LmKoN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7B2CCC0;
	Wed, 27 Nov 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745130; cv=none; b=qnEVVQofBtJEBYKF41BXGmY4aNqRNORmt2AiYRf7oqN7UkXZQwnj1dBgbyOoAkzGKsV3vrlOSOYXdGXh0nQcZCjmfyne3VmU2ArAZ4pM+aX73b3avxT3D0kEMtqS/7KvpqEWSsB1YjMJ7rmnROooWdsWGFKWQwL0GdoL+wtRw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745130; c=relaxed/simple;
	bh=LQZ7K9W4bZNhE8a/fETVAXrralhSFujDE20l16e6zEw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DbIoYttFELaO3mn5e49JyFxftSPcHC4tMo2dnbHIzRL20t7+kpWvwi3YMvNQoBEvlcyHYRui4ELICOh6Kkm0l7hPL2PjoR9xuP4eSNNEBGwh7nHgMuSwggbm4Vw4HkdnxNnrSMtOhbgvmt3RdZUkZw5tCfcC07vRJTWJ1EuUFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=cWRCY25E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QY5LmKoN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70A211140132;
	Wed, 27 Nov 2024 17:05:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 27 Nov 2024 17:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732745126; x=1732831526; bh=5s3O0Triyg
	4fMXsTTwqCuP7GwgGD1z4BRBo9kFTI3MM=; b=cWRCY25Eqd8MUTNHy8ybtDWMmq
	ERCj51shWQMbJRWtwkIOMNWhZ5wK72/IqtzQmwnoiqFMeqHuq2Z0PXc1X02iNzVg
	MO6G9bstLHWMbJ06uWMhoc5W1SdconSATX7DfVGDjDjVH/dtkfmsRGf9U93Laufm
	kNhI4HWsfKTS+mAKU2rGmv8ev4oUvnJVvRMyUxvGw6BZZXdzwpZ8G3yjqI3TRx+S
	vRzX2AB2wmnN6ZlCXA3ZQGCu0HUcNFnZXfzt3/ye5yug2SXbyaNNStNwhxDS7O53
	mf6r58Nb2mg4tUwBDL+Sa+0ET69BqybZzfEvzsXGvQOBMquMLorjPTixZc+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732745126; x=1732831526; bh=5s3O0Triyg4fMXsTTwqCuP7GwgGD1z4BRBo
	9kFTI3MM=; b=QY5LmKoN3EGTRu6SuonOuB3eZwWZoyhKgPCf5QCzRqS7wRpr59I
	LrQYmlIK8wGuxIP6o9cJmL3gUbsaqc2uCYn9FHqQaCRl4KW2AYzHEMkSepq+LsYI
	C3vzGkID/b7iFUnyzdkN7tOXUy0os8M/j4DcFcxcKtnVmHKkJbNBstFX1pDx+yuQ
	slnzkMdWE4rUW1uARNXmOpMYj3gPZ+umQwtZrHoyxpnKR/WVr9Yeza/fyDXngCAX
	iG7RYMPQk7nIBpKoA5ZL3R1xzRFP4zfI83Q9V4CiULzs5ya3TYG9sjvk1nCqSIYI
	VXccINxpj8xdU/mHjGyzJ/L8/9NynETaytQ==
X-ME-Sender: <xms:ppdHZwm_kvh37Tl-dUIs8QikZyVpjuNpn5bups4vY1IQFm4DaOQT5Q>
    <xme:ppdHZ_2IX-DxoxKztKL50lH1CwpimxydUcBSqWcXDfCJuyx7ZOWYotA7mhlag9GLB
    rB_eSqRAPUDH1nYj3s>
X-ME-Received: <xmr:ppdHZ-r5XASJ6K2yit5RCajKu_3bpyIv2gikraIIsJyase-LUnMwjc0Ues6W8pAJ2lBjBDIAysEklhIaNxAc2FFBWpq6K4V6-UYubuMzbsZvYFpN_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekveelgeetveekleegkeelffevleefledvleejudfg
    kefgheffffeifeelfffgtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrsggrihhlohhnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehr
    rghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitg
    grnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgv
    kheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeguvghvihgtvg
    htrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ppdHZ8kQuvjiw9sbtC1IUoJo8spikKT1h0fv2_ukjiEZPIYFyjkLnA>
    <xmx:ppdHZ-1_3RVUS3-UA0GLcREDd-vCpA8byASlGYvg9gOjFJPZ6kvVWg>
    <xmx:ppdHZzsCoUXfMO9mFqHA7c4NePMdtZL2IDtgU_1R1M8kUTx-OucpCw>
    <xmx:ppdHZ6WGkPhDCmHqyFzKqKcA2lH3fKJDlPwxzuQWHeRcEyxmj1nPiw>
    <xmx:ppdHZ3lMYZwLPvwVIX7xGP0jK1Jv6Iir_XkcSrjYg99fBgiztTAZykTM>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 17:05:25 -0500 (EST)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 441EEF0AAAB;
	Wed, 27 Nov 2024 17:05:25 -0500 (EST)
Date: Wed, 27 Nov 2024 17:05:25 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
cc: linux-kernel@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>
Subject: Re: [PATCH 0/5] thermal: multi-sensor aggregation support
In-Reply-To: <20241112052211.3087348-1-nico@fluxnic.net>
Message-ID: <s120q967-4r69-pps2-1qo3-9952r9173125@syhkavp.arg>
References: <20241112052211.3087348-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Gentle ping, feedback appreciated.


On Tue, 12 Nov 2024, Nicolas Pitre wrote:

> This series provides support for thermal aggregation of multiple sensors.
> The "one sensor per zone" model is preserved for all its advantages.
> Aggregation is performed via the creation of a special zone whose purpose
> consists in aggregating its associated primary zones using a weighted
> average.
> 
> Motivation for this work stems from use cases where multiple sensors are
> contained within the same performance domain. In such case it is preferable
> to apply thermal mitigation while considering all such sensors as a whole.
> 
> Previous incarnation by Alexandre Bailon can be found here:
> https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.161663-1-abailon@baylibre.com/
> 
> diffstat:
>  .../bindings/thermal/thermal-zones.yaml       |   5 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
>  drivers/thermal/Kconfig                       |  27 +
>  drivers/thermal/thermal_core.c                | 643 ++++++++++++++++++
>  drivers/thermal/thermal_core.h                |  14 +
>  drivers/thermal/thermal_of.c                  |  86 ++-
>  6 files changed, 780 insertions(+), 205 deletions(-)
> 

