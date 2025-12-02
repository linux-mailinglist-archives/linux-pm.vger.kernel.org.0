Return-Path: <linux-pm+bounces-39064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725CC9B6AA
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F0453484B4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD995311C21;
	Tue,  2 Dec 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUT7E4eA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA595285CAA
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676959; cv=none; b=Zpzr76GuPmsmHqQcDN2yUyX8hZlw7+svouKvE+xw3DUlpkn0v/Rl1WJ6S3Qkd5zIvYoleQUgf1ns7bsv5Y76zN3+zQeshkB751ZJOabOPYQqJPb41fbke+ijbQGk3YU5kOQaVesla+rjZ00VgzjCQdmc+y34LptIL9cTDPdrRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676959; c=relaxed/simple;
	bh=ge1x2oWZ+hs365NmMpqJ4TN/I4SI4ABtvBiRX4AlaQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mSwyip6zxD6gyQr21oL13BYJXbqWojE58dg3plfK6oXN2YQhJV0FUlNigCIoUCLwcFp4+GfdjsAvyAgUatS3X5UZIBp4BSCEb2IkmO/Uufsd+BSWP0+LQNBrlXFJFbwx+3QQ7c++AoVl4GWbU4iInba+sRdVw0UpJpWLHZe3BMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUT7E4eA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso39528005e9.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 04:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764676956; x=1765281756; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVGsHORFfS62JoCVlAaVjxuR8v8htnbnxQ0FZyoahLk=;
        b=yUT7E4eA4MQkVLW9xM06lCewijzwC3ksi6FRttLU+8hy83Fme4nnqWOTqLUeHufyJg
         wkw84N2Ks1X1HePbEiA3p2lt4pxVdGOXtvWlf/jG1PERNGebvH05DQFStiFcwoYZD1je
         d1xI8pwiMPS+k13s/VewWPU7yR4oXYsynch9mDjgVZ4pGZk/GSIkx8RZz1RjtLJJLcQH
         4XLdCbKBZ36hsmrg+qeaxbNv9o4oB2B4srYP2td/kJbFG7A3ICK5R4CPCTDMqkLSnPSo
         YrVk6jWpoYwz+C+9CAzAcXHpT7naoPs1aaFq7n9o3ioi/aCKmHlLnbDZIHurK7TDOJkg
         gJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676956; x=1765281756;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVGsHORFfS62JoCVlAaVjxuR8v8htnbnxQ0FZyoahLk=;
        b=VeT2eHB0Zbch9tXvG4fV+9USowuY2hINTwwbu88/Fmn1eOyxb76g5bCAuhlDXCGHMu
         B8/dnSHIOXTsw6ttT6lUOsfBbju5oPfalMDpz9CIAYd4lFuu1zwiOWb3Ivcu6grTA2fQ
         7OOPXu1CXHANYAEkd1CJjCwRHPcg5g9xIqGKag59tVc071tP5FsxDnAs+qeUr5lVYAsK
         Zp4P851JqGxGT3NKu+Mp+lo4IJuAWhVQflDpsxw8ZHk/0bFfmmzt1SCqJFuD0hYiFeeU
         xQKU5awaWfyagPTGuJ2C3UVPbLXgFo9BuKP1GMlgeVeg3plaHNsWU+lFzK9i/2tO+6jX
         C+Mg==
X-Gm-Message-State: AOJu0Yxl5lIb5MzYDOdQdbHY2v6xfBJc5S3LJHEBQkK+DQRAcZu4QyJG
	exagruogvlU9Wqp06KYnG9BR84nHNNs5RT7vraN+95JafZXEB3CgvnIDwbpIp2oq6qGH6Q/5fJT
	AAOxN
