Return-Path: <linux-pm+bounces-28240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23CAD13B6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB883AA989
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3011D88D0;
	Sun,  8 Jun 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBIqh73I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DC1D88A6
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406742; cv=none; b=aIoqf47TpvmORGwT3dSWMM6r8UzdMGb/WTG2io2bEIb60ZmhspU2UJ3S+CBNohAKk9p6/U6LmUhFvoU7XNkgnpDUu8QqUMLsYiyrlrCTTaknVd5YxNLvYwpvONjgXqjVq9ywKxYgW+4VPK7Nv8WX1v5ce6RMDNswzamKFm86ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406742; c=relaxed/simple;
	bh=QAIxMj8ojrlyDk5AX0Kepv7ZP8/D1pujkATCf1Eij14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qln3nl8c+2gjTVClfMVLQYD3elLDiNJGo6Kq3kdn52dhE6nHqG46eQisCV8eZaWLJVNdEaKUFoOn9WReZBAArCcdDUeK2FNqRn0ll4/LZbKH2ohN0ZaY44jNO2ZljiNkCjgTOySCfJ+gwz8B61Izpz8WmgUaz2p+HkZtdxwvjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBIqh73I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13086C4CEEE;
	Sun,  8 Jun 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406742;
	bh=QAIxMj8ojrlyDk5AX0Kepv7ZP8/D1pujkATCf1Eij14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=pBIqh73I/K30+zEKPB8+eK1uKdhBcvWJCdC8TL9Iz3S7GB3coXNa7Hvw1b1Xdm9bh
	 IbaP/MVYwK+/1LkZkvwsaBD/fu6RwYp4JNxnq14mhQB3JISWZzCK5FkR9hK8axkKrm
	 CnQH9nsS6duJiNqo8GpR75oRpZCRpeSnqdFWwF5tXX2yGDAIZwJKfkEd6iFCxShbXj
	 nwoDVJ+ES6SHOG9NjNiMXz/LOMYmxLBOHg6ACwwxPfnfKArdTyrKmcPVq/sSeHzXgC
	 oSXlUJfF895JBuxh54Q7yJ81hO4Tzn+oe1XdKUSAQ/Nt3yAwBs72Hs2K2ZbB4Xa0Lv
	 2o9MtlB4R64Hw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 15/18] tools/power turbostat: Dump RAPL sysfs info
Date: Sun,  8 Jun 2025 14:17:14 -0400
Message-ID: <b89e11521f93aad942785557e6645a79c24f3b96.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

for example:

intel-rapl:1: psys 28.0s:100W 976.0us:100W
intel-rapl:0: package-0 28.0s:57W,max:15W 2.4ms:57W
intel-rapl:0/intel-rapl:0:0: core disabled
intel-rapl:0/intel-rapl:0:1: uncore disabled
intel-rapl-mmio:0: package-0 28.0s:28W,max:15W 2.4ms:57W

[lenb: simplified format]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

squish me

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 156 ++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8deb6a23c7dd..30faa214676f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7404,6 +7404,160 @@ void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 	return;
 }
 
