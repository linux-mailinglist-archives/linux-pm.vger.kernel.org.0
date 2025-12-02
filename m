Return-Path: <linux-pm+bounces-39124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8ACC9D0EC
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82FE24E445A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA42F9985;
	Tue,  2 Dec 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcGSsy1p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC72F7AD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710332; cv=none; b=CNbLE5tm8cNyaHNYB3X9qMqqvHZngf4M+S+HXVyACBdKKBTKc/9QLknZDMtNsd4Sdi2ZCGZWB+WWEILOXjsEvnIZDhUrc4Mz51ZXwArvKRSR7+8BqCAHNO4K+hIvg8/mDahU19Ue+Va4v0PDwOew6UzaAw/0jIJqymDAW3be6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710332; c=relaxed/simple;
	bh=8aW7OvVeCfDNpRpESZLgGlS7ZAanw4NIUJBw4U+ifo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtJARTviId5EH7+p0G35Qd5hJqxY7iX+VHp90fDAsURaRoAZm8qOIIIpcnt2cnoxzayxMsh8cc008nXESsR8JgtQputUv7lQ7Ty9vaCTc1ucgV9c74OH5dgHIt8cOMUQEItmVa4FiuBaTJoULAKIrG5ygIORcp0Wwrwb12/CHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcGSsy1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A0BC4CEF1;
	Tue,  2 Dec 2025 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710332;
	bh=8aW7OvVeCfDNpRpESZLgGlS7ZAanw4NIUJBw4U+ifo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=QcGSsy1pa3don5gpyJDRy1I26H4nwTNbervLw4IidiWzaffiLBRxW14VTYONUUk09
	 iE3oIS5QC5x09wO+6ISVh9Tb85hjqvnbLE7vubIowv7WqXO0uNqclfAcdeRaYC8oNh
	 iSQ8LGsopPaALbRkCi8sBJKnYjzg4zHTwXkbTXsjsmXasgrcLfSuOLBTxDCxTM3U/k
	 oGCakYffXUJQSwpVUy1l1vg4LcwMLNxZhYMrq6we2Pj7EcUW0rWlV+4KymO6YX906i
	 aFiugLYir0ox+tMA51gzuuQc6lt3Vg0ZOSF8CCFer7IxBc2MhCh1+wJcwwvM7BkdeB
	 a/4XprPeb91hg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/21] tools/power turbostat: Print "nan" for out of range percentages
Date: Tue,  2 Dec 2025 16:13:36 -0500
Message-ID: <8808292799b0eafd32d89e12a2536debcecaac11.1764710012.git.len.brown@intel.com>
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

Sometimes counters return junk.
For the cases where values > 100% is invalid, print "nan".

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 92 +++++++++++++++------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0064f9091c7f..f59dcee3c816 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2999,6 +2999,25 @@ void print_header(char *delim)
 	outp += sprintf(outp, "\n");
 }
 
+/*
+ * pct()
+ *
+ * If absolute value is < 1.1, return percentage
+ * otherwise, return nan
+ *
+ * return value is appropriate for printing percentages with %f
+ * while flagging some obvious erroneous values.
+ */
+double pct(double d)
+{
+
+	double abs = fabs(d);
+
+	if (abs < 1.10)
+		return (100.0 * d);
+	return nan("");
+}
+
 int dump_counters(PER_THREAD_PARAMS)
 {
 	int i;
@@ -3026,7 +3045,7 @@ int dump_counters(PER_THREAD_PARAMS)
 
 		outp += sprintf(outp, "LLC refs: %lld", t->llc.references);
 		outp += sprintf(outp, "LLC miss: %lld", t->llc.misses);
-		outp += sprintf(outp, "LLC Hit%%: %.2f", 100.0 * (t->llc.references - t->llc.misses) / t->llc.references);
+		outp += sprintf(outp, "LLC Hit%%: %.2f", pct((t->llc.references - t->llc.misses) / t->llc.references));
 
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 			outp +=
@@ -3248,7 +3267,7 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), 1.0 / units * t->aperf / interval_float);
 
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->mperf / tsc));
 
 	if (DO_BIC(BIC_Bzy_MHz)) {
 		if (has_base_hz)
@@ -3291,7 +3310,7 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), t->llc.references / interval_float / 1000);
 
 		if (DO_BIC(BIC_LLC_HIT))
-			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * (t->llc.references - t->llc.misses) / t->llc.references);
+			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), pct((t->llc.references - t->llc.misses) / t->llc.references));
 	}
 
 
