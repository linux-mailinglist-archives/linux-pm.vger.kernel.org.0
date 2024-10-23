Return-Path: <linux-pm+bounces-16279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48259ABE72
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 08:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4A1F21141
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 06:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8F145B1B;
	Wed, 23 Oct 2024 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICd5Xtf4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DBEAC5;
	Wed, 23 Oct 2024 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663892; cv=none; b=L6IZx0e8Fuk3obmSnotuw/hsy+Xqvyl0uD4zljjQoz1cku6BTh83rWoDp6Tom2Ou8DJ2+NM1t8/wM9nV5STCy1KxVZ9N/XAOmKuQ/T11KoKf6AnRi3bk6cvhoBvHvQTh7ELfPxlvWivtFhnW8eGPgWaMGN+ky9WqTaRRyh+Sd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663892; c=relaxed/simple;
	bh=0QCLUlm8v15+aWRNMVm0cX6XDb430gG0r+9EMsreD+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+tbeEoSmfJAQU6RVSvdc2LE/Xc9HSEYdtW6UOBnwK4GQx9W4bqt+3UE+7XNu4ns52rPMwzFPFNanZjlgjhy6x5/FgQjN+nAYZnZxs1YWMTxB3/cakvdENKTzsCpJmE+9YXlS2fqzCnVpYrP2A++b3yZrrRNhhq9y2hIvpGs0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICd5Xtf4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cd76c513cso53817835ad.3;
        Tue, 22 Oct 2024 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729663890; x=1730268690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6EFI9tqsrpEEu6NwL7Z+5Ve3RfER5b3SfcI5LbP/Pg=;
        b=ICd5Xtf44EEViv7HovcCxpj3eNp8oTWm9qBAJGRAsVaryzeQQojmU8fFA3d+2uKxMa
         9WMOEH6bmxM9DTk3BTHbqdE2Y2QWjhzOPNVkG9mGMOnRYlORfTnvaA1hUX4KawB3+ZX0
         xQfNrLzsgi+WB9uh3E06dxLvxu3V7If5N6ZWY64j/vLAp/+3lbz47xJSw9dEbXpFGPTJ
         aIcPF+023TtPSKyGrSi/nRylXqrCJMJ6/haGYW7b4yBh+HKHc8qCRJygqICwsgR0Whgy
         Rs/EZfi7z8tmG8QCy+wWZjh/g7TdFPiKjTgIJDrKfXSoLYxdG+Gcf1FBcCtg6z0XWdL3
         V7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729663890; x=1730268690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6EFI9tqsrpEEu6NwL7Z+5Ve3RfER5b3SfcI5LbP/Pg=;
        b=UKXmdjEb4t2OVzTbta03+xwuRwubz2fS5RBgRCYcQuT5tjwa9B3CgkkchM61s36kQj
         Lpg2IXY3mx0RfCnbokaEpaY6JJPlg6j37dXjHWZQ7hcWyBjodcWH7wbrOpwI25q0wANl
         jbF3X3fhshxEQ1SVNGESzYv0pW3whlykRQOUh0Kd7PscpRQ+tsPG8BKFwzRdVKGIzK3f
         SKCxanleLa47bxR8lwz8dKv5gPN1ILR0Jp9AZqtWNkEJJUVEAGyRr4BxB+RT6huUS95t
         awW79csgmYR5pza0C5439+nEIM6ZxWbHabvQKOpn8vkvULhsimNqP4E4Z4xpbmyg3YEB
         yZjg==
X-Forwarded-Encrypted: i=1; AJvYcCUGpQqXq6323hTkK3PIK4v3vWIq2Ryot8dhhsh0sTl+2kRUZ4apzdEr304u/ThFBa2v5c96dxAJYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MltAlTz7DvNhG8vcRzWpAIHJqHHWScLWvJ60uZ+qp1zbeOko
	4pQBxoL+uT8FPXivUkENfcCbAWsV5L8EeBG39NI5E9O8Tsm2KAFt
X-Google-Smtp-Source: AGHT+IFyEDDoFDa/N0jty/nCuSN2nZiQsDh94bhP1FLD4nrvCSFchFWHIh5DcW4EZTByQDm3/A98Lg==
X-Received: by 2002:a17:903:40d1:b0:20c:b0c7:92c9 with SMTP id d9443c01a7336-20fa9e5fd6dmr19310735ad.34.1729663889806;
        Tue, 22 Oct 2024 23:11:29 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:f4d0:e3e8:aee:c08a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62dcsm50964255ad.27.2024.10.22.23.11.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 23:11:29 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] power: supply: generic-adc-battery: change my gmail
Date: Tue, 22 Oct 2024 23:11:26 -0700
Message-Id: <20241023061126.7896-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

change my contact in this driver.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 7bdc6b263609..d5d215f5ad8b 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Generic battery driver using IIO
- * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
+ * Copyright (C) 2012, Anish Kumar <yesanishhere@gmail.com>
  * Copyright (c) 2023, Sebastian Reichel <sre@kernel.org>
  */
 #include <linux/interrupt.h>
@@ -295,6 +295,6 @@ static struct platform_driver gab_driver = {
 };
 module_platform_driver(gab_driver);
 
-MODULE_AUTHOR("anish kumar <anish198519851985@gmail.com>");
+MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
 MODULE_DESCRIPTION("generic battery driver using IIO");
 MODULE_LICENSE("GPL");
-- 
2.39.3 (Apple Git-146)


