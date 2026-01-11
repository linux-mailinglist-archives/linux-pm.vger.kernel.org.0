Return-Path: <linux-pm+bounces-40611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DED0F11D
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D874D301D66B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC5341AD0;
	Sun, 11 Jan 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUVNQW0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187F341678
	for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140773; cv=none; b=PaBIIm+lz0yObbf7jBXW8+LEwCpezBkdnGEXvMHbzyPnDUrxSO98+bC+4A+PkngX16od9NpKyzdJMcbvkItrwusxswb6+ur7xpgD6xhzlGZCIVOIG7ccIWRNbj6sfWcIFXYmrJKfr3BStSquzk3x5D3WAdH/Jtl4plFoqngTGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140773; c=relaxed/simple;
	bh=eVpkNiFVHfH0/sNd7362yHUpEuHM+9miY/Q47hr5Zts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb+RpKdm7J3105gtLrodgBy9tNtvPd0UwcAY5D+eK8bW+WbwImD4JllwjVvvpJ1Jci26jBE2VHHhW2reLEcdKFnNbsEq8Vd/edOV+JW1HzMJc8xx4HFC81+z4jL7II7SPvXUkEfB60k0p4uVhCPQVGeOuTEYXnchJiKtQmp1eBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUVNQW0J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d5c365ceso39112065ad.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768140771; x=1768745571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLgHxTzKOaGHrCs2i3lpveP4dS7RixUlZ8uZ0dmDPaw=;
        b=KUVNQW0JD/FoDD1xAWrqNN3Ch0O7++bXc8f08jFHGbbpsZ3IsLraflEesHKm06t+nw
         MieMwGdQiUi7ahRHDlEsHvFHJ9o90tHodUM4PkwwQx4Fqf2O4lOZXG7/j1wmKbYjMOpw
         mcgRFzbSNiokYgDZsrEec3mdwLsUAQEL7lmv56nPtK7nH0QIr7HJSkzuXgX8CW/k/nL3
         AY+w270xsb1JMzwJ+xOoqkD2UMKhHWd+a7lFa3bdK52KAgn2mfnWsTBXxQUDhw8CxhMQ
         vlX2atXx/SH4MF3xNRaXzghSohFjMVFMOPJzM6/e1AUOh0LLQDp0aj3/GMjfBmKbCu23
         Y34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140771; x=1768745571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLgHxTzKOaGHrCs2i3lpveP4dS7RixUlZ8uZ0dmDPaw=;
        b=eGfbL6OJfcJkPIjlNdezLRap5WgaUVQSLIYp3kAYAVsCYcgjDt7IcHZGT7f1ZzQKyd
         my344j5Dll08ZtvtVr4t88+eRl1XeOhn2ZZ9Ivxx32YKRVRoLRfcgv0ucZo2RSxZbZa/
         OnCOsVUrMiKsARZUkjEbwt9J7GI73lCAh2TukRSGlSY90GsipT6IqmdQ2kLyY4uUILIO
         vloBSKn7kYMx95YJypxemrs+oW3uskU8U7PpvfO/8YWg0r/qNFOpo/yyddKpyfVzsUbY
         wdw89JjI8A+AlDVyw8lEQGUNhy5Pjbed8KvuukjkU/I9FWPtlgx0IwmNJbI89fJqk3Ub
         +Lqg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Fgjws4drGLJJRbGIe9BtCGnrBEtHrnBW/oM+r2Od5XvheGMpoEOA4ZLG5Qd7wFjMSldM07uDLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCE3NEPWmvZjBxDPt7RTIBU3w83fEhzMBqXK5DgsbVWKVIlnkP
	fUw/5nMaPRjzmBcfnItUR6GOE6BEzdmlSxhr70zvqZ14bxDOUxPexb5Agy5PJA==
