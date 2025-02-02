Return-Path: <linux-pm+bounces-21242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79005A24F29
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01566163996
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B11FBC83;
	Sun,  2 Feb 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwmpvXsv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A31FAC58
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516404; cv=none; b=m914rgal/totkY7c0TE12AffuqWVVhZhnyK1IFOuuR2Y2QVZNCZ93pD+8hyTv0vU7A8RB0vlglZJp4AkIZYw3DBNPMHnl2FRNTEg+52k5UQF4TLLqngIzGSpxc7MC5DjcoTvP0L8WUa7/5GxfkK3kDg/lZO2NkFTZA7Fz6YNQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516404; c=relaxed/simple;
	bh=ZbFypzkJdExdN3+OlsfxgzJeLkCZaTY5FmSg9vTVA5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOxJ6IL45W8nfU6QJemTylsxf4iZ8TFHJ75ejyItFgfxlZ1rLPE70otn6rYfUnMEn9g5LAfRbQQxL3CgKmqhVzMR2huPYnKdot3dG+3ZS11wIABy2sGR3S2txAesp3DkpVCFInJXM8K5QImG+wUBtdTN0KXDFvSSnu835k9TZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwmpvXsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3B6C4CED1;
	Sun,  2 Feb 2025 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516403;
	bh=ZbFypzkJdExdN3+OlsfxgzJeLkCZaTY5FmSg9vTVA5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=uwmpvXsvr2x9utu9U7fFUYdNKdh/mxBsfLGgs65w9hxP4C43fxyJOhXwpcojCqkZz
	 7+4gEAl/w+HQ95hHM+TRXxjWxyBx6mGOmFjyna1gDjiC8vhfpolJOw1e2GsW61v2+B
	 +aR20dVUrxpdPI/twZZi0q+JSiU9Y3qXYbJPItmrL/UO38nJrIv3vCKkQK+OhN7qOk
	 9HYhOa+rnn+F35UeYm7fcSZ7Y3JMk++ixYTIz7Jnb/svl8srgv8eFee3RM7aFHrwjQ
	 dxGDIB4PWqXiNHh+Ylq2nH2VbxxiCCWt9/IuDYH6AxXmk8+/TvclujME81kjd7uJC5
	 gYxzkGgFiP/xw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 19/25] tools/power turbostat: Allow adding PMT counters directly by sysfs path
Date: Sun,  2 Feb 2025 11:09:35 -0600
Message-ID: <83fbeb9f9776cd044d36af606127f56206337bab.1738515889.git.len.brown@intel.com>
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

Allow user to add PMT counters by either identifying the source with:
  guid=%u,seq=%u
or, since this patch, with direct sysfs path:
  path=%s, for example path=/sys/class/intel_pmt/telem5

In the later case, the guid and sequence number will be infered
by turbostat.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 107 +++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f76e1de3f968..0f2475fa9fa4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9788,11 +9788,96 @@ bool starts_with(const char *str, const char *prefix)
 	return strncmp(prefix, str, strlen(prefix)) == 0;
 }
 
+int pmt_parse_from_path(const char *target_path, unsigned int *out_guid, unsigned int *out_seq)
+{
+	struct pmt_diriter_t pmt_iter;
+	const struct dirent *dirname;
+	struct stat stat, target_stat;
+	int fd_telem_dir = -1;
+	int fd_target_dir;
+	unsigned int seq = 0;
+	unsigned long guid, target_guid;
+	int ret = -1;
+
+	fd_target_dir = open(target_path, O_RDONLY | O_DIRECTORY);
+	if (fd_target_dir == -1) {
+		return -1;
+	}
+
+	if (fstat(fd_target_dir, &target_stat) == -1) {
+		fprintf(stderr, "%s: Failed to stat the target: %s", __func__, strerror(errno));
+		exit(1);
+	}
+
+	if (parse_telem_info_file(fd_target_dir, "guid", "%lx", &target_guid)) {
+		fprintf(stderr, "%s: Failed to parse the target guid file: %s", __func__, strerror(errno));
+		exit(1);
+	}
+
+	close(fd_target_dir);
+
+	pmt_diriter_init(&pmt_iter);
+
+	for (dirname = pmt_diriter_begin(&pmt_iter, SYSFS_TELEM_PATH); dirname != NULL;
+	     dirname = pmt_diriter_next(&pmt_iter)) {
+
+		fd_telem_dir = openat(dirfd(pmt_iter.dir), dirname->d_name, O_RDONLY | O_DIRECTORY);
+		if (fd_telem_dir == -1) {
+			continue;
+		}
+
+		if (parse_telem_info_file(fd_telem_dir, "guid", "%lx", &guid)) {
+			fprintf(stderr, "%s: Failed to parse the guid file: %s", __func__, strerror(errno));
+			continue;
+		}
+
+		if (fstat(fd_telem_dir, &stat) == -1) {
+			fprintf(stderr, "%s: Failed to stat %s directory: %s", __func__,
+				dirname->d_name, strerror(errno));
+			continue;
+		}
+
+		/*
+		 * If reached the same directory as target, exit the loop.
+		 * Seq has the correct value now.
+		 */
+		if (stat.st_dev == target_stat.st_dev && stat.st_ino == target_stat.st_ino) {
+			ret = 0;
+			break;
+		}
+
+		/*
+		 * If reached directory with the same guid,
+		 * but it's not the target directory yet,
+		 * increment seq and continue the search.
+		 */
+		if (guid == target_guid)
+			++seq;
+
+		close(fd_telem_dir);
+		fd_telem_dir = -1;
+	}
+
+	pmt_diriter_remove(&pmt_iter);
+
+	if (fd_telem_dir != -1)
+		close(fd_telem_dir);
+
+	if (!ret) {
+		*out_guid = target_guid;
+		*out_seq = seq;
+	}
+
+	return ret;
+}
+
 void parse_add_command_pmt(char *add_command)
 {
 	char *name = NULL;
 	char *type_name = NULL;
 	char *format_name = NULL;
+	char *direct_path = NULL;
+	static const char direct_path_prefix[] = "path=";
 	unsigned int offset;
 	unsigned int lsb;
 	unsigned int msb;
@@ -9881,6 +9966,10 @@ void parse_add_command_pmt(char *add_command)
 			goto next;
 		}
 
+		if (strncmp(add_command, direct_path_prefix, strlen(direct_path_prefix)) == 0) {
+			direct_path = add_command + strlen(direct_path_prefix);
+			goto next;
+		}
 next:
 		add_command = strchr(add_command, ',');
 		if (add_command) {
@@ -9952,8 +10041,24 @@ void parse_add_command_pmt(char *add_command)
 		exit(1);
 	}
 
+	if (direct_path && has_guid) {
+		printf("%s: path and guid+seq parameters are mutually exclusive\n"
+		       "notice: passed guid=0x%x and path=%s\n", __func__, guid, direct_path);
+		exit(1);
+	}
+
+	if (direct_path) {
+		if (pmt_parse_from_path(direct_path, &guid, &seq)) {
+			printf("%s: failed to parse PMT file from %s\n", __func__, direct_path);
+			exit(1);
+		}
+
+		/* GUID was just infered from the direct path. */
+		has_guid = true;
+	}
+
 	if (!has_guid) {
-		printf("%s: missing %s\n", __func__, "guid");
+		printf("%s: missing %s\n", __func__, "guid or path");
 		exit(1);
 	}
 
-- 
2.43.0


