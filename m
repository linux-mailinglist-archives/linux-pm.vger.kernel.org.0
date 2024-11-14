Return-Path: <linux-pm+bounces-17528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E69C8173
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 04:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0134B1F22D67
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45121E7675;
	Thu, 14 Nov 2024 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAgpFUgP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98233FB1B;
	Thu, 14 Nov 2024 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554627; cv=none; b=WEd5bZSNCnjm8HHCpwrAU7sL+FaQw9NxWKY7vO2qnxs3ptpZV6lzy50tY60xafXa5ccHwB9Yn9PQiicaxr6cDDyJHkBmh7qFUkKtu/0e2DGkjrhv7o7lLjALkHk+DH3RiJBeY0MPRvAJ+ZaKT9v8ijDDR27mqkp8WWYgedPXXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554627; c=relaxed/simple;
	bh=n4T4tQXUvNX1ujihIIwC8wxQCwSfBPRyfcsOEjU9v6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwkMihP+WfgjwHveX4M3ZN0fj7LtO5V7b5M97x9wj2tGt2TXS17D8QlI0fbnGjjlQULlA+CMnqyiOZAT8dL3TxZkFKerAVQLvboLZkW6rLPlRNGN1XZwJXIXmSyHY6CQJG8rG2YNnfBgMxxjayKIcPq2fcywI4HWOAlEeC+R24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAgpFUgP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbce8d830dso732846d6.1;
        Wed, 13 Nov 2024 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731554625; x=1732159425; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/04CkqCrXYlODenZ1ZDkYaNp83Xg5x6FHak9tCuPUNg=;
        b=MAgpFUgP1eWmbac/0cfqa0xek6foVPcX1KGNRRK4ohYzcUl00pQA/smpa73lcQNUzX
         lN5xJBGNBqE7bcOLVPZ8QFq45M6YmH6enhLJL68+1sD31WNm41ZfcDA8Ja3TX70UQDFm
         H75d1rIdhGn9vxZbytrjV9iV9wFXkuxsvpHBlx4LsBuBzey+VNeWUtA0lPVhrF8WI/+o
         k8fPvXmJKjRb9EmUsEGcRuNTBz4JDRbNdBUiKRfdsdiGkLgDXO8qSWK1YlD/4eVVD3/Q
         +NNZqjdnw6eaFGwmQzMdwg5ITsOIDIo4LyBOx4azRK3nZPBgTt4PHXyp2fU/KSJtgk9k
         H9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731554625; x=1732159425;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/04CkqCrXYlODenZ1ZDkYaNp83Xg5x6FHak9tCuPUNg=;
        b=vxu1cCZnfOpzR/dRf7dAnZLfD1ErS59xYS9SFB0fED/jaDotOUvhj9yhhl1q2knOav
         Py+h4N3n3fIYd3ORRlxEj2ub9e+X2tBIix9wlP5LZwh/hRaHEi0SASspcijYvi3sBecO
         P7rH+2dbfOiRArVft48LEvb837aK9g2hMeSzZM44XWPHwKYJBL4+gS7mRg5WpB2JGmaC
         IR/3QD8T8irGsUoYhvUj8qbbTKXGk9mn26NzksMyZAOrKPJnV1YnIHDeeakiWwE2lcpl
         MgRv0CVd6S+SQtzTr1UL4hu/Qy5FpPjkuhGvIuZdPdcc5EMm0fPtPcnvKEGYi2G6cHan
         PyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6+/OYQnej320MQXUmyyWCdrsDvDUlD3zqgyiDpGBrlSJAD7gWk+qICoYBA5KDdDAPWSt3+FaqE7S1Q8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG46++tOWhE/Ojxv6+dSSoqarV98cJ2M0VznsvYtcQQN7DWpAi
	T1NtwbRezIy6bNAKNufK6C9s+oG5tYcSWC8e/LH0VIOT1voDpeG9
X-Google-Smtp-Source: AGHT+IG+Ltu/68Wlcdn0EdZeix4yi+OzYc9XfvFSbo/VQ3QTnnIqTH3JlokYOb+ujp8oDLlBlf7LKg==
X-Received: by 2002:a05:6214:451d:b0:6d1:9724:80fa with SMTP id 6a1803df08f44-6d3edda36e6mr7055076d6.32.1731554624509;
        Wed, 13 Nov 2024 19:23:44 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:f867:9203:71bc:12b5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee77800dsm1070486d6.26.2024.11.13.19.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 19:23:44 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend() callback return values
