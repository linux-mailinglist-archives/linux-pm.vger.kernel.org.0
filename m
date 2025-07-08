Return-Path: <linux-pm+bounces-30379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEFAFCED4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E991BC2DF7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6B2E0B69;
	Tue,  8 Jul 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeJ7K1jF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECD2E0916
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987783; cv=none; b=BbqIj7jq5CGUDKvKMtf42rKfb8f8HSoZiYbWDl528Sny9SPItbNFgcXjMEqKaZK9wr4XySHbo/qcksxHx8ZTO5sYI8n0QD8HYnOY6SiF0vih52LhCw6p2efZWNERXdwC45hKommtb2ms8vMcH6pK659RtgwPpjyuQ1gr9uz7Kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987783; c=relaxed/simple;
	bh=BO0g3NVsjvD3zy5Hf1jD2LqFckcH8XesA8tsE3wCODk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F9n5r1/Z3PM5d7MluHtAbiv7YPi5u0uB6nZa6AGX5mKoVf9aUgCNyl+Ku/zhWIc6hvpta7zSvz6vQOalXo8/Q0b7FiW3eRstFtcy3yCZaK+WAyEg9Z5trJOnw/AE9tD6fNJ40it6gFHUPlyFzW48WNgFsXINSORTfwQCfA0cJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeJ7K1jF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso3520532f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751987780; x=1752592580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vefbhrYFOAFjA+Ss9IWgRjUUOKbEdez2x+aQKjYMss8=;
        b=DeJ7K1jFzcFc29dPVAJPNFldlYzRxbBMp+wuVbWiLoyqhD7UNgQ2ThJCZOFfgdz6B9
         rAoAA0WY/o3Nz594X97VD6+FLKmewST63HCjCc4hHW5ev9dUpn5VPAm/qidD3DxTw/zO
         FFABxyURp0EuXCwC6AvNsDoMmWvQL5vXb7iaFACe3/luymEDYgyf7XdFyMxUkamCSpVt
         TNYdmfYWqEOw/rlIxz6C4TittbBV+ID1aN5Vw4JfvJI01a9giPNltsLgJP6vFqemN8cU
         6KoQ9oqan74ABR85Y/mwYlN+VBJhlH8CaY77tDbnFrfwljUYyRk/Q8zBTmeh55vImYyp
         iACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987780; x=1752592580;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vefbhrYFOAFjA+Ss9IWgRjUUOKbEdez2x+aQKjYMss8=;
        b=aA2afGAMCqcMjoH6xck+gFtPvVdghAWzFJTFcZ2irmZ3tLs7zLBG3HcSJpCY1Slzc/
         FPXPvQCsggNUn2y2m7sfapTsQyyeD9BgiuCgYAAhvGjGdKFBXfJ0h1jcXvMQmiXwDlvb
         eW2+qEn008VtRVwbMQjaOewkuE9jNjWRd1eNsPRIvULRr16ggQ06XA9mfuq4jzbUpigN
         zXMH6/KeTV9m9vTZTvBTOyGsDpWxOsGsOeOjA/v4ljMA939ZMCug3CB8offDk6iA9WQt
         GrF51RBOeT4KBuanbEhagCfalegWyN0zvPDqMcubWKudwZoJmO2iM7Y464UoPSbt/Nnz
         f9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCU5eVVqsMHBMvnYlYsmVUCreWlpbP9z7dzPG1bk0ZrtPxDjDPosAgJjX1vwE6Uqx7YyBCBzjVmRkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBp4XPvlkx7XCEa+d6wbDNvrxH2xXH8t4rr4jKcBSWhT/b//ym
	17COPq52rGtAqlsr53GmENRdySm8PHj/wKv/G/sI9m4Sxsx3kq+E3TGkj4Eq2/plkkA=
X-Gm-Gg: ASbGncvFoa+1Vowu2by1qa4GoXhyIcmp7IMmWkJzV8vuicwi0kg6jz42J5ipskPoeEt
	JLM3bnLw9NU9s0F503BAWK0b52D+awTQWpQpqTieD2UrCDDdB7muaPbgC1gQsXlM9uzUUwPCDW7
	HRn/exw5Pan2aA3068Mz7fx7nJOEnB18PVVYKxA3b4qz+Eejq7kXsQZ1iZVi79NJfPjuV7RwalE
	LYT5KRC8sMhmTf/uv3ZxIjpwPFdrogawkN7ZnwWWb0/2atykK7MB5xFGFhiZEhHk9RbUT60onPd
	cXnSzvgm94RGguWNi3X2Z1j/iZbMu/ocUqz8B6uYFs3v4OUlBh9w8/yNprXBa5bjUCJk+nnaMr3
	OEiEIvf8e4w3R2o3d/eoHtAQwJjmH36jmCdkH60llVA==
