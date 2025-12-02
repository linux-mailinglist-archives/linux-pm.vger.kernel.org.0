Return-Path: <linux-pm+bounces-39126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3BC9D0D8
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE923A04F8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33572FC003;
	Tue,  2 Dec 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfCWxJfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3982F7AC0
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710334; cv=none; b=cYFdJQWaAhDOkeVB4myFq2S2Y7kgLzTo/0TSr/VVdB/RwrOYlQoiEDSM/zH6dApAoAV916pnjYSAOA2mPDU2RkYqkJsGG2I1b4gwZ/zLOMjbe2HoNnTOE1D3rs/PBU+xfC0bYqWKH8rb/GI1Hl8U7fl5bYJKn3VgPE7UOb+JKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710334; c=relaxed/simple;
	bh=oo6U9Mf5L77AmjCuXcunGbpnR95/znXl42kTBvC51ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoSqLMXUSlJFvu7Ue68ahLhxAGRbIkwkcQ1EMibNkuKwsVFLJT5+K/FSy8uRrdtswHeupYHWxcunstBMI30/Lso61cpGcZ0Kd+/o2kMrgUiNg9+hj4S7fuXXati47k/gjIULEbLR1sPgh0t8uX/vDgr/6l0MZOgaYqCCnx8du9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfCWxJfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61A7C4CEF1;
	Tue,  2 Dec 2025 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710334;
	bh=oo6U9Mf5L77AmjCuXcunGbpnR95/znXl42kTBvC51ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=VfCWxJfIImAc6L3wYcRtd7rxWQZSvWnM4SUrqsdzG0V9tcuT5qupG1KfI9stQEDeW
	 Y78TSi1EWm9zVVxNfB42IMDIFoepdyYmUYI2Nji5RtZl3AlNMkCOo5zadeIkfoK7B1
	 l46eyL4vd+w43zUgIVf6xuo1UCJy0Jo9od02m38gUXKIuWdkL8yJxhXg/U6o4Z+Tag
	 qmLn4K6Ey++ZbOtuKgaJ66pzWwMDb56Zz7VBzfR3l/QhRqzcVg4ryjo9o42YBUMxJq
	 bvgeDt0ZmtLkbX0XnvimNf53ALRA89vqTdHRSW18grZ2kl6BGJqHClhsp3oHOu6CXd
	 fEIV0EX8+/BCw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/21] tools/power turbostat: Print wide names only for RAW 64-bit columns
Date: Tue,  2 Dec 2025 16:13:38 -0500
Message-ID: <1a23ba6a1ba28f990d4d5fd730f663261f4de913.1764710012.git.len.brown@intel.com>
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

Print a wide column header only for the case of a 64-bit RAW counter.

It turns out that wide column headers otherwise are more harm than good.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 40 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 28625143a1b9..9329a503464a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2723,20 +2723,22 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 
 /*
  * print_name()
- * Print column header name for 64-bit counter in 16 columns (at least 8-char plus a tab)
+ * Print column header name for raw 64-bit counter in 16 columns (at least 8-char plus a tab)
  * Otherwise, allow the name + tab to fit within 8-coumn tab-stop.
  * In both cases, left justififed, just like other turbostat columns,
  * to allow the column values to consume the tab.
  *
- * Yes, 32-bit counters can overflow 8-columns, but then they are usually 64-bit counters.
- * 64-bit counters can overflow 16-columns, but rarely do.
+ * Yes, 32-bit counters can overflow 8-columns, and
+ * 64-bit counters can overflow 16-columns, but that is uncommon.
  */
-static inline int print_name(int width, int *printed, char *delim, char *name)
+static inline int print_name(int width, int *printed, char *delim, char *name, enum counter_type type, enum counter_format format)
 {
-	if (width <= 32)
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
-	else
+	UNUSED(type);
+
+	if (format == FORMAT_RAW && width >= 64)
 		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+	else
+		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
 }
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
@@ -2819,21 +2821,21 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sLLC%%hit", (printed++ ? delim : ""));
 
 	for (mp = sys.tp; mp; mp = mp->next)
-		outp += print_name(mp->width, &printed, delim, mp->name);
+		outp += print_name(mp->width, &printed, delim, mp->name, mp->type, mp->format);
 
 	for (pp = sys.perf_tp; pp; pp = pp->next)
-		outp += print_name(pp->width, &printed, delim, pp->name);
+		outp += print_name(pp->width, &printed, delim, pp->name, pp->type, pp->format);
 
 	ppmt = sys.pmt_tp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += print_name(32, &printed, delim, ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 		}
 
@@ -2867,22 +2869,22 @@ void print_header(char *delim)
 	}
 
 	for (mp = sys.cp; mp; mp = mp->next)
-		outp += print_name(mp->width, &printed, delim, mp->name);
+		outp += print_name(mp->width, &printed, delim, mp->name, mp->type, mp->format);
 
 	for (pp = sys.perf_cp; pp; pp = pp->next)
-		outp += print_name(pp->width, &printed, delim, pp->name);
+		outp += print_name(pp->width, &printed, delim, pp->name, pp->type, pp->format);
 
 	ppmt = sys.pmt_cp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += print_name(32, &printed, delim, ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 		}
 
@@ -2970,21 +2972,21 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sUncMHz", (printed++ ? delim : ""));
 
 	for (mp = sys.pp; mp; mp = mp->next)
-		outp += print_name(mp->width, &printed, delim, mp->name);
+		outp += print_name(mp->width, &printed, delim, mp->name, mp->type, mp->format);
 
 	for (pp = sys.perf_pp; pp; pp = pp->next)
-		outp += print_name(pp->width, &printed, delim, pp->name);
+		outp += print_name(pp->width, &printed, delim, pp->name, pp->type, pp->format);
 
 	ppmt = sys.pmt_pp;
 	while (ppmt) {
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name);
+			outp += print_name(pmt_counter_get_width(ppmt), &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
 		case PMT_TYPE_TCORE_CLOCK:
-			outp += print_name(32, &printed, delim, ppmt->name);
+			outp += print_name(32, &printed, delim, ppmt->name, COUNTER_ITEMS, ppmt->format);
 			break;
 		}
 
-- 
2.45.2


