Return-Path: <linux-pm+bounces-19230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1A9F1C0F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 03:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21C87A0461
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B251C36;
	Sat, 14 Dec 2024 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="PIUuNSgd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9E3209
	for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734142622; cv=none; b=elLlCgtmfG53rtCOXnmgsS+u8j42S0InanZJDKMA+/BCBSArfJNjldqIbeupzkq46zBGn3n8I5OHtJndjo+Rq8ByKM+ugzCdZqKdIDO7UeRaeFW6PPvfD92Swx7YTK9xHqMLKbIq+lnPi9M+43bZ7g+TkDOL32I51I1Kvg61WyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734142622; c=relaxed/simple;
	bh=qDDUO6d4Xg2Yu767QXivyjNoNHFvWiVUDsFxucVozXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4+6psc2OJmPnf5oeW65Ux4oUuPzppDiVr0e3XR/WGy9UHlBu5Ca2FMUCfswBqFWz3xgnYmOYN+2EfWaUiGC+zETZOWUuu8WaowI1JoSz6/8zQ//DlxgnCSDe4IlSa5rVanYX4uDxsGKA6AY8uRdzvcdP9R4f4kbzMTjRfeNU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=PIUuNSgd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso1785597a12.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 18:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734142619; x=1734747419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1fVzs6h/YBXZPOyHAcR0S2VIY8HCQxGJB45TmjN4Tw=;
        b=PIUuNSgdMcSE+3ImyWI9gvPm4sIF7vuHQ5C986vS3VxYJFV3MjodE45r4/e8lbfN64
         yaYw33tJ4yU15ybJ3pimwrC/4VulIRCcO1Pw4ObX8zB2Um7EQ6iBxPlraUawPPUM0MD+
         WglkSWq5tiak0AEwIcBc/H/NUC+X8ES1C3CYpWoOMhRE1EuxHz17jAXIhJa6t6nS0P7E
         fZUeld3v9N+QyfRR4PMnvBjQ+k3/RIsBbFVBLDQ6mW2Zj5dKRpmbkLFQgOfalJyol1Vg
         pWSCjaKEvfopyPEAxurTCJOr0K+IsyzcbcnZlpGGPXt5RTzjOoyxf4EVGyNOJdHJ/mZt
         W5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734142619; x=1734747419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1fVzs6h/YBXZPOyHAcR0S2VIY8HCQxGJB45TmjN4Tw=;
        b=f0bY14SeCWeovtlRKv7p7pPXFGfQrCB7g9sX38NYCfTgVFg1G45yZkua+ZDkEM2bo+
         VK4S0SzppW72wE/qpzYA9RzQGQNnPeiQs1mA5IA1BrVpE7Ss8hr9EVLHxMRfu6YzCg/R
         SpQ5RUIPcJmoXhmRev2qDVGlozQ7avLlvIZV1sIMqqTu1pJl4X+cELiEUoopERSwoIwh
         5fZb6j1njKIzT5zd3bBsf1KTOPbyOgZr8AIZgFt+mLPrxYtQwWiMDzSKMeDcMK9rS18/
         CWJRNSLZNflNIpi+MHEIpL5UzwpUoHEr1o0/q0aG1nA3i+aetqaNJ6CgXKvUQO45WtxZ
         lHrw==
X-Gm-Message-State: AOJu0Yz28p2bq8Euq+IRMMEmLgvonk1VocVcQMlKSsflaneRhrc5HeYW
	SUbD7/FbiNNVtXLxueYGSJ4P5MoXldKma0EBwJxxag8XxAxsr7g2GdojenuIlJY=
X-Gm-Gg: ASbGncuaoQ5ygLozTF/jampDZeONrYrbd2PvWU4B6V22ixxRr9clbzCFGAJTbZo+eJ6
	Gd4E2kiFK+pptloxUDNkUUvofQycSxCp+lTWGLSBozPrD2hrGDz93dlk9m2zUCpND8QaPTDTWsK
	eoWwqem6TXlmnII1O7UgBdjNJQjOKFporE4FFP2tGNUJe7pOrfwoLbuv6+X1RIVXdg4xYIN/9ea
	BXDe5oRyv/gQ+P0doEkk9+qYKZGXVcJE3MYGptx5agXJaKuffVTOe28h4HynTxcXl4s3P3/2CCN
	Xz6ippBRq9pNUfbP25qY0VQYJqVLa/9Ygnl+mRKhXN4=
X-Google-Smtp-Source: AGHT+IE/uQBNrZ/dw3oG4hRCy0gCq6cEa9hfHhhMY2dz/Px34hBq6jvx/zVs5kicejH/rU5coqtMrg==
X-Received: by 2002:a17:90b:3512:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f290dbcbddmr6585386a91.31.1734142619435;
        Fri, 13 Dec 2024 18:16:59 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc2fcdsm3867088a91.43.2024.12.13.18.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:16:58 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
Date: Sat, 14 Dec 2024 11:16:52 +0900
Message-Id: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
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
Changes in V2:
- Utilize the device_init_wakeup() function.
---
 include/linux/pm_wakeup.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 222f7530806c..81ad82714ad7 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -240,4 +240,27 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
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
+	int err;
+
+	err = device_init_wakeup(dev, true);
+	if (err) {
+		device_set_wakeup_capable(dev, false);
+		return err;
+	}
+	return devm_add_action_or_reset(dev, device_disable_wakeup, dev);
+}
+
 #endif /* _LINUX_PM_WAKEUP_H */
-- 
2.34.1


