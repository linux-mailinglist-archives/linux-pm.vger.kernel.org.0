Return-Path: <linux-pm+bounces-42773-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPOKMpC8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42773-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5CA14F77E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3E2301D07C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941E374726;
	Tue, 17 Feb 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REYfuP7d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F337419C
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355275; cv=none; b=HguzqaIG6Asf+vyj0k6ICaw9NEbDAXUml3bRdDBBvPx8GxHmtZ32YCofYxaOpSKS+6ktRnLFrcBLGP6XcmG/Y9VMly037x6M0qt4W8IwsRkl1mFoaRKJgTbiBou8fvAq4uEi4REVL98AmQhrfY5oWOFfalof6kgruNhENkORnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355275; c=relaxed/simple;
	bh=5qTekIAadMwTMrJjPD3SCEf/TGazjrmvIqnJnQ3Szjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7pH3LY5SpOIhv5ZIq1P5YP1UYvvbITqokQnx1uBtfO27jsZfzE/1rMDRaF2UgrNNRupxh1WsIWcRQmhBn/s+y9a9rEro47C1hM1UoQQz+tcaAjAihUJ5wkEMNWJCHemNSviaO1J8bxYvp//w0OEQRpbQXmmvjewVKF58TBM1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REYfuP7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BA8C4CEF7;
	Tue, 17 Feb 2026 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355275;
	bh=5qTekIAadMwTMrJjPD3SCEf/TGazjrmvIqnJnQ3Szjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=REYfuP7d6HSZ3ntiHHuw9WKpTTcwkjQn9to8qetUEu1Jroi+fRXW94Ml0mt162J/c
	 fQfLSiM82R6y9AzHCzfBJPXfowWtSEfyZNL2CgbGBVDgF/wqkSazPTqQhS3Id6R3Cc
	 pEuxX5xqXAPBVJC0dMc1ryfHFzMZ4ewC+lxSpYriMCIAEbCSUXK4WOPxWtwhGnqph0
	 FEdVAB0OwiU9+Y0GooFpyiE68dvM4YDNw+7WYVv1heSa3EFfdfORLfAlh4ZrDm16+/
	 7UoT9b831lJiLcNKUGO+6A60BiF2Z4Ti8Yop7BYFY648uwShtL1Hs6o0m0BUhdrBKI
	 ZJpWYLePtIU9g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/23] tools/power turbostat: Harden against unexpected values
Date: Tue, 17 Feb 2026 13:03:56 -0600
Message-ID: <d0f7093ad5e4aa37405da2669bca1a62d22b7025.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42773-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6E5CA14F77E
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Divide-by-zero resulted if LLC references == 0

Pull the percentage division into pct() to centralize sanity checks there.

Fixes: 8808292799b0 ("tools/power turbostat: Print "nan" for out of range percentages")

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 94 +++++++++++++++------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 97cd9c5a0092..4dd4b0f3e6d4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3002,22 +3002,30 @@ void print_header(char *delim)
 }
 
 /*
- * pct()
+ * pct(numerator, denominator)
  *
- * If absolute value is < 1.1, return percentage
- * otherwise, return nan
+ * Return sanity checked percentage (100.0 * numerator/denominotor)
  *
- * return value is appropriate for printing percentages with %f
- * while flagging some obvious erroneous values.
+ * n < 0: nan
+ * d <= 0: nan
+ * n/d > 1.1: nan
  */
-double pct(double d)
+double pct(double numerator, double denominator)
 {
+	double retval;
 
-	double abs = fabs(d);
+	if (numerator < 0)
+		return nan("");
 
-	if (abs < 1.10)
-		return (100.0 * d);
-	return nan("");
+	if (denominator <= 0)
+		return nan("");
+
+	retval = 100.0 * numerator / denominator;
+
+	if (retval > 110.0)
+		return nan("");
+
+	return retval;
 }
 
 int dump_counters(PER_THREAD_PARAMS)
@@ -3047,7 +3055,7 @@ int dump_counters(PER_THREAD_PARAMS)
 
 		outp += sprintf(outp, "LLC refs: %lld", t->llc.references);
 		outp += sprintf(outp, "LLC miss: %lld", t->llc.misses);
-		outp += sprintf(outp, "LLC Hit%%: %.2f", pct((t->llc.references - t->llc.misses) / t->llc.references));
+		outp += sprintf(outp, "LLC Hit%%: %.2f", pct((t->llc.references - t->llc.misses), t->llc.references));
 
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 			outp += sprintf(outp, "tADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num, t->counter[i], mp->sp->path);
@@ -3262,7 +3270,7 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), 1.0 / units * t->aperf / interval_float);
 
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->mperf / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->mperf, tsc));
 
 	if (DO_BIC(BIC_Bzy_MHz)) {
 		if (has_base_hz)
@@ -3303,7 +3311,7 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), t->llc.references / interval_float / 1000);
 
 		if (DO_BIC(BIC_LLC_HIT))
