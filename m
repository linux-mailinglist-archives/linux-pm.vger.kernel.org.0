Return-Path: <linux-pm+bounces-11799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DE89446A4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66AC1C22CA3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA3616EBE9;
	Thu,  1 Aug 2024 08:32:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6321396;
	Thu,  1 Aug 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501135; cv=none; b=SL+04vv2luELECymUc/qnkjZjdkuuq4HMPpHlBaZ7/UaN79omCsgHL6nFrMXYRPMyZRCloBcMnyGbiTbA+eioB19Ke+ZN2HH/0beJYwx+C/ZDiYkjInnOX+WTPu8lMZvsxqxYf4D7KiDTIC5DdKDUPVWJ0nozlGzuyTKVuwcjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501135; c=relaxed/simple;
	bh=R8kJFLUaAFHTKoswibCvI9wlyRcLSzxhckQk/Lqxruc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QToYCN4VMseSDhEew2KKn+V/K5Wgg/AYMaygq+1EkK5Pe+OIesECKxeAtOnXNmhD79Hlq7ZBTZoC9eBEFmhwcY53yydNNoW3ATTAZcuw12N3eBnKnn0SYRVnGIo3BHSrdSok6u6bjCgjoIffk6KafOhT2MhjkxqnrvKr/HRKPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fc587361b6so48976895ad.2;
        Thu, 01 Aug 2024 01:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501133; x=1723105933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itsNJ0y0uRappunzCUTi3Pm3wBzghuzwuTR9Hzw0xws=;
        b=g5akwhdW17ICkt3ZHIEep+Kg9QS5AYjOouVS68eSTkaOfkxr9Jw75xyxvP/8+pnJl4
         LKXSwhx7JAijDBv2eBHlyDYymB/XWBgI0xnuIpaKcw8QptrzNAeWzPC5BxUHoeAlFCG9
         2PbrWxFlekmgr02GZ0nZ5CAgo0XsFpZeos3D6XOBKBiVYUtLvl0brmCKVReLER/bdMLe
         A2K+QXwdU/LSQObByDk2L7MvBCLZLzDZMcSpNf3H6fquPUzgS4OWVHuvaTZu2wjsU42Q
         7z3/WbGrAHBVAnF1BN2Axz4ld5q2mlf9zOPa9F8C2sGheJ7owtUvPv+YY0zoONajgjy0
         4oJA==
X-Forwarded-Encrypted: i=1; AJvYcCUX3rQKnepSwxS/LwuWlp7aQGwOf4Td1swYiQY1rQbpg3a4Jte6vJQGrjNqAi+aHCBWs7Le2y96RFgNG6jBI/lwj2TVlnV1/TtWFXay
X-Gm-Message-State: AOJu0YyqXnF3jMI9l/RZcR5DXTBoCNeZeinKZMFyr8qVgEfSnHCRpSzF
	X1KNojgkARWITe+zniu4X7QKD1u5hNrA2ROLsMFyMNAwB9A8cvaH
X-Google-Smtp-Source: AGHT+IFRmfaOy3TWo16oYs8rEtXj8kLuEoHayyppdYOMhUHqr+hvjpoBhGWlTAl4Tr7fhuDPft4YZA==
X-Received: by 2002:a17:903:32d1:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1ff4ce523a8mr22734545ad.5.1722501132799;
        Thu, 01 Aug 2024 01:32:12 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fb0fsm133288365ad.7.2024.08.01.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:32:12 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 1/2] PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Thu,  1 Aug 2024 16:31:55 +0800
Message-Id: <20240801083156.2513508-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
References: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/hibernate.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0a213f69a9e4..e35829d36039 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1123,11 +1123,11 @@ static const char * const hibernation_modes[] = {
 static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
+	ssize_t count = 0;
 	int i;
-	char *start = buf;
 
 	if (!hibernation_available())
-		return sprintf(buf, "[disabled]\n");
+		return sysfs_emit(buf, "[disabled]\n");
 
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (!hibernation_modes[i])
@@ -1147,12 +1147,16 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			continue;
 		}
 		if (i == hibernation_mode)
-			buf += sprintf(buf, "[%s] ", hibernation_modes[i]);
+			count += sysfs_emit_at(buf, count, "[%s] ", hibernation_modes[i]);
 		else
-			buf += sprintf(buf, "%s ", hibernation_modes[i]);
+			count += sysfs_emit_at(buf, count, "%s ", hibernation_modes[i]);
 	}
-	buf += sprintf(buf, "\n");
-	return buf-start;
+
+	/* Convert the last space to a newline if needed. */
+	if (count > 0)
+		buf[count - 1] = '\n';
+
+	return count;
 }
 
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1210,8 +1214,8 @@ power_attr(disk);
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
-		       MINOR(swsusp_resume_device));
+	return sysfs_emit(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
+			  MINOR(swsusp_resume_device));
 }
 
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1270,7 +1274,7 @@ power_attr(resume);
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
 }
 
 static ssize_t resume_offset_store(struct kobject *kobj,
@@ -1293,7 +1297,7 @@ power_attr(resume_offset);
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
-	return sprintf(buf, "%lu\n", image_size);
+	return sysfs_emit(buf, "%lu\n", image_size);
 }
 
 static ssize_t image_size_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1314,7 +1318,7 @@ power_attr(image_size);
 static ssize_t reserved_size_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", reserved_size);
+	return sysfs_emit(buf, "%lu\n", reserved_size);
 }
 
 static ssize_t reserved_size_store(struct kobject *kobj,
-- 
2.25.1


