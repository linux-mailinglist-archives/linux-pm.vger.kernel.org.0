Return-Path: <linux-pm+bounces-23734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5EA58CC7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241C07A4E95
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAF1DB55D;
	Mon, 10 Mar 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H65XTLmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UG9NfcuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220331D5AA0;
	Mon, 10 Mar 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591368; cv=none; b=h0I6UDI+fQwq/N4FUoQdb9wwSjQPAD0iEjK8J2F2YkqdUxoHhO/HYGq9MG+4ns9qq0cMupawXdOg+NVEYhtAXgczM0I/+AACjr6RF84UDe/ukLvO4nXFx7nZJ/b8oi5zgPx9XCHPQHBDzquAYcrrJ1xf0ubwvfjTJ2ZJr8Pbdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591368; c=relaxed/simple;
	bh=J3sQCA9DV6phIpiLDA9JI9hyBB3YMuMwciQ5P6V/ybU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Efdq+3EKNCFv7SAjcKo2G1B1gnEvsm3BeoTSFJ+eXToMJJsdeBBbimC9FWjJU6cG7A7YvewVXOcweNPJ9vdnKWuuyf7Ci68V4692AHY5NVzEzYNL2Y8ekruRCtZyN3ceJEJew+qeWy7PhsGGGuV+CNyKv6D1CxC7UHvqccXbc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H65XTLmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UG9NfcuG; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id EF1C720144D;
	Mon, 10 Mar 2025 03:22:44 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 03:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741591364;
	 x=1741598564; bh=J3sQCA9DV6phIpiLDA9JI9hyBB3YMuMwciQ5P6V/ybU=; b=
	H65XTLmqz5qqZeAmNdbjspDs4350aSTpjHT3M0l79hDMl4pnq2pe5PjFjK98dCwv
	o4LrfOeYYEDjkMaoDLHe88BSZrhiSJdl5IeWm8j1Y5V1cLKRqLWVUJgDtKi3AqWC
	KfuRma0iaGw+QcjCNImKXIR0+Eey/QuwGWzHp6NTvtwDaKGZZKlGkiEAkuF92KGr
	pO9m14kWbgKum5NvRFnxzdcu5loSw067bd2SrtA5NEDdn09Jr1WgKpfMC0kXMiyV
	gySoW7yibIaEIvsQ1wRt/mQUUrE+75ikoTj3/4sr/IHS3726Hqs5z8Gi4oJhQMa6
	xX3GPhTPoAZ25WWOWHZm4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741591364; x=
	1741598564; bh=J3sQCA9DV6phIpiLDA9JI9hyBB3YMuMwciQ5P6V/ybU=; b=U
	G9NfcuGL1pSUTtjpSHWgR7DtaRlOQQcEfxFpbFhGPWHrFQ72V5NqMHJoDTKyxndw
	2azGp917nTShs3jYuUCDjUk/j0yF/Dkyz8td3bEeyPjOVkVvX8PVbU3vbTjZCGWl
	rlRzl3GTL+Hbwm5fcmWrqIw2i4p43osRuubAsklPeSTD4uODiVOmZjMN5CmBP/qD
	n3i79b7PFhg3h+UucgxAepa2G3BCmKR7ZSWs0RMmvepSamdm06VCk3q272zrAZ0T
	hErjLISfVFplQVNus9lPhlIgK5TcLYttPnCIjOHExATCmHsyMn7LipJqEEosu6Ee
	juTt0ySZvua262WfAFfkw==
X-ME-Sender: <xms:RJPOZ6mBamNSP9M62JjinqZGhLUwhetd7MpHVJQ8c2akNeIW7jFsfQ>
    <xme:RJPOZx0nmWLSy_Mz_QN0eTDK8IgqkGq_CCsfYR8or1flR3vYZCUEaMlep8G4KNv5v
    LGmwhLzeoRM_LV54P0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgt
    phhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtoheprghlvgigrghnughrvg
    drsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegumhhithhrhidr
    thhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhinhhgohhohhgrnh
    dusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdr
    tghomhdprhgtphhtthhopeguvghllhgvrhesghhmgidruggvpdhrtghpthhtohepsghroh
    honhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghltheskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:RJPOZ4oNdsCVwdwBC1kejn_hiUWULMuszBBeFu3P1XFG2SOVcQq4Yg>
    <xmx:RJPOZ-kriW5mwdM3YFKa1QEM4zUdOrhgF9EjCIQihVWPJAXdavqkqw>
    <xmx:RJPOZ43M6hITEMrBvmPyYXUHsNOjK4DlkC__GIdg4uCgnY9xPGHwlQ>
    <xmx:RJPOZ1tioloLuOdFS7WnMtHjOWPdjL7vMzeeieApRc97UPovDDeF5Q>
    <xmx:RJPOZw4mIeXgUDIjrdONTNNcGYk--e8ZCokZRYbNMKAedh8jYizIJJyJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED50C2220072; Mon, 10 Mar 2025 03:22:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 08:22:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: linux <linux@treblig.org>, "Lee Jones" <lee@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Sebastian Reichel" <sre@kernel.org>, lgirdwood@gmail.com,
 "Mark Brown" <broonie@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, danielt@kernel.org,
 jingoohan1@gmail.com, "Helge Deller" <deller@gmx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <26cd328d-efb6-4fab-969a-320a3968ea29@app.fastmail.com>
In-Reply-To: <20250309193612.251929-1-linux@treblig.org>
References: <20250309193612.251929-1-linux@treblig.org>
Subject: Re: [PATCH 0/9] Remove pcf50633
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Mar 9, 2025, at 20:36, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
>
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
>
> Remove it.
>
> I've split this up based on the subcomponents to make the size
> of each patch sensible.
>
> Dave
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Looks all good to me. Whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>

