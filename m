Return-Path: <linux-pm+bounces-34042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F09B4694C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 07:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DB53AD7BD
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 05:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D0279DBC;
	Sat,  6 Sep 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yzNB6tsm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606C279DB2;
	Sat,  6 Sep 2025 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757136485; cv=none; b=ofE0/t6tghO1CgqOUbyzJX3BNNeUzo/pGsNPAV1gJ+JABnidPBct0uy5klDoZhox0djoSXz/RN1P+YbL58mj/FdP4Sjuw40QL68x+NKltTUrVZmkFZlGTA0ZPe6kQiCPXkMPFYCCJljKhv7pBT68BVxU+2KYThw8OMjM2UMCApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757136485; c=relaxed/simple;
	bh=CrT8JEHCyXG6YV6cFp3hT9XCGY1QGmIppEZH2vzoCUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cz0r2EEPUW63AoMaGyugYXYhQ4ne8b5/TcVz4nBfS7/Ql6r0CdKgFupJ4xk6tEo6RxK8jZ+XQE7hWs9F4pXOvUwB+taaTjzIsfusyCZblEdqwVbK3lR0gW6ZA4xy+NTUU7zJto0NH7mb7SVph8hrHfKW2ccdTMD5oaJ8ThJeX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yzNB6tsm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iqj54Cn31NsbsQ65ZPACX2iqR+ISlTVVxWRV3yEQ1jM=; b=yzNB6tsmSyqGh0q+E9N4mc5IsM
	8+vG39NnPBi2RvqCxI54wfyUMP0JhzBfNJS7HEmU3wWqnsHM+1uY4ABtjcKci4oeIwaPaNk70ewSa
	UBnPyxpHiyeo6LSw+3ln3acHP6aV8MnTeouX0Gm3KeV/wkRN/a9E5qRD4ld/+MBfoxYS/jU1XA9oI
	6fkjlEcO67gblYv9Mwbg5Yn8D2Zw2kJMEb3Q3M24iZjl3qbU3EH+0VWbsnb0o/8uWdG632frNvnhT
	IbWy0dTbbtWTXUkiKJxGW1tEzfZRDF0wkoQX1qdvEuU1jLEAQtkbppUrcb/5yW5FD5e/0ZfPJx2Qx
	xyaO5mWg==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uulSx-00000006oaW-3Gao;
	Sat, 06 Sep 2025 05:27:59 +0000
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
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v5] kernel.h: add comments for enum system_states
Date: Fri,  5 Sep 2025 22:27:58 -0700
Message-ID: <20250906052758.2767832-1-rdunlap@infradead.org>
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
---
v2: add Rafael's Ack.
v3: add Andrew
v4: add DOC: so that this DOC: block can be used in Documentation/
    add Greg K-H
    add Jon Corbet, Mauro Chehab, & linux-doc
v5: split enum declaration and definition (Jani Nikula)
    drop the DOC: block since it is no longer needed

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
+ * * @SYSTEM_BOOTING:	%0, no init needed
+ * * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
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

