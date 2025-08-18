Return-Path: <linux-pm+bounces-32489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AAB29817
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 06:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F617C895
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD51E8333;
	Mon, 18 Aug 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nV7dvHP9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7416E863;
	Mon, 18 Aug 2025 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490887; cv=none; b=JG03JTYHBCslBbrdgxb20jObhC4joQ9W6PgC5+IaAe8xHnwu82gBdUSXkdXaYXYjlxHibholCcN5GbsKmE+CfTz+bNy4gAF6zJvOVFXNZI0vlACda/4zzQeqgEuTT2D8/PTx4q6jE6bIrkSfQkU5nsO6jzedtzp0zwo5WNPApeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490887; c=relaxed/simple;
	bh=AkU/iDjrMa4o+cL0AHBG7IGBTfutObQtryuX4sslNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kz+kCc/BKGUtx8WNBhbVii99uV4AHtespNLQyoABGKvmJrMLLYrTBML1RlzImDypFhLAcchD8NQvQaMDdyqnxqOVuqCrEtz0cRYgh3WsVYLNB74luVxJySdXJGADzExJYd6yD9Xm1jNAup/YNB+MtKGpKudjPN8VoGml4/tMvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nV7dvHP9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=htG7jFs2jVl+bAhKiRYoM1zrlANUuEfot2+lfNCo16E=; b=nV7dvHP9wVLrpDr0elYmrWNEzz
	6nyDk+fN4GqyF391lTF4if68FA+8OOjB/f5xnzEsw/o2zpA0PMPz6Lwbsi/0tTU7BPHu0VSwPYBd+
	OFI5DwVgoRua/mTfM1R0Sjxa5Xe0p6IzXDOAK7lWIVqsktbb9h+q99p1ysbNIwniw7tALNcBhVYXw
	QWTSgVEmT5tj4eYP03qCbDv86jyVvPup+t1qJaetq3CPpTEXcG/To6EMwt+XnvujGlmVRFEZikxEy
	LgXiCm8+HAire1mSYshMTJTrGh+3XAmfc4yc333Kw9D1X7j77DCC/86PX2R7mlWvhL3fWAf1OuyLH
	fn76dEOA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unrN6-00000006SuC-0yv3;
	Mon, 18 Aug 2025 04:21:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3] kernel.h: add comments for system_states
Date: Sun, 17 Aug 2025 21:21:22 -0700
Message-ID: <20250818042123.1786468-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
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
v3: add Andrew for merging.

 include/linux/kernel.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-next-20250814.orig/include/linux/kernel.h
+++ linux-next-20250814/include/linux/kernel.h
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

