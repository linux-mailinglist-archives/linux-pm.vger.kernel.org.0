Return-Path: <linux-pm+bounces-21240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D04A24F27
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73057162EE9
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444AD1FBC8B;
	Sun,  2 Feb 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAJrW/Tw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042A1FAC52
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516401; cv=none; b=iLgNXWB6M+dZsTxV6tDF6zXBaj8m5QmMmVv1aTSEGR2I1HjSqRj0hHjQzIr3Bn5Ma+X/4TxvyN2PdSVymoIDiwGwy+eYMMaeXreErknfcbTE2Uk0ONlpJ/H8XIwGtMWd+GSVjyq5T8zdRZUPYPkrM1HzCbb8BfnpOfJcxET9I/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516401; c=relaxed/simple;
	bh=uREfF30nWOFy42XQ5hKVpFSe4MjlgRSdzUlXw76xFng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aASZ6Duf2Ww9NKCnfCDASqn2vjFOAo1+0hXnnh+H/eJbmjlRtD1OiY9IHHlkoDdM25GwsxRRKui301A5JyrqSZnhYhp53GvJNrZn85AZGf9h50BSVl7ZvBti8uAWUhWtSDJNZt3ZtgZAJqDuExHyOxl9tY+uNjIyrntxS0xwy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAJrW/Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4058C4CED1;
	Sun,  2 Feb 2025 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516400;
	bh=uREfF30nWOFy42XQ5hKVpFSe4MjlgRSdzUlXw76xFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=aAJrW/TwD1bvNYKaSEK02kWg1ZrpWH7dt/djDUySERMOZiwDr1ldkqKDHD9aAyN5Y
	 EgqX8mS/1LYSZSZu3Ot6QTQdquII4vIpR09aEfWkPEZQHK7uvK/5uoXUuH6KTjNmsJ
	 sMnM77wPc432Ov1GB4Cwo2JFQJmICmVz9rMD0vO5HndPDkEUSoP/EGlQR2YnU24Ehf
	 q39ZolBf2UTxp64K1tZBbI29Qyd4++pxN9q1NTc6hqYxrODW0xI0dSA+mWxZ6vNyht
	 b/KBYb5hqo9VI6Cc4bZ0+x1lMu0eNiT5t4TEB/NNQiGiXSIF6+uRysssI8merxjpyk
	 Zyct6yae9MHMg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 17/25] tools/power turbostat: Add PMT directory iterator helper
Date: Sun,  2 Feb 2025 11:09:33 -0600
Message-ID: <4265a86582eaa224d171328be0c71e2a7ccd194f.1738515889.git.len.brown@intel.com>
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

PMT directories exposed in sysfs use the following pattern:
  telem%u
for example:
  telem0, telem2, telem3, ..., telem15, telem16

This naming scheme preserves the ordering from the PCIe discovery, which
is important to correctly map the telemetry directory to the specific
domain (cpu, core, package etc).

Because readdir() traverses the entries in alphabetical order, causing
for example "telem13" to be traversed before "telem3", it is necessary
to use scandir() with custom compare() callback to preserve the PCIe
ordering.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 14c495886746..6104d5bcca5c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1589,6 +1589,93 @@ struct pmt_counter {
 	struct pmt_domain_info *domains;
 };
 
+/*
+ * PMT telemetry directory iterator.
+ * Used to iterate telemetry files in sysfs in correct order.
+ */
+struct pmt_diriter_t
+{
+	DIR *dir;
+	struct dirent **namelist;
+	unsigned int num_names;
+	unsigned int current_name_idx;
+};
+
+int pmt_telemdir_filter(const struct dirent *e)
+{
+	unsigned int dummy;
+	return sscanf(e->d_name, "telem%u", &dummy);
+}
+
+int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
+{
+	unsigned int aidx = 0, bidx = 0;
+
+	sscanf((*a)->d_name, "telem%u", &aidx);
+	sscanf((*b)->d_name, "telem%u", &bidx);
+
+	return aidx >= bidx;
+}
+
+const struct dirent* pmt_diriter_next(struct pmt_diriter_t *iter)
+{
+	const struct dirent *ret = NULL;
+
+	if (!iter->dir)
+		return NULL;
+
+	if (iter->current_name_idx >= iter->num_names)
+		return NULL;
+
+	ret = iter->namelist[iter->current_name_idx];
+	++iter->current_name_idx;
+
+	return ret;
+}
+
+const struct dirent* pmt_diriter_begin(struct pmt_diriter_t *iter, const char *pmt_root_path)
+{
+	int num_names = iter->num_names;
+
+	if (!iter->dir) {
+		iter->dir = opendir(pmt_root_path);
+		if (iter->dir == NULL)
+			return NULL;
+
+		num_names = scandir(pmt_root_path, &iter->namelist, pmt_telemdir_filter, pmt_telemdir_sort);
+		if (num_names == -1)
+			return NULL;
+	}
+
+	iter->current_name_idx = 0;
+	iter->num_names = num_names;
+
+	return pmt_diriter_next(iter);
+}
+
+void pmt_diriter_init(struct pmt_diriter_t *iter)
+{
+	memset(iter, 0, sizeof(*iter));
+}
+
+void pmt_diriter_remove(struct pmt_diriter_t *iter)
+{
+	if (iter->namelist) {
+		for (unsigned int i = 0; i < iter->num_names; i++) {
+			free(iter->namelist[i]);
+			iter->namelist[i] = NULL;
+		}
+	}
+
+	free(iter->namelist);
+	iter->namelist = NULL;
+	iter->num_names = 0;
+	iter->current_name_idx = 0;
+
+	closedir(iter->dir);
+	iter->dir = NULL;
+}
+
 unsigned int pmt_counter_get_width(const struct pmt_counter *p)
 {
 	return (p->msb - p->lsb) + 1;
-- 
2.43.0


