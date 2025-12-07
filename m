Return-Path: <linux-pm+bounces-39273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B8CAB677
	for <lists+linux-pm@lfdr.de>; Sun, 07 Dec 2025 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 951DB3002FF2
	for <lists+linux-pm@lfdr.de>; Sun,  7 Dec 2025 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038242F549A;
	Sun,  7 Dec 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2YCpRvb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378E2701B1
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120568; cv=none; b=nI3ICARUnPKIdxbBzlg+vak3WViM7Ph6QXkEvsDLmvO6x/x3McWSNLmdxA6GN/uZVk5euEdkclCVXkHHwLoCIv6KpWc1Bq2fZoC+cato82qHLDK+3EDjqWeWGu/IJeq+dJAjYabLXURy/j7Eo1pT1DRWMtbPVaQf3qd63v/Iu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120568; c=relaxed/simple;
	bh=Hh3bWchJaClFdaxbrmt1tJ2RmenazGLYgV1LqYXzcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocWtQcd/O3cnb8o3iE+NIqpU4wefOET4yJX1/KGCV0lb/DlJMW4cky7opSxaKJCK3v1asM9uBYBhipZZhrrDVj/yktK2s/qITDCOQsjOPrSMXZh2qgc6yIEkdBxIHOPL2REIpyqHrVTEhy0C6qfhKzjlWqPOAIPtmsdJOfhcFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2YCpRvb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so2474267b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Dec 2025 07:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765120562; x=1765725362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOwVN9mfGP9x9nqOzkMp2NF1E55nCwqERCAUAF8zvBQ=;
        b=g2YCpRvb45ZuPquetwT31DYNIlXXjWuKqcO2bBe0TP72Gtz79Vc7mHv18HrvQdqfp1
         9vF8qqwx/9EzEvUFT36BJ4ANqR5Dvd0T2hKoxV4N2uRcpk+d22XAhc0BKccd8amBrtj/
         p+w5amHyO51FWtWqSiv8WBHXKk0rDsax5eQAjMOdrqHVJobDpDOunUh2hb/o26HR2+5/
         SeRJqMG1QJ0HL7djUeMMtyGJ0h8ad3AqPojTuZYiWC1EYjZJuOwx67JhJDCLrydBpdP8
         Id2rh+SLpbtPQzcbGgc+49JIkG9YeirQw8gt/DzQv33egysf4HdsRuqPuCtuWrl8tm8G
         KEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765120562; x=1765725362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOwVN9mfGP9x9nqOzkMp2NF1E55nCwqERCAUAF8zvBQ=;
        b=Rgy0vpHkH9Gcp3wonn5jF5wtCfxoCwf50tP7h5vyIUHdwIJ0eIz4tbAkuylKbAy53L
         AFxzphKgYytXnsvV0Gxi/CJiknnnWt2va9vPdeUnoWch9RsN2gBM6pBql+I8R1yQimPS
         npa/VQSVq6/WDnM0KlB/8vtEbpSE8bc1HOoGRL/DLF1LcblhFKZtb5pujllHlFbwH5KY
         Tiq14MIRSp8afThAGpg6BGk62YzJ0QEwWWLK5tcJ9TG3Jmf6sM04Ol3n5h6q2JIlMtE1
         gO2IunJVvqddlFnF1X/RCkBJs7IbOEPvcaAb7xH9ioUFpqeZy0rFsCb7pLQuKHZmx4ou
         ZwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZMjUTqgAE+7wep960hGpO9JNswdj1Mx1z2tsaRC9y1l46w5Ttbd8niPsp+z0eK9Cjfgvswe+aOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEIUX4I3xfUsXL3Y/UbFILqc8T3A1F7C8SF6huXvQ/T7qomuS
	mJJbdYWgN9GHCnV9GFwoJfv62AJ4XnzQaSPmDHdUUAVVHXEnowHNfuK9
X-Gm-Gg: ASbGncvUIIVr74DOEJEIdH98CtiPX018zOfS1pe+ZHkgcv0HMLmytqzXp3GOSZ1A95G
	WBi8x1f+HiAqkJN7Mg8x3gni9XBdSTF3A+ga7BXGjL7fTiSNN5JLOPu7ftmiWxSyUEP/W2G8hu+
	oWyuLM6q5R88RL7qOC9A5j9Jt4AxG7XoQ7lOaNJZAxVy+WfBNDcR+OgEVz42Mc8y7OvxM5IVeNy
	1+g9TrY0RnX6o4R5iW6QyzglFsWeVScIj7kFRU/chfGTMK8arrP/vLmbxhiWuaLB88MTp8hqypd
	CGVzXMQCyqwzQoJu2BKr4Ak1MeFOVzLVoaE6Ar9oaE6ZYIcJucL166cxzOJlOUk3rdt6oSSwNdf
	v8IMqYdhDOqggbBHZ3kLTLQ9i7C+klEMLiHl3tdCYmHwc8AtDz4YNEYCFf5lpy75wns0h3ShqME
	d/uWcWyv8FG9SLqv9T0TNkvvkI
X-Google-Smtp-Source: AGHT+IHg2IepontQxf2wtozXosugj2KovvQBBe4oX5X7wYNtAFaUAIomETjLZZeSvkSjkSOQvzdqGg==
X-Received: by 2002:a05:6a20:394a:b0:342:9cb7:649d with SMTP id adf61e73a8af0-36617e80db9mr4555321637.26.1765120562406;
        Sun, 07 Dec 2025 07:16:02 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:efe:2e55:f77f:8407])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0222cf5f55sm317074a12.20.2025.12.07.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 07:16:01 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: sscanf return value error handling
Date: Sun,  7 Dec 2025 20:45:48 +0530
Message-ID: <20251207151549.202452-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inconsistent error handling for sscanf() return value check.
It uses implicit boolean conversion instead of explicit return
value check. The code checks if (!sscanf(...)) which is incorrect
because:
 1. sscanf returns the number of successfully parsed items
 2. On success, it returns 1 (one item passed)
 3. On failure, it returns 0 or EOF
 4. The check 'if (!sscanf(...))' is wrong because it treats
    success (1) as failure

All occurrences of sscanf() now uses explicit return value check.
With this behavior it returns '-EINVAL' when parsing fails (returns
0 or EOF), and continues when parsing succeeds (returns 1).

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/powercap_sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index bdc65e040d17..e998454e4bf6 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -68,7 +68,7 @@ static ssize_t show_constraint_##_attr(struct device *dev, \
 	int id; \
 	struct powercap_zone_constraint *pconst;\
 	\
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1) \
 		return -EINVAL; \
 	if (id >= power_zone->const_id_cnt)	\
 		return -EINVAL; \
@@ -93,7 +93,7 @@ static ssize_t store_constraint_##_attr(struct device *dev,\
 	int id; \
 	struct powercap_zone_constraint *pconst;\
 	\
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1) \
 		return -EINVAL; \
 	if (id >= power_zone->const_id_cnt)	\
 		return -EINVAL; \
@@ -162,7 +162,7 @@ static ssize_t show_constraint_name(struct device *dev,
 	ssize_t len = -ENODATA;
 	struct powercap_zone_constraint *pconst;
 
-	if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id))
+	if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) != 1)
 		return -EINVAL;
 	if (id >= power_zone->const_id_cnt)
 		return -EINVAL;
-- 
2.43.0


