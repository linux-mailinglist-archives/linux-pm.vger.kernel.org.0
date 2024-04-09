Return-Path: <linux-pm+bounces-6077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F789CF60
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664211F24838
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59217D2;
	Tue,  9 Apr 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Mquohk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5C63C
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622710; cv=none; b=ZDuBOqzJn0uDAg/ruAhLUj55hqeRhmJgQEOmLb98YoBdbJCzq9RcGq2lqOsgNlND/4FxvBma1XN6TgnZGFA8SSyOxyc8np8Y/HWX0qRdowBC/dCzM9ZYdf9dwO3ZcQ1CeHQxlW+WMBbgmHdgTYy+Xv6K8RZVkql12i8n7FsOQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622710; c=relaxed/simple;
	bh=Hqb6v0Nf26+ktX7CnD4+gC1D0WT5ZWvKlEPBndQ6+FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaABlUuV+SWjiiD63yCO3XEnthX0xGWG8IQ2hj4PHywdrKR/UpHXwmZMbuOkHJpo2PhYCgo13qz7jFYSeMIemXH7PeZbNit2R/T1Jsdd+mds9egKby9+oCXo4ma+lULXhPg0/7k1k5vZ5t3vGK5QOvXPCouzsbCs0LWu9Ybxc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5Mquohk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de0f9a501d6so1611421276.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622707; x=1713227507; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KszsjJ3Jy3kYUzKrg7dckRUPQ1eROABoRzz9QTjkRA=;
        b=K5MquohkW+3Fe1uuECEdTP/bLspleS0n6Qt9QmzEtmXkoN6kx8H7vveF1voowHudpj
         /Sg6GhQSUyAQdXLnIW55TnTjxuKU0T1mxYFLSADLixhpyFPkTD3cbPX25rnAY9RNoOYf
         4PpvyMCv7AGEhg0m000aE06RhL7cRw9NDYMuqzTAkUYf6ngrrXQiDbJjfWy7bg/mk7+G
         qpSkLijRjVoI/0LI6aiaGJFRy717fVDeqe8CQgMR5fgTRNWQ2fm4J6jWEki8v97Wns+F
         QIvnKO1eKTrr18td/OSCXCAuxxo/h7khjgCXmADDA9ZZrCn2WAlLsYzrw2JC4nH2tnVr
         Zleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622707; x=1713227507;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KszsjJ3Jy3kYUzKrg7dckRUPQ1eROABoRzz9QTjkRA=;
        b=WsR8B6CkCLkz2XWAI3JYX3hIYNeLEqwnrgFBE26Sn7WS70ZqU8MsHPYQNX1/Oma5jR
         ThS7ZdJ4R2SnTk7cyqZzsI0XahOSe+9k9AR97OMqroK8/9iD4pPF4A/VSILOh5ag+iMe
         Q6/fpOa0MGYoFzH8DtBvNWQJdmtUj51h9p7zhRMOVjpAwiSQ3E12aKnmdSVbYLplkGbX
         +T/B7+GUZTk2q6fe4rTdhOEjon1H4n//vLF1DvkFZOHppwjYFRw4Arq2k8eIgX4mlVpp
         i1hR0YSSOFKyAbCXZUSjpQ9+Db0dmCiSV+HwPaMvPbsl5apXSS6tYGpxdDluXURQFxo4
         ZX5Q==
X-Gm-Message-State: AOJu0YwZnLVgB9mBjVJRk1E6ocuu5Un4obp4IEi7SfDRkEchw2q75R1Q
	vgBxfy/q+fobhje01WNe/ikDXvuY4Agt0M3eubWc8QkPtqEZbLNYY2zDKmGf
X-Google-Smtp-Source: AGHT+IGEW7abeVkJb4Xf9DPD0NMTiMrSJlxb8RfQu9U/tsDKIyfw2CyLQKgTiA1BskspZs68fjMZBA==
X-Received: by 2002:a25:97c9:0:b0:dd1:44c1:350e with SMTP id j9-20020a2597c9000000b00dd144c1350emr8258764ybo.34.1712622707391;
        Mon, 08 Apr 2024 17:31:47 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:47 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/26] tools/power turbostat: Expand probe_intel_uncore_frequency()
