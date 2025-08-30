Return-Path: <linux-pm+bounces-33446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A2EB3C82A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 07:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF962A229CC
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A723C506;
	Sat, 30 Aug 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9SC7fd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7621D3DF
	for <linux-pm@vger.kernel.org>; Sat, 30 Aug 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532067; cv=none; b=Xwa1oWTP7X0PqvUEaPS7nhjs6as8fz+JJjPNPD9G1g6lwDIQYRKLPtJJdslZUPnrbMJwnSTevcInHj6NB+u4z2H4EI5+tOsn5k6Q0wHACGoQkqQTkJQEHW1RhAcKATv137pTCcLquj86MDaoZd1vnTMHdl22rvqFaAC1s/EdpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532067; c=relaxed/simple;
	bh=S1vZt7Bb4Ae+RWB6wNDxEbqhqUr6G2a84Yhov5BmfHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lONAVKNyupB3Vxe8WdfNBImIJ6k2cPJJDb+yqImWy5A3/+0tt1l1KHvq/a6XwVvT7PxEqCmfNLpT+p7/P901I2Zxx8n1XvJYVhzPxpCKqM2PkIp6u+ZM2FdVFQOwKMFgCv5S5fa+t4ilCjTfYwW/BmIo3AYl7jidoqhCUyzPJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9SC7fd6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso16609365e9.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532064; x=1757136864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Q7BLbHegOCnkq2HK0s5fiWA5SObOxBtK/e6uu5VQA=;
        b=t9SC7fd6caf4+YBI2zTET4NMznvplGkjDpiqE0QgWY/JpTNvix/CIVv1TCTnpOf3UO
         Ig32mqyKqGCx8pANmPCg2sQSuA76KnjVX82QQA68NSkgdAjfzRwt22DGPQunjO/5SMoX
         BVQDlvr4TwNOkxtl8QDr+rfCklp/rZXV1RRzzxDe7mFlEnEA0xHbxN1zIvmwNMgNFaJL
         pmc0lw5phLfs1rojIi3GV0MzNQdaap1gUJHBBicYpJU7cjMVb0NhHXUw3zMUdpeOqt8w
         V1Sgg9u3ECZ1/01vSR2VevIpGQ/ZRUjKxKcLmYhkBrg8MQ7gEy8rG12zEwAQSH/StVG1
         00Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532064; x=1757136864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Q7BLbHegOCnkq2HK0s5fiWA5SObOxBtK/e6uu5VQA=;
        b=H7r6OIIOWHIkQnP3kaCfzw5B9QlhVFrTZ9gegmlPZcbTHDgCtEA0YDLCVmhT1UgksJ
         k+W6FU03X998Vr6yW+FvvDiydwfCp0m8tRtJR7k+uiSmq7kZxY6xur13PCQbhh/JCshz
         o822NpWLxf1Ws2r4IcnGcUKMacOgddrL8UVdL58sN6RtS7FyVqy3puZyxQ/5R0tUgqUa
         M3fd1lWNyIN7wIWSFlcVGSEER5VxX+f4fCI0VW5T9FGfJws/CIYVEbaGR7HOkLX0V6y1
         X5Q8N2d7UfO0oO2UVDrC27/yv+e6vEAiE4cdp+joXGt6QbBBjmKATGZoCyl5IOLXSjqD
         qTuA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3TWkouojrXDdvErxTGIY/5tBLHwZsZYf30sqaG+QsrAI3lgxsT+xY6xwyTHHwUAq0XSjkKoDmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzINJmfVSEcj2UohrcuMDCLIn6LqDqw6gMhGxhGTDKU70pL24
	JLNpuSoCFFeWawWxpZxcwmIEhbI83GDInkRYwA5PlCizQBxj2cFBWflTJYEJs5tXyB6Ug2xRiAE
	ykAC/7w==
X-Google-Smtp-Source: AGHT+IG+n0I71S1k8YlpBU/vBHmclbTokOkeTD/2Ohvipfj8z0xD7rZ8VQ9FJqk7Er6TBlWDeOo6ZWXEnqY=
X-Received: from wmbep10.prod.google.com ([2002:a05:600c:840a:b0:459:dcaa:ec9e])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ec6:b0:45b:7608:3c9b
 with SMTP id 5b1f17b1804b1-45b85528623mr5772045e9.3.1756532064271; Fri, 29
 Aug 2025 22:34:24 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:54 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-3-srosek@google.com>
Subject: [PATCH v1 02/12] ACPI: DPTF: Move INT3400 device IDs to header
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The ACPI INT3400 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c           | 10 ++-------
 drivers/acpi/int340x_thermal.h                | 21 +++++++++++++++++++
 .../intel/int340x_thermal/int3400_thermal.c   | 10 ++-------
 3 files changed, 25 insertions(+), 16 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.h

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 947fe50c2ef6..04df20ef1a2e 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -9,10 +9,11 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 
+#include "../int340x_thermal.h"
 #include "../internal.h"
 
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT3400"},
+	ACPI_INT3400_DEVICE_IDS,
 	{"INT3401"},
 	{"INT3402"},
 	{"INT3403"},
@@ -24,9 +25,6 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT340A"},
 	{"INT340B"},
 	{"INT3532"},
-	{"INTC1040"},
-	{"INTC1041"},
-	{"INTC1042"},
 	{"INTC1043"},
 	{"INTC1044"},
 	{"INTC1045"},
@@ -42,25 +40,21 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INTC1064"},
 	{"INTC1065"},
 	{"INTC1066"},
-	{"INTC1068"},
 	{"INTC1069"},
 	{"INTC106A"},
 	{"INTC106B"},
 	{"INTC106C"},
 	{"INTC106D"},
-	{"INTC10A0"},
 	{"INTC10A1"},
 	{"INTC10A2"},
 	{"INTC10A3"},
 	{"INTC10A4"},
 	{"INTC10A5"},
-	{"INTC10D4"},
 	{"INTC10D5"},
 	{"INTC10D6"},
 	{"INTC10D7"},
 	{"INTC10D8"},
 	{"INTC10D9"},
-	{"INTC10FC"},
 	{"INTC10FD"},
 	{"INTC10FE"},
 	{"INTC10FF"},
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
new file mode 100644
index 000000000000..a0d379492a79
--- /dev/null
+++ b/drivers/acpi/int340x_thermal.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * The ACPI INT3400 device IDs are shared between the DPTF core
+ * and thermal drivers.
+ */
+
+#ifndef _ACPI_INT340X_H_
+#define _ACPI_INT340X_H_
+
+#define ACPI_INT3400_DEVICE_IDS	\
+	{"INT3400"},	\
+	{"INTC1040"},	\
+	{"INTC1041"},	\
+	{"INTC1042"},	\
+	{"INTC1068"},	\
+	{"INTC10A0"},	\
+	{"INTC10D4"},	\
+	{"INTC10FC"}
+
+#endif
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 908cc1bf57f1..6311125c3ebd 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include "acpi_thermal_rel.h"
+#include "../../../../drivers/acpi/int340x_thermal.h"
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
 #define INT3400_ODVP_CHANGED 0x88
@@ -683,14 +684,7 @@ static void int3400_thermal_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3400_thermal_match[] = {
-	{"INT3400", 0},
-	{"INTC1040", 0},
-	{"INTC1041", 0},
-	{"INTC1042", 0},
-	{"INTC1068", 0},
-	{"INTC10A0", 0},
-	{"INTC10D4", 0},
-	{"INTC10FC", 0},
+	ACPI_INT3400_DEVICE_IDS,
 	{}
 };
 
-- 
2.51.0.318.gd7df087d1a-goog


