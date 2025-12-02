Return-Path: <linux-pm+bounces-39107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDC1C9D0B6
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E646C4E4FCF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8F2F998D;
	Tue,  2 Dec 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx881+pq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4172F7477
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710312; cv=none; b=cCPVdUkRWvmLGqQ2m5jQZsIWoO1659HMjKNSvQpbNhkkkrXBpmQ286oNRYYDCVlz1iziyt+jqxTjM+XK1trmZ3cUkrAQ/wmfQlNWLs8lQIqrbLQf1jKMrMlvcHS3LnD5Q2xIZfB4EnejnTtNhlY17/dgcn6yGe7Iq3w14nPuaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710312; c=relaxed/simple;
	bh=Huh+5HfGYEwAMer0mcqMProfy5+osLVMVKj5LK1f3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGt+T7qxAa/Ld34EPwyN+ppMoZmM9as7rhOH45LeWF1wK2fQjuMksWwQGfvovyTaKEP0sNXYfEuXGGDmGLaFgXvSTAwd+fGdBrGaaoOZkgZZpseLNfLCG1PrqAn4+b/Xfc5xnVe0VHV66dohn/aRAFcGmIQevZ6zWpWMIbIqV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx881+pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF13C113D0;
	Tue,  2 Dec 2025 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710311;
	bh=Huh+5HfGYEwAMer0mcqMProfy5+osLVMVKj5LK1f3zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=hx881+pqzNlA71iqC68W3oX2W/+GgtaVXLQJpUVryG+11e6KKXE2CHLdHOBtmk4Ky
	 J+9EKl8ALUhEMAd66sCN9C5/xCvPWcPqGr8XR3gUSlhWQhQtu2MrOVBFH58V6j/TQG
	 8P8TFtP5IVWEDD7LeIkIgZdcmWbqlEs408EI+Sz8zlHJYmNshiEWW/vk/sX0byDhA6
	 E7i2mox6FAfgKV0ulBvbMQCTEse/udkeA6PB8W/oX9fjCE+CTzFmRybWqGnCzuQ7B5
	 4Y3MIEHdLLdpoi/1ZqMFCST8U8cLbXAjdyZXVmdMD+ymeVRaS4/i5+0bWjJlQq67BM
	 dCghiHGgD1XNw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Andrej Tkalcec <andrej.tkalcec@intel.com>
Subject: [PATCH 01/21] tools/power turbostat: Regression fix Uncore MHz printed in hex
Date: Tue,  2 Dec 2025 16:13:19 -0500
Message-ID: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251202211824.321697-1-lenb@kernel.org>
References: <20251202211824.321697-1-lenb@kernel.org>
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


