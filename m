Return-Path: <linux-pm+bounces-22745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE0A40D8D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 10:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30383B263B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F41FFC42;
	Sun, 23 Feb 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="UP91jSsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ozyeWCSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD831D89F8;
	Sun, 23 Feb 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740301397; cv=none; b=O9I7yH9uKq2R1og6M9vt7EHo5REw6slKcsMcb6F9UZDsp/qN8Xc5PNDzBLuV5Lw3nY2HiXYR94DZp3jKr4uy/21PJuzmG6BvRgKmdOEyQmwN6KQruMY0ypIw7L8sOqnOpK8RR5CW275p6pXXgmQ15zv9VY1Lpaf10YVwz2sGhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740301397; c=relaxed/simple;
	bh=fCEcMc7RMUMnSFEpm2pdzeZjD2OWZZgNfbMOgPYCsEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpUGgSvLp4AN+1fzDvPncVsetqj0Y0RLLvZnMd8DdRC34K0GXuAbI5TGmKz2q4XOKST+VWBhin3MNANrfqBb5WHtESCHzjGXoHlQ38U7OCWPZz1C3mS9OYeOq7TdgWdFMFr682GkkAY7JshnQenfQ5gQnXbHjV8NUpXvJMSL0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=UP91jSsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ozyeWCSV; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailflow.phl.internal (Postfix) with ESMTP id 68ABD200D15;
	Sun, 23 Feb 2025 04:03:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Sun, 23 Feb 2025 04:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740301393; x=1740308593; bh=rR0lG1HqwL
	HdKmh1L1Q+3HA+XJIsSU89HsqNgZSMZYY=; b=UP91jSsrK21sGc1fKzC0Xubvi/
	Px4QjbV6BgKX2of72GCoI1++xhm58Y90bUtAlQ8BbromQukfP7uRjf+QBosA4tKU
	xjNVvZlyxAYwOg6qUGA14YxpESaNeXo++GKCMa4ZVkPxYgTiL/34P0HXI5P9QB5Q
	hRNCaCh3kHcJt5kZceiqMlJhsarUcbc7BPUZVF6e/RFvumm1S/qyvuHBKOy0SQSL
	cTxOZlG6l8J8AhLzPmZVZqGgE8p876szBPfQ6yJET1S3b/5J491YdjOBZHNefgIU
	epYvEHMx9EdFtPqr6EZT/K0DkwavXSKyBQYMff8efUrsI6lzy4+seUPKdMlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740301393; x=1740308593; bh=rR0lG1HqwLHdKmh1L1Q+3HA+XJIsSU89Hsq
	NgZSMZYY=; b=ozyeWCSVrq6ZeFCaCQrEBXXOybLROwbF7zB4axtI05UnC8bMek/
	HplkY+Yvidoj+m8cI1r4lRSwj9ZTJ7TaZqHt3HMlT4PIflL+DlVGoN5K1oCG8aUz
	p3F9I69j3MnwgJyvJzTSxQabyUBOzBhPMlK28TqnxjcRrKc30e93jAjx8kwUhAwD
	3Zyj1O3z02AAVqY37WA7wMAFH4ZFwzdoXYjR+3riyStqb67uD6p9j0ByZkOcC+59
	uBAaryvqNyaDSmPXMMRmkluf8DVrYM5VyyRDPL/eo6mY45RZdsFB8QX5Inuyrd9P
	AG8VzmK4W5axKyqv2tT30XAg+H2GfBS0ylw==
X-ME-Sender: <xms:T-S6Z2C_xYV3bNnptucocY4qCtKeewxrsC0NAgKeJtJHQOEnAvf_IA>
    <xme:T-S6ZwjYmJMzaRjxL0LrFwxA-ln-OAx4dKP6-Z6hCSL2O4048xGhSw4v0UFmtDOeC
    3B0MlGpmv5vJ4UGKGA>
X-ME-Received: <xmr:T-S6Z5mD6zi27a04xfe7S4HaT139eF6aNHYgTPpzBta_8Oc-LAlDN2BGuz2sAmgbwgWzae5WkzIuim3CprI_Zam768WV9ky-65U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejheegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepudefhfehudetjeeutdfhvefhtdeltdfgheefkeefleegveev
    tedtveelfffhiedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
    thdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hfnhhklhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhvvghnsehs
    vhgvnhhpvghtvghrrdguvghvpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvg
    highdrihhopdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshht
    pdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpth
    htohepmhgthhgvhhgrsgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T-S6Z0zqcRiXeOlqKx8mmZ-1komXthg5pod44TaAINRYJcNV8t5iTw>
    <xmx:T-S6Z7TOVONgPflH1HKdseNAh33d0XxwpGvUFdpRLFugHALGbaLAcQ>
    <xmx:T-S6Z_ZWqCOWzXqX9ZYAAtiduWdDKEfNkz9cFA_BldrCFC1LmRChjA>
    <xmx:T-S6Z0ScM17wGYjATkl3QKYgA9tAn_PeJErj30vEXjLZkqKlK1MzRw>
    <xmx:UeS6Z1nV0QWUnynP-qzHUMWNgfwJNKMvjNTeFFlmE23wPF3FtzGIHOd8>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 04:03:11 -0500 (EST)
Date: Sun, 23 Feb 2025 10:03:09 +0100
From: Janne Grunau <j@jannau.net>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, imx@lists.linux.dev,
	Eileen Yoon <eyn@gmx.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 4/5] media: apple: Add Apple ISP driver
Message-ID: <20250223090309.GA430621@robin.jannau.net>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-4-6d3e89b67c31@gmail.com>
 <20250219113422.GA26386@robin.jannau.net>
 <CAMT+MTR4yPzC-NBLT6uLhveHFDWpwwn=hUzU6=WDc73+UVEMwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMT+MTR4yPzC-NBLT6uLhveHFDWpwwn=hUzU6=WDc73+UVEMwQ@mail.gmail.com>

On Sun, Feb 23, 2025 at 09:48:30AM +0100, Sasha Finkelstein wrote:
> On Wed, 19 Feb 2025 at 12:34, Janne Grunau <j@jannau.net> wrote:
> > > +     while (maps < end) {
> > > +             maps++;
> > > +             maps = of_translate_dma_region(dev->of_node, maps, &heap_base,
> > > +                                            &heap_size);
> > > +     }
> >
> > The hand-rolled reserved memory parsing looks like it can be replaced
> > with of_iommu_get_resv_region();
> 
> I have looked into it, and `of_iommu_get_resv_region` does the wrong
> thing. We fill out `reg`, and it grabs that instead of `iommu-addresses`.

Downstream commit 704ace01cd3c4 [0] ("iommu: Add IOMMU_RESV_TRANSLATED
for non 1:1 mapped reserved regions") adds device virtual addresses to
struct iommu_resv_region. Sorry for the added dependency but it is
required anyway for the isp to work.

ciao Janne

[0] https://github.com/AsahiLinux/linux/commit/704ace01cd3c423b1e2492f0777d9c4c0f3404d8

