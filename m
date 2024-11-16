Return-Path: <linux-pm+bounces-17668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613039D0012
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 18:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6671F2200E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14818C006;
	Sat, 16 Nov 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="gLDJiIdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSnttT4T"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B72B66E;
	Sat, 16 Nov 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731778224; cv=none; b=Evj1JpxWB39+JlWQqID/QIeuQVVC6Jz0Sb3UNyob1HVfo9f6cGRdqe+LMuvg3N6tuRhyVeRC1UCl4uCn7dZnKrH92nDnU7dRoHSvi0xdxt9qtoF7+y9YE0LWalVA/5YNnT4o3UIDSDNoSSw4S4pBt8cJe0SCBVBkZZuQlBxQZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731778224; c=relaxed/simple;
	bh=N9TZCRG4w5+v1s33fY+M82uyC/rS99FJZ7qNaE0/msA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V9z4+KOaJ4QLzKOjgrvSXtwcbG0MZ+fFhcj+AiG8dHMGOve6el/NNf3VpNXtBbENQ39yUlWxMLqCJyJ6n3LlyTW+M+2lqATlMX545c8/Z6Ojms+iuHQFA1PlG173fxliojjiBXCXr0zbV5DLgmJM0kE9Gxr/O6AL1ayf/hWjqyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=gLDJiIdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSnttT4T; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F91B2540115;
	Sat, 16 Nov 2024 12:30:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 16 Nov 2024 12:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1731778220; x=1731864620; bh=g0
	YK6d1XcwH/2Z/2zLe+w89RByVGI7LsxBIJNkyWnmo=; b=gLDJiIdfj49us35xji
	9NoR9LEwt3z7FQziPgHDZ3JfSVRHIVgu/rA+UtI7fji3cQMjWBCMlGeye85S4QNd
	maOSRRbHpb6rMGHOW9mUDW914EQvRU4Lcr8oGqiMubTxKU5sTN3qV1DMciN0p62m
	omUJJWm/6hdevx2LNbw4vklGfKIsTN8ccbMmFONgC2o8Kt3TMtkY5dxN17011/+4
	OApUzkwgc8g/hDAseOqvYNKN6g4YBf4vqCKoClyAccoU1lVA2zT4Dnb+HDAtJ5jX
	uggXJlmoQ82UTg6V5hjxgU/5hX3w+BcGX0lsqhd8mX7FE4yIfXt1a/xz5JTwXX1G
	4P/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731778220; x=1731864620; bh=g0YK6d1XcwH/2Z/2zLe+w89RByVG
	I7LsxBIJNkyWnmo=; b=kSnttT4TYcr1IgmFzouJE8TsfTZryGTlyx4EVdZUEPIN
	8I65685CvdROBajd6IHyssTnKpf0iq0en+tGDcH0s1ytAUn1RtyQA+9NRK8u5XtY
	Ge9z/QR9lYMEJCfJXQ8LICZ26K7u2Ao4iRM4FC35DwlfdFi09frr2Vlt9wFqcF0o
	nWJKST+GhqNzDE6iIrbulI/h+krABRcJwnANR/H/+5AyIlxvKMz7IuVvm5MWCnqj
	kyG1yhqWIFnp2shMH1H+C2H5oeUTDbwF8X4dxlJyOV8cufTYV1YVoI8Cj01mCRWx
	Ba3ZLACQaZbOalicl/SZLAWtTTWAe+KkKe9Ja59o6Q==
X-ME-Sender: <xms:q9Y4Z5ArAasMjno0vik_GJ8b-0eBsXB8K_bXHm_aw5jFasXNMn6Paw>
    <xme:q9Y4Z3gIWS241hH_Itzp3gFApLuSQHaz3b5jJsbwfmizR4h5MKDPRTfqwz-ppfkTt
    FSCRpHn96uh9Aru50M>
X-ME-Received: <xmr:q9Y4Z0nDhCJwJt9T_gVZTthdnRfJCztIcAIn3d2Ahd8XYs4edvv_HtI6i7i00rsJZ2dzm8RDHkXXuqlkGhEdfRlgTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfh
    rhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlh
    hunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghr
    nhepheduleetteekgffffedufeeuvdejiedvkefhveeifeegffehledtvdevhfefteegne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhl
    rghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtoh
    epjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhord
    horhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphht
    thhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnih
    hklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:q9Y4ZzwoKpQjVmH2R175GvyWT3EngQTYYJAdTi3BRqBRPNBO3BOaHA>
    <xmx:q9Y4Z-TNrFGPlsHD0hOLhMebYY11V_3jgkckwXZCDLhrWk48plqlQw>
    <xmx:q9Y4Z2YepQ4jOOChT80oxpS0IRhs6m9NLQaFgGU2YmMUzbwBGVIAcg>
    <xmx:q9Y4Z_QmQ4LohSIPYkPNfwNiWCNQg3acVPkm98TnOiSdvpT9HkCf8A>
    <xmx:rNY4Z7Sgdf4nd7AMM_M3DRSCLgSg0Vg8dNSaxQipLG3AdckG6tAy_VLG>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 12:30:19 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] thermal: rcar_gen3: Improve reading calibration fuses
Date: Sat, 16 Nov 2024 18:29:32 +0100
Message-ID: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series aims to remove the code duplication that was added 
when adding support for Gen4 devices. The logic to read the calibration 
fuses are identical for Gen3 and Gen4, but the registers are at 
different offsets.

Patch 1/2 is a small drive-by patch which fixes a style issue of the 
constants found when working on the fuses code. While patch 2/2 is the 
real work removing the code duplication.

It is tested on both Gen3 and Gen4 boards, but as not all boards have 
the fused calibration values and the driver fallback to hardcoded values 
only Gen4 have really been tested as I don't have access to a Gen3 board 
with fused calibration values.

Niklas Söderlund (2):
  thermal: rcar_gen3: Use lowercase hex constants
  thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4

 drivers/thermal/renesas/rcar_gen3_thermal.c | 85 +++++++++------------
 1 file changed, 34 insertions(+), 51 deletions(-)

-- 
2.47.0


