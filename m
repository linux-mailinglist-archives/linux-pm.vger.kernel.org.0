Return-Path: <linux-pm+bounces-41833-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK4zCRUxfml0WQIAu9opvQ
	(envelope-from <linux-pm+bounces-41833-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:43:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB1C30E4
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBD5303FF0F
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24E33F8A3;
	Sat, 31 Jan 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqo3DPPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57F2D8DDB
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877777; cv=none; b=mKMPQpUT3haBb9ZQXsebkxezTf0MzKzTintty5W9S56cQSpQQRNM+laFdHRAs1B3Tp+8/ktKDS8hGoOTu4HsgtNmXo1IariFpq08j5qufuN0oYjcOIeukTkdh73344iyQDeRrAQyohm25BtNycmedqNBy7Ap+qagMmZlXo6bpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877777; c=relaxed/simple;
	bh=J/AAB3tENADKoPHbBY0BMm2WYEeRFL8x0RBuyPbusOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQoyFKe0P+21QjefEjki3Vg0WPxEL/wFucv11nhQwfBBf1D3WkUVy0YDhI0DLXky9CscYNSufP4Zr+WSjDXnhhnm8nc2JEs5EEVIrLAobjt8xJS//3msU6f9czRTEqoymlnowi7D/bNWFumGy/Hn9r2r3Qpybfb1SeNOs0tyTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqo3DPPF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0a95200e8so20154705ad.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769877775; x=1770482575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfnskZKszActZmelXo052mV+WPSTY5JhwZFi+v0Z/VM=;
        b=Jqo3DPPFhgT2lg75Ou+JSgifhBnfoJdogLBuwFRgNbA8MwQ1thJFEv2WUeq9W6JiNT
         uHAd7oCIQm/dxvlsUu9CL1k4BWTAroZRfXNtnFBgLFJF7ChRV5yriPaBkr6pUk5R9l3e
         RZTbZjTHKx6T1QV1bj9QfDaZ83UKfo5Uh/gYybrfYq4i6BI1ezOG+y0XMaetz01J/Avc
         wBK2f4Tu3UbrfoJflUn3oOVfPOPa7VgmG988HW2rr6dndcgyxQTylPjCC62PlpqlOXzM
         KnpuHjg/Qqn0Z4ESjA5O4dpAFTsjJIoHdRhtQ2YzLcTPoq43o9AhY+agAMenIV8TnCfR
         GY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769877775; x=1770482575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfnskZKszActZmelXo052mV+WPSTY5JhwZFi+v0Z/VM=;
        b=JIHU98WThBOeDTD6icpNcobW9pa6SylED28/F0xopyLvmJd9IkhMOUhvYUESusGcDX
         6DLS9Nm92c55YOegIwlSi4qrPh3rgyxY5RJGJ8pGZsAnj3PYMNEPmkGu1Be8h6GDWSqu
         T2TD+uiYFUzq2FUwKkpWvtQZPmHu4W5osl2hyNEXKyxwIZuOM7B6ZxDlETBufvJ9tYnt
         kUZ7na5bimJpQCmTsbp1neyHk/+MBzvK7Q7vYofCx8uzYSh0JRzdA03EP0YjPlk5ospc
         GW7X6AkhLIf54+xFpfRhKPvTtrD2/blheTwndgWF9C+BUqXEcyN5AFtYkgKMvUr247N1
         7bdg==
X-Forwarded-Encrypted: i=1; AJvYcCXvCpl6WqzbQjfikPniq3Urqn8EKNVkSaqPnPRAoq8RxfRg+vUDmzVseoYwQVmsoxT89ZV6SkXuGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIS/aWPsp/En7J5Sews1KeWrPd2q2IY241kiA1C8d6uahXe7qh
	OMZV/AR9zOMmsm7+1/cFl4DhmxYBZMniUT+qgvb5op9GVl+szHXWM7VtNjpkR3If
X-Gm-Gg: AZuq6aKbAKsecbHkSHBbcQ91nZWlrxSiJYaF0keZB3NAwbQsaouD3Q5CsU+XtphhwSb
	yBg/W4TNcJ9sFN4qyzlybR28X0T2hX5ZGWXkmC5nmHST09e19nTFTYp8kX+PZ5uFC2tB1dw+nJ9
	P1IQ6lF0jcamTBJ88Gwg3cIycSkE5hT5eQXP9JO9AYMA84ziqws/6G3Wp7UDnN8oAo5H8grcFWh
	e1U3/KW3k+TfFi8zeMk73zD9jT8F8fj0fUljYv1xAgbWf6aCdikd0mx8hO606Yhv738bzJOZ9OY
	+YZ1efC7SMb0eyKT03R8KNrvtrJb07ZPM9lsLj2sokN4MwNr4dE3HFWxH480WqvewLPHJQu2KS3
	1zShWAWx4VF3eZEGNPW/CCv9rqrMiyyI0iadWKdtxjG1B6Q5//EitUTRleWsdnOwjl2KPYNAYG4
	tTZKZy0NDot0Bw/MXo0Gz+gOcvRQ==
X-Received: by 2002:a17:902:dacf:b0:29f:1bf:6424 with SMTP id d9443c01a7336-2a8d7ee5172mr72814435ad.18.1769877775380;
        Sat, 31 Jan 2026 08:42:55 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:1ecb:768f:dd7b:8c69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eecedsm104762715ad.15.2026.01.31.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:42:54 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/cpupower: Replace strcpy/strcat with snprintf in powercap.c
Date: Sat, 31 Jan 2026 22:12:33 +0530
Message-ID: <20260131164233.7924-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-41833-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77DB1C30E4
X-Rspamd-Action: no action

Replace all unsafe strcpy() and strcat() calls with snprintf() in
powercap.c to prevent potential buffer overflow vulnerabilities.
The snprintf() function performs automatic bounds checking to ensure
the destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 tools/power/cpupower/lib/powercap.c | 42 +++++++++++++----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef..4116a9795bbe 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -100,7 +100,7 @@ int powercap_get_driver(char *driver, int buflen)
 		driver = "";
 		return -1;
 	} else if (buflen > 10) {
-		strcpy(driver, "intel-rapl");
+		snprintf(driver, buflen, "intel-rapl");
 		return 0;
 	} else
 		return -1;