@@ -3305,7 +3324,7 @@ int format_counters(PER_THREAD_PARAMS)
 			if (mp->type == COUNTER_USEC)
 				outp += print_float_value(&printed, delim, t->counter[i] / interval_float / 10000);
 			else
-				outp += print_float_value(&printed, delim, 100.0 * t->counter[i] / tsc);
+				outp += print_float_value(&printed, delim, pct(t->counter[i] / tsc));
 		}
 	}
 
@@ -3319,7 +3338,7 @@ int format_counters(PER_THREAD_PARAMS)
 			if (pp->type == COUNTER_USEC)
 				outp += print_float_value(&printed, delim, t->perf_counter[i] / interval_float / 10000);
 			else
-				outp += print_float_value(&printed, delim, 100.0 * t->perf_counter[i] / tsc);
+				outp += print_float_value(&printed, delim, pct(t->perf_counter[i] / tsc));
 		}
 	}
 
@@ -3333,34 +3352,34 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+			value_converted = pct(value_raw / crystal_hz / interval_float);
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 		}
 	}
 
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(t->c1 / tsc));
 
 	/* print per-core data only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c))
 		goto done;
 
 	if (DO_BIC(BIC_CPU_c3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c3 / tsc));
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c6 / tsc));
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->c7 / tsc));
 
 	/* Mod%c6 */
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(c->mc6_us / tsc));
 
 	if (DO_BIC(BIC_CoreTmp))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
@@ -3376,7 +3395,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(mp->width, &printed, delim, c->counter[i]);
 		else if (mp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, 100.0 * c->counter[i] / tsc);
+			outp += print_float_value(&printed, delim, pct(c->counter[i] / tsc));
 	}
 
 	/* Added perf Core counters */
@@ -3386,7 +3405,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, 100.0 * c->perf_counter[i] / tsc);
+			outp += print_float_value(&printed, delim, pct(c->perf_counter[i] / tsc));
 	}
 
 	/* Added PMT Core counters */
@@ -3399,12 +3418,12 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+			value_converted = pct(value_raw / crystal_hz / interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
@@ -3463,46 +3482,41 @@ int format_counters(PER_THREAD_PARAMS)
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (DO_BIC(BIC_Totl_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100 * p->pkg_wtd_core_c0 / tsc); 	/* can exceed 100% */
 	if (DO_BIC(BIC_Any_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_core_c0 / tsc));
 	if (DO_BIC(BIC_GFX_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_gfxe_c0 / tsc));
 	if (DO_BIC(BIC_CPUGFX))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_both_core_gfxe_c0 / tsc));
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc2 / tsc));
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc3 / tsc));
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc6 / tsc));
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc7 / tsc));
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc8 / tsc));
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc9 / tsc));
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10 / tsc);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pc10 / tsc));
 
 	if (DO_BIC(BIC_Diec6))
-		outp +=
-		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->die_c6 / crystal_hz / interval_float);
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->die_c6 / crystal_hz / interval_float));
 
 	if (DO_BIC(BIC_CPU_LPI)) {
 		if (p->cpu_lpi >= 0)
-			outp +=
-			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
-				    100.0 * p->cpu_lpi / 1000000.0 / interval_float);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->cpu_lpi / 1000000.0 / interval_float));
 		else
 			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
 	}
 	if (DO_BIC(BIC_SYS_LPI)) {
 		if (p->sys_lpi >= 0)
-			outp +=
-			    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
-				    100.0 * p->sys_lpi / 1000000.0 / interval_float);
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->sys_lpi / 1000000.0 / interval_float));
 		else
 			outp += sprintf(outp, "%s(neg)", (printed++ ? delim : ""));
 	}
@@ -3556,7 +3570,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(mp->width, &printed, delim, p->counter[i]);
 		else if (mp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, 100.0 * p->counter[i] / tsc);
+			outp += print_float_value(&printed, delim, pct(p->counter[i] / tsc));
 	}
 
 	/* Added perf Package Counters */
@@ -3569,7 +3583,7 @@ int format_counters(PER_THREAD_PARAMS)
 		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
-			outp += print_float_value(&printed, delim, 100.0 * p->perf_counter[i] / tsc);
+			outp += print_float_value(&printed, delim, pct(p->perf_counter[i] / tsc));
 	}
 
 	/* Added PMT Package Counters */
@@ -3582,12 +3596,12 @@ int format_counters(PER_THREAD_PARAMS)
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+			value_converted = pct(value_raw / crystal_hz / interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
-			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
+			value_converted = pct(value_raw / tcore_clock_freq_hz / interval_float);
 			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
-- 
2.45.2


