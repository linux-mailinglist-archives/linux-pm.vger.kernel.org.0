Return-Path: <linux-pm+bounces-36789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43855C07110
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB321C20042
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989E32F754;
	Fri, 24 Oct 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6arYswO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787732ED57
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320810; cv=none; b=YDHkpq3OaRSG2O6/m9R6tBXNsv/wpQzfjnJwBUaauZJXcJqCryEH70fsuQUJwuqen1k4HbiR3mXaZQ38YbAe7Cs7Iq12w/Lif2A5Thl1ZzNpTEfvz9WADuJp6zzGPmJobGakEr/V8AQK6EgIWzIaZh0xcGX49gEXBY0gQP9CxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320810; c=relaxed/simple;
	bh=GWXHzkFli5dYftWmm3XabLpcqydfp5rO9O/Uu4CE70Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPXOQpbXn8W0uiC9ZlZvsWk+KMDersWRCg7MIpIZUWFEXVm/NrGrH33DxcFHfMPnmuEiRHSIC82TK/JImsIJUzO1MRl56cThAJfH4NuEpAFb2HGjOnijcvjZTyKRiTr0kxU2NLM5RkOM/IwST+u7iR9bqj1JH7Tyh+Yae5ay3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6arYswO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD21C4CEF1;
	Fri, 24 Oct 2025 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320810;
	bh=GWXHzkFli5dYftWmm3XabLpcqydfp5rO9O/Uu4CE70Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Y6arYswOVESfRF7pDkeUF5LSpvGhQO9tyaAnutQVPBJahq1U0y7W4ZDbjOQS3igHc
	 V1it2NvarRgZERKJtCdXXy0JHfMplIU6rTRNetpndtMYkYBfTjNLI8qpjmu9s9xvDd
	 ckRNkDb9BeQo8rIDwhv4CXFmnp/wXoxjCDGOwvPcrC3PRMX9djDpXlCcveQ3jY0psg
	 BKjOpSH5L+SA/J16eUBMQKHlwJ3ekAll5o6K1DHhKb+ejOI+jLSe7KUTsZ/t7gHbln
	 3uCrndHcEsjnK92/raUVr65PwsG7XgHAqDbT0zd4GeIH039KZjBseGMP6QswJNBKzp
	 G77GWN+C1dFKw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/8] tools/power turbostat: Refactor added-counter value printing code
Date: Fri, 24 Oct 2025 12:38:14 -0300
Message-ID: <885e8227641604a6732cd5049f23ab39f80bee14.1761320252.git.len.brown@intel.com>
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

We build up many copies of very similar code...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 153 ++++++++++----------------
 1 file changed, 57 insertions(+), 96 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d753df8706d..f9b99940b247 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2717,10 +2717,24 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
  */
 static inline int print_name(int width, int *printed, char *delim, char *name)
 {
-	if (width == 64)
+	if (width <= 32)
+		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+	else
 		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+}
+static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
+{
+	if (width <= 32)
+		return (sprintf(outp, "%s%08x", (*printed++ ? delim : ""), (unsigned int)value));
 	else
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%016llx", (*printed++ ? delim : ""), value));
+}
+static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
+{
+	if (width <= 32)
+		return (sprintf(outp, "%s%d", (*printed++ ? delim : ""), (unsigned int)value));
+	else
+		return (sprintf(outp, "%s%-8lld", (*printed++ ? delim : ""), value));
 }
 
 void print_header(char *delim)
@@ -3221,20 +3235,13 @@ int format_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
 
-	/* Added counters */
+	/* Added Thread Counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW) {
-			if (mp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)t->counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
-		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->counter[i]);
-		} else if (mp->format == FORMAT_PERCENT) {
+		if (mp->format == FORMAT_RAW)
+			outp += print_hex_value(mp->width, &printed, delim, t->counter[i]);
+		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+			outp += print_decimal_value(mp->width, &printed, delim, t->counter[i]);
+		else if (mp->format == FORMAT_PERCENT) {
 			if (mp->type == COUNTER_USEC)
 				outp +=
 				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
@@ -3244,21 +3251,13 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 	}
 
-	/* Added perf counters */
+	/* Added perf Thread Counters */
 	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-					    (unsigned int)t->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->perf_counter[i]);
