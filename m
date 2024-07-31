Return-Path: <linux-pm+bounces-11729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2099942491
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 04:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D5D1C22844
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837017557;
	Wed, 31 Jul 2024 02:45:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E6CA64;
	Wed, 31 Jul 2024 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393930; cv=none; b=qtj7Wvb7VWxNNVGgirE9KydKzxGy0m8q/dzFgp0/sZUWSVNkrY/GGaWt2ZVBoOLBDyosKNmQ1UejVkFBfH/5JJIYMwey2VB6aPUYBdnUE/RDP8NHXu3vYz90p90nfAUkybwzuPn269bpm7rHFQ6EpHoJgsMbQ/UkZCXJhAEDrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393930; c=relaxed/simple;
	bh=U1CZfyMXnga9L0eRRaH/DSy8of+LlyshL0TYHZbXa7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJK85T8tq2L/wAHbsdCiTDAX1StnEqvOhXTX5jC5n4vdHRSg/83qAJlpQhOeepO/IFlFhPXXpxRUOQcuOTUzgLcGwVGpsLn3ogvVPsIRWzrcpnmLsB6iMfcZmhY3f+406wZw4/1jLe3Pvmu7THRiDwYVDZNldHoZmltRWxKmGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fc52394c92so44960625ad.1;
        Tue, 30 Jul 2024 19:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722393927; x=1722998727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne+PCxzGGKtVPei5AF0IA8cgmefV3VGq8jxTeAoWXxc=;
        b=TADSZu+sivb+pldxrf3UoFNE71HbgQjqNCSzXt4tjUUGLkZSF2+/6v03/LFuNgKZZI
         AyipdlmXa4XIvvin+WqLPsgdG8CQtX4+Y/HEJ4BIhPRt80Lhn05YvOPphqf6Dj9jzMBK
         5SJBEqOxV7Kjf23kn0mKR4aIoOgO87UyRdZXS7pOoiEnS7IQyM/dC7FW/BgcIQKVh661
         XmgMTLsVd00cAkaeYa/j0bXtyESttrX8bBgSXne2vE2/+irQSId/d1peHGwNdLVCv6zm
         xLXdPpu82tpqPafy5gZjsAGvRfyYUqjo0CqtLzqrroGBAwzeBZqD6HwR4ZTf2F+cl8lc
         a7xA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjBLYW28YFe9dne2VQ+LxF5V7wpBSoOZXiOI8tlNlOBQWhLjfDL/ZzzqLngOfbdbQX4i+Wil3sDJdkdl4IwI6CWKHU4/QH+JxmuQC
X-Gm-Message-State: AOJu0Yx5F7W5Dj5rBzisQ4OiBUOJe4aau9Qq9ZIVHPboTuGlaEc7Lk3I
	fkuKFdUlWOpC5wgzyF0L5LElXXiptx39jqGxwETiOPnFnQKVsjcy
X-Google-Smtp-Source: AGHT+IH3lZBLC5Fdp+EOh13lyQ4O9rCqF92Bil5QuaJtA0kLhV8xC7a7w5NpamYMz91VDo3umMaVAA==
X-Received: by 2002:a17:902:db05:b0:1fd:9e88:e4d3 with SMTP id d9443c01a7336-1ff04818822mr162310955ad.19.1722393927389;
        Tue, 30 Jul 2024 19:45:27 -0700 (PDT)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c86afasm109620575ad.42.2024.07.30.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 19:45:26 -0700 (PDT)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 1/2] PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Wed, 31 Jul 2024 10:45:17 +0800
Message-Id: <20240731024518.126716-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731024518.126716-1-luoxueqin@kylinos.cn>
References: <20240731024518.126716-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin Luo <luoxueqin@kylinos.cn>

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/hibernate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0a213f69a9e4..0792d3a85e94 100644
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
@@ -1210,8 +1210,8 @@ power_attr(disk);
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
-		       MINOR(swsusp_resume_device));
+	return sysfs_emit(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
+			  MINOR(swsusp_resume_device));
 }
 
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
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


