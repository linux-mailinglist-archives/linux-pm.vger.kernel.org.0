Return-Path: <linux-pm+bounces-33798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D01B4328D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB243A7284
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70002750FA;
	Thu,  4 Sep 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fv1TVnEl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6A2750E1;
	Thu,  4 Sep 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967797; cv=none; b=TtMiHxkf6AMrAE8bDdV4B21axTWqfZZtplv7674fMnMg0RJtro8hrCB8uk7Ba7L9tR0A8uSOyCSxi2mN2oNch7EBIgxX3mGBXOZRInVXlRmmrmtRBUwhwrc4TXD9L7hVYfiFYV9yRbSeckb6bwh8WaL/kcd9TCpW9H6mcxNXbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967797; c=relaxed/simple;
	bh=DpE82IJAwixADlnMuviaS0MAb4mJckPRZS0EepdPCVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLzbmMqUyI4+7u37WxC6pIFBFpVBF6SmMm0Vxvt+9GKregLg09Hyhv6bfRs2PHgX3gpcf84u4H82UC0OnawhBpnviVqln7QqxbRHU7LB5gZyDD86s9unvDAXsepx+VqpHiJk2x96En1D30MZd0sjJbquvzpzEshluElUFQgRGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fv1TVnEl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KxCfRS8/dIzqWWtc3wSYSDwPd9eAd3omN4Lj9Pa5Xi0=; b=fv1TVnEl4thmm1prMBC18GOGOt
	//dRAfezKTviuTLVDljsrJaNhm5m95oYJWrjAq59bj7C+SOpIg7AGQ8LOEcoy+EJ29rQQaOnElXNI
	sCw5UeRV3x107+1UOO0ca0zaCT6qJ6OpvBdyvQ6r8Pt8vlZuo2jmJ+1OvhMhq16CW1tbUI21IWT5Y
	rIPdYnF3qUBmDHjRuJDbAcJs1kfWEbxRBT8Chgcfjha2FkQ76rFZTRQGXZMvX2dj0wqIcqqZbMvgS
	hr/1DwJz+rys8ZqveEeYED/qv/BL0CDESRGO4DX4cTYNcGuu521CoP9UpecqwNAOZ0beea/ytW9LN
	FAkWJopg==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3aC-00000009ZVY-3nK0;
	Thu, 04 Sep 2025 06:36:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v4] kernel.h: add comments for system_states
Date: Wed,  3 Sep 2025 23:36:31 -0700
Message-ID: <20250904063631.2364995-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide some basic comments about the system_states and what they imply.
Also convert the comments to kernel-doc format.

However, kernel-doc does not support kernel-doc notation on extern
struct/union/typedef/enum/etc. So I made this a DOC: block so that
I can use (insert) it into a Documentation (.rst) file and have it
look decent.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
---
v2: add Rafael's Ack.
v3: add Andrew
v4: add DOC: so that this DOC: block can be used in Documentation/
    add Greg K-H
    add Jon Corbet, Mauro Chehab, & linux-doc

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
---
 Documentation/driver-api/pm/devices.rst |    8 ++++++++
 include/linux/kernel.h                  |   18 ++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

--- linux-next-20250819.orig/include/linux/kernel.h
+++ linux-next-20250819/include/linux/kernel.h
@@ -164,8 +164,22 @@ extern int root_mountflags;
 
 extern bool early_boot_irqs_disabled;
 
-/*
- * Values used for system_state. Ordering of the states must not be changed
+/**
+ * DOC: General system_states available for drivers
+ *
+ * enum system_states - Values used for system_state.
+ *
+ * * @SYSTEM_BOOTING:	%0, no init needed
+ * * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
+ * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
+ * * @SYSTEM_RUNNING:	system is up and running
+ * * @SYSTEM_HALT:	system entered clean system halt state
+ * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
+ * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
+ * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
+ *
+ * Note:
+ * Ordering of the states must not be changed
  * as code checks for <, <=, >, >= STATE.
  */
 extern enum system_states {
--- linux-next-20250819.orig/Documentation/driver-api/pm/devices.rst
+++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
@@ -241,6 +241,14 @@ before reactivating its class I/O queues
 More power-aware drivers might prepare the devices for triggering system wakeup
 events.
 
+System states available for drivers
+-----------------------------------
+
+These system states are available for drivers to help them determine how to
+handle state transitions.
+
+.. kernel-doc:: include/linux/kernel.h
+   :doc: General system_states available for drivers
 
 Call Sequence Guarantees
 ------------------------

