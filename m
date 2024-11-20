Return-Path: <linux-pm+bounces-17815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59A9D3A6A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 13:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1263EB27265
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199719F495;
	Wed, 20 Nov 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="mf+f3LE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVEDTfIh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF417BB2E;
	Wed, 20 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104248; cv=none; b=A+wfs5G2dabtJdOJWLPXQrJoJ4bbrqO49WTS/SnPhz7JHSOzV3X7EbQw3NJwVESxLnFKGCEYXWJQCemv9jPw5QCQ2QKjD+N+HzkRIHffb2RVh5EfF/8VVqw1QTzeNUYv8T/jBFn3Df+eyvuaQRLOtVbN+eqzCvlIPVh1SEoIlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104248; c=relaxed/simple;
	bh=i2CBklWPXlJ3JbhxuVqap6XIRKIU1MG1yfP7QRnWXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgrsxoR/kIc5BGwNITixlfe2cBgCr3dfqIjP4lNm4cK1s4z/noWrHtydVY3KnBOSC4jTssvAkwUPxY7NyHtF4hD2p/f1EgardWIHL0lYiYo5/FNzU4U4Fheqq6wBZU43H9CsuEKRq8Nh9Ct2jWsoFIEdTaaAgN0M4pVhthnU9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=mf+f3LE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVEDTfIh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F2CD1380140;
	Wed, 20 Nov 2024 07:04:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 07:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732104245;
	 x=1732190645; bh=9TipcHQ7iM6nQRgz7dpD1Gjx1n7NzOrPEylSULkgCdU=; b=
	mf+f3LE57lA4JIbxZQ9uEd7oVqIBsc3rRzrkIOYQW1QoFvtyUOuIM33wSxp4fYsi
	QdhzIyea+G5aQ0U3AZXDvkPNJoiKkKrdQXtZkj13Ktrc1QVOq5Zu3rGJWMwjICCO
	x9Il1QqLlLJ5nhAVhFpr/gDGDbFbu2+YvSpSwg/DRpc0UDQNu5aHbfVTta5pBa8o
	VUr5Tc9B3qKWbwaVOl3wucSokxeV3MBvsywOxBnTLjIEfRVKJ4aJJ5Wtt0bHqPXW
	+QY2RV6QPrTJTSMA40TM6gB+Kb0lxSqgbq/EWN2pt1OcJSOQK6uD0kfesXsRp18O
	JSdg5GxGS7S2bCVYZrHU2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732104245; x=
	1732190645; bh=9TipcHQ7iM6nQRgz7dpD1Gjx1n7NzOrPEylSULkgCdU=; b=Q
	VEDTfIhdT2So2KlmS+hqdHYpdIpBGtxwgu5xE25tkB3nUHHyQpn8w8vBHIocCcR3
	e9tVkUHnztgeiKpKhDCTVKrwCUPWJJOC7o7NpH+1T4AffEMD9yVTXpzgIjxUf+Yk
	q3lR3V0XZ6r44JmtY/iPqS83O5fXcGgSVl5rvZUJwHJflK9SOXHBu7zkbYe9eUln
	fSn6+c445y8eoxziLB2gMufiWql6Q4uW0nPXrx9u2xcA7UA9CVQKzS9uYVAsfIaP
	k0GhG+0SXvwfEzjh96zbDqOXG6WEaJICvAY7fcVCZlgpPxTaROogEUua2SpHSZnK
	WdsLhGz8U/vGLVGMzvcdQ==
X-ME-Sender: <xms:NdA9Zw3hx1r42eoSBfkOw0_q6W6t6gkvdEjYkm8kmofZg8ZovKoJgw>
    <xme:NdA9Z7GcPkFnXRzL-n7MebXchGLLCW8QLk5jprzkAVne_kqyyS8Dx6o4PIE6pDnvZ
    KD9HWpXN_4ulaLoPKI>
X-ME-Received: <xmr:NdA9Z44V_PBhRgCntQGP61_3O65RwD_nlMW40M1i8v7fRk_n9nA1NqDL713ZZFCQoovCy5eTRZA5wT2JeNNNU0MohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdefhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:NdA9Z50tfl4p5IWF3tPA6YMuEl2j3_HGxumuVlE9IgtZvRp9bf6XHw>
    <xmx:NdA9ZzE-tAeefHvzOLBQHWOslIfSj4HHEtBeLlUeTZMoz2BnfyRtFw>
    <xmx:NdA9Zy8dsYtIFfhIY9QO5BjHAJz29ou1Hv64V6CSa_iXi4LGqh7v8g>
    <xmx:NdA9Z4k4k7YQnUnJETwhm2SXjB4P4dJ1LXHr0VoWAa3qmK9sCHpkig>
    <xmx:NdA9Zy21vGCOxDFaYUJB21BDUjMLWar-peJx4xyUcKc9Ai9-xUQk3p9o>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:04:04 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/2] thermal: rcar_gen3: Use lowercase hex constants
Date: Wed, 20 Nov 2024 13:03:35 +0100
Message-ID: <20241120120336.1063979-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v1
- Update a few more defines not related to the fuses missed and pointed
  out by Geert, thanks!
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 810f86677461..95b636f79e07 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -21,11 +21,11 @@
 /* Register offsets */
 #define REG_GEN3_IRQSTR		0x04
 #define REG_GEN3_IRQMSK		0x08
-#define REG_GEN3_IRQCTL		0x0C
+#define REG_GEN3_IRQCTL		0x0c
 #define REG_GEN3_IRQEN		0x10
 #define REG_GEN3_IRQTEMP1	0x14
 #define REG_GEN3_IRQTEMP2	0x18
-#define REG_GEN3_IRQTEMP3	0x1C
+#define REG_GEN3_IRQTEMP3	0x1c
 #define REG_GEN3_THCTR		0x20
 #define REG_GEN3_TEMP		0x28
 #define REG_GEN3_THCODE1	0x50
@@ -38,9 +38,9 @@
 #define REG_GEN4_THSFMON00	0x180
 #define REG_GEN4_THSFMON01	0x184
 #define REG_GEN4_THSFMON02	0x188
-#define REG_GEN4_THSFMON15	0x1BC
-#define REG_GEN4_THSFMON16	0x1C0
-#define REG_GEN4_THSFMON17	0x1C4
+#define REG_GEN4_THSFMON15	0x1bc
+#define REG_GEN4_THSFMON16	0x1c0
+#define REG_GEN4_THSFMON17	0x1c4
 
 /* IRQ{STR,MSK,EN} bits */
 #define IRQ_TEMP1		BIT(0)
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