-			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), pct((t->llc.references - t->llc.misses) / t->llc.references));
+			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), pct((t->llc.references - t->llc.misses), t->llc.references));
 	}
 
 	/* Added Thread Counters */
@@ -3316,7 +3324,7 @@ int format_counters(PER_THREAD_PARAMS)
 			if (mp->type == COUNTER_USEC)
 				outp += print_float_value(&printed, delim, t->counter[i] / interval_float / 10000);
 			else
-				outp += print_float_value(&printed, delim, pct(t->counter[i] / tsc));
+				outp += print_float_value(&printed, delim, pct(t->counter[i], tsc));
 		}
 	}
 
@@ -3330,7 +3338,7 @@ int format_counters(PER_THREAD_PARAMS)
 			if (pp->type == COUNTER_USEC)
 				outp += print_float_value(&printed, delim, t->perf_counter[i] / interval_float / 10000);
 			else
-				outp += print_float_value(&printed, delim, pct(t->perf_counter[i] / tsc));
+				outp += print_float_value(&printed, delim, pct(t->perf_counter[i], tsc));
 		}
 	}
 
@@ -3344,34 +3352,34 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = pct(value_raw / crystal_hz / interval_float);
+			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
+			value_converted = pct(value_raw / tcore_clock_freq_hz, interval_float);
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 		}
 	}
 
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->c1 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->c1, tsc));
 
 	/* print per-core data only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c))
 		goto done;
 
 	if (DO_BIC(BIC_CPU_c3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c3 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c3, tsc));
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c6 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c6, tsc));
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c7 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c7, tsc));
 
 	/* Mod%c6 */
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->mc6_us / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->mc6_us, tsc));
 
 	if (DO_BIC(BIC_CoreTmp))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
@@ -3387,7 +3395,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(mp->width, &printed, delim, c->counter[i]);
 		else if (mp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, pct(c->counter[i] / tsc));
+			outp += print_float_value(&printed, delim, pct(c->counter[i], tsc));
 	}
 
 	/* Added perf Core counters */
@@ -3397,7 +3405,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, pct(c->perf_counter[i] / tsc));
+			outp += print_float_value(&printed, delim, pct(c->perf_counter[i], tsc));
 	}
 
 	/* Added PMT Core counters */
@@ -3410,12 +3418,12 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = pct(value_raw / crystal_hz / interval_float);
+			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
+			value_converted = pct(value_raw / tcore_clock_freq_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
@@ -3471,39 +3479,39 @@ int format_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100 * p->pkg_wtd_core_c0 / tsc);	/* can exceed 100% */
 	if (DO_BIC(BIC_Any_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_core_c0 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_core_c0, tsc));
 	if (DO_BIC(BIC_GFX_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_gfxe_c0 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_gfxe_c0, tsc));
 	if (DO_BIC(BIC_CPUGFX))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_both_core_gfxe_c0 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_both_core_gfxe_c0, tsc));
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc2 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc2, tsc));
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc3 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc3, tsc));
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc6 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc6, tsc));
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc7 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc7, tsc));
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc8 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc8, tsc));
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc9 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc9, tsc));
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc10 / tsc));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc10, tsc));
 
 	if (DO_BIC(BIC_Diec6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->die_c6 / crystal_hz / interval_float));
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->die_c6 / crystal_hz, interval_float));
 
 	if (DO_BIC(BIC_CPU_LPI)) {
 		if (p->cpu_lpi >= 0)
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->cpu_lpi / 1000000.0 / interval_float));
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->cpu_lpi / 1000000.0, interval_float));
 		else
 			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
 	}
 	if (DO_BIC(BIC_SYS_LPI)) {
 		if (p->sys_lpi >= 0)
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->sys_lpi / 1000000.0 / interval_float));
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->sys_lpi / 1000000.0, interval_float));
 		else
 			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
 	}
@@ -3543,7 +3551,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(mp->width, &printed, delim, p->counter[i]);
 		else if (mp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, pct(p->counter[i] / tsc));
+			outp += print_float_value(&printed, delim, pct(p->counter[i], tsc));
 	}
 
 	/* Added perf Package Counters */
@@ -3555,7 +3563,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, pct(p->perf_counter[i] / tsc));
+			outp += print_float_value(&printed, delim, pct(p->perf_counter[i], tsc));
 	}
 
 	/* Added PMT Package Counters */
@@ -3568,12 +3576,12 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = pct(value_raw / crystal_hz / interval_float);
+			value_converted = pct(value_raw / crystal_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
+			value_converted = pct(value_raw / tcore_clock_freq_hz, interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
-- 
2.45.2


