Return-Path: <linux-pm+bounces-17669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 455AA9D0014
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 18:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB71B1F2206C
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3EB18FDD2;
	Sat, 16 Nov 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="iv0KRo/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ej0Im65R"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6D8172A;
	Sat, 16 Nov 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731778225; cv=none; b=Rp0o2UMLkFARNKGnnKIiO1dhqdVmAsbfupkadICBWl4ihJDt/txkt/Ea1OiEnA+KrdXiXSSwHfjL6qOQEYWSQ81zV1Idn88wPnunnE+ERsMzO4FGfkc4hz/zVHo8JG+mexSChMD/+bvJ4SCKbh8+D+HhARQ5bIZlFWz6dR/Z2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731778225; c=relaxed/simple;
	bh=FrxyMDWy7NS+A5hqjTZBthzgHqOgj9GR2PtYvmZSDRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nbk8gQ/WbSQyjGIZp9jb8hvgn6GQsw2Ys3tL3406I0GkHxAuuSeQ6/64qBngKb3H1a+DvnFhz7Y/nleB2FU1JgwRwDXGI5htKwOFF0p6M3k07mxeQxKzf9rE/P94Hc2mHnTovE2UN148Vs+z9pegfrG+8h/RpFsAejl/SBdjy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=iv0KRo/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ej0Im65R; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1947254010F;
	Sat, 16 Nov 2024 12:30:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 16 Nov 2024 12:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731778222;
	 x=1731864622; bh=H3WarWFFkzDD72BAl/qyKtTF+8QIIevjt1AxZzLz1kI=; b=
	iv0KRo/n5r/3Dnc87YcdciWJ4N76o3oxsdsGMS5GutZ2SMZ1j4vTLjNHH4v11QA7
	tdEoyleIRMXZbt7w1Q8KPZz0B6dmLdphpgLLt7LC15KHKKShs7jh3mok1mkdJNhL
	5e1BhDaxXIpdPwdLLs5ylzjjzwNFp2EvudwpjUSN004BbDaUKl2z0PHJGC6sW7v4
	4L4snIjxccjWM17NAgTtbbNWZKatb6u059vZjQZOrohQ9oLWxzJ0FTUBS3iHv8bO
	Xeg27H2SabVMslNl6OnNecAFhC72oyuTp0u/OeouLJLjdLp2M/7T87Jh0uJwJoiE
	IvM3mSyYYRXxWzqX8eaW7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731778222; x=
	1731864622; bh=H3WarWFFkzDD72BAl/qyKtTF+8QIIevjt1AxZzLz1kI=; b=E
	j0Im65RiDeYTA+x3HDmxnSmFTS4b160c6+2VPhZ1iZaaH+ovtG58vX3153+dCaWs
	ySeGPyJYUj6up3SzscjROhHRxWCFGVWkzuP3THCs9CoPKdyRSQljLR/CZVe8vXlh
	HyR17gNox/QBCRfgYM1PPnqpxpGTKeEtEAKKqRa8N1CQM0ZPTTkwMzwd6wDGhXol
	bkcoxnubzB0ey0JsEXDplpi0f/2TyCK0TtUqKcGU+TOgucKHhyokk0J/JiMFwrGg
	uai2poPnbpA34pjp/vfX/r1Lp5zspaqihqTE9fRDs1wCOyDb5PiiNwPdOunZp8wW
	jNqO+A0AKdecKP7Yvw0rg==
X-ME-Sender: <xms:rtY4Z7fVuv-M-bnb_V8bG2k9r4rjPctQfiS6GvPUaCo4XMPIRTyQDA>
    <xme:rtY4ZxOFOb2jq1kXUZZ2aTl-yQlQ_ErzFq2jBopB9ieZTJdYi7X3ats0m-WhKdJGL
    Gw_OgD61ekrTpdsd94>
X-ME-Received: <xmr:rtY4Z0gT8V31ihPf5S5R61ESEToWAYPFZC2Ah-lWWHH3YMsHj1zCGeHyOAujw1PBet5kTVa67Pqc71WYCC3Txw2bcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvg
    hrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthht
    vghrnhepheeigfeuveeutdefhfehgeekvedtleeuueekveefudehhffhjeffgfegffelfe
    egnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    khhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpth
    htohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrh
    hordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdr
    shgv
X-ME-Proxy: <xmx:rtY4Z89ROxILUNS5yOQwxJAwWb1QSXmITjjy7OSyqiAYXtdmn1fAWA>
    <xmx:rtY4Z3uT2TcZiCUW8imhLN0W94a5h7rrR2j7wzgs72nxHP_OFePe_w>
    <xmx:rtY4Z7HpbmLsK-aQzzJWHq-csvvxRz1SeAa4r2sFYSh1wIOHCVPLPw>
    <xmx:rtY4Z-MX-O5bfdfNv9dV9bPLnJ0kMu9N9D1qI8kuUiWdwS35hShS9w>
    <xmx:rtY4Zw96qt1oVlL5ajfZ09xF-GiBNc26_4W5--TMcGuk83_cS7jrMyCM>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 12:30:22 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] thermal: rcar_gen3: Use lowercase hex constants
Date: Sat, 16 Nov 2024 18:29:33 +0100
Message-ID: <20241116172934.1829676-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The style of the driver is to use lowercase hex constants, correct the
few outlines.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 810f86677461..35b8ecb8877e 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -57,11 +57,11 @@
 /* THSCP bits */
 #define THSCP_COR_PARA_VLD	(BIT(15) | BIT(14))
 
-#define CTEMP_MASK	0xFFF
+#define CTEMP_MASK	0xfff
 
 #define MCELSIUS(temp)	((temp) * 1000)
-#define GEN3_FUSE_MASK	0xFFF
-#define GEN4_FUSE_MASK	0xFFF
+#define GEN3_FUSE_MASK	0xfff
+#define GEN4_FUSE_MASK	0xfff
 
 #define TSC_MAX_NUM	5
 
-- 
2.47.0


