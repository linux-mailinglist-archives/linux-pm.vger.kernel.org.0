Return-Path: <linux-pm+bounces-40668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AABABD13A7C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 384BF303D8AB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49AD2E7185;
	Mon, 12 Jan 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2z48vMq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338442E093A
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230950; cv=none; b=cM1ChalXNnh28FQpDjnG/iQfFRYBTg1Ik7KM3Vv1j1ftvRfNRTyvrcaQEHEKFCHB6FS2EtWA5MVwqQfdYiYXat/bs3lu7dncj4IAU3tOAB7fe0jOn358lpJRDrqfX/K7FDRTmGen3OCjbCH6xaA3oAe2oDrKLiBZQtUGUZTNSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230950; c=relaxed/simple;
	bh=uu/0gx32kQnkFqHlQ6veDyTiR50b8osndfHDDKfyLFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCbK92PJ5PHhW8TeRhomU/bDQZut4ENaBHyVy9qkQOgqld2w4eodrZj9cFXpVQ7dedh9zd1HW5Vz+UnF3rzeMDSH3KGW/lGyV1+YQcxM7LAc2NIXUiqk6E5UOSiSxuIqn94FQ+v1qtQYBYyPzwshHc+m4hbnTs/c0x2GEBn1EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2z48vMq; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0d0788adaso43091235ad.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230948; x=1768835748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnMqe0D1x/FU87z66s9oq5Es+BDzRArlUSrNXRg5zps=;
        b=J2z48vMq9jGBBb4ZQqveJjUNvIh+kUTrktuBogKJTXgZoEDU7ty1JexOVXABFVMCCD
         O6aDE4qpnuqavvJEmTaeoV489thijz7ZAq+J/ltcPzIUy2PyYhi7jK6VDgDm6oYlIj1M
         e6JCW8+m81shp0qpzLsQqzVXjF4DT8ZkqMaBY3ej2nkcgkS+YLjp9bKO7El8lK6Mz3GM
         cU2/QJ2U3MvEniXrBm0C+hEpodgQU1hUR/PT9pjGAwyy1Gs56cviXMj82xI0qj/44tBV
         bU6gKLUt9O+GPiGoCG2bWrOqCKq1ligrTjaWGXHcQ6kl1f/xBvjLodJsuxqIKiEJ95i7
         0ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230948; x=1768835748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnMqe0D1x/FU87z66s9oq5Es+BDzRArlUSrNXRg5zps=;
        b=Dd8/8N3tCv1dNUpkUGHmi1BvvXakB/J6sPJTACMS6OPIIMMzjlQBr5LAly4lqQXsE5
         qUIeauOZxMty2d0TuIWPjQ6fDVAYCpOxgP6/GM987HZGWVRCTZ/NDxm40y6HyB7i5mGG
         BZuhsbvlteJ7gLZxeVw2/HlaGvGzU6uI4XGc0l+EiN91NbnCoNiggCs+OGBE48iDHKnE
         iePHO54g2CctZK72ieTmBK1PdkBXFVh1posJO5xzeECPN5w57wv/eqR8w6jlYTqRQFlK
         9aS7mx+NQqw51kr/FIytT6OeRxReVMql6DpVeLCpVZwnYhJHCHvsNvA4QiZNh/tTU8gQ
         qPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXLFVt0aiOsLO/IJz7k+/6XmmOVMlwVDSJqfcbLcCANSBeg53PZiU6/Zntab7JyUUT4XTgY9lSSNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjPgko8utQVoVSfqZBvR3JfAtqAmvhbmkf8d02lOr5tnFhpCw
	ZQRAqeqfbeNEhlrCTwzj6bUNpFDiGQ8IRj6VpC8Y5cwv83XcDqfjM6kB
X-Gm-Gg: AY/fxX7YYxDQ/Htr6LGnzls7xB3mKtuWHEtuqMDH9cBHakT9hMUd1Xd9NBRY1LpPfER
	oyQZec1z+xzfA4GIrfAJxKzhr+J0ocF784PuMq22RsHRLR7YF6DvfiOJxn3HIere2CkipWIQKse
	lfpQw/M/3xDOQWUlev4okvZNxEkuPnMUYm0eoqHrXuDG+TWnisy+Tru18wTbkh94au5hOskQUUh
	qaf0rpNbHO88p106dXdFv4zZiNKL7vI0SAws4pj6SjhTHamDcprIWIB7RmI/t7yk2+pSLzAFsLX
	6cNGYYLG3qrEl7/LdHhufQJLTEmlrHkj1PzoY2efnPspgzjYmstWcY8RRIGhCurJn3lCyeGuLll
	Wv3I9Fga9UBGUOWVihk9k1XbwzBdXiZxceFNkDTscGZTI5dKYnxUXTjS5+LwZfLA45jevxCyyQi
	hJ0Ud0vME4rc6t6z/B6dXUf8sCRs/ZY9RfQxU=