+static int fread_int(char *path, int *val)
+{
+	FILE *filep;
+	int ret;
+
+	filep = fopen (path, "r");
+	if (!filep)
+		return -1;
+
+	ret = fscanf(filep, "%d", val);
+	fclose(filep);
+	return ret;
+}
+
+static int fread_ull(char *path, unsigned long long *val)
+{
+	FILE *filep;
+	int ret;
+
+	filep = fopen (path, "r");
+	if (!filep)
+		return -1;
+
+	ret = fscanf(filep, "%llu", val);
+	fclose(filep);
+	return ret;
+}
+
+static int fread_str(char *path, char *buf, int size)
+{
+	FILE *filep;
+	int ret;
+	char *cp;
+
+	filep = fopen (path, "r");
+	if (!filep)
+		return -1;
+
+	ret = fread(buf, 1, size, filep);
+	fclose(filep);
+
+	/* replace '\n' with '\0' */
+	cp = strchr(buf, '\n');
+	if (cp != NULL)
+		*cp = '\0';
+
+	return ret;
+}
+
+#define PATH_RAPL_SYSFS	"/sys/class/powercap"
+
+static int dump_one_domain(char *domain_path)
+{
+	char path[PATH_MAX];
+	char str[PATH_MAX];
+	unsigned long long val;
+	int constraint;
+	int enable;
+	int ret;
+
+	snprintf(path, PATH_MAX, "%s/name", domain_path);
+	ret = fread_str(path, str, PATH_MAX);
+	if (ret <= 0)
+		return -1;
+
+	fprintf(outf, "%s: %s", domain_path + strlen(PATH_RAPL_SYSFS) + 1, str);
+
+	snprintf(path, PATH_MAX, "%s/enabled", domain_path);
+	ret = fread_int(path, &enable);
+	if (ret <= 0)
+		return -1;
+
+	if (!enable) {
+		fputs(" disabled\n", outf);
+		return 0;
+	}
+
+	for (constraint = 0;; constraint++)
+	{
+		snprintf(path, PATH_MAX, "%s/constraint_%d_time_window_us", domain_path, constraint);
+		ret = fread_ull(path, &val);
+		if (ret <= 0)
+			break;
+
+		if (val > 1000000)
+			fprintf(outf, " %0.1fs", (double)val/1000000);
+		else if (val > 1000)
+			fprintf(outf, " %0.1fms", (double)val/1000);
+		else
+			fprintf(outf, " %0.1fus", (double)val);
+
+		snprintf(path, PATH_MAX, "%s/constraint_%d_power_limit_uw", domain_path, constraint);
+		ret = fread_ull(path, &val);
+		if (ret > 0 && val)
+			fprintf(outf, ":%lluW", val / 1000000);
+
+		snprintf(path, PATH_MAX, "%s/constraint_%d_max_power_uw", domain_path, constraint);
+		ret = fread_ull(path, &val);
+		if (ret > 0 && val)
+			fprintf(outf, ",max:%lluW", val / 1000000);
+	}
+	fputc('\n', outf);
+
+	return 0;
+}
+
+static int print_rapl_sysfs(void)
+{
+	DIR *dir, *cdir;
+	struct dirent *entry, *centry;
+	char path[PATH_MAX];
+	char str[PATH_MAX];
+
+	if ((dir = opendir(PATH_RAPL_SYSFS)) == NULL) {
+		warn("open %s failed", PATH_RAPL_SYSFS);
+		return 1;
+	}
+
+	while ((entry = readdir (dir)) != NULL) {
+		if (strlen(entry->d_name) > 100)
+                        continue;
+
+		if (strncmp(entry->d_name, "intel-rapl", strlen("intel-rapl")))
+                        continue;
+
+		snprintf(path, PATH_MAX, "%s/%s/name", PATH_RAPL_SYSFS, entry->d_name);
+
+		/* Parse top level domains first, including package and psys */
+		fread_str(path, str, PATH_MAX);
+		if (strncmp(str, "package", strlen("package")) &&
+		    strncmp(str, "psys", strlen("psys")))
+			continue;
+
+		snprintf(path, PATH_MAX, "%s/%s", PATH_RAPL_SYSFS, entry->d_name);
+		if ((cdir = opendir(path)) == NULL) {
+			perror ("opendir() error");
+			return 1;
+		}
+
+		dump_one_domain(path);
+
+		while ((centry = readdir (cdir)) != NULL) {
+			if (strncmp(centry->d_name, "intel-rapl", strlen("intel-rapl")))
+				continue;
+			snprintf(path, PATH_MAX, "%s/%s/%s", PATH_RAPL_SYSFS, entry->d_name, centry->d_name);
+			dump_one_domain(path);
+		}
+		closedir(cdir);
+	}
+
+	closedir(dir);
+	return 0;
+}
+
 int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	unsigned long long msr;
@@ -7538,6 +7692,8 @@ void probe_rapl(void)
 	if (quiet)
 		return;
 
+	print_rapl_sysfs();
+
 	if (!platform->rapl_msrs || no_msr)
 		return;
 
-- 
2.45.2


