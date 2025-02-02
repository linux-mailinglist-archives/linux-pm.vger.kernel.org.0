Return-Path: <linux-pm+bounces-21243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BDA24F2A
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E079D3A50FE
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EE1FBC92;
	Sun,  2 Feb 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiX+5PeO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5D1FAC4F
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516405; cv=none; b=HWCMj3QToIMc0Ue+ZYF+ldLVnySooiEKt260s4D8lM+gO6sYgfP08CtxKmEsJzk5kK81642Iv7GEjFIl8eLEo+LkMLLXSA2B5vYLEQXneBycoajYDBm1PDsLbBsYavK6ojCIpDKLE4X8eayt9bQ9lqAUF4h7P1zKqZuCCiSpLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516405; c=relaxed/simple;
	bh=wsNj9PAo1zn3Ck0hs9H6JliXkRo4YJy0nPzSBTGnMCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiuxFhjFlHvjFQqxKaTnJ8FblPRwJl+D8uOoFHl0/wMlakAmuIePKhYvhFmd2l2tM3uFSTO2v37FjDQhR5ozv2uwdbTyBRxBZLtl57V+jhJUfd4QFLa6gdw7MH3z52VW8/8mb1bA559zYkxiuToHeyI39BdIE4RlkMVOXgeu2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiX+5PeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415F7C4CEE1;
	Sun,  2 Feb 2025 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516405;
	bh=wsNj9PAo1zn3Ck0hs9H6JliXkRo4YJy0nPzSBTGnMCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=PiX+5PeOrUrMGywz/38ZMw/qffPM6RpYqmx1ib6QK3r/wRO3EmkD5V/+8Fd3uNH6R
	 6sLh95JTbk9OypLJjMQmXBUvus8jLF4MAwGb/gVm5dqbbRKfqDcJVA3ULdMNnDYnDC
	 v4eTEC7R5E3PT+fYk8tM68J4yaNJfN+/BTAUUI5BAGlwebrdW/pCbGageux8hv/+q0
	 j7EMX/ESbltQnxS4DcY3Uc+HPLhjHGRyFd/xu95SXw/OfSuK11gp/xrva+SzwClELm
	 tlzbqlxyEgIWHBpnP/M5pI3buxhvVDli9jYQ1F7p7rTiY9Af347hgF5fLKZOf4vCLC
	 Z5JIbD8iU7gWQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/25] tools/power turbostat: version 2025.01.14
Date: Sun,  2 Feb 2025 11:09:36 -0600
Message-ID: <a80e53472209b1c749e02e91ac62c053ac457099.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
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

Fix checkpatch whitespace issues since 2024.11.30

Summary of Changes since 2024.11.30:

	Enable SysWatt by default.

	Add initial PTL, CWF platform support.

	Refuse to run on unsupported platforms without --force
	to avoid not-so-useful measurements mistakenly made
	using obsolete versions.

	Harden initial PMT code in response to early use.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 36 ++++++++++++---------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0f2475fa9fa4..76d2632e60ac 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3,7 +3,7 @@
  * turbostat -- show CPU frequency and C-state residency
  * on modern Intel and AMD processors.
  *
- * Copyright (c) 2024 Intel Corporation.
+ * Copyright (c) 2025 Intel Corporation.
  * Len Brown <len.brown@intel.com>
  */
 
