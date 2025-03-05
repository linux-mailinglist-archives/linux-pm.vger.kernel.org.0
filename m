Return-Path: <linux-pm+bounces-23497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B8A506B5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE5172180
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77D1C8629;
	Wed,  5 Mar 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="eV+LEgaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCkotCXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEF1A9B2C;
	Wed,  5 Mar 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196845; cv=none; b=F5Azsf43I6ICJU5ki0Q2RYfv79Z6ON3f3SYYVS/Umyz8JS7IqOWAEsOeVeqSXwFkri0578Pu58pjwU4jAlYnaDcUQSYhit01OkLrI0DN+QKzcWtmiAyqQHMrIMB88dljwoaxDm9l1NcpWFHFiK4isUl5iw3K0wxUJlVz35IzO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196845; c=relaxed/simple;
	bh=Y1F2WhHneuB3GD3V3Qb0JvYvJ0Xti7Y1K7CkI9vklUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvQP1mZEph1Z/PyuzR2eMOqvktYWpHAF9xIg1T5XLh6enk5vVn1Zweak9HyWYTiBfVFABhZLxwawHV4sJBbP7X4DW8JvEfKi84YjcDvhSLWvkq8OOnG2f/MclGbw8/wpv6ggy/aIr5ZNjNcl6/2kz8+ESQvekgQgMi+V8WMQs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=eV+LEgaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCkotCXP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5714D138274F;
	Wed,  5 Mar 2025 12:47:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 05 Mar 2025 12:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741196842;
	 x=1741283242; bh=6EoSXjam3GmYoXgEmskAlCdGJLnZ/EAVS9+3/uWSBPc=; b=
	eV+LEgaSb5khzXJjPYFXlArL/KeC5ZS0WR5HRjeKnrVM2TjCHG/75MQo/+MnpCvO
	Usx4hy+rLfttOM15t1oCBy13JthlpuutFwDm9cjpXO1ahs6kGjHkXSf45Us5oM7p
	hQZIUoDhS6ZF7i5hmC8UMO9VzO5jxDeWwCTC4/duCf/jJfISZ9D7JTtX5Ibnb02+
	l+Rt9ItnlHKpmi+cy4PASZGDZm8qMM6j7ArbKZfxNNpXOxxiajAGa9pWECpX6xEl
	VyeSdAQqHIJ1UiaplQGjCk2JyT4AdaQOagnlu6MRdWoxc+83XMuXKYNCBF4q5i2z
	Y88qW65mNhWl2XQyb7jfhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741196842; x=
	1741283242; bh=6EoSXjam3GmYoXgEmskAlCdGJLnZ/EAVS9+3/uWSBPc=; b=H
	CkotCXPBBnUqjfBluq3bTD8iqViioePtLOA+KvQ+q129oGNNeXrt8hrEwRxCKXdD
	qus0t1bA/8B+QNnMO71aC7soHCEf49cQdigzTGkbPrBfoHJziVNdQhxi2dHk3U6m
	GeJG1J1N68D8mrl//AwVEXB11XozpOPiMXzApbRuFouXTvHHNptJv/TwzrC0643+
	tTHz3CiLr3yc+7rkZ8/e0cRjIucENUkXAZE7lckgkOvBHCOAzi8QBRar9o0ELAZv
	MtpdaTMm/8LtY7tTUoyYXl8n+Rh3BhEFJ242ZLOoUrgBcsFU0E6Pz2jgj+WDck2C
	URQMAw+oM2ovSJ+eGpUUg==
X-ME-Sender: <xms:KY7IZ2vW9rqCXXxN5fIvEb6s_v0KQ4LN1PEyLSASjQXJ1edVhtfCCQ>
    <xme:KY7IZ7eJVxyxnPPn1S_P1oxgy8Ugk8e1Rb34jBSFCcQ0o7YDQ6Fqdv0vPeDZICH99
    BmKQ9uaJYI7Jz623h0>
X-ME-Received: <xmr:KY7IZxxlFFUihAz8mBCbOp-hVehK2OcgX1moH6iPQxZjQ1VU5hcCvJpvyYEFj5aFcJAOFhm3EgkgsH4Ykv90m823ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffr
    rghtthgvrhhnpeehiefgueevuedtfefhheegkeevtdelueeukeevfeduhefhhfejfffgge
    ffleefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlih
    hnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
    pdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhope
    hgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhr
    vghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhikhhl
    rghsrdhsohguvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgdprh
    gtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggv
X-ME-Proxy: <xmx:KY7IZxOhOU_i7hliXakREqTVagaywPGZKb7xyKWp2mHKQnDVdzS1Mg>
    <xmx:KY7IZ29rCLb0yj67jWrj80a6BZRufqCQZS-_b2PNGX1Iz3j4vAza8Q>
    <xmx:KY7IZ5UUVt9GSKWcIBqGTGhBce3aJ3DBjjStEbHWi9BDSj4qGyc-DA>
    <xmx:KY7IZ_cyHhArSzgs1OoZ2t7qMWwUmHmSffa9qmLqJCFQGCt4mYIlng>
    <xmx:Ko7IZ5YslcpL3RArQ5S8cZreX4u3PsvmrT-wZ0Ye4oG0hF8YXp7wnkti>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 12:47:20 -0500 (EST)
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
Subject: [PATCH v4 1/2] thermal: rcar_gen3: Use lowercase hex constants
Date: Wed,  5 Mar 2025 18:46:30 +0100
Message-ID: <20250305174631.4119374-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
References: <20250305174631.4119374-1-niklas.soderlund+renesas@ragnatech.se>
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
2.48.1