X-Google-Smtp-Source: AGHT+IGcFQuwb1MMLl2dKUjfYTUZlEeNX8v0f5iGL8b9Z3yiss2UDsE8Rr8Y8j1xL6GHbC9MyU7dow==
X-Received: by 2002:a5d:64c3:0:b0:3b2:e07f:757 with SMTP id ffacd0b85a97d-3b4964f5198mr15567653f8f.1.1751987779991;
        Tue, 08 Jul 2025 08:16:19 -0700 (PDT)
Received: from ta2.c.googlers.com (24.125.187.35.bc.googleusercontent.com. [35.187.125.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ed9sm13422219f8f.38.2025.07.08.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:16:19 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 08 Jul 2025 15:16:18 +0000
Subject: [PATCH v2] PM: add kernel parameter to disable asynchronous
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEE2bWgC/3WMQQqDMBBFryKz7pQ4Umy76j3ERYwTHWgTmRSpS
 O7e1H35q/fhvR0Sq3CCe7WD8ipJYihApwrcbMPEKGNhIEMX05orLi+0aQsOo/c4eLINk6WWPRR
 lUfbyOXJdX3iW9I66HfW1/r1/QmuNZQMZ45xpxpt7PCVYjeeoE/Q55y+T5r9MqQAAAA==
X-Change-ID: 20250708-pm-async-off-bf2a3e2a27ef
To: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751987779; l=3744;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=BO0g3NVsjvD3zy5Hf1jD2LqFckcH8XesA8tsE3wCODk=;
 b=nxgXM/6WbOhhZErwDKymuatsJhC3gAMLqLl3ogzft5EwC2wI9aAa9G7icLP6QytYoyEMXSCuC
 HWSpx/mXtubCDNxhQaMC+gY5OFUYMbfd3DR7Q5i+L+shVizUN3H77xt
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

On some platforms, device dependencies are not properly represented by
device links, which can cause issues when asynchronous power management
is enabled. While it is possible to disable this via sysfs, doing so
at runtime can race with the first system suspend event.

This patch introduces a kernel command-line parameter, "pm_async", which
can be set to "off" to globally disable asynchronous suspend and resume
operations from early boot. It effectively provides a way to set the
initial value of the existing pm_async sysfs knob at boot time. This
offers a robust method to fall back to synchronous (sequential) operation,
which can stabilize platforms with problematic dependencies and also
serve as a useful debugging tool.

The default behavior remains unchanged (asynchronous enabled). To disable
it, boot the kernel with the "pm_async=off" parameter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Dealing with the pixel6 downstream drivers to cope with the changes from
https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.

Similar to what people already reported it seems pixel6 lacks proper
device links dependencies downstream causing i2c and spi client drivers
to fail to suspend. Add kernel param to disable async suspend/resume.
---
Changes in v2:
- update the documentation and the commit message to describe that the
  "pm_async" kernel parameter provides a way to change the initial value
  of the existing /sys/power/pm_async sysfs knob.
- Link to v1: https://lore.kernel.org/r/20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 kernel/power/main.c                             |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..33ca6b881b1d77bdeea765b19291a90b2a82e8a3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5000,6 +5000,17 @@
 			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
 			remains 0.
 
+	pm_async	[PM]
+			If set to "off", disables asynchronous suspend and
+			resume of devices during system-wide power transitions.
+			This parameter sets the initial value of the
+			/sys/power/pm_async sysfs knob at boot time.
+			This can be useful on platforms where device
+			dependencies are not well-defined, or for debugging
+			power management issues. Defaults to "on" (asynchronous
+			operations enabled).
+
+
 	pm_debug_messages	[SUSPEND,KNL]
 			Enable suspend/resume debug messages during boot up.
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3d484630505ae91fea29f7f9b3fbcf7e585955d8..3cf2d7e72567ecbea2cd80acd3c7f6da85f5bef4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/pm-trace.h>
@@ -112,6 +113,14 @@ int pm_notifier_call_chain(unsigned long val)
 /* If set, devices may be suspended and resumed asynchronously. */
 int pm_async_enabled = 1;
 
+static int __init pm_async_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		pm_async_enabled = 0;
+	return 1;
+}
+__setup("pm_async=", pm_async_setup);
+
 static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-pm-async-off-bf2a3e2a27ef

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


