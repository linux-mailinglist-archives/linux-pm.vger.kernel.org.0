Return-Path: <linux-pm+bounces-11252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC9937695
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C311C217D3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D381211;
	Fri, 19 Jul 2024 10:23:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2982D69;
	Fri, 19 Jul 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384591; cv=none; b=hoKQV7EmdfS6pFnNZQfrIGEC/nF9rNItiyjc5nRbOBfn2hthXThIssu/FPEmJdp4FNOc6lz1Cc1MNtNlJr+OeP8L0k9OG+TXp5f8IjoYDlhW5kJ8eOKHBbD3tFqulh8J2GKEyR1oYH3+tlGGUR3ZaUMpPbgv3sNBHqK6Oobr0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384591; c=relaxed/simple;
	bh=odHth/5yAnmmeRVLLttZI54SxLBD/q7eKts+Y63UlPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cu1XocIvrWuAdK3nnZmfRzSimKwsb4QeGCelBc2L0Dtmv96mSZWZSsI9UCCkupsrEBb0uk6zu7DIfkIN99u+TiR6fpPr3pB4b2U9khanccFEg0hBaB04ixb5BW6+TBEISpDS3j07YMYNEibojeqCML3+mo+R3P7IVBDwp6Dkqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fd69e44596so2008755ad.1;
        Fri, 19 Jul 2024 03:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721384588; x=1721989388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzIznD4An+j8MgLPrLcoQQ2kcUvCuZm2sbz2UvLTaEg=;
        b=n+2I09M8rJdt41yHxamDcbTPQws7ka6FUilJG2YOkPry3n+SxnHkJ56F19H44JG+K3
         VnUc9DwwlYJrHTg7pXKMqx/P2gzyBrE3G2+zH/Yt8dCBwOfig1nlpukH77akIXrJfe6i
         swumUnIhz+LQvLoB6+7TRpc02zRKM1aqkHst9v1dHlq7lD43t7rivF60UggUilCLQwWM
         Ocwi3iRvB3Uu0iqhPn0AzFwRb1QIu8jtFVwvctQi292fWRAL7jpe6Jie3v0taHnIhyyR
         2ZeFRJN5+AcNKdWODAIkTq1sASL5ifB+fdKTniEuZlr3S9H7VRrAbW3DXzHMGXCYmCoT
         ASrA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtIZusgMHQML94s+LDqlOC/Gfi8610O6koMxE4DxG8Jqyg7gI1V5lwHXseudakYwikXJPehpN7Z3GrVkE4MF+bbUJPgI14XjZIw7k
X-Gm-Message-State: AOJu0Yzj0yUVQg7sppnsUbvjvjAB/61xCUx9OIGKwqsOk8CoHQfP5NMq
	NjOPJNus2DeLsSGg3zLVzgISeDqPcnb0ticm5+YtqwFSB9bod6FA
X-Google-Smtp-Source: AGHT+IGQdZ21/i2k31nXeNT/Pfe+gBAQu5RhIGS2Ny1Ytvm0dUuQ4Ab4LsjJ+5rrq93gVqf00Rl6SQ==
X-Received: by 2002:a17:902:da91:b0:1fb:d07c:64cd with SMTP id d9443c01a7336-1fc5b60a90cmr84055805ad.21.1721384588189;
        Fri, 19 Jul 2024 03:23:08 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f49a218sm1283535ad.298.2024.07.19.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:23:07 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Fri, 19 Jul 2024 18:22:12 +0800
Message-Id: <20240719102212.974245-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
 kernel/power/hibernate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0a213f69a9e4..f55648df9b81 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1123,11 +1123,11 @@ static const char * const hibernation_modes[] = {
 static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
-	int i;
-	char *start = buf;
+	int i, pos = 0;
+	ssize_t sz = 0;
 
 	if (!hibernation_available())
-		return sprintf(buf, "[disabled]\n");
+		return sysfs_emit(buf, "[disabled]\n");
 
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (!hibernation_modes[i])
@@ -1147,12 +1147,13 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 			continue;
 		}
 		if (i == hibernation_mode)
-			buf += sprintf(buf, "[%s] ", hibernation_modes[i]);
+			pos += sysfs_emit_at(buf, sz, "[%s] ", hibernation_modes[i]);
 		else
-			buf += sprintf(buf, "%s ", hibernation_modes[i]);
+			pos += sysfs_emit_at(buf, sz, "%s ", hibernation_modes[i]);
+		sz += pos;
 	}
-	buf += sprintf(buf, "\n");
-	return buf-start;
+	sz += sysfs_emit_at(buf, sz, "\n");
+	return sz;
 }
 
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1210,7 +1211,7 @@ power_attr(disk);
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
+	return sysfs_emit(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
 		       MINOR(swsusp_resume_device));
 }
 
@@ -1270,7 +1271,7 @@ power_attr(resume);
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
 }
 
 static ssize_t resume_offset_store(struct kobject *kobj,
@@ -1293,7 +1294,7 @@ power_attr(resume_offset);
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
-	return sprintf(buf, "%lu\n", image_size);
+	return sysfs_emit(buf, "%lu\n", image_size);
 }
 
 static ssize_t image_size_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1314,7 +1315,7 @@ power_attr(image_size);
 static ssize_t reserved_size_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", reserved_size);
+	return sysfs_emit(buf, "%lu\n", reserved_size);
 }
 
 static ssize_t reserved_size_store(struct kobject *kobj,
-- 
2.25.1


