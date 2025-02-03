Return-Path: <linux-pm+bounces-21292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E1A2576D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A990166D62
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608E20126B;
	Mon,  3 Feb 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iAWAW67Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUBtY33Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD6201034;
	Mon,  3 Feb 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580085; cv=none; b=V3nyTsnZgRRTyGOeVozdhD+m7VeAE/TlyRx/o45zKZFiHB6HqXIOSPHpyWpenZof4hiwpdgLyo5hGNUqe4nDX4s5C5AqVdTeSNCRsA5d2UChnTiUDP6OSsn3crCgbhXU1J5aZi5n9drDZ4gjH5sJQ3bX2VZ64Jk4vyzmLULVURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580085; c=relaxed/simple;
	bh=+/Di4h1qeXkRupXv3IUSSHONLZcjGGQuZMIx64goYoA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oZ4+RIW19c2eWojxkiFiLd3PETpj+jZLEdVDrbX2HBx9V1PdFwhQQxlXEWFL1b9aRMRSVBtWd3CsZVtnOPn6A6xvRLqlP6S6CC3O32ZiCkxCLwZ+yrm4y3La7/tWFHvCs7Y90n8nyNkNcgQTJ9vlHzYKY7U1G7J6Z17LrKJfL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iAWAW67Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUBtY33Z; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 32C1313801A7;
	Mon,  3 Feb 2025 05:54:42 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 05:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738580082;
	 x=1738666482; bh=DiaCxIAAI53nKzTtEbXz18A8HBU6oz0mrAWO1i/orWo=; b=
	iAWAW67Z1v86W+SBQRThflq4erQoe+BttiXIwHmd7CLUFSEaE9ujZHOyMMLCqWA0
	iO95qn9PTPb+MP5R+WQZ3j5lxin/6294OewiaxF3/ZCOt65620U/WmRhxO2S7pXW
	aE566f0vwRwpYGWItVDVWh9QxlG9UPHrVVgFMkiLPEns3T5Yt1ZOOJhjeMSfyacg
	AvICW/lPiMhkbPNRbRyGy6dTWj3MyipVoOk8SnsaNwOj7V9g39Zx0RyamAmfphbq
	eYil188cjo2vBjBK8Lxa3PtjaUGb+FmGdGBQbA7eTdZO+GxA8sn0UENHFCojIsYd
	KdMFdiw9ae7YGsvatPMsog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738580082; x=
	1738666482; bh=DiaCxIAAI53nKzTtEbXz18A8HBU6oz0mrAWO1i/orWo=; b=U
	UBtY33ZtIynhNyxbq7q2sDjFJ6JhlehP24kBs7zYg90iCpreRzQf/v7qoyEJhbCe
	Ibj7ooRGfRJ2qhYmHK+/4Nf99+/HNvcAMrjvY0ulLV89giOt1hPYGN6sBvrVVKLm
	IdlB+aYd6a1rnn4X+RW2GhftK4KPI6804h8BL3EY0Yz+e2vIaomLMpuy3vNePZ4T
	0ujWUY/W1v2+UxKbwtK8yOD9MLg/1esdYIx3mauBlyQ5gvSVYiYqmdH7DCls32jU
	m8mTIcNZxgLZFNq4mvUhblhs14kqkIIBra746jAFnQdEH4KAU3+QoDEKPEuZNMJ0
	653tVrdDL3zouA1U6mazA==
X-ME-Sender: <xms:cqCgZ67VdE9HNracQKdQixa2r7ZZEtoKR7cX6SvQobDArlJC1IhdEQ>
    <xme:cqCgZz5rF_UV1gQFRy9zDttMKN2ICTKM31c3hEwI34v_cZUhFan0-glHEdOkUNtqw
    dJIBoYqL5wa9iWFWTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpihgvrhhrvgdrghhonhguohhish
    esrghrmhdrtghomhdprhgtphhtthhopegrnhhsuhgvlhhsmhhthhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfh
    grvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrhes
    lhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cqCgZ5e12v0LRN8mAn3NaTPL24l__jSi5I1E7mI09VP7Wba0vL1AhQ>
    <xmx:cqCgZ3JnXDMMtsAWktOnoqSFKqMDqW2CEdliOacTKrPv__T1Diw4vw>
    <xmx:cqCgZ-I7pFg_pkHtlb5yBWpI3Ra0L28HBExxjN2bu2aMbc-DAABkhQ>
    <xmx:cqCgZ4wn-fyPPKqX7qDNeXQ3KoB3KIwP7c7w8seoBE6GcQPBEwh-Nw>
    <xmx:cqCgZ28Cm9RGAp3jxEDQ715stMZqua6bFizDSnF09gkKgDoNvQ8aCOr_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC79B2220072; Mon,  3 Feb 2025 05:54:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 11:54:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Christian Marangi" <ansuelsmth@gmail.com>,
 "Pierre Gondois" <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d1ed3940-976b-47d0-b5e0-9bf08f687246@app.fastmail.com>
In-Reply-To: <20250203092141.irtn3qf5feowg4jt@vireshk-i7>
References: <20250122065516.1483301-1-arnd@kernel.org>
 <20250122070000.sawplgg5tfhrvdfw@vireshk-i7>
 <3ccab07b-6cb9-46be-8a8e-e7745f5a951f@app.fastmail.com>
 <20250203092141.irtn3qf5feowg4jt@vireshk-i7>
Subject: Re: [PATCH] cpufreq: airoha: add CONFIG_OF dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 3, 2025, at 10:21, Viresh Kumar wrote:
>
> Going to send this patch now, lemme know if it looks okay:
>
>
>     It would be possible to mark the variable as __maybe_unused to shut up
>     that warning, but a Kconfig dependency seems more appropriate as this still
>     allows build testing in allmodconfig and randconfig builds on all
>     architectures.
>
>     An earlier commit, b865a8404642 ("cpufreq: airoha: Depends on OF"),
>     tried to fix it incorrectly. ARCH_AIROHA already requires CONFIG_OF, so
>     this change does nothing, and the dependency is still missing for the
>     COMPILE_TEST case.
>
>     Fix it properly.
>
>     Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
>     Fixes: b865a8404642 ("cpufreq: airoha: Depends on OF")
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     [ Viresh: updated commit log and fixed rebase conflict ]
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me, thanks!

    Arnd