X-Gm-Gg: ASbGncsNZSAOzMQPTzbNBXzw2dutW3XNOk7TN5BUJwaJ+goQy6bJxZ5xGUPm44AysY1
	pr8lleoWxqTJdKHZYMHDX3L4E4vWkq46bGV+b1L3XY1M7Ls+GurWmrqIAYdV3H3kTVXwJX0mek0
	MK83GvBffL6KGDWpHKPQX1BMxsc5uG5A73xtt2Tao8z9YPr/5EHAI4wk4AwRu73Q6KLjjFRZCYi
	o8wzzcAH8Sw+OyJ26lm2hsCqGT9htltHIf3wQ96mVMce7/KiFfCV9eqYy9Mcwg8kou3FTCv4HNE
	KQGttooHq585t0t1avov7BoCcinTnTzuYs3hWXO+m99z6//WgjCMK1A0wvOcOygbYKvPMXZe5cl
	r8YosIjBkhb+4YDL6ofHuVY4H+S/20FDxGvoMkdJ4D/fbWNXlRb+63Jc3S1c5CyFhtX5gHWk5C/
	19Sf7UeXUY+UNsrR+5QUsqKu2zkU2Xs18k0iqtYNi81QIEKsCNwX1rVpG++MLo307Qjzs0fhGew
	eXeFQ==
X-Google-Smtp-Source: AGHT+IFE5uAtt+SD+gnxgEcSOfhYD+5ANP6IoR0nePsdS8RDBM8wp8CK1WLeWWdDh/y2R4AL51kMLQ==
X-Received: by 2002:a05:600c:4588:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-477c0165d5bmr376336125e9.5.1764676956095;
        Tue, 02 Dec 2025 04:02:36 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add608bsm362778215e9.5.2025.12.02.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 04:02:35 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 02 Dec 2025 12:02:29 +0000
Subject: [PATCH] thermal: thresholds: change thermal_thresholds_init to
 return void
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-th-threshold-init-v1-1-7e5d7e878b6c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFXVLmkC/x2MQQqAMAwEvyI5G9CqF78iHqSJNiBVEhGh+HeDM
 CzMYaeAsQobjFUB5VtMjuzS1hXEtOSNUcgdQhOG1gev5ChbOnZCyXJh5Kaj0PUL9QT+O5VXef7
 mNL/vByRdtlFjAAAA
X-Change-ID: 20251202-th-threshold-init-ce03d234ad4d
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764676954; l=2592;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=ge1x2oWZ+hs365NmMpqJ4TN/I4SI4ABtvBiRX4AlaQM=;
 b=s/he3mk1qHiaCP+v3rvROdSJCSCPjte6+AMp4pVY0Xd4Jm1RNEm05yWvKlhQi2036qIPVtk+3
 FvHmQZu4PR/DcOYT9wKOYNKouwRUZ519xECDIT223a7AMrtZYQF/l/b
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The function always returns 0, so change its return type to void and
remove the return value check in the caller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/thermal_core.c       | 6 +-----
 drivers/thermal/thermal_thresholds.c | 4 +---
 drivers/thermal/thermal_thresholds.h | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643592b46cbbe708c716230fac215ef..05c1e2ff6a0a29e640646132a8d4a0ee63a200a8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1618,9 +1618,7 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
-	result = thermal_thresholds_init(tz);
-	if (result)
-		goto remove_hwmon;
+	thermal_thresholds_init(tz);
 
 	thermal_zone_init_complete(tz);
 
@@ -1630,8 +1628,6 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
-remove_hwmon:
-	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index 38f5fd0e89303aca32be3c6b11928196b825502b..351f4a464b11df1b64f45f980a349d19a3521b4b 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -13,11 +13,9 @@
 #include "thermal_core.h"
 #include "thermal_thresholds.h"
 
-int thermal_thresholds_init(struct thermal_zone_device *tz)
+void thermal_thresholds_init(struct thermal_zone_device *tz)
 {
 	INIT_LIST_HEAD(&tz->user_thresholds);
-
-	return 0;
 }
 
 static void __thermal_thresholds_flush(struct thermal_zone_device *tz)
diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/thermal_thresholds.h
index cb372659a20d648e92d7800628d29f4343f4137b..5e2629ca369875f4336a2b334fa0da4bcfe9e54b 100644
--- a/drivers/thermal/thermal_thresholds.h
+++ b/drivers/thermal/thermal_thresholds.h
@@ -8,7 +8,7 @@ struct user_threshold {
 	int direction;
 };
 
-int thermal_thresholds_init(struct thermal_zone_device *tz);
+void thermal_thresholds_init(struct thermal_zone_device *tz);
 void thermal_thresholds_exit(struct thermal_zone_device *tz);
 void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high);
 void thermal_thresholds_flush(struct thermal_zone_device *tz);

---
base-commit: 63d26c3811421ceeb5b82a85489b88bf545e33c7
change-id: 20251202-th-threshold-init-ce03d234ad4d

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


