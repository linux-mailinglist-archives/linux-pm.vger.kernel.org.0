Return-Path: <linux-pm+bounces-39112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD6C9D0D1
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90B9C4E4365
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5C2F9DB7;
	Tue,  2 Dec 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzvCM4fe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E162FB619
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710317; cv=none; b=MJsGUWHci6pZcNhPyDGNnG8dAMbUj1yZep+V/ukxWCPq3jAiNQ7KcIcRcnjBN9zuFFLqhk7XRWwAnE1sx8bPgF8+IKO9LHg8+gx/3MPI3pzY/wobEkhG1CS9dAOIEUIejmo4GZPxQlAaM/0I5dNTTybdR/8UAU6c85NtSJSDVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710317; c=relaxed/simple;
	bh=arRmVLWfA0OIIw0IvhTo1OlGzhGV3JXhy3hAi235i0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E36rBmUF3/QymA2YkOflvG6MfdttLhpXPnE/dshxp7JBsTapgHO8rengps5RAsO30rzDzLMKPFHzEcBOLSxoy9hCakM8yNOTmPkugNB2X9ktc/XDU2Ejv48mzmtsacyr3DkDZ/o72lTfE/tkYpE0T5/T5FWUR5QVSzih7/My+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzvCM4fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91164C4CEF1;
	Tue,  2 Dec 2025 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710317;
	bh=arRmVLWfA0OIIw0IvhTo1OlGzhGV3JXhy3hAi235i0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=TzvCM4feV5ZslCYZq/tWmKCeEdLM9QR+T6+/BNhDh7xtc3vuUKj763QaOHEz3QWjn
	 jWgqdgscCsmhtoGK7/j6Ef7nvtyjkWbqdNacw0qVudf+weRjHfdjkhOphLGWYhT7k3
	 Kgeth8D0LmHkiK9tYct5RLjzXwDsDIlzrroqhJIJaqNWYEU2ZJVMQD79SpHONXsoBl
	 eL7zUZ0HatFxXWBHV/TV//6LOCbTH5yaYO/PFBTznsLwtv5scG6hJfmGZ0AD6nkFH3
	 eMkMzU9tRtekvMAuwFZqlSomTNyLcNFC8SepVOCWhzdYOGIqmtHyo3sJ0mfOQmcIss
	 cro/8kXgyDBzQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/21] tools/power turbostat: Refactor floating point printout code
Date: Tue,  2 Dec 2025 16:13:24 -0500
Message-ID: <696d15cbd8c2cf29a8e7486bf9fbf085f4cefed6.1764710012.git.len.brown@intel.com>
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


