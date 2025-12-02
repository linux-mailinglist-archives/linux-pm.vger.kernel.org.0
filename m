Return-Path: <linux-pm+bounces-39098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2AC9CC4B
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7348C4E01F2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97C2DC798;
	Tue,  2 Dec 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NG60G3Ak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3131DED49
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703901; cv=none; b=KUbaO+f0TgUj0FJsdNkeyPkmzhHKJCgKF6AJAuE/gywu7Kv41uuj4DozpyppKWg7XSjZJxJWpPBuTJszOEP9kugSIhY5nqKlEyRzmDPy0JJrvnH2Hcow1O3Iu+JknqPkOlEttwVvDMFLrjnzNLTJmaqAhIKHolamalalCnQqVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703901; c=relaxed/simple;
	bh=fEcCW49GLxnu7FGzwMj26z1F3Yk1MWApE98oMgQh5bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPfXqh8mr9aMnRLVK5TABY/HwnPYBXrrdRzG5BoIvFnJd4mUAYJjZbF+J8LAXC4aD9ddh9ZKRuVokG7ulZ2SGnXSNSFgPTM4NnzpZzeZlJ5Y6viRjY02yMWawp7Zj2QcLzJN8d+V+CMMTYlTjqCa77QYz2B0RLrxW7V5pBnIeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NG60G3Ak; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555415c5fso69863685ad.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703899; x=1765308699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyAV6b1dCSPUCut9ORTRvQyMGZe7GCYluMBZNHP/w0U=;
        b=NG60G3AkZ+ojKcjb4X92s+pUJBRTzg0wzCAi4D8U3bGg0dinWD2k++VsLBHedghUbj
         Ei3ky9/pqP8RDEOUSRjz9n1rIR9TSlN+8em4vRjFG6pRntndrg6ae3F1Zb0zA1FHariN
         G4IwJdHv8nRDifKBYve0H01O9IsAHtZddHz1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703899; x=1765308699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyAV6b1dCSPUCut9ORTRvQyMGZe7GCYluMBZNHP/w0U=;
        b=A1okA23NFy9Ys+QHeNvn/L7IhZ+leYUQSUpeWAaxHpIXkuxICnG4qTBb05yHnOIBTE
         81UqNI0ohFs6J5VVqogr23x1znchY5ewJlEa76YayDJ+z1XLlqNmkv3EPgIJ1U9sB3Xu
         cVwZY4ET9/b+a0Si+3MDr4WG/volZQGr1LouHKjC3JhWDYdm3AbNmY2BTsEKf8TJHdo5
         FEr3vwbuNiJMN7Qr1UeB8UodKTir3efruWMv1lXrr6MLLxcqHRk57zN4Fa9NyxgoB+ye
         GK4q+7ezusp0oS+JIyZ9aown1R5eAnmbip2lKbf49YlCx3h+DA7yqkGZJyKDGLqmXT4U
         FPYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+r5sPNl5cxs04/eAcWSTN+CmXaboMAtWyFH1cJOMTk8DJKKXEZy/QzhOwRR/wwgNYU1S3+bk3YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXrfe4P0rIvpa1BwUaKx3XQzP2cXlaVi73BSG0Aaan06A+Des
	kEdgqn2Kqx66cO+IpymFpMnXP8Av6oli1D8VbTj2aFh3mwOpItKzT4oY5DrqjXyygw==
X-Gm-Gg: ASbGnctK3eA6J6xyG6Ndq0/is9YN4+fhvwRa6PzkdfaeyaUiJFizGTolpBGEsTwOYHV
	Hxh3ZifIi4gcUB2lriBx8wICKORGjpgl69hsTFE4upaTuT6WfwzwRSUewm46aOZL8H11+aIBTg8
	ZNNuzBxXuHIDPvzOLgrZ3DQQgtY8X7IK9yjKfug5Lh6wkTXPweGppY/w0p4atXKObQdSA+z93H1
	REvynrlcEdY3d5OBxcvHNtK2H/gAFA2TdVjqOKKrnm6jZUcAXB5jLmyIfSG5WdB33iOaXTlBWIr
	IZlnaiyt5C7U5cTIVej7fYj6+001woZ9WPnYTMb854ioUalWcRCTNi6DizfnlnZ4o9hwbW66Ol/
	wqcCyIlK03KcBjXrAO68XuTO9RtyLFt1KACdy3MmN3ilJxNdeJWvOSGbrVg64nrtsfd99v9Up/r
	xLTZ6BciRua25m09nCldHl0bdthJDD2F4W+knK7/0WarZo7iD0+jNGs7WthGsAxuKCHBpYY5M=
X-Google-Smtp-Source: AGHT+IFwi+4LK0qpugw0KBj5fazsKFox+KJ1G9nPqHCdptaKIAv1XlFaC9KoFdl/LTA5slQRRkbFbw==
X-Received: by 2002:a05:7022:688:b0:11b:9386:8267 with SMTP id a92af1059eb24-11defd3855bmr389146c88.44.1764703898701;
        Tue, 02 Dec 2025 11:31:38 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcaed5f6bsm91630110c88.1.2025.12.02.11.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:38 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] PM: runtime: Stop checking pm_runtime_barrier() return code
Date: Tue,  2 Dec 2025 11:30:24 -0800
Message-ID: <20251202193129.1411419-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently this test is the only code that checks the return code from
pm_runtime_barrier(), and it turns out that's for good reason -- it's
inherently racy, and a bad idea. We're going to make
pm_runtime_barrier() return void, so prepare for that by dropping any
return code checks.

This resolves some test failures seen like the following:

[   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drivers/base/power/runtime-test.c:177
[   34.559694]     Expected 1 == pm_runtime_barrier(dev), but
[   34.559694]         pm_runtime_barrier(dev) == 0 (0x0)
[   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:1

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 477feca804c7..1535ad2b0264 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -37,10 +37,6 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
 
-	pm_runtime_get_noresume(dev);
-	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
-	pm_runtime_put(dev);
-
 	pm_runtime_get_noresume(dev);
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
 
@@ -174,7 +170,7 @@ static void pm_runtime_error_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
 
 	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
-	KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
+	pm_runtime_barrier(dev);
 	pm_runtime_put(dev);
 	pm_runtime_suspend(dev); /* flush the put(), to suspend */
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -225,7 +221,7 @@ static void pm_runtime_probe_active_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
 
 	/* Nothing to flush. We stay active. */
-	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
+	pm_runtime_barrier(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
 
 	/* Ask for idle? Now we suspend. */
-- 
2.52.0.158.g65b55ccf14-goog


