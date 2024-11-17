Return-Path: <linux-pm+bounces-17678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A37F9D0211
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 06:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D821F21CBE
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 05:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250681B815;
	Sun, 17 Nov 2024 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="Vski8F5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93317996
	for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731820434; cv=none; b=nY9Sl4dEEsruvoTlX0SbLNCyq4zkv+oC2rwyTFw7ltrPry87GLwgFC0/r/oD+RZZ2F0CuzksWR/MOlWyxjggD0vas3PYXmKatujr0cC734x3AcKeUu/CGrmfUWWcWfK88FiH75mHKox/1NOF18UsrTDsVQvhgaYKtpEWXe0I/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731820434; c=relaxed/simple;
	bh=5MgNO26PZy3fPWCNlieA2b0OF/IQdElPorbCAQ8LWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFZs1I7v5QTTksjCn+hzp4j0g5oyWQmtsi6BVFB/DT3D0ahRw7q9MUshUAauBpiIxWpvAMKq+QZo9bMIbqm4Jitf5L6eaMZXrqt5wyqZyUUhXvNdFFF0iSaUhhCc05aAH+hAjyLQ2JW4z/QFWzzfslL6vlghDRT0fI9kbH1YNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=Vski8F5a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7248c1849bdso548510b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2024 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731820431; x=1732425231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYbYam3GaclUeMEBIstjEL7a3oAmPuVNtUlQikrML2I=;
        b=Vski8F5aWdpkom/cFlJBCFKpPsQtGHJ/Fwiq1ycdBJIaHxquSMnGrWklQvPfjtyIyL
         MOzZuAQhMTwBXgdII8Qrj5FWqMy93mu80k/qd4q4EsyzCzFYDuR7Z1dNoqEOKaUJ+kjc
         zz9qbJTMm2rl7KzXneHw3A65g3GPxy/ETGLwFzamH+ZyF6dSrdwKlrd8JTFjvTpSL2OY
         Fefo8IwgobR5xqqK4rTDF7qKwYaj+5rUh+oXglsVCdUbzzkPp0ZJDvuCIRB6xdX9QYz1
         EiFYxqJXDGxg4cE7QCdIWfEiCmjYFaTh8qVvrimq31ry/5Ft/2gO2tX3wiH1z6rB1BiO
         VE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731820431; x=1732425231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYbYam3GaclUeMEBIstjEL7a3oAmPuVNtUlQikrML2I=;
        b=YvsV5WuAO0b4F3SO6jY8DHW6mxpvF/6UV0rkr2WzKnNQLlMvbar2eBM3Z4G9jvOt87
         ZUEhK7VH+hDoFXQnc3bzLnYG/g2hN998tFbP6Su5kxeflmBHxKa1JRYrW9AbRbNfWrVR
         rrtkBcm2bmUIgvNPYvIKVIxyeveS+MA80s0yjjacpTocHZL47FKf9lCIcyQlxc5ypPLB
         jSC9Xb2GpPDcJefPy2+Uh3UXwowf8SI8uCcIjWzwCajI7gIiriRyPeZNasNB8/Gj9wv4
         3gy4SELm62NXrjlfJ23HaUSm99NflF90v96lqKydYKK4qkNzv44ZokrR31ydl3c6IDGK
         0JOQ==
X-Gm-Message-State: AOJu0YxTJFxYdHrkrjiArbn4jcy92D+qOOhQbXLneU8rhXlZZpIxki+i
	dloCipr5MmYN9CmTZMGoX5OSp6C2LQQ/+rJrpq822YkRoZPjBqXwIfk0QRj/
X-Google-Smtp-Source: AGHT+IHVIaZxxfcGzYZ5sNqlyqvHv+eyu2dhlkMMbhBapnm5ZOp5Fd6t7RpQnvTlNaLozOTNfo2tBQ==
X-Received: by 2002:a05:6a00:14c6:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72476b87342mr13292718b3a.8.1731820431051;
        Sat, 16 Nov 2024 21:13:51 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:96f6:cb09:e09e:fe02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5c0csm3841693b3a.164.2024.11.16.21.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 21:13:50 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Sebastian Reichel <src@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Signed-off-by : Andrew Davis" <afd@ti.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
Date: Sun, 17 Nov 2024 14:13:20 +0900
Message-ID: <20241117051320.1135900-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return is executed on the devm_register_sys_off_handler() line in
as3722_poweroff_probe, so the last return line is unnecessary. Remove it.

Fixes: 348fde771ce7 ("power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/power/reset/as3722-poweroff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index bb26fa6fa67ca7..8075382cbc3625 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -57,8 +57,6 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 					     SYS_OFF_PRIO_DEFAULT,
 					     as3722_pm_power_off,
 					     as3722_poweroff);
-
-	return 0;
 }
 
 static struct platform_driver as3722_poweroff_driver = {
-- 
2.45.2


