Return-Path: <linux-pm+bounces-10785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A392A727
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FCB1C20912
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402A143881;
	Mon,  8 Jul 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq8/Ch9A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAA1E532;
	Mon,  8 Jul 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455544; cv=none; b=VN5V+OQnLdfo3nrn0jhUqIxIKGzSzhDagUX/rm6Dnht8BwVaZqGrgw5FVOmnOVvnuO8E5lN28jGhZ23sqCgVj5IzDgPKyQTNeoSZCs0NbD6beBOE8tK2Ga/kP4RnAOV+wxB/OGJZOmS6KPF7XOiB2/fBPqe3az53CjGMZZxjhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455544; c=relaxed/simple;
	bh=T6zqV2s16QFB7PZs29sqDQW6Klci55YbTwdo2bCNLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWaRDyX82WNi8guM2KpIv2iU+QrbH0lTSpS3CnVJYEWaH5s8k0PqIsWtxlSerNzPoMR2FePiz2XVrN3c5lmrp7a7Fo/sCBHTmwytkKXa/j/pZORlQuDeiNg+UiTYIVzikDZJuMgsFiXkTK9ZoGgqn6P5qKFYKrOXdAPNbXvxFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq8/Ch9A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso16837655e9.3;
        Mon, 08 Jul 2024 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720455541; x=1721060341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38p8QWMHWXz9B5rjFOZCS6GDANaWGeHzqVbGxVlItoM=;
        b=Rq8/Ch9ALszkptVTkGKygV3FZBppOpI8e/w+xltE4HDoZmJtEKes4wDf2QTX7FucfP
         4RsDOpvjQNTqxHdu33YeeksaTl2XiGmTGaIifQxc6a4/Wecg3/Knac4Ti4VzWjavC/hO
         WgbafyQ70LToHEAW8NPo5IUZqBVaFhVc2ayHUspUhmjVDyts8s+sN8olDkfuZjtP3Dq/
         0i9XzA+IoT4x/Nyl9b5EkMBj9rh+y81pkbSoQMWsdJKiKfetZ38xA4TVwqCYN1CofrYh
         lIhjvB9xFAycO3GPStKTu+9aeqxf4gK4Fp04vRQpRlT29jj+2cj2uO1RPgKESIUm07No
         SJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455541; x=1721060341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38p8QWMHWXz9B5rjFOZCS6GDANaWGeHzqVbGxVlItoM=;
        b=Tl3IQK5nHkPgrCFsgkEmdmancc2Fx6Z0m+1s5HWtc95c1ugif+71LCBhLAuV6Dd0/h
         VjDj8uaz3uYc+n2EW8D57OaI2DkYRcAgPRJmE4jbKevRO09N+BXlDpc0wDma6RMOYnxs
         oi0jkQH4GGxJDFKoRf8Qs9xrW8sRSRh0oC6iSrTZV4NfeQcg3faFM7gwaTPc6AZkUzfi
         YA7M52CJIp8E7POQrtAJVHLJ1C3/vwQg1AT2iEi861Np9/agnaI6Hr3eh/lbE6OGyhVe
         Ho+KOnx+lAYQr9YN730XNclJDf5s4+0GVVYcrMm8UaF5095AzHbpYThCjtT/bhfDsUnn
         e2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXPApOnGE1acV+hviTghyWeVTw3L0q2rcHPfTYmkcUHnU1t5QtqvrIA1sew2RhbUhEswiUxYtIPCeP/ZjBIZ9qaoMqdkg+CZov3E1Wo
X-Gm-Message-State: AOJu0YzLil+jc9YVFqaCaI1lF5kSWVfqUdNpR2FzaP6Ef4vAKbEG7+tc
	ksiXqkZUFKFBAoikqOjwbwjswy0cNrDMATMTl3H+redfDn8GadBc
X-Google-Smtp-Source: AGHT+IFHLZ3dF6AgkEP+YQrJhIu1QNJYC+GQ0YMNE7yaN8YQVR9Q+BhNdqHebfjyC0VzrRXYQ5tZ9w==
X-Received: by 2002:a05:600c:3b8d:b0:426:6765:d6b0 with SMTP id 5b1f17b1804b1-426707db70emr578985e9.15.1720455541065;
        Mon, 08 Jul 2024 09:19:01 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0b6bsm4371665e9.3.2024.07.08.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:19:00 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: "'Rafael J . Wysocki'" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sti: cleanup code related to stih416
Date: Mon,  8 Jul 2024 18:18:40 +0200
Message-ID: <20240708161840.102004-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"st,stih416-mpe-thermal" compatible seems to appear nowhere in the
device-tree nor in the documentation.
Remove compatible and related code.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/thermal/st/st_thermal_memmap.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 29c2269b0fb3..e427117381a4 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -142,15 +142,6 @@ static const struct st_thermal_sensor_ops st_mmap_sensor_ops = {
 	.enable_irq		= st_mmap_enable_irq,
 };
 
-/* Compatible device data stih416 mpe thermal sensor */
-static const struct st_thermal_compat_data st_416mpe_cdata = {
-	.reg_fields		= st_mmap_thermal_regfields,
-	.ops			= &st_mmap_sensor_ops,
-	.calibration_val	= 14,
-	.temp_adjust_val	= -95,
-	.crit_temp		= 120,
-};
-
 /* Compatible device data stih407 thermal sensor */
 static const struct st_thermal_compat_data st_407_cdata = {
 	.reg_fields		= st_mmap_thermal_regfields,
@@ -161,7 +152,6 @@ static const struct st_thermal_compat_data st_407_cdata = {
 };
 
 static const struct of_device_id st_mmap_thermal_of_match[] = {
-	{ .compatible = "st,stih416-mpe-thermal", .data = &st_416mpe_cdata },
 	{ .compatible = "st,stih407-thermal",     .data = &st_407_cdata },
 	{ /* sentinel */ }
 };
-- 
2.45.2


