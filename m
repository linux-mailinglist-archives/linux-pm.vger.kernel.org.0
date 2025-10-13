Return-Path: <linux-pm+bounces-36000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328ABD5F33
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211913A3036
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806519CCF5;
	Mon, 13 Oct 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCazQzo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD184C81
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383847; cv=none; b=N5PZYDQiCddcqIbFlekqNmKugUFARyAzdLIG1wrabC1lblk9OUbvuGZiKgCZLkCaFR2afHkaNGcnjMh/Lp0LNypqW4vyLqxGPSKCqNnhgFaP7WUsQi3xJ1pcsmAfF0JmVhJrSg6PH55hesexDG1/++EJ/KDEdNKyP6Q84Eurq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383847; c=relaxed/simple;
	bh=k8L9EYVq4ZcGBQxGjh4u5oQtIJQX+iDffThzcZuRlZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGaRMdLrSSJkbK0+IlBBvX6kB99ApdawPSsXH4viDMRGzCt85u5SoPeepbP2n9UQfz8eGZYEibS2MT7mR9E+XSgpsoSJHugEuthC2kR3bCpmByh6nEa5CgoCVlD0CV9mV4AHJOUOOxxmnc4eEim8TuzXvG972vFhTIp3na4T4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCazQzo8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760383845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qpGSyBJC0SfDABFt4fi6cbT29UFiUUF23XI7uRytY/Y=;
	b=iCazQzo8ned0kdzBlBqbp0bA+chBKWxQBwsOtKWpj4HfzfS9Bl6D++g6+XOjVDh1awEreu
	CQGfeafFhp1JUu0Ds06mzczXv3FDx2tbbrRpUMW0DAYrzvAjVyCrU6JNGdxMNjRZbKLRIT
	QqkoTuIM34dqgXfjL1moGe9A1Wv82Bw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-fPTpuas2NJ-EAciB-qVlCA-1; Mon,
 13 Oct 2025 15:30:42 -0400
X-MC-Unique: fPTpuas2NJ-EAciB-qVlCA-1
X-Mimecast-MFC-AGG-ID: fPTpuas2NJ-EAciB-qVlCA_1760383840
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA9781800576;
	Mon, 13 Oct 2025 19:30:40 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.80.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CD851955F21;
	Mon, 13 Oct 2025 19:30:35 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	lyude@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: console: Fix memory allocation error handling in pm_vt_switch_required()
Date: Tue, 14 Oct 2025 01:00:27 +0530
Message-ID: <20251013193028.89570-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  The pm_vt_switch_required() function fails silently when memory
  allocation fails, offering no indication to callers that the operation
  was unsuccessful. This behavior prevents drivers from handling allocation
  errors correctly or implementing retry mechanisms. By ensuring that
  failures are reported back to the caller, drivers can make informed
  decisions, improve robustness, and avoid unexpected behavior during
  critical power management operations.

  Change the function signature to return an integer error code and modify
  the implementation to return -ENOMEM when kmalloc() fails. Update both
  the function declaration and the inline stub in include/linux/pm.h to
  maintain consistency across CONFIG_VT_CONSOLE_SLEEP configurations.

  The function now returns:
  - 0 on success (including when updating existing entries)
  - -ENOMEM when memory allocation fails

  This change improves error reporting without breaking existing callers,
  as the current callers in drivers/video/fbdev/core/fbmem.c already
  ignore the return value, making this a backward-compatible improvement.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 include/linux/pm.h     | 5 +++--
 kernel/power/console.c | 8 ++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574..a72e42eec130 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -25,11 +25,12 @@ extern void (*pm_power_off)(void);
 
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
-extern void pm_vt_switch_required(struct device *dev, bool required);
+extern int pm_vt_switch_required(struct device *dev, bool required);
 extern void pm_vt_switch_unregister(struct device *dev);
 #else
-static inline void pm_vt_switch_required(struct device *dev, bool required)
+static inline int pm_vt_switch_required(struct device *dev, bool required)
 {
+	return 0;
 }
 static inline void pm_vt_switch_unregister(struct device *dev)
 {
diff --git a/kernel/power/console.c b/kernel/power/console.c
index 19c48aa5355d..a906a0ac0f9b 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -44,9 +44,10 @@ static LIST_HEAD(pm_vt_switch_list);
  * no_console_suspend argument has been passed on the command line, VT
  * switches will occur.
  */
-void pm_vt_switch_required(struct device *dev, bool required)
+int pm_vt_switch_required(struct device *dev, bool required)
 {
 	struct pm_vt_switch *entry, *tmp;
+	int ret = 0;
 
 	mutex_lock(&vt_switch_mutex);
 	list_for_each_entry(tmp, &pm_vt_switch_list, head) {
@@ -58,8 +59,10 @@ void pm_vt_switch_required(struct device *dev, bool required)
 	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
+	if (!entry) {
+		ret = -ENOMEM;
 		goto out;
+		}
 
 	entry->required = required;
 	entry->dev = dev;
@@ -67,6 +70,7 @@ void pm_vt_switch_required(struct device *dev, bool required)
 	list_add(&entry->head, &pm_vt_switch_list);
 out:
 	mutex_unlock(&vt_switch_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(pm_vt_switch_required);
 
-- 
2.51.0


