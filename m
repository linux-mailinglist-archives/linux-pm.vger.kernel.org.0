Return-Path: <linux-pm+bounces-36786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03CC070DA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C113A8761
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B332C326;
	Fri, 24 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HooQl49n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BF324B27
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320804; cv=none; b=WcyyMMVYhp3q8A8KAci2Ptbos88D1/445352qdJRAqZXf6fNssfBwrXM3sMpMBkmTGozvb6GNutamumkEZpOVsMqVzxvtYOsjc6+arqcGsd4KGJUfPT9DD5w2aX06Mbmqpcq8+ChHR3w9olUbfOCry8wFp2TlI231akyPdxllzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320804; c=relaxed/simple;
	bh=Huh+5HfGYEwAMer0mcqMProfy5+osLVMVKj5LK1f3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CC4z3bLJ8IX8DDFa70uT7DtNZXaqobeTTXhFcXjdGMXE+YPwAnABy9iXRZRAgKDKcz2dsUgQVDLcVN18hztdkVidJJT+dzHYRWxx/Qr+9CKxTFTx07UCtahny7rzNvr3GIEZwLU7ro+MecS+7wTOYG/5NFVGM+JaBSSDK6C2inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HooQl49n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48197C4CEF1;
	Fri, 24 Oct 2025 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320804;
	bh=Huh+5HfGYEwAMer0mcqMProfy5+osLVMVKj5LK1f3zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=HooQl49nKY00rArXxuqw+gk3zphqT0TJ1WUuWS9iWELGK2U9+Shbp9oyY3RI7i7uo
	 pjVM4pK/kZUYnZKAQo6FP0sRfsMUwhQu54REteKCMAhHv5BsCvyk0Z0yd0l8VbMb7X
	 uTPUzc3Hri+bG4vmNCBpW3szmDbSDR2Jd8EED/mqRKmogLe981KoyuZd4EUaZrx+pw
	 lXWIJgZhhERX7pdRkuDWnt22bvSQSnKhxJl7hEIe8Bzn5biJ5eW7r62ZGTTKNXMsdz
	 E40NHBI+aWRMrXuzBzd/dI31TShnN4DZBDINqx4n+HIUhk3A6epKstdqqZ6RU1PzM4
	 vY5q8Jo04MVhw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Andrej Tkalcec <andrej.tkalcec@intel.com>
Subject: [PATCH 1/8] tools/power turbostat: Regression fix Uncore MHz printed in hex
Date: Fri, 24 Oct 2025 12:38:11 -0300
Message-ID: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251024154630.18359-1-lenb@kernel.org>
References: <20251024154630.18359-1-lenb@kernel.org>
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

A patch to allow specifying FORMAT_AVERAGE to added counters...
broke the internally added counter for Cluster Uncore MHz -- printing it in HEX.

Fixes: dcd1c379b0f1 ("tools/power turbostat: add format "average" for external attributes")
Reported-by: Andrej Tkalcec <andrej.tkalcec@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f2512d78bcbd..1b5ca2f4e92f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3285,13 +3285,13 @@ int format_counters(PER_THREAD_PARAMS)
 
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)t->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
-		} else if (mp->format == FORMAT_DELTA) {
+		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
 				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
 			else
@@ -3382,13 +3382,13 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->core_throt_cnt);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)c->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
-		} else if (mp->format == FORMAT_DELTA) {
+		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
 				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
 			else
@@ -3581,7 +3581,7 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->uncore_mhz);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
+		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp +=
 				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)p->counter[i]);
@@ -3758,7 +3758,7 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	    new->rapl_dram_perf_status.raw_value - old->rapl_dram_perf_status.raw_value;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE)
+		if (mp->format == FORMAT_RAW)
 			old->counter[i] = new->counter[i];
 		else if (mp->format == FORMAT_AVERAGE)
 			old->counter[i] = new->counter[i];
-- 
2.45.2


