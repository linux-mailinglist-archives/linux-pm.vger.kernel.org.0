Return-Path: <linux-pm+bounces-36791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B350BC070FB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED943AB3F7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C532E730;
	Fri, 24 Oct 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQyk0pm8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454D32E720
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320814; cv=none; b=mjpgvg0zHv1fnYyL/8GHlLtl0UkdANlebLfFYY05h56XhDdtsgDHv6RMMauqsN2V+4aWmA4/kXFu3CVxj8gEiSZ/4lAG49Zk7X646F4P7jAOgIbyiF7+b0qyHgWPx9ksk3l0Q7FcmqB6P5lVHw9zPgZZwUezNmrg0TpioZ2YHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320814; c=relaxed/simple;
	bh=arRmVLWfA0OIIw0IvhTo1OlGzhGV3JXhy3hAi235i0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VamI19rsXgbca/0ZOnsbEqFBFGForPhk12gNPSOkGGiX8DhYIy/ncSLWWAb4gxShzty3j4hXH16LSE8CIWZyfG+YopK6PIR2HcoxEuUN3SYlLgVF74M3bvdXi4dWweB8xXbXtFmzHBkoiDIkhO6poXdBPDvKlb3m78Kp6LSrZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQyk0pm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE74C4CEF5;
	Fri, 24 Oct 2025 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320814;
	bh=arRmVLWfA0OIIw0IvhTo1OlGzhGV3JXhy3hAi235i0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=jQyk0pm85wgQJqCVocIZgKJCV782r9hK/RWKQRJfa6oGqMSexs1lLginleyHUp6ns
	 rytN77gHoeuZjDvgN2HZw57NXhBJAS3xkfXg5CMTmt303NjDaG4PTVN1r6hCczH0Wh
	 BzoAWjQXpo3V1TVJxllfGrX25aoxEHvBhAWEVt+vpBZjzX4oP+4jZEfPimZkZYYe06
	 ZRo9/rcosfaOP8LeS9cdMlcyaJgPDt1Sht8j46ItnetoZttqrKuPu6Gp8XIaEIuz9L
	 bXH2DbNG/xR8P58z/fwpcgAPKeKeN/iaBI2lBEsV246UFTmmq8VyflsYYuD5dBeK6o
	 FPdUqLSx64tGw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/8] tools/power turbostat: Refactor floating point printout code
Date: Fri, 24 Oct 2025 12:38:16 -0300
Message-ID: <696d15cbd8c2cf29a8e7486bf9fbf085f4cefed6.1761320252.git.len.brown@intel.com>
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

Too many copies of (usually) the same printf code...

Also, unify code for added-counter FORMAT_AVERAGE,
which was correct where it was tested, but neglected elsewhere.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 60 +++++++++++++--------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f9b99940b247..47cb72343038 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2736,6 +2736,10 @@ static inline int print_decimal_value(int width, int *printed, char *delim, unsi
 	else
 		return (sprintf(outp, "%s%-8lld", (*printed++ ? delim : ""), value));
 }
+static inline int print_float_value(int *printed, char *delim, double value)
+{
+	return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value));
+}
 
 void print_header(char *delim)
 {
@@ -3243,11 +3247,9 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_decimal_value(mp->width, &printed, delim, t->counter[i]);
 		else if (mp->format == FORMAT_PERCENT) {
 			if (mp->type == COUNTER_USEC)
-				outp +=
-				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
-					    t->counter[i] / interval_float / 10000);
+				outp += print_float_value(&printed, delim, t->counter[i] / interval_float / 10000);
 			else
-				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i] / tsc);
+				outp += print_float_value(&printed, delim, 100.0 * t->counter[i] / tsc);
 		}
 	}
 
@@ -3255,16 +3257,13 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, t->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA)
+		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, t->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT) {
 			if (pp->type == COUNTER_USEC)
-				outp +=
-				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
-					    t->perf_counter[i] / interval_float / 10000);
+				outp += print_float_value(&printed, delim, t->perf_counter[i] / interval_float / 10000);
 			else
-				outp +=
-				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->perf_counter[i] / tsc);
+				outp += print_float_value(&printed, delim, 100.0 * t->perf_counter[i] / tsc);
 		}
 	}
 
@@ -3320,20 +3319,18 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(mp->width, &printed, delim, c->counter[i]);
 		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(mp->width, &printed, delim, c->counter[i]);
-		else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i] / tsc);
-		}
+		else if (mp->format == FORMAT_PERCENT)
+			outp += print_float_value(&printed, delim, 100.0 * c->counter[i] / tsc);
 	}
 
 	/* Added perf Core counters */
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, c->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA)
+		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
-		else if (pp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->perf_counter[i] / tsc);
-		}
+		else if (pp->format == FORMAT_PERCENT)
+			outp += print_float_value(&printed, delim, 100.0 * c->perf_counter[i] / tsc);
 	}
 
 	/* Added PMT Core counters */
@@ -3347,12 +3344,12 @@ int format_counters(PER_THREAD_PARAMS)
 
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
 			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
 
@@ -3500,26 +3497,25 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			outp += print_hex_value(mp->width, &printed, delim, p->counter[i]);
-		else if (mp->format == FORMAT_DELTA)
-			outp += print_decimal_value(mp->width, &printed, delim, p->counter[i]);
-		else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i] / tsc);
-		} else if (mp->type == COUNTER_K2M)
+		else if (mp->type == COUNTER_K2M)
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->counter[i] / 1000);
+		else if (mp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+			outp += print_decimal_value(mp->width, &printed, delim, p->counter[i]);
+		else if (mp->format == FORMAT_PERCENT)
+			outp += print_float_value(&printed, delim, 100.0 * p->counter[i] / tsc);
 	}
 
 	/* Added perf Package Counters */
 	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, p->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA) {
-			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
-		} else if (pp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->perf_counter[i] / tsc);
-		} else if (pp->type == COUNTER_K2M) {
+		else if (pp->type == COUNTER_K2M)
 			outp +=
 			    sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
-		}
+		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
+		else if (pp->format == FORMAT_PERCENT)
+			outp += print_float_value(&printed, delim, 100.0 * p->perf_counter[i] / tsc);
 	}
 
 	/* Added PMT Package Counters */
@@ -3533,12 +3529,12 @@ int format_counters(PER_THREAD_PARAMS)
 
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
 			value_converted = 100.0 * value_raw / tcore_clock_freq_hz / interval_float;
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
 
-- 
2.45.2


