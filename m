Return-Path: <linux-pm+bounces-36788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BFBC070F5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0B55091A3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E26328613;
	Fri, 24 Oct 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGnVgrPq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F197328B45
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320808; cv=none; b=u/IdzIY8Z2Lq+MWOhMsISR0nubY/Onycy/483UbZrEeAgsvYsEYoAWnyqeeiqvi5dLxoTinXGqIlgbsAiqOM43NSJy/HqXIlk1M2++5ARcgNobqIH18XJs8fv1yhEKE6nBGUzkThNd39kRbaxmpm8IdAtNm34rhwUvYrvsjb7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320808; c=relaxed/simple;
	bh=bP0xybzZt/gquG5dPNmAyaLcjnJ7wwGlvaT9UDJYQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLm/6c185I7zQzfGxP/r0Mqjj7AJ8AQAgvq1sBXM+ZnL0KIwva8PBe6EkOvbth+SWIM6pnNlcNj4SeG/Wvm3/N5BtT6HGhFmS8+MBN7T8CeTAfpz2Ygd7jryzXVN/ZtficzZt+zxWMi8xgNRmqOc7ISrkfVLQ/yxCwLv3qr0F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGnVgrPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC002C4CEF1;
	Fri, 24 Oct 2025 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320808;
	bh=bP0xybzZt/gquG5dPNmAyaLcjnJ7wwGlvaT9UDJYQyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=UGnVgrPqXr8yynC5Km1VaI1OXQKej6HS82X2KcQE1awMZnWG9cyp9sr4ELSPBg42j
	 25ONwk/TjPIAaL+OPjfxAuHdTW+mVkUcDujKlYns0gMSaEwwERb+Zgh6gf5xF8xvy8
	 Mlq0zaR4tGo0JblTIkml+jJTDEEfxGBBxruGcrYzjtHcyO2CNvqtFOQSAGr5hfdJPt
	 qAau8t7MG5g07eQy/a+ghU+sVOHSssi3yfjGIO0UwixDel16PuTTpNyIEwciN6es8O
	 dIDIEg/yKUeNnH7C8cJfdvQC+lge1x3tmmZ6xswaj059nUkDP2lDjaEOE307zl9Jg0
	 BOqd67DikgTZw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/8] tools/power turbostat: Refactor added column header printing
Date: Fri, 24 Oct 2025 12:38:13 -0300
Message-ID: <56dbb878507bf7a367103728318d7852c1c4ee71.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
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


