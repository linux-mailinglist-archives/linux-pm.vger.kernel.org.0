Return-Path: <linux-pm+bounces-18219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652FD9DBF26
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 05:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B417164AC9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 04:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A281537DA;
	Fri, 29 Nov 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVJIeaFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95D22EE4;
	Fri, 29 Nov 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732856277; cv=none; b=rkbYZhznmMrd1qa1b49JH7KldkVRe+no7NfMyYXSNZPw+EHw5IakdxXGoobsB20Ij9zdU/gFOtLDtDen3D0z2C07dYJKXR4UWkgFO2oRxkMzvQncCFVxQO/SwADuQ4yVIip5a0vDrmrR/Iz3qZ6HVvDzYYnv+foM22f7eOjFgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732856277; c=relaxed/simple;
	bh=5U6h1Z5fr+R0QY54TWNq1gNMDGrt+6cwosjjIV8xsQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWej5a4uC9DZS6XVHvuS4Fx/0HrvwLVuBoWDc8gKjE+88NtIiiFL1MB7GXgRf023ssWPk0henbffuclMlbX0YCgYGg/u4zMjDpCw23Xbdj8nSGS46IoXOTcN+WAUCNfYw9+xkWvCzjSRwV4gzK9U1YaF+mfLLQ87Awcjh3PeV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KVJIeaFt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1rLvYlqK/58eJQCTQLKYZ9N7ZVCL+zhzpVOIkaFzhEo=; b=KVJIeaFtZFPs8bCw2fpoeycqQD
	mePfPq5n/MSSPkBZ7r9S5/W/et/5RiLFiKgF0+q5nnqBGsdkcKkE6Rl9sM6UiRjkiCsgJ8V7Qn5tg
	YuOVrMsKXLemwqWcJlOQ8uRc3MRUBhrAqdMHRe9lmhVuEu7s+c6H1ShMkL3eFxTaAW5yHlQftoWN8
	Tn5zOPHWEkaBQBvOE+yukOTxkrwdk74GBboWVQM5StCsT7m2GP1sZtYCTP3Tk3WFcJLVoSihFweQQ
	XQMqnzqCNUlae6IodP+qbEjfgBC8l/QJnxtKcetnIpeeAh0mHrwFkB8P/OkVrjbdW0sUT5QqyFgy+
	1+vdxA4Q==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGt4j-0000000GtuG-35QM;
	Fri, 29 Nov 2024 04:57:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] kernel.h: add comments for system_states
Date: Thu, 28 Nov 2024 20:57:50 -0800
Message-ID: <20241129045750.456251-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
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
---
 include/linux/kernel.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-next-20241125.orig/include/linux/kernel.h
+++ linux-next-20241125/include/linux/kernel.h
@@ -176,9 +176,19 @@ extern int root_mountflags;
 
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

