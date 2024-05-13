Return-Path: <linux-pm+bounces-7777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF18C47BA
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E135D1C22F2E
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4B2768FD;
	Mon, 13 May 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFiClpmg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69B7711B
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629277; cv=none; b=Bz9rwRJJ02opwykAsrZluTHKun9ePpvw5UIT/O/HW1zI2pjO/yJ4NJI+jcVSkquz/S2nosU3q+vdVvyU7jAv94amCQljXBCcxX3uCqCWYGl+VpRpxFO5zN2RmlrDmOtwnlk37bZcd5ltAl0xTYsD2hirBxHAFvEeHE2spfRx57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629277; c=relaxed/simple;
	bh=tICB1a6yoMaZjjWYnMiKz3/dUEkcFHk9eQpbKQjLSaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGEcpvIFJedBooV3Pb19Q2rmoMnXHDj63R0IkzR5oKXLr4LiR9axLJJMSmtdqZzsv972wCsRY7lpkApa6+d1SRiwPOu6cJlag1g/OCwB2Mp+u2sNKM/SVBDRgveG0ELC0bKdIKHL773rMMp4ZCKvUvenn//PmCrq6wKT9gQj5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFiClpmg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61be4b9869dso50257337b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629275; x=1716234075; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKDCqc+3dXe7BFLwvwxIIv/nY+QKrXSFHWRmQ6LsmtU=;
        b=DFiClpmgC+5HJREV0PyznZtH7P2vadnx9lTrFL8LM7xCXbgFmuUS+1TG900KcQOozQ
         18YTwASR4BpLX8STJ+IsHPF57yelxaf5jyQrZGYkV5L3rfXYU1PE5/n9/OJmbdRE1w9J
         mzMmkXFSBt8IkuwFyUJspSTkrH0NiKg1arF1LH6jNdaKRNCZPLh3lvTpwdGUhInCtCaN
         FlTgQ7rNnhBJHBflGGSRF7KBREHajJDUEmznJnTuooAxpbMicDwPatjH3rGQXlCsodus
         HwQNGx5fqklchAknajnEt3uSvK1419C8EGmBgvXRHPPESYmCUfebWiOn7MA3HWwxoOVZ
         FpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629275; x=1716234075;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKDCqc+3dXe7BFLwvwxIIv/nY+QKrXSFHWRmQ6LsmtU=;
        b=A70vnCFBEXbjFy0yZap7vs0u5ZGAdgO7RAUgkpYqdFtKqCWxLGEmkmBdEO1vr5+8KP
         sU2/ke2iKicKkfg4k1x8v+uiM8F9Kvv5pZTEpGGJAPmU3yTq4x99NcZz27rmr4e08US/
         AJcrF6N8I+h7yJwGVa4sZ6bKj/pggsYDzIQdL43cGIrYjT3zzSoR5uIPCPLD5S1QGNo2
         t3jT4l6IkgxRC2jSqPvNZ04TrPYxfcBZJfaEW+ffrpRM5Y5sw85jyjxXqN5LyZuHbaAU
         SRU6yycTjPnZcbtPcdzHc5l1Uk+q/zF3rAbUfcyGHTyMx7L8Xo2iux21GS3mk1AAyRQn
         Wsmw==
X-Gm-Message-State: AOJu0Yz0nhKYIre1RwKUAAL0EjHe7JyNPXi/ou/fvp+0c7X2+TzReYbb
	H7DcIgGYmKm07OyrpozTiaf9AsEEDG5lkvZZv3p2/QVh1X4P38BPa5cWTQ==
X-Google-Smtp-Source: AGHT+IGN18sLkJCPtVSA9gVgnDNWUFEYEDZIip1jAVL8sgSmpMLmGtYMXGPjwqy3y8UWtZsy3Ao+nw==
X-Received: by 2002:a05:690c:fd5:b0:614:2b54:16f3 with SMTP id 00721157ae682-622affc3428mr125912787b3.25.1715629275063;
        Mon, 13 May 2024 12:41:15 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:14 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/15] tools/power turbostat: Enable non-privileged users to read sysfs counters
Date: Mon, 13 May 2024 15:40:44 -0400
Message-Id: <0e39702fbbcdb16ad349439065d24a3bb5e2f331.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

A group of counters called "sysfs" displays software
C-state request counts and resulting perceived C-state residency.

They are not built-in counters that turbostat knows about ahead of time,
rather they are discovered in sysfs when turbostat starts.

Thus, they are added dynamically, using the same interface
as user-added MSR counters.

When turbostat enters "no-msr" mode, such as when running as a
non-privileged user, it clears all added counters.

Updating that to clear only actual MSR added counters
allows regular users to see the sysfs counters.

[lenb: commit message]

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 56 +++++++++++++++------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd6cb31b7099..f92b46cfda31 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1377,36 +1377,42 @@ struct sys_counters {
 	struct msr_counter *pp;
 } sys;
 
-void free_sys_counters(void)
+static size_t free_msr_counters_(struct msr_counter **pp)
 {
-	struct msr_counter *p = sys.tp, *pnext = NULL;
+	struct msr_counter *p = NULL;
+	size_t num_freed = 0;
 
-	while (p) {
-		pnext = p->next;
-		free(p);
-		p = pnext;
-	}
+	while (*pp) {
+		p = *pp;
 
-	p = sys.cp, pnext = NULL;
-	while (p) {
-		pnext = p->next;
-		free(p);
-		p = pnext;
-	}
+		if (p->msr_num != 0) {
+			*pp = p->next;
 
-	p = sys.pp, pnext = NULL;
-	while (p) {
-		pnext = p->next;
-		free(p);
-		p = pnext;
+			free(p);
+			++num_freed;
+
+			continue;
+		}
+
+		pp = &p->next;
 	}
 
-	sys.added_thread_counters = 0;
-	sys.added_core_counters = 0;
-	sys.added_package_counters = 0;
-	sys.tp = NULL;
-	sys.cp = NULL;
-	sys.pp = NULL;
+	return num_freed;
+}
+
+/*
+ * Free all added counters accessed via msr.
+ */
+static void free_sys_msr_counters(void)
+{
+	/* Thread counters */
+	sys.added_thread_counters -= free_msr_counters_(&sys.tp);
+
+	/* Core counters */
+	sys.added_core_counters -= free_msr_counters_(&sys.cp);
+
+	/* Package counters */
+	sys.added_package_counters -= free_msr_counters_(&sys.pp);
 }
 
 struct system_summary {
@@ -1566,7 +1572,7 @@ static void bic_disable_msr_access(void)
 
 	bic_enabled &= ~bic_msrs;
 
-	free_sys_counters();
+	free_sys_msr_counters();
 }
 
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
-- 
2.40.1


