Return-Path: <linux-pm+bounces-33347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C06B3AF89
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF9189244A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688419D8A8;
	Fri, 29 Aug 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9jgA06f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DD18BBB9
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427627; cv=none; b=NjkWMl9463ghPGI+S0dmeHoPBtC7+L+nK+It06l/BXACLA84pzJkrc/2xEz5oegfK4y9NIcDynOWuGVsGtOmafLl043iVOpGHWKAuou+edG1Jz9k53x9IC/DVIo1iHAoQmM1ZVanXE9Cstwzf4rfhIpsnsp2lWJ3Sgtcbpx9YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427627; c=relaxed/simple;
	bh=Q56VG0oXv7fc6qv0ZFPm5cKl52Q7ty3jvIzKtCq+/TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNNLOSwLpUh4oXf68lxoq2Q6yPT6W4l6jRm10O/n94LtL0DExA9eov43ggzb2uR7jCdvo5UgPeDAVc5HGYpLKP9XCyNDRyNqfcBNaRDUQbq5yNwEY4sjFzyDG2P4pMFDHc55UyZ1TpOcxCx1PRHEzXF+SxkhsChYFLWzJsDTHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D9jgA06f; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-770530175b2so1264045b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756427625; x=1757032425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6XaNX8Mq1vSJ5IzdJQsqjDN1yWPQ2JHHVDMfjlEZJI=;
        b=D9jgA06fdi1B7eieK1oZDcMUkWM0G5DIRqqCCNvahQaHv2fvOKUlF3i2GnQdApP6sT
         wVBaCI5FHohhRo1ZpMVCN7SYOl1EGPNG0BxOIsCOSQ3fuvDrjZk1G7JS5ZghEmrOqrld
         BjSqLfPA27o3pOHUhEXO7b60b+zYTEjeTQY5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427625; x=1757032425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6XaNX8Mq1vSJ5IzdJQsqjDN1yWPQ2JHHVDMfjlEZJI=;
        b=blbX6p+hFvy5LDdljrR7venw6rdtFmmtK6rTgJxdysQfgWs0Nj2UaC227XHA6O06o0
         udjrHErDVSNpgyAIoLnCM2ZRP7xMlYKQqqQkDFaNPpG7J63E93Iszr6Xx4BT1WjJ2BUU
         iCRZeVI26kF7s9duT3o447E5LrbAMvYrvlQgeDCVkOiKIU8LNuTZoaHmQ6bFFokQB3Vk
         drheQM2F6R9Mzyiu4fey4U6y9Y3Fq4dawafEwK4jRneFWqc2Kp3wp2uHIN2wEdm40Zis
         k8VoJUbshXBPU4456DWeKLUaPhlK+UJg/C0rcadcw4Aw9B+daFtZ9v6XS69pS+mbVAnC
         MOTw==
X-Forwarded-Encrypted: i=1; AJvYcCW1T/rR5fke1Ir9FQYLvNoLKS5teYMzZZjggbPOCLfggru1oH/u5eewV+WKINIBirgil2KokRVKZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUlTz7k1CcePzylfbykd2Obh0wicC/yzJbvMYJn0xsfcDkLPO
	Hw0kP9xSg3iV0I2njMYnva7B7MCECmzRT8TwaextRG6twvRP/PNWLXjZkPsWL+r5/g==
X-Gm-Gg: ASbGncsAfyGbl9ZaFzsyxL6JL3SKXTCYSPN7g/wBoW8fL6vVUvd25mKzoqhFGbpWyiy
	u/C87mjWF8b1ceQo6reL8wlEF46mhfX2MZPRhKNWgl1+MN4WQbpHDh+/QWeMvSgVqBo4CQa0Ikb
	44atgEzT3qWSoRzkkOODA5xNmdWYqbR6F9yG4x23ZsG4g5t/Wf3mmDkhvYQqzPTCeSkcGJdCf8Z
	DnJgDYvYREQaJ3gIVbomJiz+V4jX2AOVOd6Tr7txgyz62ualDt8Sc+l4XjsKH3iJh13P7siVq1z
	H/kJ3Goh85oaSV0CGC9R51ed6r91/uIP6lEUhZY/uenEp22RlEYkLAANnGUeZht5kzKsziKUvkX
	VROu+QZ1JcXvkDGqVvPcmwuykA+caJ0uf7bT8+r6fB1Nmw/nJO5R5PX1unFGw6/iG9eFVC/8=
X-Google-Smtp-Source: AGHT+IG5QB6/LyVNvh+/P2eNw80P808BpcaNCzzRcETaF4BYYBlIiW2JcWPH6sU5e+JuKFxHv0k4hA==
X-Received: by 2002:a05:6a00:1786:b0:770:5931:e05d with SMTP id d2e1a72fcca58-7705931e21cmr21439515b3a.31.1756427624841;
        Thu, 28 Aug 2025 17:33:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a4e24e3sm621877b3a.78.2025.08.28.17.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:33:44 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com,
	Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] PM: runtime: Make put{,_sync}() return 1 when already suspended
Date: Thu, 28 Aug 2025 17:28:27 -0700
Message-ID: <20250829003319.2785282-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250829003319.2785282-1-briannorris@chromium.org>
References: <20250829003319.2785282-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pm_runtime.h docs say pm_runtime_put() and pm_runtime_put_sync()
return 1 when already suspended, but this is not true -- they return
-EAGAIN. On the other hand, pm_runtime_put_sync_suspend() and
pm_runtime_put_sync_autosuspend() *do* return 1.

This is an artifact of the fact that the former are built on rpm_idle(),
whereas the latter are built on rpm_suspend().

There are precious few pm_runtime_put()/pm_runtime_put_sync() callers
that check the return code at all, but most of them only log errors, and
usually only for negative error codes. None of them should be treating
this as an error, so:

 * at best, this may fix some case where a driver treats this condition
   as an error, when it shouldn't;

 * at worst, this should make no effect; and

 * somewhere in between, we could potentially clear up non-fatal log
   messages.

Fix the pm_runtime_already_suspended_test() while tweaking the behavior.
The test makes a lot more sense when these all return 1 when the device
is already suspended:

    pm_runtime_put(dev);
    pm_runtime_put_sync(dev);
    pm_runtime_suspend(dev);
    pm_runtime_autosuspend(dev);
    pm_request_autosuspend(dev);
    pm_runtime_put_sync_autosuspend(dev);
    pm_runtime_put_autosuspend(dev);

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 8 ++------
 drivers/base/power/runtime.c      | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 263c28d5fc50..1be18e871f1d 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -43,15 +43,11 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
 
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
-	/*
-	 * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
-	 * this as -EAGAIN / "runtime PM status change ongoing".
-	 */
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put(dev));
 
 	pm_runtime_get_noresume(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
 
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3e84dc4122de..17cf111d16aa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -498,6 +498,9 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	if (retval < 0)
 		;	/* Conditions are wrong. */
 
+	else if ((rpmflags & RPM_GET_PUT) && (retval == 1))
+		;	/* put() is allowed in RPM_SUSPENDED */
+
 	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
 	else if (dev->power.runtime_status != RPM_ACTIVE)
 		retval = -EAGAIN;
-- 
2.51.0.318.gd7df087d1a-goog


