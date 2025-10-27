Return-Path: <linux-pm+bounces-36921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B5C0EC97
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A934D738
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5A22D4F6;
	Mon, 27 Oct 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9P7A7SE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6332ECE80
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577506; cv=none; b=qwiWODPhPEZtUMkp+o6cmB69sB9Z40QatKMkWI/rNB55l49T4g3VFU2z84wegcxvLo6f9E398USwXKn82mL+B6durvYkC6kxsfT6wXtcGEWeluS1M1O71smPUA1FZfEdH4PEMLaVnBzp+769a96hylEVnZZRNR8fO47Cp1f8OYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577506; c=relaxed/simple;
	bh=T6j5pJIXxBFsaGqyk9NT2RfkOVr+/me2qdWz0yBnXMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOPsEAJ2HPu8BRw/b/B0X+8PfiACM51ZsAlkRpVaUJ2/s7O5IPSnE39ntBkC2uvncRD9YzoToDKJUUR3OMDzJOX2dJy+RIFhw49gqS/F3aC3526FbpU+ldqBSJAp/gGnRLjEgH6ExNoBi9snoyFN+sziuYjWHcCxpqJ+fnRBYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9P7A7SE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so59831765ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577503; x=1762182303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=G9P7A7SE0cYKcuVk8MuBwcRcI74Kjl6yzR2cI8MhocDmNulu+Blaqelp6KgoHbWxwd
         t9rYTdRhIHyK6aOGUHGhOMHNx5T6Y81wndqXyjJzh1/UqPAI7Iuy6LRwc5sVvCgrrcYT
         Gq0Z9o7x61LaU28+avucYFU3C66Y2Mo165wSpT4RflfEKbZbc1iwyk8d+42cjp0YEJNB
         fI2UEMxUNKqvCoVDCBaKZ/61wftDhyd8sDtxcHtxBcv4OsBpIHjtW7fl35QzaJ51PVvk
         qg/4MpzUX3zBaHBRB7GESPKtRHWZyAB271XnUW2zuBEnJbtccpKBDJCzW4UTvxIzLKmt
         hsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577503; x=1762182303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=JoVb0j5SwsjZhFxvpyNr8prDqCmE1n4Mgpv+vOROrPvFhbaSRk3EyQAij2QaVFUKAb
         lNVkBiWU0cGkDimdTAa4fgUdxvMvhz4gCsPNPYYL6bDiOv+bodfmXhce1NnjZg7cXlz9
         IK+G1fE4ZqpbQpZvzizBQCXOjr/ND2xYoKkEUETsEn977Amx7n8WFnIaY9nKiS0ULvf0
         y2w+p9cvdH8lPkKI+bcE9K/6ozyJ4GRqPajHM4QqOfabnvWv/ROCCNWt95EWYHaW1sS7
         PRL9C9T4V39kKSYponqkarap8LKC9PasKIJQLzZaCXOYf3oglsQFtBubPy0CaBuWa8Jk
         XO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfoxvKMIQ54dN/oYUFgNeup1Vkkipt/i3AF7tUgtBsZfjZS1mPBg3WMN0SggzgwgRSVZShYBl9RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRH2bKmgjrCv2enotwFwBQ3EderHalZuYJW3FoezqLJOThk2nU
	Kosu4yeitFpEaJzUUf3HNVNGBv6Cor6d7Az+vsyy0Gzhzd0+TIJ2Jxzg
X-Gm-Gg: ASbGncv7tXkItVtgwI8OeTQ5dUMJA7tU44E4RdAgKqUPYmyscxTpGzUecj4gfQdajyw
	gyRtQNsEvam5y4zX8uKf9d0+WOnfBaE8lvy51e3PbsayDr8SemDDrggxHcmh984SgBKrlFHBdRy
	PKTXNs0vFw8B1UNR5XJxDvHc7qZlYMmJIBcXgl7IhkDd59MldnkhD87MfaEBTVHC5Zw5ewyjX9E
	iY6yGkrwNo6AFjvCnYIxp3nkp2AMks0FxcjfYYVI7yKMsz10QOgi9JxEiXCzNjfOf8wRCs/tDBB
	WsOz8vuR1QxNLDmXPvUsy+hMg08WRxR7OY9OrPIHntHHfYcnkTHarqasWYqHXaEOSyHQtl0Af3t
	yKCnAD7R5/UoJYTr+fhpdfzb5PmSLklOfacT7zvUjzoz+s71tzhmPZfPTZjXLMqC+hHkw3AP0g4
	nC/ppvK2Q+kgamGtR7xbKonRtmCKXe3D7X
X-Google-Smtp-Source: AGHT+IHo5ASx3suVa6f8wqaFBDyQtbbs8qUYAB4N9R32si782j8k4P1cTG8u6ANyizohrN8+sMLTeg==
X-Received: by 2002:a17:902:eccc:b0:27e:f07c:8413 with SMTP id d9443c01a7336-294cb378960mr2882435ad.9.1761577502931;
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d273a2sm84808825ad.60.2025.10.27.08.05.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Date: Mon, 27 Oct 2025 23:04:45 +0800
Message-Id: <20251027150447.58433-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two reference count leaks in this driver:

1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
   of the PCI device, but pci_dev_put() is never called to release it,
   thus leaking the reference.

2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
   nforce2_dev which is stored in a global variable, but the reference
   is never released when the module is unloaded.

Fix both by:
- Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
  the configuration.
- Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
  global device reference.

Found via static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fedad1081973..fbbbe501cf2d 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -145,6 +145,8 @@ static unsigned int nforce2_fsb_read(int bootfsb)
 	pci_read_config_dword(nforce2_sub5, NFORCE2_BOOTFSB, &fsb);
 	fsb /= 1000000;
 
+	pci_dev_put(nforce2_sub5);
+
 	/* Check if PLL register is already set */
 	pci_read_config_byte(nforce2_dev, NFORCE2_PLLENABLE, (u8 *)&temp);
 
@@ -426,6 +428,7 @@ static int __init nforce2_init(void)
 static void __exit nforce2_exit(void)
 {
 	cpufreq_unregister_driver(&nforce2_driver);
+	pci_dev_put(nforce2_dev);
 }
 
 module_init(nforce2_init);
-- 
2.39.5 (Apple Git-154)


