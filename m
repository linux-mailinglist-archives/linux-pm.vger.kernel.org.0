Return-Path: <linux-pm+bounces-19401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BE9F5DB5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 05:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0836B1647C3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E213F43B;
	Wed, 18 Dec 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="E/UpVdPK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515F12D758
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494986; cv=none; b=SMBz2MmkuTL+H3FnL9KFPXnFz+Vdg3nNi6xf+srO4GDQpXKd3//XmduIrZmST2p+HVea/JOVSdpDFVRtoDlPvMtwPKjLYBcLyiwJE48CG0P6gwYhgDVcsmkgu31cQ+Z+HRGLIeVFPZf0FchdwMeT7Wg4oc5bYuVaQ8O2bH8tNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494986; c=relaxed/simple;
	bh=SHzlLPjzv79b1rLvZeZjQjkoAP+VlgoofWlmKzX9cVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQ8iJ3k9RtaBt93ZPmYnRnmkW45UJip5y0YnY/ipSaOOwDTQSdVATngTYb2UxuC1S5jCD30uUUX8F5yEAp63mho/lvQqTr2ktvjLFTUVBsVDtjOq198MAaUMD49KnsWvteN4HAd0iIEKeWqaVoVMkxDYxkKby9KWhDqtz+j4Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=E/UpVdPK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72739105e02so6565055b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 20:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734494983; x=1735099783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g41ch1E9u/0fjD91ZUIEWG0XH7IIW2wFxAqbnpEBwYA=;
        b=E/UpVdPKNS6gWBf74+wLv1CmrdeZjRCtuPOtA0xIuEwFmTdyQtv4Bq6WwUoS2BB1l9
         S2G9dNYl+mb5mjQoGdQZUE5Z+sFDy0ID/PaFlBnQdoeklrCg0WRK23SAy9rThM2OreKk
         Z5Abjj5vybh7y3PXSxEW11J34seUx92i8VhLr5y1+OS4Be+/rc2TC1QUgz3Nsv3f7ZGK
         WVDvGYsWOk1JM2YYpLAlALcQ9RmXf8uJfxUSCc5t+ZMGL7eZ8djhm8a1oiGD0E5KMerU
         l6tGl1T7SEq+Uvh2A7hrPkkelCV/Bivn0FzPkoNErFq/v/jZBfT6o+BCovJHbWITrvx8
         zhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734494983; x=1735099783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g41ch1E9u/0fjD91ZUIEWG0XH7IIW2wFxAqbnpEBwYA=;
        b=asbeyzXiQlf4q2qFxst/xfrv7mPq+kXIA1iMOGlz7cYXD4/Us3oxvmy7FO2ymKgSxZ
         OlouIeWduVWm8mkSBeaA5SQhw3EzMxTewWaw6NVxB8o+77RK7fEWrR2mUdTOIllrN5UP
         jBJRv8/HrkY1rzBdFrypncN4Vw8n38wjZRCnxslPDRXSInwbYvnxbl4iNOhlw1nLDXFR
         z7KSoPDIFZmJglnJmkJeETVxMwhXPhu7P6UT77KqsPHURCBt950VJ4JlVqOVfdiMQVKh
         3UnyOB6XlGrkN9u6qoh2+8Z77jm29i8CuPrSiFz3ftIn0GPhitHqa5L4midxBc0ltgMa
         2XbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMwYINaTk/MgOfMZB7CnOt1hvJuWmD/8RKV33ZgFbTkN4AoRwjRTSd3ec/9Gfrk88fE9sIwwveZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYihudxvO+GaqpzDelk34mAeIattbnnOOyVqKSTH+3oIT3+LC9
	/XVODiddEtrV933PLuhMWQnYSPwxmXMQjs6D4YHzDEissW9CKFyRtnbXGS02dkpGonkmSTflqsu
	N0ltLxQ==
X-Gm-Gg: ASbGncsiWR7pWp2jP1iME6xZ9jliy5Qvkx7Hnwv9M26KiPGBV25d7i5E2pS60G5VbLI
	D95oqSqM5QtGipTK5FToJVfVOZ9RLFdBScVT05rnNgcf8w2Q8rHVXm2CsAp0lMRW1EaU5AZS3P/
	41+/Dm5rpS7Q3hhF0jhm//SCLCnOZDWEABxw7iVC6nC1oYDtdSs/TludDc8gfaRe0d/af/IqoUx
	y1p34Pm9ogoEDtWwS5JIh0Owr0rOgfKYkJOtSZmrkdHkDW2EhtjlhLqSmKMR5iYnsdcMDf5dJl3
	Ojc=
X-Google-Smtp-Source: AGHT+IE/iTTmfsPTwobhuJOWiRzrT1Q0VITqzU1GwKMNDyBaMNrQ6rPCx8Oyvh3z9QZwyMP9m+4JZw==
X-Received: by 2002:a05:6a21:3989:b0:1e1:ae4a:1d4b with SMTP id adf61e73a8af0-1e5b4889115mr3098103637.34.1734494983301;
        Tue, 17 Dec 2024 20:09:43 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:933f:d83:186f:7181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78eb7sm7783126b3a.107.2024.12.17.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 20:09:42 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org
Cc: d-gole@ti.com,
	linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3] PM: wakeup: implement devm_device_init_wakeup() helper
Date: Wed, 18 Dec 2024 13:09:35 +0900
Message-Id: <20241218040935.1921416-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers that enable device wakeup fail to properly disable it
during their cleanup, which results in a memory leak.

To address this, introduce devm_device_init_wakeup(), a managed variant
of device_init_wakeup(dev, true). With this managed helper, wakeup
functionality will be automatically disabled when the device is
released, ensuring a more reliable cleanup process.

This need for this addition arose during a previous discussion [1].

[1]:
https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v3:
- Disregard the return value of device_init_wakeup().

Changes in v2:
- Utilize the device_init_wakeup() function.
---
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 222f7530806c..d501c09c60cd 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -240,4 +240,21 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
 	return 0;
 }
 
+static void device_disable_wakeup(void *dev)
+{
+	device_init_wakeup(dev, false);
+}
+
+/**
+ * devm_device_init_wakeup - Resource managed device wakeup initialization.
+ * @dev: Device to handle.
+ *
+ * This function is the devm managed version of device_init_wakeup(dev, true).
+ */
+static inline int devm_device_init_wakeup(struct device *dev)
+{
+	device_init_wakeup(dev, true);
+	return devm_add_action_or_reset(dev, device_disable_wakeup, dev);
+}
+
 #endif /* _LINUX_PM_WAKEUP_H */
-- 
2.34.1


