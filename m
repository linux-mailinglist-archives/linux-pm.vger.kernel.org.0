Return-Path: <linux-pm+bounces-16742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19C9B67CE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C89C1C21C75
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E179213EEE;
	Wed, 30 Oct 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMQeShE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE5213ED9;
	Wed, 30 Oct 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302061; cv=none; b=jobC/ctMwK5td73rDXawL6PfWsHWF9f1YN67EPBv/QmZPkdjTjqrUbpjmN98736Us26fahtZrc3Vb3yfPbwx1NnkFWBc33L1TeSMLIjxmOEX5NOxYYvTUls+qOkqdtge2Ut+D3R3jXjM58V+UGIOaB6M9PuH0IFFAj+vb2n3/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302061; c=relaxed/simple;
	bh=dp7Rt1x5se7IjoicRuuvaRIcwU8RIWWuCWECT6ZmwLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omSTnONCqM8qzMNEfeXpEYjkDarezIeBRLgvTv1FvFabVEtjwihZwXW6yYgLxl3vActxMNph0U1dJa43tZB3c3xG9nklR7m35ckNcjCF8dmlK8vN5ji+nq4WKX27EM66NXv4PfsB8hLLST/6u50LSyqxsKbGpCt8ojyFGbSOl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMQeShE/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eab7622b61so9398a12.1;
        Wed, 30 Oct 2024 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302059; x=1730906859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYjqPUvHlnFE6/zLSAetb7FzSywGnSPHf/K1ifJ2bww=;
        b=bMQeShE/qAjX1pcSNa6Kz7fwUKRw6fLsjJnYTtW89nWe5teULa2EcDU4qw9qq+NpU2
         5JD+MWuiQuu2dqUnr1mv2VDll7f94GKrZFVWbNZoMqCxsp7ypOfwrO2MHyNPV3d1dvyd
         VjGQUs+WtmuqSumCRoFlK3rZ4/4V0SG5cQvf68KHegtPtgXegt9XYGLJur0/E673JmmD
         pbIe+91NYFHRI659kIlC9jUlUCoGQkRtZgc417ECTI6/kPcjX1EmwpFB4e1J8caNpaha
         8a9MYPnoJJ6qZCg8DwxdNYkb38C/scAoeWEEl/D05+L00hE65LOwy8j86b4hK+JBExRA
         aH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302059; x=1730906859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYjqPUvHlnFE6/zLSAetb7FzSywGnSPHf/K1ifJ2bww=;
        b=eQBt9zM4gAeXUlmvrXX6orMOMmljs86cOjJko1xlCpJu/M3Ge8Pjqp+xKEM3L3Hz/Y
         lVzHCiPIXSqGfNelzW/LQiptZePdi2MGROMPKZMUraYcTXOrUX1whpk+eqAXa3y3oEm7
         htxZbbKq7hms3WcYUcmk9/1MAfev5vx21FcWIS2tywAK3B5FYerMWGwEN0QrNCoSMLPI
         v4XryZdWvUs6YwulUtqvEgX3o7MOmc6Y3eOjYH5KLwydOwJGZp+c4I16X6Yi6ZK6QPMk
         tWmupBA7XJCYWiLeqTetfiVvLGdedZRX9t5D8GxamsD6lLTx0EZJ0lW+W3o2iO6ZaELU
         JaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXpU4tj8rYzPgUctwmhgcgdXduoy60g+wPDwEhKtebb4CyjCYgnGWbsOc6haqEA4Cy6p57+Jq2jrAvAls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qeU9/kj7P+7RjOttGTYs2kewwGv7QIfl1AJtC9B3dVPjpD9c
	uP9j7pXG0CdruaLT12FmKXJR7I71JowXhG5An4TgnKhHisVXu4yl
X-Google-Smtp-Source: AGHT+IFzlwxdcUfGEH/hWPbCNqI1qzjDtssH7En8lQwGybFEPaZUZiCCAyCMQjeLVe0jDMWvkuwrNg==
X-Received: by 2002:a05:6a20:e30b:b0:1d8:abf3:58be with SMTP id adf61e73a8af0-1d9a8402d5emr19824526637.21.1730302057200;
        Wed, 30 Oct 2024 08:27:37 -0700 (PDT)
Received: from vishnu-pc ([117.248.51.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d089sm9637735b3a.99.2024.10.30.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:27:36 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-kernel@vger.kernel.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH v2] implement set_enabled functions on powercap.c
Date: Wed, 30 Oct 2024 20:57:07 +0530
Message-ID: <20241030152706.179779-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241019124233.194140-2-t.v.s10123@gmail.com>
References: <20241019124233.194140-2-t.v.s10123@gmail.com>
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
Changes in v2:

- simplify the implementation of sysfs_set_enabled using system()
  function.
---
 tools/power/cpupower/lib/powercap.c | 31 +++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef..a2c0c33b7729 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -70,6 +70,17 @@ static int sysfs_get_enabled(char *path, int *mode)
 	return ret;
 }
 
+static int sysfs_set_enabled(char *path, int mode)
+{
+	char command[SYSFS_PATH_MAX + 10];
+
+	char yes_no = (char)(mode + '0');
+
+	sprintf(command, "echo -n %c > %s", yes_no, path);
+
+	return system(command);
+}
+
 int powercap_get_enabled(int *mode)
 {
 	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
@@ -77,12 +88,11 @@ int powercap_get_enabled(int *mode)
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
@@ -180,8 +190,17 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
 
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


