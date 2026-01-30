Return-Path: <linux-pm+bounces-41743-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAW9K1YdfGmAKgIAu9opvQ
	(envelope-from <linux-pm+bounces-41743-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 03:54:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A2B69BC
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 03:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8888A300DE27
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 02:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24592FE060;
	Fri, 30 Jan 2026 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uCSB1r4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B321B9D2;
	Fri, 30 Jan 2026 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741651; cv=none; b=sBaZpHmgtiYPW65tUoo+samRtoKoy62JKawvRz5EC6+4YXjr21LhCGYTtvKn6+PXgdawW+16BUlFuPzR44H+jLjOD8HrJQ1MGCNv/+4qfithQzT/b7FKTHYdiHo+VAkjx9ziIhp08TNe0GKSZqvS9fGWO7eJPDi1i2zXzH6z1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741651; c=relaxed/simple;
	bh=7zU0TwG75RGIgT972dnuuYkRcDkDi3HpsMTBB16Kzok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYvdch0dC9fPSIdaCWr5uHJqvt/tbUeXxfM2nmxCQGh36IkOt9Ok26LIR+iVvW4JBMY3IhBlEBZQApOd9Na7Pu7uffWIaRkoul2iYtA6qoysN/cQ1pEQfP23D0pYwC3qaSaxdbk0xi3UiFXkeB7IZpoEDnSvhWgGeztb/dpJKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uCSB1r4j; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769741640; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3YSibFwj/80xAqvhWs5e/65pjtsEbkgkAa8KD7MK7os=;
	b=uCSB1r4jqqyIbQcEqWKArhlYrkW3+g2X/4wwlJOKDQKuh+mrkp1AETorVQCwBhvV8qyXMy9SeAQbMceRYsh3ductk2vZiQDIDg/1m3rSvLfsMbN49Nbh7NV0LipSz61aWdnhhbTlg07DhVueYBbdQUcWiytXDYQjhRtb3HkEjvA=
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0Wy9Fdll_1769741639 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 10:54:00 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH V1] tools/power turbostat: Fix RAPL MSR address selection on AMD platforms
Date: Fri, 30 Jan 2026 10:53:58 +0800
Message-ID: <20260130025358.4136660-1-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41743-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qinyuntan@linux.alibaba.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 165A2B69BC
X-Rspamd-Action: no action

idx_to_offset() uses valid_rapl_msrs to determine which MSR address to
return for RAPL counters (Intel's MSR_PKG_ENERGY_STATUS at 0x611 vs AMD's
MSR_PKG_ENERGY_STAT at 0xc001029b).

However, probe_rapl_msrs() calls idx_to_offset() before valid_rapl_msrs
has been set - it's only assigned at the end of probe_rapl_msrs() after
successful MSR validation. This causes idx_to_offset() to always return
the Intel MSR address (0x611) during the probe phase, even on AMD systems.

On Intel platforms this works by coincidence since the default (else
branch) returns the correct Intel address. On AMD platforms, this causes
turbostat to fail with:

  turbostat: cpu0: msr offset 0x611 read failed: Input/output error

Fix this by:
1. Falling back to platform->plat_rapl_msrs when valid_rapl_msrs is zero
   (not yet validated). This ensures the correct platform-specific MSR
   address is used during the initial probe.
2. Changing valid_rapl_msrs type from 'unsigned int' to 'int' to match
   plat_rapl_msrs type and avoid sign comparison warnings.

Fixes: 19476a592bf2 ("tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5ad45c2ac5bd..449492d5e043 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -492,7 +492,7 @@ unsigned int quiet;
 unsigned int shown;
 unsigned int sums_need_wide_columns;
 unsigned int rapl_joules;
-unsigned int valid_rapl_msrs;
+int valid_rapl_msrs;
 unsigned int summary_only;
 unsigned int list_header_only;
 unsigned int dump_only;
@@ -2132,10 +2132,18 @@ struct msr_sum_array *per_cpu_msr_sum;
 off_t idx_to_offset(int idx)
 {
 	off_t offset;
+	int rapl_msrs;
+
+	/*
+	 * Use valid_rapl_msrs if available (non-zero), otherwise fall back
+	 * to platform->plat_rapl_msrs. This allows probe_rapl_msrs() to call
+	 * this function before valid_rapl_msrs has been set.
+	 */
+	rapl_msrs = valid_rapl_msrs ? valid_rapl_msrs : platform->plat_rapl_msrs;
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		if (valid_rapl_msrs & RAPL_AMD_F17H)
+		if (rapl_msrs & RAPL_AMD_F17H)
 			offset = MSR_PKG_ENERGY_STAT;
 		else
 			offset = MSR_PKG_ENERGY_STATUS;
-- 
2.43.5