Date: Wed, 13 Nov 2024 22:23:24 -0500
Message-ID: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Drivers commonly return non-zero values from their suspend
callbacks due to transient errors, not realizing that doing so
aborts system-wide suspend.

Log, but do not abort system suspend on non-zero return values
from driver's .suspend/.suspend_noirq/.suspend_late callbacks.

Both before and after this patch, the correct method for a
device driver to abort system-wide suspend is to invoke
pm_system_wakeup() during the suspend flow.

Legacy behaviour can be restored by adding this line to your .config:
CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=y

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/power/driver_api.rst | 25 +++++++++++++++++++++++++
 Documentation/power/index.rst      |  1 +
 drivers/base/power/main.c          | 25 ++++++++++++++++++-------
 kernel/power/Kconfig               | 17 +++++++++++++++++
 4 files changed, 61 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/power/driver_api.rst

diff --git a/Documentation/power/driver_api.rst b/Documentation/power/driver_api.rst
new file mode 100644
index 000000000000..b9a46a17f39b
--- /dev/null
+++ b/Documentation/power/driver_api.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==================
+Driver Suspend API
+==================
+
+
+1. How Can A driver abort system suspend?
+-----------------------------------------
+
+Any driver can abort system-wide  by invoking pm_system_wakeup()
+during the suspend flow.
+
+ie. from the drivers suspend callbacks:
+ .suspend()
+ .suspend_noirq()
+ .suspend_late()
+
+Alternatively, if CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=y is present in .config,
+then any non-zero return value from any device drivers callback:
+ .suspend()
+ .suspend_noirq()
+ .suspend_late()
+will abort the system-wide suspend flow.
+Note that CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=n, by default.
diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index a0f5244fb427..f655662a9c15 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -7,6 +7,7 @@ Power Management
 .. toctree::
     :maxdepth: 1
 
+    driver_api
     apm-acpi
     basic-pm-debugging
     charger-manager
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..1b4ab73112e4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1244,7 +1244,6 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state, bool asy
 Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
-		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 		goto Complete;
@@ -1270,7 +1269,12 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state, bool asy
 Complete:
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
+		async_error = error;
+		return error;
+	}
+	return 0;
 }
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
@@ -1424,7 +1428,6 @@ static int device_suspend_late(struct device *dev, pm_message_t state, bool asyn
 Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
-		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
 		goto Complete;
@@ -1437,7 +1440,12 @@ static int device_suspend_late(struct device *dev, pm_message_t state, bool asyn
 Complete:
 	TRACE_SUSPEND(error);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
+		async_error = error;
+		return error;
+	}
+	return 0;
 }
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
@@ -1681,7 +1689,7 @@ static int device_suspend(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 
  End:
-	if (!error) {
+	if (!error || !IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
 		dev->power.is_suspended = true;
 		if (device_may_wakeup(dev))
 			dev->power.wakeup_path = true;
@@ -1695,14 +1703,17 @@ static int device_suspend(struct device *dev, pm_message_t state, bool async)
 
  Complete:
 	if (error) {
-		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
 
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+	if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
+		async_error = error;
+		return error;
+	}
+	return 0;
 }
 
 static void async_suspend(void *data, async_cookie_t cookie)
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index afce8130d8b9..db120bba0826 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -141,6 +141,23 @@ config PM_SLEEP
 	depends on SUSPEND || HIBERNATE_CALLBACKS
 	select PM
 
+config PM_SLEEP_LEGACY_CALLBACK_ABORT
+	bool "Enable legacy callback abort via return value"
+	depends on PM_SLEEP
+	help
+	This option enables the legacy API for device .suspend() callbacks.
+	That API empowered any driver to abort system-wide suspend
+	by returning any non-zero value from its suspend calbacks:
+	(.suspend/.suspend_noirq/.suspend_late)
+	In practice, these aborts are almost always spurious and unwanted.
+
+	Disabling this option (default) ignores .suspend() callback return values,
+	though they are still traced and logged.
+
+	The proper way for a device driver to abort system-wide suspend is to
+	invoke pm_system_wakeup() during the suspend flow.  This method is
+	valid, independent of this config option.
+
 config PM_SLEEP_SMP
 	def_bool y
 	depends on SMP
-- 
2.43.0