-		} else if (pp->format == FORMAT_DELTA) {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->perf_counter[i]);
-		} else if (pp->format == FORMAT_PERCENT) {
+		if (pp->format == FORMAT_RAW)
+			outp += print_hex_value(pp->width, &printed, delim, t->perf_counter[i]);
+		else if (pp->format == FORMAT_DELTA)
+			outp += print_decimal_value(pp->width, &printed, delim, t->perf_counter[i]);
+		else if (pp->format == FORMAT_PERCENT) {
 			if (pp->type == COUNTER_USEC)
 				outp +=
 				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
@@ -3269,17 +3268,13 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 	}
 
+	/* Added PMT Thread Counters */
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = t->pmt_counter[i];
 		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-						(unsigned int)t->pmt_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->pmt_counter[i]);
-
+			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, t->pmt_counter[i]);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
@@ -3319,52 +3314,35 @@ int format_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_CORE_THROT_CNT))
 		outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->core_throt_cnt);
 
+	/* Added Core Counters */
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW) {
-			if (mp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)c->counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
-		} else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE) {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->counter[i]);
-		} else if (mp->format == FORMAT_PERCENT) {
+		if (mp->format == FORMAT_RAW)
+			outp += print_hex_value(mp->width, &printed, delim, c->counter[i]);
+		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+			outp += print_decimal_value(mp->width, &printed, delim, c->counter[i]);
+		else if (mp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i] / tsc);
 		}
 	}
 
+	/* Added perf Core counters */
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-					    (unsigned int)c->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->perf_counter[i]);
-		} else if (pp->format == FORMAT_DELTA) {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->perf_counter[i]);
-		} else if (pp->format == FORMAT_PERCENT) {
+		if (pp->format == FORMAT_RAW)
+			outp += print_hex_value(pp->width, &printed, delim, c->perf_counter[i]);
+		else if (pp->format == FORMAT_DELTA)
+			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
+		else if (pp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->perf_counter[i] / tsc);
 		}
 	}
 
+	/* Added PMT Core counters */
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = c->pmt_counter[i];
 		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-						(unsigned int)c->pmt_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->pmt_counter[i]);
-
+			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, c->pmt_counter[i]);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
@@ -3518,37 +3496,24 @@ int format_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_UNCORE_MHZ))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->uncore_mhz);
 
+	/* Added Package Counters */
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW) {
-			if (mp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int)p->counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
-		} else if (mp->format == FORMAT_DELTA) {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->counter[i]);
-		} else if (mp->format == FORMAT_PERCENT) {
+		if (mp->format == FORMAT_RAW)
+			outp += print_hex_value(mp->width, &printed, delim, p->counter[i]);
+		else if (mp->format == FORMAT_DELTA)
+			outp += print_decimal_value(mp->width, &printed, delim, p->counter[i]);
+		else if (mp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i] / tsc);
 		} else if (mp->type == COUNTER_K2M)
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->counter[i] / 1000);
 	}
 
+	/* Added perf Package Counters */
 	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
-		if (pp->format == FORMAT_RAW) {
-			if (pp->width == 32)
-				outp +=
-				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-					    (unsigned int)p->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->perf_counter[i]);
-		} else if (pp->format == FORMAT_DELTA) {
-			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->perf_counter[i]);
-			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->perf_counter[i]);
+		if (pp->format == FORMAT_RAW)
+			outp += print_hex_value(pp->width, &printed, delim, p->perf_counter[i]);
+		else if (pp->format == FORMAT_DELTA) {
+			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		} else if (pp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->perf_counter[i] / tsc);
 		} else if (pp->type == COUNTER_K2M) {
@@ -3557,17 +3522,13 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 	}
 
+	/* Added PMT Package Counters */
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = p->pmt_counter[i];
 		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
-			if (pmt_counter_get_width(ppmt) <= 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
-						(unsigned int)p->pmt_counter[i]);
-			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->pmt_counter[i]);
-
+			outp += print_hex_value(pmt_counter_get_width(ppmt), &printed, delim, p->pmt_counter[i]);
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-- 
2.45.2


