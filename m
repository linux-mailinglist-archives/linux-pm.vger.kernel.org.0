Return-Path: <linux-pm+bounces-18706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576B9E741C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A1B1885601
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048C207641;
	Fri,  6 Dec 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="lA+eVJA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ES6gM88r"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167984A3E;
	Fri,  6 Dec 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499083; cv=none; b=o5MBvdbPd7XuX8gA4YosxjLkY2WX0RZTJWbkS0S8B4j6T/cpehVjC5ZdMXZeZPVyMQdMBPTFPCLxCC1mWvq0YNFomV7/0QP/d583pYdZDNRKq1XCg7fR0YLnHQ+typd4l3nzrRmHf7kw/VbbvUZYq/L1R+LVQtJJKnNKRVrrqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499083; c=relaxed/simple;
	bh=3pm03vE2nPTOxUYb5BZY/N3lC6qjUwAxC0SQy/snoEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlEDE0Sb5pOJ2YLZbqoEWPBJLwCyuIqsSk4irKc9GY/WFqTzEDonCxKPHdY5R8H0fORiYQ7lXitFiVJqrU+UIUP8A6+HsuLuCE1xMDH/4UEK/pMPEBKA/1w95dwdBdH54TWE5zt4+2ewDp1e20sBI0pD88Sja6JYvF/56b3PkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=lA+eVJA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ES6gM88r; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7375111400CB;
	Fri,  6 Dec 2024 10:31:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 10:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733499079;
	 x=1733585479; bh=gLToBmrg8VOOyPspRlKyveHq8wpQx6esED2Tqm/0nl4=; b=
	lA+eVJA4YCSc7S2VmCynBrTgdsTKBIOOrJVgzs4EhisGVJ7CUNOZaLXWtpenrnYh
	H77/IGnCyBDhcKzRR4qN/a4uRBHgILSAqHy7WEL3uTR2DqwnQnogpQ9ldr44Uc0l
	OoVe09ERoTpIcx+bguYqUSM0CgphAZtZVGd3AoaVO+ut7JubnuC2cX72vTXT81lK
	woFBeNWm9kK6k0ECUp2Eja5MFXWui3q1b0tV69sUP6ZwlH4HCUyunF8Pv8fNhWJ4
	k9dKEIzoRmYRH71Mamam6Torcus4AAp9CoetztiNzBSdkMFTvOOCMERogDUHiyZ9
	RDFF+lpnQFIvwJhv+PZhFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733499079; x=
	1733585479; bh=gLToBmrg8VOOyPspRlKyveHq8wpQx6esED2Tqm/0nl4=; b=E
	S6gM88r4OPbXUqNhGko18ICUiYEgOXuUxnQGjsemjVZxmG5MaoTZt5ciN4Efi8j5
	lG5PHjup6rAJBG7tDVkyOSTclfLsBS3BsiWTtvxw0lKYWyYXR4r1FRYRUGrF2nhZ
	36JTX6rweM4cBTFmWlgBZk0kGA+9V5eDs0vxUn3l9dXn0tlvz+Tqov78DBJ8geSG
	NCTourQMew8ivucdFOz5HmDHKOPciYgEBO/kPwc/p+ja6+Fd0alAW55VxpfoEXVg
	GfWCBH+6SMfNK+Ag4gWIly3cb+XZ/CYXCJkjNBSpWyEWP/VsTlHPrHcKZKV9Nm35
	wkz8c2H+6lsyq7NcyPNUA==
X-ME-Sender: <xms:xhhTZz7VC_6bzAEfCrkb-jFCoYX_B3xFBXCSFDMXSxvZlvNJq1XaFg>
    <xme:xhhTZ46bvW1AlE_BWn7xZ-65HdBZIYzegRTjIuI5ps_biJjVaX-L_zhWZ8Eg5Ji8U
    f9-hLis7P2oGZ0Bo8g>
X-ME-Received: <xmr:xhhTZ6cnxZVnFnSfq7L8Ht2xvpJtyOzMWCjj_v3NHff1wlEE4WXkujbyoB4gMUv4OtHhffvpO68-yf_iJU-4hc4QMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvg
    hrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthht
    vghrnhepheeigfeuveeutdefhfehgeekvedtleeuueekveefudehhffhjeffgfegffelfe
    egnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    khhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpth
    htohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrh
    hordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepghgvvg
    hrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgv
    shgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihhklhgrshdr
    shhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvpdhrtghpth
    htohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvg
X-ME-Proxy: <xmx:xhhTZ0JYaYu-t21n_YCeZy2i4KyVpcCcMKM5geSrasNyLoLRLmO1ig>
    <xmx:xhhTZ3KkQdYtVQ7M8PNvWWzpfgrvhXTTsM6TRCWo896R2FLuClsZkA>
    <xmx:xhhTZ9wMsCl-rmxr3-tP2d7ebwADdO9UQoBXzuBkvO-g2V585I3JJg>
    <xmx:xhhTZzKz8ADmAg5taIbml991NHZdKLLMIL72f7vIAlohfHSXSW0L3Q>
    <xmx:xxhTZ4UNbRO5wqQlnzeRVgrMcudgjm3lwbzfvWOex05bxFrNHm-UBQ8h>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 10:31:17 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/2] thermal: rcar_gen3: Use lowercase hex constants
Date: Fri,  6 Dec 2024 16:30:49 +0100
Message-ID: <20241206153050.3693454-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se>
References: <20241206153050.3693454-1-niklas.soderlund+renesas@ragnatech.se>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
* Changes since v2
- None

* Changes since v1
- Update a few more defines not related to the fuses missed and pointed
  out by Geert, thanks!
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 1ec169aeacfc..deec17435901 100644
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
2.47.1


