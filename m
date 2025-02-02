Return-Path: <linux-pm+bounces-21241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF7A24F28
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C0162EC5
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D421FBC87;
	Sun,  2 Feb 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL06eiIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AD1D7E57
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516402; cv=none; b=HU0W76KbJOnOu47ZH3yMwGRRJhgL3aEOsfHjsDesfaTZzs+3+RsMIY/oTm0uW1kr/IB4u8A7HFnuUPsN+idU3ZngM7E2iQsf+D5fnrchSgNG+xFS+eUst8v6aFTdCB4rwx/vP/X2nmGeQsB8aTb1WzTkTLLmahymcaWsxvxIdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516402; c=relaxed/simple;
	bh=7awYaxrnmNyDutDWYIlYHhVNIQYf7BAxMHJzD19aLDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnnmIlWSZKqfD3m+MILarls1PibdGFH7GS6lr3YNVGDgnsUyIbKikaTdHOjobSGMFNT/GkyYvHnW7OoU48t31M7FaArgayN27a5X50Y4fgmKIks3/i7n56WBU4hXrEmZSQeUSDDg87ZHbU7HkgXtwEx1OJktjZyI/JyNreoTrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL06eiIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A01BC4CEE0;
	Sun,  2 Feb 2025 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516402;
	bh=7awYaxrnmNyDutDWYIlYHhVNIQYf7BAxMHJzD19aLDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=eL06eiIHBEYv76IE1XoSPVsuSrvetiPwSqcJMuhruzVAdvJ+hVPwvnHC0u9UhFtJR
	 D3m2ivfpr2z8GZomZ/cyLDoOV8MmJLhHpJBvkaYtWBuDoBPEw0Go71Tve45K3ALAyD
	 ctCEBXqfSUBEb28aTw+83Um4R5BqIGiORVtptjsC+62wQDH8MeP/gjSB/oROBiacIN
	 QcvDZ5HQuKY+N5FsVvwGJZepdy66FR3yPVtkpNlMBGqWtRedGamYL5nkF8mm6Gs10c
	 mgL0HEJAdHzgnMX2YlwEGB9cGbgg67i37PJOb9Kcz0x9WV7ze8P62wVMU4AKUgXosD
	 6Jeks/W2zhzLw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 18/25] tools/power turbostat: Allow mapping multiple PMT files with the same GUID
Date: Sun,  2 Feb 2025 11:09:34 -0600
Message-ID: <16ce467875ef8572b82f9af30fcf7b2f65fc2e95.1738515889.git.len.brown@intel.com>
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

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Some platforms may expose multiple telemetry files identified with the
same GUID. Interpreting it correctly, to associate given counter with a
CPU, core or a package requires more metadata from the user.

Parse and create  ordered, linked list of those PMT aggregators, so that
we can identify specific aggregator with GUID + sequence number.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 75 ++++++++++++++-------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6104d5bcca5c..f76e1de3f968 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9033,46 +9033,35 @@ int parse_telem_info_file(int fd_dir, const char *info_filename, const char *for
 
 struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 {
-	DIR *dirp;
-	struct dirent *entry;
+	struct pmt_diriter_t pmt_iter;
+	const struct dirent *entry;
 	struct stat st;
-	unsigned int telem_idx;
 	int fd_telem_dir, fd_pmt;
 	unsigned long guid, size, offset;
 	size_t mmap_size;
 	void *mmio;
-	struct pmt_mmio *ret = NULL;
+	struct pmt_mmio *head = NULL, *last = NULL;
+	struct pmt_mmio *new_pmt = NULL;
 
 	if (stat(SYSFS_TELEM_PATH, &st) == -1)
 		return NULL;
 
-	dirp = opendir(SYSFS_TELEM_PATH);
-	if (dirp == NULL)
+	pmt_diriter_init(&pmt_iter);
+	entry = pmt_diriter_begin(&pmt_iter, SYSFS_TELEM_PATH);
+	if (!entry) {
+		pmt_diriter_remove(&pmt_iter);
 		return NULL;
+	}
 
-	for (;;) {
-		entry = readdir(dirp);
-
-		if (entry == NULL)
-			break;
-
-		if (strcmp(entry->d_name, ".") == 0)
-			continue;
-
-		if (strcmp(entry->d_name, "..") == 0)
-			continue;
-
-		if (sscanf(entry->d_name, "telem%u", &telem_idx) != 1)
-			continue;
-
-		if (fstatat(dirfd(dirp), entry->d_name, &st, 0) == -1) {
+	for (;entry != NULL; entry = pmt_diriter_next(&pmt_iter)) {
+		if (fstatat(dirfd(pmt_iter.dir), entry->d_name, &st, 0) == -1) {
 			break;
 		}
 
 		if (!S_ISDIR(st.st_mode))
 			continue;
 
-		fd_telem_dir = openat(dirfd(dirp), entry->d_name, O_RDONLY);
+		fd_telem_dir = openat(dirfd(pmt_iter.dir), entry->d_name, O_RDONLY);
 		if (fd_telem_dir == -1) {
 			break;
 		}
@@ -9106,35 +9095,51 @@ struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 		mmap_size = ROUND_UP_TO_PAGE_SIZE(size);
 		mmio = mmap(0, mmap_size, PROT_READ, MAP_SHARED, fd_pmt, 0);
 		if (mmio != MAP_FAILED) {
-
 			if (debug)
 				fprintf(stderr, "%s: 0x%lx mmaped at: %p\n", __func__, guid, mmio);
 
-			ret = calloc(1, sizeof(*ret));
+			new_pmt = calloc(1, sizeof(*new_pmt));
 
-			if (!ret) {
+			if (!new_pmt) {
 				fprintf(stderr, "%s: Failed to allocate pmt_mmio\n", __func__);
 				exit(1);
 			}
 
-			ret->guid = guid;
-			ret->mmio_base = mmio;
-			ret->pmt_offset = offset;
-			ret->size = size;
+			/*
+			 * Create linked list of mmaped regions,
+			 * but preserve the ordering from sysfs.
+			 * Ordering is important for the user to
+			 * use the seq=%u parameter when adding a counter.
+			 */
+			new_pmt->guid = guid;
+			new_pmt->mmio_base = mmio;
+			new_pmt->pmt_offset = offset;
+			new_pmt->size = size;
+			new_pmt->next = pmt_mmios;
+
+			if (last)
+				last->next = new_pmt;
+			else
+				head = new_pmt;
 
-			ret->next = pmt_mmios;
-			pmt_mmios = ret;
+			last = new_pmt;
 		}
 
 loop_cleanup_and_break:
 		close(fd_pmt);
 		close(fd_telem_dir);
-		break;
 	}
 
-	closedir(dirp);
+	pmt_diriter_remove(&pmt_iter);
 
-	return ret;
+	/*
+	 * If we found something, stick just
+	 * created linked list to the front.
+	 */
+	if (head)
+		pmt_mmios = head;
+
+	return head;
 }
 
 struct pmt_mmio *pmt_mmio_find(unsigned int guid)
-- 
2.43.0


