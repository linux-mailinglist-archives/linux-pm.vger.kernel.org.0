Return-Path: <linux-pm+bounces-16022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766729A4DD6
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F350B25D87
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5C1E009C;
	Sat, 19 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+uj0LNc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87802629D;
	Sat, 19 Oct 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341796; cv=none; b=TKAAqcMytyU7WolFKGHT3Xhg9gzqgEvztwHuKLKw+0zoJV0gs1vE82R4H0LHCRWCU5t+7xsreznP3bWvje5oECqm+pq1B8ySQnjsmP4BL52F8qJ9bzCsXIUgSdYxUIPqLTbFhUo7WwzU1tri2iKNUHgM8RbQScISgrpZsiv+eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341796; c=relaxed/simple;
	bh=GCbkQiCCMKqEcJmM4aFS45i6RcNkOzlh+2Z+T0yQros=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kX1DFkzv4iFSUu70CRSBWa1Mo02Zr/4deh6o3uM68BNhxaar1L4sFvtCq3DKw/OTR1Jg5dPdBqh8E21hB0Zi2Ys5GOtEHEdntv8hgUwdWdmfjMjGiNxJ02nJpP8/f9m225YqntOuj8jNIYy4+kEmO0Eg20K8KPUlcbqRpvK6tZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+uj0LNc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c9978a221so35711165ad.1;
        Sat, 19 Oct 2024 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729341794; x=1729946594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTPLw4mbvudBDdndIwqX0EgEn9opTe0HakiCP5Mrd3o=;
        b=f+uj0LNc07wrrbxmPWnqLKhEHYlguC+oRGBlCowrewDVEEvnwHUCIkN2Wfx+K9wWWw
         q7/riVF1D0iuFldeqHM4qf0zEXXbeDcr0zs4OZGvMINac2snIUgLU9VXcYEXyEVJUQMc
         VAwTv8cSX2L8KeIvJilgH5B5H6F0DaFfm6gAMRtHtQ1nNcgR7R+GEbyXDwdLnIX3O05b
         GSw2gECYE6JfjOrR0gC+C9/sPbjrcC4v3i5fNbEG/FnlI7SJ4g9r/ebKteCHlbEs47bA
         PwS1IhJvFQuK7P5c8E9QBZbsHPVd93xkPS5mIzrsZsJYdl0X4hIdWjNfiPqPUCY0ccWI
         27Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729341794; x=1729946594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTPLw4mbvudBDdndIwqX0EgEn9opTe0HakiCP5Mrd3o=;
        b=ON+9q4ilxEcRRGJU/DmcylcOcV44TkriCZgbrYGBP0ZR3itAmKr/GUVTZDQtDbhArs
         Hv/bDHAZWQSdkrmPuj635VxeoaVNm7ElJitmSq3HIQPA0kONi/ggWcljRf+OyjS/VOpZ
         +9PBKzcQwjtZAiSPU4FOFDTo9cGd9Jv8fNueSv0D3njbOJrBaniVdHceAozHbFagxuTC
         wTibHWV8QNCiH1GeUohmccDMmSL0Spqir0lGA0ym2xQwCzxID9MO5m4UKhw2yQd4/wc/
         mjssOeXwVBFf90g/9e65cMUBnw0iy3vEWdU2zyddOout+3GUOuqv0/bTv2TXizyZY4Vg
         7PEQ==
X-Gm-Message-State: AOJu0YyDAOkYCAt3zvWbrFnRlPimcUHUk0jK+Jk06VoWUcHCFz/1FKOK
	c2qa+YApU+bF5Uecyanz3ZcTcBRo1IavpbAqr67fby0aC1N1WKCG
X-Google-Smtp-Source: AGHT+IGXy72rqnIuR9mCgk6ykiptdauTnKZPgHwcjrZldo3SbHRED6L3mR58z5gcIlocw3/QtDHfLA==
X-Received: by 2002:a17:902:ce87:b0:20c:9c09:8280 with SMTP id d9443c01a7336-20e5a92a675mr69776725ad.54.1729341793862;
        Sat, 19 Oct 2024 05:43:13 -0700 (PDT)
Received: from vishnu-pc ([120.61.204.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a90fcc3sm27098575ad.266.2024.10.19.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 05:43:13 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH] implement set_enabled functions on powercap.c
Date: Sat, 19 Oct 2024 18:12:34 +0530
Message-ID: <20241019124233.194140-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the functions sysfs_set_enabled, powercap_set_enabled,
and powercap_zone_set_enabled on powercap.c.

Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
---
 tools/power/cpupower/lib/powercap.c | 43 +++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef..1cf2b0de5536 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -70,6 +70,29 @@ static int sysfs_get_enabled(char *path, int *mode)
 	return ret;
 }
 
+static int sysfs_set_enabled(char *path, int mode)
+{
+	int fd;
+	char yes_no = (char) (mode + '0');
+	int ret = 0;
+
+	fd = open(path, O_RDWR);
+	if (fd == -1) {
+		ret = -1;
+		goto out;
+	}
+
+	if (write(fd, &yes_no, 1) != 1) {
+		ret = -1;
+		goto out_close;
+	}
+
+out_close:
+	close(fd);
+out:
+	return ret;
+}
+
 int powercap_get_enabled(int *mode)
 {
 	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
@@ -77,12 +100,11 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
-/*
- * TODO: implement function. Returns dummy 0 for now.
- */
 int powercap_set_enabled(int mode)
 {
-	return 0;
+	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
+
+	return sysfs_set_enabled(path, mode);
 }
 
 /*
@@ -180,8 +202,17 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
 
 int powercap_zone_set_enabled(struct powercap_zone *zone, int mode)
 {
-	/* To be done if needed */
-	return 0;
+	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+
+	if ((strlen(PATH_TO_POWERCAP) + strlen(zone->sys_name)) +
+	    strlen("/enabled") + 1 >= SYSFS_PATH_MAX)
+		return -1;
+
+	strcat(path, "/");
+	strcat(path, zone->sys_name);
+	strcat(path, "/enabled");
+
+	return sysfs_set_enabled(path, mode);
 }
 
 
-- 
2.47.0