X-Google-Smtp-Source: AGHT+IGPxmQ1kqM9Y+/PooGdd71tDVNUoILktcyjch+8IqS37vwBrYsliExh1QZEWmEBY6AsgV25IA==
X-Received: by 2002:a17:902:c949:b0:2a0:c942:8adf with SMTP id d9443c01a7336-2a3ee40d5a9mr161920895ad.8.1768230948295;
        Mon, 12 Jan 2026 07:15:48 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48d77sm175976905ad.41.2026.01.12.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:15:47 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH v0] PM: wakeup: call device resume after superior device complete resume
Date: Mon, 12 Jan 2026 23:14:41 +0800
Message-ID: <20260112151441.1860607-1-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background:
Extist device A,B and C.A is parent of B,C has no dependency on
either A or B.A is an asynchronously resume device,
while B and C are synchronously resume devices.dpm_list: A->B->C.
When A has not completed asynchronous resume,
the main loop will be blocked at B,and C cannot start resume
even if it is not associated with either A or B.
This will result in a waste of CPU resources
in the main loop if A resume need long time.

Solution:
Place devices that are dependent on others but have not yet
completed resume into a waiting queue,and resume subsequent
unrelated devices first. After the current list is empty,
resume the devices that were skipped before.
This approach does not violate the dependencies between devices.

Benefits of modification:
1. The synchronous device will not block the main loop
by waiting for dependent devices to complete.
2. Asynchronous devices will not start early and
waste scheduling resources.

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
---
 drivers/base/power/main.c | 144 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4bec5dd88547..13633b96c1c8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -35,6 +35,8 @@
 #include <linux/devfreq.h>
 #include <linux/timer.h>
 #include <linux/nmi.h>
+#include <linux/delay.h>
+#include <vdso/time64.h>
 
 #include "../base.h"
 #include "power.h"
@@ -327,6 +329,64 @@ static bool dpm_wait_for_superior(struct device *dev, bool async)
 	return device_pm_initialized(dev);
 }
 
+/**
+ * dpm_finish - Test a PM operation have finished.
+ * @dev: Device to test.
+ */
+static bool dpm_finish(struct device *dev)
+{
+	if (!dev)
+		return true;
+
+	return completion_done(&dev->power.completion);
+}
+
+/**
+ * dpm_test_suppliers_finish - test suppliers of the device have finished
+ * @dev: Device to handle.
+ */
+static bool dpm_test_suppliers_finish(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	idx = device_links_read_lock();
+
+	dev_for_each_link_to_supplier(link, dev)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_flag_is_sync_state_only(link->flags))
+			if (!dpm_finish(link->supplier)) {
+				device_links_read_unlock(idx);
+				return false;
+			}
+
+	device_links_read_unlock(idx);
+
+	return true;
+}
+
+/**
+ * dpm_test_superior_finish - test superior of the device have finished
+ * @dev: Device to handle.
+ */
+static bool dpm_test_superior_finish(struct device *dev)
+{
+	struct device *parent;
+
+	if (!device_pm_initialized(dev))
+		return true;
+
+	parent = get_device(dev->parent);
+
+	if (!dpm_finish(parent)) {
+		put_device(parent);
+		return false;
+	}
+	put_device(parent);
+
+	return dpm_test_suppliers_finish(dev);
+}
+
 static void dpm_wait_for_consumers(struct device *dev, bool async)
 {
 	struct device_link *link;
@@ -831,6 +891,8 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
 	ktime_t starttime = ktime_get();
+	int resume_num = 0;
+	LIST_HEAD(dpm_noirq_wait_list);
 
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
 
@@ -849,8 +911,32 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 			dpm_async_with_cleanup(dev, async_resume_noirq);
 	}
 