Date: Mon,  8 Apr 2024 20:30:59 -0400
Message-Id: <bb6181fa6bc942aac3f7f2fa8e3831952a2ef118.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Print current frequency along with the current (and initial) limits

Probe and print uncore config also for machines using the new cluster API

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 84 ++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c23703dd54aa..bbd2e0edadfa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4581,20 +4581,15 @@ static void dump_sysfs_file(char *path)
 static void probe_intel_uncore_frequency(void)
 {
 	int i, j;
-	char path[128];
+	char path[256];
 
 	if (!genuine_intel)
 		return;
 
-	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00", R_OK))
-		return;
-
-	/* Cluster level sysfs not supported yet. */
-	if (!access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00", R_OK))
-		return;
+	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
+		goto probe_cluster;
 
-	if (!access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
-		BIC_PRESENT(BIC_UNCORE_MHZ);
+	BIC_PRESENT(BIC_UNCORE_MHZ);
 
 	if (quiet)
 		return;
@@ -4602,26 +4597,73 @@ static void probe_intel_uncore_frequency(void)
 	for (i = 0; i < topo.num_packages; ++i) {
 		for (j = 0; j < topo.num_die; ++j) {
 			int k, l;
+			char path_base[128];
+
+			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d", i,
+				j);
 
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/min_freq_khz",
-				i, j);
+			sprintf(path, "%s/min_freq_khz", path_base);
 			k = read_sysfs_int(path);
-			sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/max_freq_khz",
-				i, j);
+			sprintf(path, "%s/max_freq_khz", path_base);
 			l = read_sysfs_int(path);
-			fprintf(outf, "Uncore Frequency pkg%d die%d: %d - %d MHz ", i, j, k / 1000, l / 1000);
+			fprintf(outf, "Uncore Frequency package%d die%d: %d - %d MHz ", i, j, k / 1000, l / 1000);
 
-			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_min_freq_khz",
-				i, j);
+			sprintf(path, "%s/initial_min_freq_khz", path_base);
 			k = read_sysfs_int(path);
-			sprintf(path,
-				"/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/initial_max_freq_khz",
-				i, j);
+			sprintf(path, "%s/initial_max_freq_khz", path_base);
 			l = read_sysfs_int(path);
-			fprintf(outf, "(%d - %d MHz)\n", k / 1000, l / 1000);
+			fprintf(outf, "(%d - %d MHz)", k / 1000, l / 1000);
+
+			sprintf(path, "%s/current_freq_khz", path_base);
+			k = read_sysfs_int(path);
+			fprintf(outf, " %d MHz\n", k / 1000);
 		}
 	}
+	return;
+
+probe_cluster:
+	if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00/current_freq_khz", R_OK))
+		return;
+
+	if (quiet)
+		return;
+
+	for (i = 0;; ++i) {
+		int k, l;
+		char path_base[128];
+		int package_id, domain_id, cluster_id;
+
+		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
+
+		if (access(path_base, R_OK))
+			break;
+
+		sprintf(path, "%s/package_id", path_base);
+		package_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/domain_id", path_base);
+		domain_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/fabric_cluster_id", path_base);
+		cluster_id = read_sysfs_int(path);
+
+		sprintf(path, "%s/min_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		sprintf(path, "%s/max_freq_khz", path_base);
+		l = read_sysfs_int(path);
+		fprintf(outf, "Uncore Frequency package%d domain%d cluster%d: %d - %d MHz ", package_id, domain_id,
+			cluster_id, k / 1000, l / 1000);
+
+		sprintf(path, "%s/initial_min_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		sprintf(path, "%s/initial_max_freq_khz", path_base);
+		l = read_sysfs_int(path);
+		fprintf(outf, "(%d - %d MHz)", k / 1000, l / 1000);
+
+		sprintf(path, "%s/current_freq_khz", path_base);
+		k = read_sysfs_int(path);
+		fprintf(outf, " %d MHz\n", k / 1000);
+	}
 }
 
 static void probe_graphics(void)
-- 
2.40.1


