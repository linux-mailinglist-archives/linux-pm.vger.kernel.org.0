Return-Path: <linux-pm+bounces-21244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E281A24F2B
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924641884C60
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEF1FBC87;
	Sun,  2 Feb 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cut1W6y/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC11F9F73
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516407; cv=none; b=prH95sIlNvSLkd+OPI8iWP4kfAHGbchO5RHX+jsMJxi/AlnMmlTqOdMaDCpfwSQkJsxGCYzxodFyT0gWIDCUg8M4IFw2EAwJNRPFfwbTaDZ+cD4c2nvv10g+QcMeaE0xfxVkJFvx7ioKRfl3p3PirgRHo9qn1ntjhdRg+smguNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516407; c=relaxed/simple;
	bh=RMVZNI9GML9uxNNbHkqdaqva2odlb4BkpDhEXrPUJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNfelQ1/mDI4CWJfeH+k5N5iv1mZK0aEvAu0HQv7/vUOfI/S2/YutPkXdtQAnPK5AH45no75j7wO3UQERUWtU0vKU8b6aHv1Bqjgl8SuMEY6LfgUM6SwwJJrfGtKbsQ6AysvhM0o2VFMRECXuFNSOMxCaO7Z+7CSIMY4xa5LMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cut1W6y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83437C4CEE1;
	Sun,  2 Feb 2025 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516406;
	bh=RMVZNI9GML9uxNNbHkqdaqva2odlb4BkpDhEXrPUJgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Cut1W6y/EiKUxMPhGJcoQHAgpGpjuzeFdVaJ+NX5lz6565DMBk2/mGo4BkkDaXzz9
	 y+OFoDBwsKs1HmoPwztZL3qWalcDqkcxJYuONKAVBKDhtAsbJuAKmG5hdiGhjA/N1K
	 bTc9/36cm2BnIaDGfgEq+zjiR+yPOX2oj9JR73r61ByphlwTxRqig54SyHJkvbCYZ7
	 hbFpeP5TvTCuOIjgrQG084CUPCwRpfLQ/1zGox4vD485XxHjwpgEUTiVcR5Ws1RtRT
	 vh2wxd9RoZ2HQoqgytUR5nG59ZH4u7GlP2/mEA0HJQ56vh6/ifl4es0Hbw7srantQ6
	 bbRUrsevZQPAA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 21/25] tools/power turbostat: Add tcore clock PMT type
Date: Sun,  2 Feb 2025 11:09:37 -0600
Message-ID: <1a202afeaa370970413846c2cb09b383875e753c.1738515889.git.len.brown@intel.com>
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

Some PMT counters, for example module c1e residency on Intel Clearwater
Forest, are reported using tcore clock type.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 32 ++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 76d2632e60ac..ecaa4e0fb2c0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1538,6 +1538,8 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 #define PMT_MTL_DC6_GUID           0x1a067102
 #define PMT_MTL_DC6_SEQ            0
 
+unsigned long long tcore_clock_freq_hz = 800000000;
+
 #define PMT_COUNTER_NAME_SIZE_BYTES      16
 #define PMT_COUNTER_TYPE_NAME_SIZE_BYTES 32
 
@@ -1560,6 +1562,7 @@ struct pmt_mmio {
 enum pmt_datatype {
 	PMT_TYPE_RAW,
 	PMT_TYPE_XTAL_TIME,
+	PMT_TYPE_TCORE_CLOCK,
 };
 
 struct pmt_domain_info {
@@ -2474,6 +2477,7 @@ void print_header(char *delim)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+		case PMT_TYPE_TCORE_CLOCK:
 			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
 			break;
 		}
@@ -2548,6 +2552,7 @@ void print_header(char *delim)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+		case PMT_TYPE_TCORE_CLOCK:
 			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
 			break;
 		}
@@ -2679,6 +2684,7 @@ void print_header(char *delim)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+		case PMT_TYPE_TCORE_CLOCK:
 			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), ppmt->name);
 			break;
 		}
@@ -2997,7 +3003,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = t->pmt_counter[i];
-		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3009,8 +3015,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
+
+		case PMT_TYPE_TCORE_CLOCK:
+			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 		}
 	}
 
@@ -3077,7 +3088,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = c->pmt_counter[i];
-		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3089,8 +3100,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
+
+		case PMT_TYPE_TCORE_CLOCK:
+			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 		}
 	}
 
@@ -3275,7 +3291,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
 		const unsigned long value_raw = p->pmt_counter[i];
-		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+		double value_converted;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3287,8 +3303,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
+			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
+
+		case PMT_TYPE_TCORE_CLOCK:
+			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 		}
 	}
 
@@ -10016,6 +10037,11 @@ void parse_add_command_pmt(char *add_command)
 			has_type = true;
 		}
 
+		if (strcmp("tcore_clock", type_name) == 0) {
+			type = PMT_TYPE_TCORE_CLOCK;
+			has_type = true;
+		}
+
 		if (!has_type) {
 			printf("%s: invalid %s: %s\n", __func__, "type", type_name);
 			exit(1);
-- 
2.43.0


