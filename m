Return-Path: <linux-pm+bounces-11633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC19408EE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 08:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7885B1C22D2F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2718F2F6;
	Tue, 30 Jul 2024 06:55:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210ED190460;
	Tue, 30 Jul 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322513; cv=none; b=C7b27PlmpmGxoofcJfIWSvy/Y1+AUCtWTSGE1jC0uSZurH0o4MhHvfYbh0gCBjb99gBy+l313amAzOAxKAx5F4S686fUY8YqPFe5lguxivXgyfTRGr83rFnMUTKZNZEzgA3GKg1YL0RRUQmwUvUn0oXgHUHh8ChrzMwd7wja/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322513; c=relaxed/simple;
	bh=HyEc1KC08/P7sfYf3nsdQ5JXg8thcyn+se5XuoW1T+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD9u+2YjrQ4LJAK4dyEw4Xb/rEGq6hDZfw1l+CIyRNY6MJfNoiZv15shxnaQgUYwOMX4iRR9OxWt4T+7VkxZPVUAJH41dLap2Hhwl8Usq42VurNrjLl5Xz7+Y8PqJ3anZnaWYxGE3Yx0JUQz61nSgxaCUEQX4J9KkZP4QFJE9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fc56fd4de1so24764635ad.0;
        Mon, 29 Jul 2024 23:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322510; x=1722927310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5f2Yy4WlxKF0KPO77Fw1ob2HwlhkvfHZP1IHU/L5xc=;
        b=pQtTaoMy4Lw7q5C1R+Lr91osMfpBcF9AAnZSwH9Qr0ytlb5WEbTgJ6Sw162bosqRaS
         dLO6S8mW8ogUkgZbn1ll9Cjw6DZ8VE2fhrmkD5A9XVxG6wRBxi3P8UG+VQvQM1Fsp/da
         /K5kTtW0QKmwu+ehg/e209uwZRdwhcajIIyVxL/it9Ltprg5J9amzks0vLiMn8y+LaMd
         o65QypCauE24x6hiSp/0UAcq0FMeViw6Kr6JJMRlhDHqpx5mzwfXcO08YoESKKScpxCj
         5eWHodw2vwChWCy+J2OaNLtsyr8KC7DsQlQ6/eNlFAmwDe3SFg4joONDnxqD5vwGgrQ7
         3jXw==
X-Forwarded-Encrypted: i=1; AJvYcCXKp1ruKkSS/w1+xSawkIrhcj6ACbMafe/4VgID47MHaeKzEHy2fQ1x9jLfl3y1bxm/BGuduGvlTyBn7sOutBu2CE0xLaweY8PaAICp
X-Gm-Message-State: AOJu0YzdIew54VWckeSgsxTIFRZGPdB3i2XXHH2mpcR9P2RDCTqA4E+8
	+HxRM6uO8zMY8ufRwNkvK6HLZHQXjgkITFwSZKGW9Os9mKCxS53E
X-Google-Smtp-Source: AGHT+IHnU1SrEP4NuLb9TyeIOT8n6boB8Q5YEkLpV0CotgSKByvezErIAcfB67RaU1wDVcjA84Q72A==
X-Received: by 2002:a17:902:c945:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-1ff37be4ce3mr18366905ad.12.1722322510395;
        Mon, 29 Jul 2024 23:55:10 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa18sm94392875ad.190.2024.07.29.23.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:55:09 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH 1/2] PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Tue, 30 Jul 2024 14:54:53 +0800
Message-Id: <20240730065454.2096296-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
References: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
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
 kernel/power/hibernate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0a213f69a9e4..604fb30ec007 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1124,10 +1124,10 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
 	int i;
-	char *start = buf;
+	ssize_t sz = 0;
 
 	if (!hibernation_available())
-		return sprintf(buf, "[disabled]\n");
+		return sysfs_emit(buf, "[disabled]\n");
 
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (!hibernation_modes[i])
@@ -1147,12 +1147,12 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			continue;
 		}
 		if (i == hibernation_mode)
-			buf += sprintf(buf, "[%s] ", hibernation_modes[i]);
+			sz += sysfs_emit_at(buf, sz, "[%s] ", hibernation_modes[i]);
 		else
-			buf += sprintf(buf, "%s ", hibernation_modes[i]);
+			sz += sysfs_emit_at(buf, sz, "%s ", hibernation_modes[i]);
 	}
-	buf += sprintf(buf, "\n");
-	return buf-start;
+	sz += sysfs_emit_at(buf, sz, "\n");
+	return sz;
 }
 
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1210,7 +1210,7 @@ power_attr(disk);
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
+	return sysfs_emit(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
 		       MINOR(swsusp_resume_device));
 }
 
@@ -1270,7 +1270,7 @@ power_attr(resume);
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
 }
 
 static ssize_t resume_offset_store(struct kobject *kobj,
@@ -1293,7 +1293,7 @@ power_attr(resume_offset);
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
-	return sprintf(buf, "%lu\n", image_size);
+	return sysfs_emit(buf, "%lu\n", image_size);
 }
 
 static ssize_t image_size_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1314,7 +1314,7 @@ power_attr(image_size);
 static ssize_t reserved_size_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", reserved_size);
+	return sysfs_emit(buf, "%lu\n", reserved_size);
 }
 
 static ssize_t reserved_size_store(struct kobject *kobj,
-- 
2.25.1