-	while (!list_empty(&dpm_noirq_list)) {
+	while (!list_empty(&dpm_noirq_list) || !list_empty(&dpm_noirq_wait_list)) {
+		if (list_empty(&dpm_noirq_list)) {
+			list_splice_init(&dpm_noirq_wait_list, &dpm_noirq_list);
+			/*
+			 * sleep 1 millisecond avoid CPU busy loops
+			 */
+			if (!resume_num) {
+				mutex_unlock(&dpm_list_mtx);
+				fsleep(USEC_PER_MSEC);
+				mutex_lock(&dpm_list_mtx);
+			}
+			resume_num = 0;
+		}
+
 		dev = to_device(dpm_noirq_list.next);
+
+		/*
+		 * Skip devices that are still pending completion of dependent devices
+		 */
+		if (!dev->power.syscore && !dev->power.direct_complete &&
+			dev->power.is_noirq_suspended && !dpm_test_superior_finish(dev)) {
+			list_move_tail(&dev->power.entry, &dpm_noirq_wait_list);
+			continue;
+		}
+		++resume_num;
+
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
 		if (!dpm_async_fn(dev, async_resume_noirq)) {
@@ -981,6 +1067,8 @@ void dpm_resume_early(pm_message_t state)
 {
 	struct device *dev;
 	ktime_t starttime = ktime_get();
+	int resume_num = 0;
+	LIST_HEAD(dpm_late_early_wait_list);
 
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
 
@@ -999,8 +1087,32 @@ void dpm_resume_early(pm_message_t state)
 			dpm_async_with_cleanup(dev, async_resume_early);
 	}
 
-	while (!list_empty(&dpm_late_early_list)) {
+	while (!list_empty(&dpm_late_early_list) || !list_empty(&dpm_late_early_wait_list)) {
+		if (list_empty(&dpm_late_early_list)) {
+			list_splice_init(&dpm_late_early_wait_list, &dpm_late_early_list);
+			/*
+			 * sleep 1 millisecond avoid CPU busy loops
+			 */
+			if (!resume_num) {
+				mutex_unlock(&dpm_list_mtx);
+				fsleep(USEC_PER_MSEC);
+				mutex_lock(&dpm_list_mtx);
+			}
+			resume_num = 0;
+		}
+
 		dev = to_device(dpm_late_early_list.next);
+
+		/*
+		 * Skip devices that are still pending completion of dependent devices
+		 */
+		if (!dev->power.syscore && !dev->power.direct_complete &&
+			dev->power.is_late_suspended && !dpm_test_superior_finish(dev)) {
+			list_move_tail(&dev->power.entry, &dpm_late_early_wait_list);
+			continue;
+		}
+		++resume_num;
+
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
 		if (!dpm_async_fn(dev, async_resume_early)) {
@@ -1160,6 +1272,8 @@ void dpm_resume(pm_message_t state)
 {
 	struct device *dev;
 	ktime_t starttime = ktime_get();
+	int resume_num = 0;
+	LIST_HEAD(dpm_suspended_wait_list);
 
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
 
@@ -1178,8 +1292,32 @@ void dpm_resume(pm_message_t state)
 			dpm_async_with_cleanup(dev, async_resume);
 	}
 
-	while (!list_empty(&dpm_suspended_list)) {
+	while (!list_empty(&dpm_suspended_list) || !list_empty(&dpm_suspended_wait_list)) {
+		if (list_empty(&dpm_suspended_list)) {
+			list_splice_init(&dpm_suspended_wait_list, &dpm_suspended_list);
+			/*
+			 * sleep 1 millisecond avoid CPU busy loops
+			 */
+			if (!resume_num) {
+				mutex_unlock(&dpm_list_mtx);
+				fsleep(USEC_PER_MSEC);
+				mutex_lock(&dpm_list_mtx);
+			}
+			resume_num = 0;
+		}
+
 		dev = to_device(dpm_suspended_list.next);
+
+		/*
+		 * Skip devices that are still pending completion of dependent devices
+		 */
+		if (!dev->power.syscore && !dev->power.direct_complete &&
+			dev->power.is_suspended && !dpm_test_superior_finish(dev)) {
+			list_move_tail(&dev->power.entry, &dpm_suspended_wait_list);
+			continue;
+		}
+		++resume_num;
+
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
 		if (!dpm_async_fn(dev, async_resume)) {
-- 
2.52.0


