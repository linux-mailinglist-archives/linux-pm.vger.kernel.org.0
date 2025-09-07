Return-Path: <linux-pm+bounces-34099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49535B478FF
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 06:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9461B27855
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 04:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358621B0420;
	Sun,  7 Sep 2025 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ao+tn07v"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B229A2;
	Sun,  7 Sep 2025 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757219945; cv=none; b=GT2HTS6RdMbPC3Ucxv37nukF4HqxSOgJLDESxD5i5PYxOYiWauwnlGRyu2oIxv4GPPGz5ZyNWZmnxRa0yosjslhH5nSuiQ/SbWNHOj/5YeeZNgMiis3e6Ky17T/iOw8n7vXDDPWc/K/kvTq4HJYG12JOC1WWAbjZxKvinMPEqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757219945; c=relaxed/simple;
	bh=/lX0LsSdffZULY13rRCfoDtGT3rYVlYAShatzJZ23as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7sSeCQVxDZS8oKxy0OPZx1xM30dzHykzjyN6aw3oqH6uJJRKOlTD7pYp2TMo82g9WsVo7slp2lC+xvr/ZocJUT+2nTob5JUzMxXAziLZGhjVLxM4b+C7P/2omUFKxbeilBX7h6Li0JBYV1/2+caPiDgP7MnUF+QYQ/OpL3Hg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ao+tn07v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=spgYFx1rLcbLN03vNZ6HO8Ze/s5DAhECuU9Ynm/f4ME=; b=Ao+tn07vMJSklQJqxic0Ublht0
	weBHU+LWZBWM75vcxeHoyVZuaiLlx7YqDfvM1gNupltPBa9gSC/Cu/Dz9PQDZiOSWBvgWoyDc/8UR
	A54m//ZRxpk3FLpL66yDczddPTKLHx7Cda3SV70pbxG7NowzWJSFMA4v+f96cBho+6YkwekAoOhRE
	umbn2q8X7Wf21+xeFzQ7SYwc/J+YW3kx3E638KgFekifEYTV0dv8VHpolGKcpWiCX3UPXqJFdbTao
	auqezxHHOPI/5if9IFwAtobSXwj/SjP9lZe6lg9t12x6QQtHqW4FhgS/HR9RLSpwfnp1DRF7/suuT
	kmhutW4g==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv7B4-00000009Ovp-3Hzc;
	Sun, 07 Sep 2025 04:38:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v6] kernel.h: add comments for enum system_states
Date: Sat,  6 Sep 2025 21:38:57 -0700
Message-ID: <20250907043857.2941203-1-rdunlap@infradead.org>
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

Split the enum declaration from the definition of the system_state
variable so that kernel-doc notation works cleanly with it.
This is picked up by Documentation/driver-api/basics.rst so it
does not need further inclusion in the kernel docbooks.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> # v5
---
v2: add Rafael's Ack.
v3: add Andrew
v4: add DOC: so that this DOC: block can be used in Documentation/;
    add Greg K-H;
    add Jon Corbet, Mauro Chehab, & linux-doc
v5: split enum declaration and definition (Jani Nikula);
    drop the DOC: block since it is no longer needed
v6: remove one of 2 asterisks on each enum comment line since dropping
    the DOC: usage does not need them;
    Add Mauro's Reviewed-by:

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
---
 include/linux/kernel.h |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- linux-next-20250819.orig/include/linux/kernel.h
+++ linux-next-20250819/include/linux/kernel.h
@@ -164,11 +164,23 @@ extern int root_mountflags;
 
 extern bool early_boot_irqs_disabled;
 
-/*
- * Values used for system_state. Ordering of the states must not be changed
+/**
+ * enum system_states - Values used for system_state.
+ *
+ * @SYSTEM_BOOTING:	%0, no init needed
+ * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
+ * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
+ * @SYSTEM_RUNNING:	system is up and running
+ * @SYSTEM_HALT:	system entered clean system halt state
+ * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
+ * @SYSTEM_RESTART:	system entered emergency power off or normal restart
+ * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
+ *
+ * Note:
+ * Ordering of the states must not be changed
  * as code checks for <, <=, >, >= STATE.
  */
-extern enum system_states {
+enum system_states {
 	SYSTEM_BOOTING,
 	SYSTEM_SCHEDULING,
 	SYSTEM_FREEING_INITMEM,
@@ -177,7 +189,8 @@ extern enum system_states {
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
 	SYSTEM_SUSPEND,
-} system_state;
+};
+extern enum system_states system_state;
 
 /*
  * General tracing related utility functions - trace_printk(),

