Return-Path: <linux-pm+bounces-36853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF4CC0AE62
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115ED3B3F29
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC492C1780;
	Sun, 26 Oct 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2h06+9/"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E11F5E6
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498356; cv=none; b=Xi56zML8ylRNtonwXEhxVdKl5v0nH6hCrvKbZe89zv1Tln+zzRrjh5SKuUwKUnVgiHzDyMkr9LT942mzjyhmmISd+fDVYKInIFbsgU4VRsAQTotHB5wyIG1t20Jd2Okkn4yKsmwldROciEi/659TlZmnHFn7jmyESETovguk8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498356; c=relaxed/simple;
	bh=pOr9H7d14Gtw12sWQjbcQjTI11u4cMnBCOwDA49Z1+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTr3SAuSMuumqx6IRB90SwVy1qAwoQ1uDNHmZ9541y/i5ElaH9O5N++ML6eglXeCIKxHu4YWqISywNAD7Hi9HEmQL1sdOjd7PR7qmWRVnI2kN4izpaBduNlf+fSpdfj3/f+2N7EtTLVeCcQMwdcbAlBR1pbz/dKklGPRiLnLZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2h06+9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761498354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bA1cIwXomvcX1UTVpRY8z5I/n8g7kRe8UX4mFoCfBqc=;
	b=L2h06+9/VHwGfOrqiBHGYXqghKXTU/zsFguTo+ISbQ4qcTYnWCRfXGi8ZjxJzZ2Wm0HidV
	WiIoVomm7+6QnjJrdyAmMesdgdbXrWuYKn34BXpK5/hfpf6rKpnWta92syAfkLKQhEMn/+
	vee47YQVR3DGNXX3F8RNYrTPZtdd844=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-4iHEveDYOTSX9FuP-bBgGg-1; Sun,
 26 Oct 2025 13:05:47 -0400
X-MC-Unique: 4iHEveDYOTSX9FuP-bBgGg-1
X-Mimecast-MFC-AGG-ID: 4iHEveDYOTSX9FuP-bBgGg_1761498346
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93F0F196F75E;
	Sun, 26 Oct 2025 17:05:45 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.80.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A34C1955F1B;
	Sun, 26 Oct 2025 17:05:36 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	lyude@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: runtime: fix typos in runtime.c comments
Date: Sun, 26 Oct 2025 22:35:27 +0530
Message-ID: <20251026170527.262003-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix several typos in comments:
- "timesptamp" -> "timestamp"
- "involed" -> "involved"
- "nonero" -> "nonzero"

Fix typos in comments to improve code documentation clarity.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1b11a3cd4acc..7fe63cab2708 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -90,7 +90,7 @@ static void update_pm_runtime_accounting(struct device *dev)
 	/*
 	 * Because ktime_get_mono_fast_ns() is not monotonic during
 	 * timekeeping updates, ensure that 'now' is after the last saved
-	 * timesptamp.
+	 * timestamp.
 	 */
 	if (now < last)
 		return;
@@ -217,7 +217,7 @@ static int dev_memalloc_noio(struct device *dev, void *data)
  *     resume/suspend callback of any one of its ancestors(or the
  *     block device itself), the deadlock may be triggered inside the
  *     memory allocation since it might not complete until the block
- *     device becomes active and the involed page I/O finishes. The
+ *     device becomes active and the involved page I/O finishes. The
  *     situation is pointed out first by Alan Stern. Network device
  *     are involved in iSCSI kind of situation.
  *
@@ -1210,7 +1210,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  *
  * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
  * is set, or (2) @dev is not ignoring children and its active child count is
- * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
+ * nonzero, or (3) the runtime PM usage counter of @dev is not zero, increment
  * the usage counter of @dev and return 1.
  *
  * Otherwise, return 0 without changing the usage counter.
-- 
2.51.0


