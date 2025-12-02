Return-Path: <linux-pm+bounces-39109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA660C9D0BC
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33AB64E50CF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12D2F9DA5;
	Tue,  2 Dec 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqk8V6wC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D662F90E9
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710314; cv=none; b=VvjuBwWoyFT4o9o9xNdZ1UrnIXerjrwQ07lPhF1Y6halmH6iVunHYwRok4a0HKDBnWVtiXPwI08C80wm2L9H+qm+sb6Wy6nwdSdOQD+0ouUc3EBiedzxZ0YpQiwitGdu6pzjgJqFJBoFTYqWiK2gnmEsNw6HkjJq+jxmxUVkXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710314; c=relaxed/simple;
	bh=bP0xybzZt/gquG5dPNmAyaLcjnJ7wwGlvaT9UDJYQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvDZo7dXLT5fb7ZRRsrtKUer5s6n1Fwmi8DYiBYppj9jymQTjBkiJ/8hhTU3RA9osEA8w8XRkm+KmcqG3doVGKvYHFspDTac88sa2o9DkSC/G8GIUKY8YbgYL77HnHMwiggc9b0eCQSo8cfJbYxuT4infYohQZjsTZrQQPN+anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqk8V6wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3677CC4CEF1;
	Tue,  2 Dec 2025 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710313;
	bh=bP0xybzZt/gquG5dPNmAyaLcjnJ7wwGlvaT9UDJYQyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=pqk8V6wCgGlNPC4uwcUPv+sKJ8cnvoOvxrMD3pMahreIYdZH1SESJcMbF2pyRJx/L
	 /x0jVf6AVMb/S9rK2qVGJrHklzr0cNZC1XU6fZQnMq5tOyA0vv1Mh+nqZ9Rb7IDzTt
	 rfL+goN9L4UYjCZLjQ15p0RKDgTnVCjTIw7ydERJI5+n6O1Fi8/73Tc+PdZzTjkUBF
	 wQ9xY4+gAP11QA9U6stImDqdbcpAC3CgWKxUHCzJKIIySaQXlm2jdvGK2yPfE+n5UD
	 EGXAe/NpyLOeMyuSiFp2OB6qUd98nd0nKo1Ean8c9s8JGVSUFVljJhqDqnZIwt3v+r
	 WCbykrEMosaTg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/21] tools/power turbostat: Refactor added column header printing
Date: Tue,  2 Dec 2025 16:13:21 -0500
Message-ID: <56dbb878507bf7a367103728318d7852c1c4ee71.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
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

Over time, we built up many copies of nearly identical code...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 137 +++++++-------------------
 1 file changed, 36 insertions(+), 101 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7c24c2f9a075..5d753df8706d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2705,6 +2705,24 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 	}
 }
 
+/*
+ * print_name()
+ * Print column header name for 64-bit counter in 16 columns (at least 8-char plus a tab)
+ * Otherwise, allow the name + tab to fit within 8-coumn tab-stop.
+ * In both cases, left justififed, just like other turbostat columns,
+ * to allow the column values to consume the tab.
+ *
+ * Yes, 32-bit counters can overflow 8-columns, but then they are usually 64-bit counters.
+ * 64-bit counters can overflow 16-columns, but rarely do.
+ */
+static inline int print_name(int width, int *printed, char *delim, char *name)
+{
+	if (width == 64)
+		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+	else
+		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+}
+
 void print_header(char *delim)
 {
 	struct msr_counter *mp;
@@ -2760,50 +2778,22 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
-	for (mp = sys.tp; mp; mp = mp->next) {
+	for (mp = sys.tp; mp; mp = mp->next)
+		outp += print_name(mp->width, &printed, delim, mp->name);
 
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
-			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), mp->name);
-			else
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), mp->name);
-		} else {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), mp->name);
-			else
-				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), mp->name);
-		}
-	}
-
-	for (pp = sys.perf_tp; pp; pp = pp->next) {
-
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
-		} else {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
-		}
-	}
+	for (pp = sys.perf_tp; pp; pp = pp->next)
+		outp += print_name(pp->width, &printed, delim, pp->name);
 
 	ppmt = sys.pmt_tp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
-			else
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
-
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name);
 			break;
 		}
 
@@ -2836,49 +2826,23 @@ void print_header(char *delim)
 			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
 	}
 
-	for (mp = sys.cp; mp; mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
-			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
-			else
-				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
-		} else {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", delim, mp->name);
-			else
-				outp += sprintf(outp, "%s%s", delim, mp->name);
-		}
-	}
-
-	for (pp = sys.perf_cp; pp; pp = pp->next) {
+	for (mp = sys.cp; mp; mp = mp->next)
+		outp += print_name(mp->width, &printed, delim, mp->name);
 
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
-		} else {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
-		}
-	}
+	for (pp = sys.perf_cp; pp; pp = pp->next)
+		outp += print_name(pp->width, &printed, delim, pp->name);
 
 	ppmt = sys.pmt_cp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
-			else
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
 
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name);
 			break;
 		}
 
@@ -2966,51 +2930,22 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_UNCORE_MHZ))
 		outp += sprintf(outp, "%sUncMHz", (printed++ ? delim : ""));
 
-	for (mp = sys.pp; mp; mp = mp->next) {
-		if (mp->format == FORMAT_RAW || mp->format == FORMAT_AVERAGE) {
-			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
-			else if (mp->width == 32)
-				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
-			else
-				outp += sprintf(outp, "%s%7.7s", delim, mp->name);
-		} else {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", delim, mp->name);
-			else
-				outp += sprintf(outp, "%s%7.7s", delim, mp->name);
-		}
-	}
-
-	for (pp = sys.perf_pp; pp; pp = pp->next) {
+	for (mp = sys.pp; mp; mp = mp->next)
+		outp += print_name(mp->width, &printed, delim, mp->name);
 
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
-		} else {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
-			else
-				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
-		}
-	}
+	for (pp = sys.perf_pp; pp; pp = pp->next)
+		outp += print_name(pp->width, &printed, delim, pp->name);
 
 	ppmt = sys.pmt_pp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
-			else
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
-
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name);
 			break;
 		}
 
-- 
2.45.2


