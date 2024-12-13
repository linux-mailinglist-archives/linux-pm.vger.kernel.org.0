Return-Path: <linux-pm+bounces-19169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCAF9F0349
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 04:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4A1169E0C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 03:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44B15F41F;
	Fri, 13 Dec 2024 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="gkHqzMz5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AB7DA62
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061964; cv=none; b=eRJet7l2VbW6OPjkcaBipEpohykKaT5OitgWwmX+epKlWSgNpGVySFaX1iV227diqQZtsv+JjtbBq/WFy/6fPzLd9TPHXCYZLspgzpDQPplHbPHtcV1G7RweQEA4il0E1jUxhOL+mOlo8I3I//e+UKFdfqJgn6SywxFUpxOGLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061964; c=relaxed/simple;
	bh=qt2dWCg+WCI06RbKMRyPPw37FqkbCiIVc2yPO471Tgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkDpyt5mHyQQY8fw0ftygVRppiwnXRiJW/EBJwA2PUdwjQQ6HfvJbhh1wTDJIn6vQmZ6PhnS3ljynJYN2b0S3AQaNYWsCyWDIEonTMRo230aeJM52H7kftLawVd05Zyt6QHhvbci1vpbReVI/sfhq4eAn3wnIg1sNZEXEIAYcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=gkHqzMz5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166651f752so14144535ad.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734061961; x=1734666761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhIKXu39g0td2Hkm/h3BepPdiq0tmK4NBRl5M4ZCVAo=;
        b=gkHqzMz5oNvgBVRftIrvE61V4a6LSUvgX+pWNxoXmTDiB/XzE2Cg41f5M3Yaem28Sh
         BA7Njgd6ks1JroigWoddYDk/ykPra2LhjsuNQbv4OuX4/ABQeJGbfkE/ErdAuk6tgF3c
         8/wNCRBTXBDGVEYpgjblvb/YlcfkM9QQFUg/CXKP2/TR8FTwOLjNkuF5Qd37ogrUJnGN
         M5vin4UiHqcSLgA7LsC/j44nFRasVyMgvDy83mcXhky6mFYHh/wpEGXzuOOaOQ5s16Df
         zf/PP9tn+XdO5xMgo1SR94e16OiygZvWqTKIITgnW/e8WT63GbCqAvUJ+d/2qbIEVSx3
         SOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061961; x=1734666761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhIKXu39g0td2Hkm/h3BepPdiq0tmK4NBRl5M4ZCVAo=;
        b=Y3r1GZTNZg9DQ/w6iEY0K4hJeHszPqH6UDTJ0L1naNLZQkhbEHmwVnlZUe7ARgoRzh
         TSgWxs3mEmy4OVWdmJ/k42YEiBBA3hcck6P9C0Dv+jZYXIFHGOqMQTlSPLQjqbIuVh/L
         wClLVH5HsDDdBT9jHQTbArh2fdc0LsQoaqIIGj4G/kVRyxklPnNQ/oJfD+SGg+CxqIoc
         DNfjxpHXRnqqVWpzgRef0oetSJ5MZuWdZzSUz6J/U0mZ8LlmMbjPH6KxM1ewJV6GU+Zx
         70hGMhOa9eTbd9o50z7f4NRNa3SURoM5oAFw4ZzaFfeqCGlOeE69ODhw+7F42leW7cO/
         qFAg==
X-Gm-Message-State: AOJu0YzvHsSSdtqH1NPTC6Lb6I64/dv9gcPe2foHViQOfHGpkbA798MR
	Qq39Gx+Y7+Z7KjC6PeM3nS+RLi5iXSuwlXplg/d5+4R49bGKVbiyitL/+4CiGM3zIKK30wTeQ2C
	20ifwiA==
X-Gm-Gg: ASbGnct1QUmZzO6Nx/vSalqT6q+YF2mWjkwXfBgz5U/R1dxAUvnQcjUKyMeie7Xtqjm
	uriYizsCX0Noe3QY44kstdcoZ/76cyb9aWFvtKBTd67QqM67VGVamzgWMLjYCu26fuQ2dWUnPO5
	MQ3sLV1B1sDgEcwAtf/G8R7snsZ9ssr1beNfVVIfvONKDUBCgF57bJhAQFZW8/MgPittsKS1qmn
	rBwl34xlIkan149eH78TWLz/rWW5ZUgyu0ArIVIzKYDFwm8h6T/i6ag8Vtpegxc1AWMgnVG/GhN
	rKj0yno3tHa1yH8DwRZStSP2gX5RgCYeHavJkDNTmgQ=
X-Google-Smtp-Source: AGHT+IEUifAvbdOQ0IN1frQ+3irMvlrLBhDRn3jd7gprMcrt9+tV4qHZOHs1O6SM9lXKfL6SoeYSFA==
X-Received: by 2002:a17:902:f648:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-21892a5d7e9mr16281655ad.41.1734061961067;
        Thu, 12 Dec 2024 19:52:41 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21613079c56sm115564575ad.27.2024.12.12.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:52:40 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] PM: wakeup: implement devm_device_init_wakeup() helper
Date: Fri, 13 Dec 2024 12:52:35 +0900
Message-Id: <20241213035235.2479642-1-joe@pf.is.s.u-tokyo.ac.jp>
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

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 include/linux/pm_wakeup.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 222f7530806c..baf4f982858a 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -240,4 +240,31 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
 	return 0;
 }
 
+static void devm_device_disable_wakeup(void *data)
+{
+	struct device *dev = data;
+
+	device_wakeup_disable(dev);
+	device_set_wakeup_capable(dev, false);
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
+	int err;
+
+	device_set_wakeup_capable(dev, true);
+	err = device_wakeup_enable(dev);
+	if (err) {
+		device_set_wakeup_capable(dev, false);
+		return err;
+	}
+	return devm_add_action_or_reset(dev, devm_device_disable_wakeup, dev);
+}
+
 #endif /* _LINUX_PM_WAKEUP_H */
-- 
2.34.1