X-Gm-Gg: AY/fxX74cUddCq0LrM4E6a/O7AKqzaFKtiiGXH6oFt+3ZZRRMLPzUiMLaI8eODy2jfg
	feZ4d4OxlN/WAkFSxjdbutZ0iIfUf//cVi3oeEECvUz+nlJ1tNdeyaeg9hV6xL3jZeFejZcnwXE
	4VkKV5d8ox0FB3ofS1qZ3kdxiNsAPYgc0d5V+/OcEvCwc/YqJzN26gLzujxe7mkgytAUm87fRyk
	B9/3mZ+ScAfD6zax3kfZ4mqqYlEEMlTYlm/aydh4eL90ZRXVFBzp3Rlx5rDRUyo8HfXBfU+9XFk
	oUJZUm60jUDkcL/UwU5eYsYWwgGwW00SHx7ygLvNbxECkJ9Jj3Z4Ru+YFI0iqZLlVrmOHQMi0CP
	HMwwMdkaRyQkaKTDAjNLQN5A2pV8Maw5G0/ODyt0Nz0wxVvhHSKMKvp1fWA7skBua6ujlk81jO2
	8oPhKsdlVwxBBU8oSWqOsVuIlGBw==
X-Google-Smtp-Source: AGHT+IGbFJmJOYDLuNja261zZ8Hot4TyrJjHnokveJphC1DV4zTURdk7VUWhK+csfOHK3cfpvEaRVw==
X-Received: by 2002:a17:903:1c8:b0:29e:97a1:76bc with SMTP id d9443c01a7336-2a3ee458f0dmr164155395ad.21.1768140771023;
        Sun, 11 Jan 2026 06:12:51 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:df65:ffa4:d9b6:3e58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc794asm150766705ad.70.2026.01.11.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:12:50 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: Replace sprintf() with sysfs_emit() in sysfs show functions
Date: Sun, 11 Jan 2026 19:42:36 +0530
Message-ID: <20260111141237.12340-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all sprintf() calls with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred over sprintf() for formatting sysfs output
as it provides better bounds checking and prevents potential buffer
overflows.
Also, replace sprintf() with sysfs_emit() in show_constraint_name()
and simplify the code by removing the redundant strlen() call since
sysfs_emit() returns the length.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/powercap_sys.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 1ff369880beb..f3b2ae635305 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -27,7 +27,7 @@ static ssize_t _attr##_show(struct device *dev, \
 	\
 	if (power_zone->ops->get_##_attr) { \
 		if (!power_zone->ops->get_##_attr(power_zone, &value)) \
-			len = sprintf(buf, "%lld\n", value); \
+			len = sysfs_emit(buf, "%lld\n", value); \
 	} \
 	\
 	return len; \
@@ -75,7 +75,7 @@ static ssize_t show_constraint_##_attr(struct device *dev, \
 	pconst = &power_zone->constraints[id]; \
 	if (pconst && pconst->ops && pconst->ops->get_##_attr) { \
 		if (!pconst->ops->get_##_attr(power_zone, id, &value)) \
-			len = sprintf(buf, "%lld\n", value); \
+			len = sysfs_emit(buf, "%lld\n", value); \
 	} \
 	\
 	return len; \
@@ -171,9 +171,8 @@ static ssize_t show_constraint_name(struct device *dev,
 	if (pconst && pconst->ops && pconst->ops->get_name) {
 		name = pconst->ops->get_name(power_zone, id);
 		if (name) {
-			sprintf(buf, "%.*s\n", POWERCAP_CONSTRAINT_NAME_LEN - 1,
-				name);
-			len = strlen(buf);
+			len = sysfs_emit(buf, "%.*s\n",
+					 POWERCAP_CONSTRAINT_NAME_LEN - 1, name);
 		}
 	}
 
@@ -350,7 +349,7 @@ static ssize_t name_show(struct device *dev,
 {
 	struct powercap_zone *power_zone = to_powercap_zone(dev);
 
-	return sprintf(buf, "%s\n", power_zone->name);
+	return sysfs_emit(buf, "%s\n", power_zone->name);
 }
 
 static DEVICE_ATTR_RO(name);
@@ -438,7 +437,7 @@ static ssize_t enabled_show(struct device *dev,
 				mode = false;
 	}
 
-	return sprintf(buf, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", mode);
 }
 
 static ssize_t enabled_store(struct device *dev,
-- 
2.43.0


