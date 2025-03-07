Return-Path: <linux-pm+bounces-23583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF2A55D85
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B06F162C7E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A52152196;
	Fri,  7 Mar 2025 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GEwSFkE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E0168B1;
	Fri,  7 Mar 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313884; cv=none; b=A6NauFDcc/qRNhA12riSZ0o9i8uRftQWLdpD+9n6B9okp+qWWKt4gui9rcso8z585zh9JhR9Ve6XWvPo3zrMqC3AVJhffFMwJextnrassETFrFcuoHeTdluk1SZD6yl3Y5wkA4HEtlZ56M4E8cLLHOQx0xdWmxhwuin8Q1UEPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313884; c=relaxed/simple;
	bh=o5x7cLEjm8MZX6Jghu2IW59J2Iu3i6+TNqseTqAL1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvuvJmNnxL4c7jplfuJHU9IeKhPyE4x73ChnIVBtyNhd18lIQ/1Zh+hmF3CP/ptUJw/77Ht1L79lgeJ7aRk3cE0tRVpoY970KCFPZLY61tWLJ6o16f+7Ft7xm4jutmQIQ7wYV20cyeKdgzB7vWWqgQ9Bgo5z79r2MHMp5agqwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GEwSFkE6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=o7mlQ1962EQiMMcntIkUeCtxj49EfYHI00jQrO3UUx4=; b=GEwSFkE6tfS2VRZq
	wJgFMV9Clr0R9JkmZotTSOkbxSTxSmw2Wp1aqiiMRp6iqD3fVnhvMHnVRkMyMt6WIYpO/Tov9Vt/H
	l3UJGcQiLehWHr4V+0Q4WlKX08tUcwV/TDv+Qr7OdBhth8zJLuZcCoEGqooPAIFGhE3sSNMr8lBWr
	Ul8yUqEzm/eNg7/iB2VPuwa7MpgdymvPomWUwQOvK0Z17dApm1ncwqBcGuueWffjwJCMm+yA5t1YY
	NH3Eyg+qsoMEtzB6xLYvUxI9GUgkNu8gYUZKtmKC3qg5PUFx+eiZyhF4XjDvhCQzjfJ3Q2BJmS0Q6
	Mfzqqeo9udR7pu7Gcg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqNHa-003I6m-2T;
	Fri, 07 Mar 2025 02:17:50 +0000
From: linux@treblig.org
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drivers: base: power: Remove unused pm_generic_ wrappers
Date: Fri,  7 Mar 2025 02:17:50 +0000
Message-ID: <20250307021750.457600-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pm_generic_thaw_early() has been unused since 2016's
commit 294f47ffd55c ("PM / Domains: Remove redundant system PM callbacks")

pm_generic_freeze_late() has been unused since 2019's
commit 3cd7957e85e6 ("ACPI: PM: Simplify and fix PM domain hibernation
callbacks")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/base/power/generic_ops.c | 24 ------------------------
 include/linux/pm.h               |  4 ----
 2 files changed, 28 deletions(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 4fa525668cb7..6502720bb564 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -114,18 +114,6 @@ int pm_generic_freeze_noirq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
 
-/**
- * pm_generic_freeze_late - Generic freeze_late callback for subsystems.
- * @dev: Device to freeze.
- */
-int pm_generic_freeze_late(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->freeze_late ? pm->freeze_late(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_freeze_late);
-
 /**
  * pm_generic_freeze - Generic freeze callback for subsystems.
  * @dev: Device to freeze.
@@ -186,18 +174,6 @@ int pm_generic_thaw_noirq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
 
-/**
- * pm_generic_thaw_early - Generic thaw_early callback for subsystems.
- * @dev: Device to thaw.
- */
-int pm_generic_thaw_early(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->thaw_early ? pm->thaw_early(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_thaw_early);
-
 /**
  * pm_generic_thaw - Generic thaw callback for subsystems.
  * @dev: Device to thaw.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 78855d794342..7bf22ed4a1d5 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -838,10 +838,8 @@ extern int pm_generic_resume_early(struct device *dev);
 extern int pm_generic_resume_noirq(struct device *dev);
 extern int pm_generic_resume(struct device *dev);
 extern int pm_generic_freeze_noirq(struct device *dev);
-extern int pm_generic_freeze_late(struct device *dev);
 extern int pm_generic_freeze(struct device *dev);
 extern int pm_generic_thaw_noirq(struct device *dev);
-extern int pm_generic_thaw_early(struct device *dev);
 extern int pm_generic_thaw(struct device *dev);
 extern int pm_generic_restore_noirq(struct device *dev);
 extern int pm_generic_restore_early(struct device *dev);
@@ -883,10 +881,8 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
 #define pm_generic_resume_noirq		NULL
 #define pm_generic_resume		NULL
 #define pm_generic_freeze_noirq		NULL
-#define pm_generic_freeze_late		NULL
 #define pm_generic_freeze		NULL
 #define pm_generic_thaw_noirq		NULL
-#define pm_generic_thaw_early		NULL
 #define pm_generic_thaw			NULL
 #define pm_generic_restore_noirq	NULL
 #define pm_generic_restore_early	NULL
-- 
2.48.1


