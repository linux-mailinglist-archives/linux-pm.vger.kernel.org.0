Return-Path: <linux-pm+bounces-16362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD99AE26E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD232844E3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DB1C07EB;
	Thu, 24 Oct 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/OVl4hl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FD1C07DF
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765411; cv=none; b=QdBZ2KN3pOLMwQL1F9FfA4OQkEmW9Z/4tiCqKkXzA3EVREidUZ0d2InxwklM4ijKhE+wCK3vuwJ+cSOd4UWd/fj6gycbeO/zKYVC444uLBeJindUBVRRrHs1CzHGOinhqXb3dYdYrOozo3pW/uxgJCVTC/HsecXS3UcjwUu5QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765411; c=relaxed/simple;
	bh=eXzIVANoSdckZ6/KVBlOoXOvkdYkN+bwsUCbZIcRgns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKCe2GTyOfSq5ScTNz4QkyL81ru6F1QfYvn3BXOKkn1eMkN9T15EKiMB2Oy1yf/TySuKK29jVy06nh2I9HCtOvUwrEv/OiBp9RdsipMVRmVCqeacDm88daOvcb6gZTakMUSeIEDzShzag0eVzBHd9WdpDsgUAaUd4FbDe9nI9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/OVl4hl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so7551925e9.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729765407; x=1730370207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGfd1JHcREPOU5Z6qqF2PdooBtljEuBL480hQIscwuw=;
        b=D/OVl4hl66LLD+LI16/Laue7XUgvCXFW1Co3iqu6AoW+jvXfc5z+CoXFCn98i5jCpp
         f8MzYWwJb7Of+2+INlz8uExV361cnsGS827Bkcfz/SRpfh19FunrAehQrUq5Mz5zRlLv
         PQbmRamSvsrkqrPb1e2mDqqxlRTgD8XjZYx6la5d1fA1eWuh7jCkPFxBhA+7jrpiL4MO
         +FIazLh2qCyw7Ku54ccZjxlMhAbAbGYnVyw7fSmseeBRyKLhlzLp1pS3Xia9oenNMnph
         FDdfzRLvXHndq99UMzV/qTBsr/IbYxxJGXK51jCMTbE3w/fNrrwrPsCzkmvdcXIyjfo+
         FuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765407; x=1730370207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGfd1JHcREPOU5Z6qqF2PdooBtljEuBL480hQIscwuw=;
        b=km4Q3cZnhCrL0Px8dZeNax4Avra4GkbyfzLXn+crXbgrWIvvh+QdPXx5ue8mYzwyCK
         fe14wAVsRE7EzKHljIuUpaj5IwfF86WGrWh8iHKXOeQanf03ywRKUFKXpH2z0R2eisVl
         JZL/jiMN7bM06zeXkjB3uj5aY0W/YM2DY3Br32cF/+dHkRvQFjUFn6Diucfp1yMYdEpV
         i6+ioFWuMqneo5Dtu6hmody0p9pBk5vEzzHER2NfcbJEUi5HCxFI2seplHBqZ0SCIAib
         3rwtiVwmsxaDqdXb57QXaX4cNRLCEBeoPGqtIbrMwR70SqWg7jtKUQgjyftOf3ieXRAG
         79sw==
X-Forwarded-Encrypted: i=1; AJvYcCWD2KTPzzeKcdnn5fJ5xn95KZTyG6n1UAmcDYE5Gp6mVVUGSlORWxUZgaiEK1s7aLWjwdu9lYEWFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5LcRtFApPq7Ou/9eFWkA3lHjocgL2HL9B51ADQ6vT6wUxRF3
	iTHxBzOsJ/D8aHRd3KJ9Mdag7D2RaNbgQuYGb5T4uo5Jl4r8b/3m+K3pIpqjwX0=
X-Google-Smtp-Source: AGHT+IGwgk1Q6Ug+BVFVnUXFcZ9dVuF5hFZk5XTuZGnRFR7wmgF12+GD4A9jzFwefYAW34tVJukA0A==
X-Received: by 2002:a05:600c:5490:b0:431:5d14:1cae with SMTP id 5b1f17b1804b1-4318415fee0mr44990735e9.19.1729765406341;
        Thu, 24 Oct 2024 03:23:26 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bfb0f2sm40739335e9.22.2024.10.24.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:23:25 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rjw@rjwysocki.net
Cc: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/thresholds: Fix thermal lock annotation issue
Date: Thu, 24 Oct 2024 12:23:03 +0200
Message-ID: <20241024102303.1086147-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the thermal zone is unregistered (thermal sensor module being
unloaded), no lock is held when flushing the thresholds. That results
in a WARN when the lockdep validation is set in the kernel config.

This has been reported by syzbot.

As the thermal zone is in the process of being destroyed, there is no
need to send a notification about purging the thresholds to the
userspace as this one will receive a thermal zone deletion
notification which imply the deletion of all the associated resources
like the trip points or the user thresholds.

Split the function thermal_thresholds_flush() into a lockless one
without notification and its call with the lock annotation followed
with the thresholds flushing notification.

Please note this scenario is unlikely to happen, as the sensor drivers
are usually compiled-in in order to have the thermal framework to be
able to kick in at boot time if needed.

Link: https://lore.kernel.org/all/67124175.050a0220.10f4f4.0012.GAE@google.com
Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_thresholds.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index ea4aa5a2e86c..2888eabd3efe 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -20,17 +20,22 @@ int thermal_thresholds_init(struct thermal_zone_device *tz)
 	return 0;
 }
 
-void thermal_thresholds_flush(struct thermal_zone_device *tz)
+static void __thermal_thresholds_flush(struct thermal_zone_device *tz)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *entry, *tmp;
 
-	lockdep_assert_held(&tz->lock);
-
 	list_for_each_entry_safe(entry, tmp, thresholds, list_node) {
 		list_del(&entry->list_node);
 		kfree(entry);
 	}
+}
+
+void thermal_thresholds_flush(struct thermal_zone_device *tz)
+{
+	lockdep_assert_held(&tz->lock);
+
+	__thermal_thresholds_flush(tz);
 
 	thermal_notify_threshold_flush(tz);
 
@@ -39,7 +44,7 @@ void thermal_thresholds_flush(struct thermal_zone_device *tz)
 
 void thermal_thresholds_exit(struct thermal_zone_device *tz)
 {
-	thermal_thresholds_flush(tz);
+	__thermal_thresholds_flush(tz);
 }
 
 static int __thermal_thresholds_cmp(void *data,
-- 
2.43.0