@@ -271,11 +271,11 @@ struct msr_counter bic[] = {
 #define	BIC_Sys_J		(1ULL << 60)
 #define	BIC_NMI			(1ULL << 61)
 
-#define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
-#define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
+#define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die)
+#define BIC_THERMAL_PWR (BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__ | BIC_SysWatt)
 #define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
 #define BIC_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
-#define BIC_OTHER ( BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
+#define BIC_OTHER (BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
 
@@ -1593,8 +1593,7 @@ struct pmt_counter {
  * PMT telemetry directory iterator.
  * Used to iterate telemetry files in sysfs in correct order.
  */
-struct pmt_diriter_t
-{
+struct pmt_diriter_t {
 	DIR *dir;
 	struct dirent **namelist;
 	unsigned int num_names;
@@ -1604,6 +1603,7 @@ struct pmt_diriter_t
 int pmt_telemdir_filter(const struct dirent *e)
 {
 	unsigned int dummy;
+
 	return sscanf(e->d_name, "telem%u", &dummy);
 }
 
@@ -1617,7 +1617,7 @@ int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
 	return aidx >= bidx;
 }
 
-const struct dirent* pmt_diriter_next(struct pmt_diriter_t *iter)
+const struct dirent *pmt_diriter_next(struct pmt_diriter_t *iter)
 {
 	const struct dirent *ret = NULL;
 
@@ -1633,7 +1633,7 @@ const struct dirent* pmt_diriter_next(struct pmt_diriter_t *iter)
 	return ret;
 }
 
-const struct dirent* pmt_diriter_begin(struct pmt_diriter_t *iter, const char *pmt_root_path)
+const struct dirent *pmt_diriter_begin(struct pmt_diriter_t *iter, const char *pmt_root_path)
 {
 	int num_names = iter->num_names;
 
@@ -2302,7 +2302,7 @@ void help(void)
 		"  -h, --help\n"
 		"		print this help message\n"
 		"  -v, --version\n"
-		"		print version information\n" "\n" "For more help, run \"man turbostat\"\n");
+		"		print version information\n\nFor more help, run \"man turbostat\"\n");
 }
 
 /*
@@ -9053,18 +9053,16 @@ struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 		return NULL;
 	}
 
-	for (;entry != NULL; entry = pmt_diriter_next(&pmt_iter)) {
-		if (fstatat(dirfd(pmt_iter.dir), entry->d_name, &st, 0) == -1) {
+	for ( ; entry != NULL; entry = pmt_diriter_next(&pmt_iter)) {
+		if (fstatat(dirfd(pmt_iter.dir), entry->d_name, &st, 0) == -1)
 			break;
-		}
 
 		if (!S_ISDIR(st.st_mode))
 			continue;
 
 		fd_telem_dir = openat(dirfd(pmt_iter.dir), entry->d_name, O_RDONLY);
-		if (fd_telem_dir == -1) {
+		if (fd_telem_dir == -1)
 			break;
-		}
 
 		if (parse_telem_info_file(fd_telem_dir, "guid", "%lx", &guid)) {
 			close(fd_telem_dir);
@@ -9425,7 +9423,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2024.11.30 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.01.14 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
@@ -9750,7 +9748,7 @@ void parse_add_command_msr(char *add_command)
 
 	}
 	if ((msr_num == 0) && (path == NULL) && (perf_device[0] == '\0' || perf_event[0] == '\0')) {
-		fprintf(stderr, "--add: (msrDDD | msr0xXXX | /path_to_counter | perf/device/event ) required\n");
+		fprintf(stderr, "--add: (msrDDD | msr0xXXX | /path_to_counter | perf/device/event) required\n");
 		fail++;
 	}
 
@@ -9822,9 +9820,8 @@ int pmt_parse_from_path(const char *target_path, unsigned int *out_guid, unsigne
 	     dirname = pmt_diriter_next(&pmt_iter)) {
 
 		fd_telem_dir = openat(dirfd(pmt_iter.dir), dirname->d_name, O_RDONLY | O_DIRECTORY);
-		if (fd_telem_dir == -1) {
+		if (fd_telem_dir == -1)
 			continue;
-		}
 
 		if (parse_telem_info_file(fd_telem_dir, "guid", "%lx", &guid)) {
 			fprintf(stderr, "%s: Failed to parse the guid file: %s", __func__, strerror(errno));
@@ -9962,9 +9959,8 @@ void parse_add_command_pmt(char *add_command)
 			goto next;
 		}
 
-		if (sscanf(add_command, "seq=%x", &seq) == 1) {
+		if (sscanf(add_command, "seq=%x", &seq) == 1)
 			goto next;
-		}
 
 		if (strncmp(add_command, direct_path_prefix, strlen(direct_path_prefix)) == 0) {
 			direct_path = add_command + strlen(direct_path_prefix);
-- 
2.43.0


