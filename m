Return-Path: <linux-pm+bounces-27295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E77ABB471
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F03189508B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 05:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17C1E25EF;
	Mon, 19 May 2025 05:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xfVe5nv8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039427453;
	Mon, 19 May 2025 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632236; cv=none; b=rTGUQlRjz1KmZ99MffMl6xd/tpfWh4ltxojoQJgoqXcLwVFohD5Yo3pUfOh7keytMA+anPoAnyCIl0bSRzn1KUk1WCiw2BIb2zR/Y61CKvnuzYnynwwlvJBXs8W5K/SbOSTBahovdyL2zvjID6VWp+HaZck1bd/tnhqbwEx5nuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632236; c=relaxed/simple;
	bh=Ma6J5CmVLVn7pucZEsvbwHDgreaVRnprrOMo8RP2wxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJyczcQ7w+Fz4mWmtVwlc6sM/IO9ICyBag9oTqR44hdztpIkV7iszNzFoLjuKwMrtoNPSzlfIaBo3ZSMT8UkYaM+Vpl1Ec9PBIF/2jegU3Idoo/KhnAskEYUD5oj9e4eLE9aGPiEDMbhtS2I4+0z3G0EoJGnH+tcHTpwE86GRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xfVe5nv8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=L9JD+q348GXIv6b9KLko+dnfCCLdQBps7z1zpvbHi/c=; b=xfVe5nv8ubNmETzvT88K5N0p4S
	94bc7MDWWuVW7dxa5dAvmaGXUP4kRbq/LPd9s+fVPAU6l0XdRCFecUwWwRdRzkg89Kmdao0IGgo/W
	FNJ8y+UHZsS0quGPuikkJLLZO90a/i1Lxq33FvbosXFjQ5K7dPk4Wkt4UpSOTVE6hj3+KxTNqYX8j
	uDBbsThygFxKi1VVcR7Iiso66eFA0AU6hf0+h8MqzDZbeY4vfFBLGRawUJ9Hu/lX6hc3FwAMOCKHa
	7tXi/y1YWDQI3KED88MX1Ono3esa7Dqbanh4lclj8KRpazcb10o0z01KEKWNLhGPRT6MPkCAfLfYc
	BWRexomA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGsyb-000000081Mn-42A9;
	Mon, 19 May 2025 05:23:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2] kernel.h: add comments for system_states
Date: Sun, 18 May 2025 22:23:43 -0700
Message-ID: <20250519052343.1872023-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide some basic comments about the system_states and what they imply.
Also convert the comments to kernel-doc format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
v2: add Rafael's Ack.

 include/linux/kernel.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-next-20250516.orig/include/linux/kernel.h
+++ linux-next-20250516/include/linux/kernel.h
@@ -164,9 +164,19 @@ extern int root_mountflags;
 
 extern bool early_boot_irqs_disabled;
 
-/*
- * Values used for system_state. Ordering of the states must not be changed
+/**
+ * enum system_states - Values used for system_state.
+ * Ordering of the states must not be changed
  * as code checks for <, <=, >, >= STATE.
+ *
+ * @SYSTEM_BOOTING:	%0, no init needed
+ * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
+ * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
+ * @SYSTEM_RUNNING:	system is up and running
+ * @SYSTEM_HALT:	system entered clean system halt state
+ * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
+ * @SYSTEM_RESTART:	system entered emergency power off or normal restart
+ * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
  */
 extern enum system_states {
 	SYSTEM_BOOTING,

