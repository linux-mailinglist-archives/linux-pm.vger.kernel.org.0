Return-Path: <linux-pm+bounces-21234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08526A24F21
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA861884B3F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101451FAC49;
	Sun,  2 Feb 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqkRQ7Jr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BF1D7E57
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516393; cv=none; b=j2nl9KzPybVJFjdjuTqY5UqkXP9Si9RLIzzyxFxsXd698vJAM7RxD3xNPb5fLL8pCc+FxEVpaTQ/OVvbHFau+JtkUGFQncT8hOrxgxl6t8+5XcUjzzivcC1ffsu2SCH5vVib/3P41kpSQrWxgldHuQVJE2PSA1sKz2LKAl7ke8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516393; c=relaxed/simple;
	bh=WFpmSrIgIrhNo6DTrNv+2W8Ut9DCsZ2P6okj3zjDCzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRhR6c4szkH3Sb/SEy/QcyXky+Cld2mYDbO+oFJwHv87Xsijzgsoq92H480StzuuuUQPpN3qQMkZKlWQUW9EFBfKEOsbmAQcRn4UXNTc8cZTdprPozhxgcdEG+dpnr+vrSCGgHZ3zCsWQmLIPSmO2Wb1Tslx6GVznf+PUuveqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqkRQ7Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3DFC4CEE0;
	Sun,  2 Feb 2025 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516392;
	bh=WFpmSrIgIrhNo6DTrNv+2W8Ut9DCsZ2P6okj3zjDCzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=tqkRQ7JrAsCGqUx3zSW1BPdTFDhl9RasYJWitMM/DtbTYYq7j5e0V9TukiHCPnAGK
	 ufkxKZRC43NLHAG+5TmUJ/PjnXwODCU9dIbM0QTfaXBcWwY5YtwTcP8fXVPC8dn6Vz
	 l3UJ3Rh9MazjHmtLBPwlyLIt6EWGLxSBnfmGpBC2HS+FyDYOa6/E8otDz71pbRUc+s
	 t1XfKoEV+ofXeSh5i3+ygM17JXv1HgxnwwX8tUMK5NiGrt4NNyzPj4nT4A0j3EGdXa
	 ++rLpl6mCRcUsTHlvIhG4HyBoUV5izykv+MnmBwX0wrcvW1yEUCmBTP+Cm+D8WeV4J
	 6GqYmNLy0iplg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/25] tools/power turbostat: Fix PMT mmaped file size rounding
Date: Sun,  2 Feb 2025 11:09:27 -0600
Message-ID: <2f60f03934a50bc1fb69bb4f47a25cddd6807b0b.1738515889.git.len.brown@intel.com>
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

This (the old code) is just not how you round up to a page size.
Noticed on a recent Intel platform. Previous ones must have been
reporting sizes already aligned to a page and so the bug was missed when
testing.

Fixes: f0e4ed752fda ("tools/power turbostat: Add early support for PMT counters")
Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1d99aaf9681b..a2ca1c6c3638 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -95,6 +95,8 @@
 #define INTEL_ECORE_TYPE	0x20
 #define INTEL_PCORE_TYPE	0x40
 
+#define ROUND_UP_TO_PAGE_SIZE(n) (((n) + 0x1000UL-1UL) & ~(0x1000UL-1UL))
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
@@ -8996,7 +8998,7 @@ struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 		if (fd_pmt == -1)
 			goto loop_cleanup_and_break;
 
-		mmap_size = (size + 0x1000UL) & (~0x1000UL);
+		mmap_size = ROUND_UP_TO_PAGE_SIZE(size);
 		mmio = mmap(0, mmap_size, PROT_READ, MAP_SHARED, fd_pmt, 0);
 		if (mmio != MAP_FAILED) {
 
-- 
2.43.0


