Return-Path: <linux-pm+bounces-17371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F19C4E1E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB85B2248A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C275209F3C;
	Tue, 12 Nov 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="gteDu0WR";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d529lF+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a61xleSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A9208203;
	Tue, 12 Nov 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388937; cv=none; b=mxiKGVYJyVQnGQb0dZT8HTvzO7drKhy0H92gAxbueIkNd6mU69sFJ4mTpur993VhyLNZQnce56gouYcnK8qHosiliXwj8cnEjmY4ifeOSTBvAaCjIZIV92DAjD2Nqo+KlLGuxTkJDVmlS/t0Jt9KhLsHcZRv6+5qytPpopAMQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388937; c=relaxed/simple;
	bh=m9VPv5PBAnppqyeqDsWr0haZicyZWHbvNO1lfIFr3kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ak7rcVCnSpH53XSQRYJTms0BjjyvHSoSEq0+/mY2lPq9W1HozvqlUxsz+3S4qZgTzQQk2zLnDlxTzE093EZ0emdZCxAtIBzTVOjMNWc5dqm23ertAU6LUAxDvFnn1NrUsxOUVYrGIvWdLyOTjtAULsePqNPtbIkoiNamFEZTisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=gteDu0WR; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d529lF+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a61xleSI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B5D211401D2;
	Tue, 12 Nov 2024 00:22:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 00:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=2016-12.pbsmtp; t=1731388935; x=1731475335; bh=T8vtAQAqsN
	p8BhMHJmTbGaRORBcsj6rH9xgRT7jiOQo=; b=gteDu0WRZ95+JytpNHsUuMZYo5
	BxNrBHA+l/YHdmV8dEQJIOLjmFtsKs+PwMwk24b2p4fUWA1+oLeS7VSjuyX1ARlZ
	ZDNvHyi16r4Sl1j52PcX8XfVrh7+qjY0MlJLlTZ0EPFPQoaj6aVs0jq9YoyTX+ba
	TwfwpjMHeyn440q0I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731388935; x=1731475335; bh=T8vtAQAqsNp8BhMHJmTbG
	aRORBcsj6rH9xgRT7jiOQo=; b=d529lF+HOvHCkqPTJ1IeRnWu0u/LyJkQlHNan
	e4PZsCaYjchFUUOIoK6Z8n72ejN3oPwG4iabKjmCpKBJs4rg66Zq3MUy4S7iVNXD
	QDdYUQEHOm0zTUP/FOQzyHUatxXaAecFh40UGdnsaALxBtNnEvwx+yyqEjdeAF0e
	XX061RA3l8NRXeM58i0U5otSMmPcoDmeL2H2df8oaUBhLmn+uLq7fqoKvI2AcM87
	iijAI8nsRIgItnnRrUP4M/z3r70zBd0iYePNHOkO+fHlbqx3xDUn/mtRoFHdtTf8
	Xc3BozpraI/D7Sh9hMGN0iCW0pT7Q7PHjHxZyG8WcfYn66XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731388935; x=1731475335; bh=T8vtAQAqsNp8BhMHJmTbGaRORBcsj6rH9xg
	RT7jiOQo=; b=a61xleSI1uHpLdcLMxyU4OlTUS6W3HyLgpYgIApeITJ/YWGLlw3
	TzhzCTGlNQoJCPSJcugBqymAf50bsgf4Dp/AaRk6JK+yZeOvJKVh4k0C+Z1ixvYH
	ZpaPf6SJ4HXjUv901iLH2ry3TC6CgG6bSISIFZVm9Krvcud14dGf1UkqBug6PeCA
	GOoZkXZ8GteUIDDGHqLUVwrrTto8DJsgxgZGhLVNht1bPvFHgQwYBbdrX6DqXW9E
	nXjqEdYbDagczpJxNIHGHuzc/xbQk4Vi9gnYfjn+eTuoMHFJc6hk0V/amVxMl9g4
	EgP8hywPlVQOl+GpXLojFj/GJmU6SJ6HSHA==
X-ME-Sender: <xms:BuYyZxANIpGG366ga0go0Eg124PbBO0V9ONuaWkyDRPDahheJaF6iQ>
    <xme:BuYyZ_gL8pVlUVf7cfTUs-8LwqfrPqyBmFcizxuCo_Iikz_YAYWUXd7e4vws03rcX
    U0jrQvdxMoFM0fUTeQ>
X-ME-Received: <xmr:BuYyZ8lA0F7q-cL92FOor9sepnynixgIcW2QYoc-o8y6tRfM_kDJNf-sqlKCv9XQi__1sNBJFWduXJvPZASboUJmCkwC-m1owEK_bv0lNgUG1XK2pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
    ohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeduhfdvlefggeeugfejiefgtdekjeehkeevveegiedtledv
    iefhveefteffieegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhugihn
    ihgtrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrsggrihhlohhnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehnphhi
    thhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BuYyZ7yXD8WZswjtbU0h_VFj2gjGtGtUEHpKGdvAcaxk3AG4bm8cqA>
    <xmx:BuYyZ2RHig_-Ltt_0Jpb9AwBzFWiOgWvfNi8x-hu6EXuYl0dvbcjPw>
    <xmx:BuYyZ-bZGuNfcOQYEyVUtktomUm6qfVK3404JWvqGsGP2g0DXolxSg>
    <xmx:BuYyZ3T82Jg8vHUk4tgmcak7dBAsHz2JQdiU0W7dWKDW4j3i-1-KBA>
    <xmx:B-YyZ38faoY5f7NewUnWfE8v-nwI3FKUu_kiUp6hYPpe5fP-BwV-eX-6>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:22:14 -0500 (EST)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C521FECB7FC;
	Tue, 12 Nov 2024 00:22:13 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/5] thermal: multi-sensor aggregation support
Date: Tue, 12 Nov 2024 00:19:37 -0500
Message-ID: <20241112052211.3087348-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides support for thermal aggregation of multiple sensors.
The "one sensor per zone" model is preserved for all its advantages.
Aggregation is performed via the creation of a special zone whose purpose
consists in aggregating its associated primary zones using a weighted
average.

Motivation for this work stems from use cases where multiple sensors are
contained within the same performance domain. In such case it is preferable
to apply thermal mitigation while considering all such sensors as a whole.

Previous incarnation by Alexandre Bailon can be found here:
https://patchwork.kernel.org/project/linux-pm/cover/20240613132410.161663-1-abailon@baylibre.com/

diffstat:
 .../bindings/thermal/thermal-zones.yaml       |   5 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 210 +-----
 drivers/thermal/Kconfig                       |  27 +
 drivers/thermal/thermal_core.c                | 643 ++++++++++++++++++
 drivers/thermal/thermal_core.h                |  14 +
 drivers/thermal/thermal_of.c                  |  86 ++-
 6 files changed, 780 insertions(+), 205 deletions(-)