@@ -125,13 +125,12 @@ static int sysfs_powercap_get64_val(struct powercap_zone *zone,
 				      enum powercap_get64 which,
 				      uint64_t *val)
 {
-	char file[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/";
+	char file[SYSFS_PATH_MAX];
 	int ret;
 	char buf[MAX_LINE_LEN];
 
-	strcat(file, zone->sys_name);
-	strcat(file, "/");
-	strcat(file, powercap_get64_files[which]);
+	snprintf(file, sizeof(file), "%s/%s/%s",
+		 PATH_TO_POWERCAP, zone->sys_name, powercap_get64_files[which]);
 
 	ret = sysfs_read_file(file, buf, MAX_LINE_LEN);
 	if (ret < 0)
@@ -165,16 +164,14 @@ int powercap_get_power_uw(struct powercap_zone *zone, uint64_t *val)
 
 int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
 {
-	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+	char path[SYSFS_PATH_MAX];
+	int ret;
 
-	if ((strlen(PATH_TO_POWERCAP) + strlen(zone->sys_name)) +
-	    strlen("/enabled") + 1 >= SYSFS_PATH_MAX)
+	ret = snprintf(path, sizeof(path), "%s/%s/enabled",
+		       PATH_TO_POWERCAP, zone->sys_name);
+	if (ret >= sizeof(path))
 		return -1;
 
-	strcat(path, "/");
-	strcat(path, zone->sys_name);
-	strcat(path, "/enabled");
-
 	return sysfs_get_enabled(path, mode);
 }
 
@@ -189,22 +186,21 @@ int powercap_read_zone(struct powercap_zone *zone)
 {
 	struct dirent *dent;
 	DIR *zone_dir;
-	char sysfs_dir[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+	char sysfs_dir[SYSFS_PATH_MAX];
 	struct powercap_zone *child_zone;
-	char file[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+	char file[SYSFS_PATH_MAX];
 	int i, ret = 0;
 	uint64_t val = 0;
 
-	strcat(sysfs_dir, "/");
-	strcat(sysfs_dir, zone->sys_name);
+	snprintf(sysfs_dir, sizeof(sysfs_dir), "%s/%s",
+		 PATH_TO_POWERCAP, zone->sys_name);
 
 	zone_dir = opendir(sysfs_dir);
 	if (zone_dir == NULL)
 		return -1;
 
-	strcat(file, "/");
-	strcat(file, zone->sys_name);
-	strcat(file, "/name");
+	snprintf(file, sizeof(file), "%s/%s/name",
+		 PATH_TO_POWERCAP, zone->sys_name);
 	sysfs_read_file(file, zone->name, MAX_LINE_LEN);
 	if (zone->parent)
 		zone->tree_depth = zone->parent->tree_depth + 1;
@@ -243,9 +239,8 @@ int powercap_read_zone(struct powercap_zone *zone)
 				return -1;
 			}
 		}
-		strcpy(child_zone->sys_name, zone->sys_name);
-		strcat(child_zone->sys_name, "/");
-		strcat(child_zone->sys_name, dent->d_name);
+		snprintf(child_zone->sys_name, sizeof(child_zone->sys_name),
+			 "%s/%s", zone->sys_name, dent->d_name);
 		child_zone->parent = zone;
 		if (zone->tree_depth >= POWERCAP_MAX_TREE_DEPTH) {
 			fprintf(stderr, "Maximum zone hierarchy depth[%d] reached\n",
@@ -278,7 +273,8 @@ struct powercap_zone *powercap_init_zones(void)
 	if (!root_zone)
 		return NULL;
 
-	strcpy(root_zone->sys_name, "intel-rapl/intel-rapl:0");
+	snprintf(root_zone->sys_name, sizeof(root_zone->sys_name),
+		 "intel-rapl/intel-rapl:0");
 
 	powercap_read_zone(root_zone);
 
-- 
2.43.0


