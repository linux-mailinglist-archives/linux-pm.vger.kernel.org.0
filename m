Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576928B1E8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgJLKAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:00:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:42332 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLKAf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 06:00:35 -0400
IronPort-SDR: eqTR4pqskpZdlwvAV3/uqJxQAdVfvaVAYMWMPlzcSXrebrHm4V42FFzS/tzaDKi2eTZJ/0YJyR
 73Qc9qHr3QjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145037207"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="145037207"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 03:00:34 -0700
IronPort-SDR: ZBUJ9FTeS1dbqqTgViZaqMf0Aaln1rKcDCYFdzx6WM4yYjQZUrcO1RB9kYDMZ5uXnJgABF8Ecw
 gKmnu1Qt/HpQ==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529901172"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 03:00:32 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] tools/power turbostat: Fix ACPI CState format issue
Date:   Mon, 12 Oct 2020 18:02:05 +0800
Message-Id: <20201012100205.2750-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently if the system boots with BIOS _CST Cstate information
enabled, the turbostat output would have unaligned problems:

C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
5       37      138     0.00    0.02    1.30    98.51   0.38    0.00    0.00    99.43

The C1_ACPI% is of 8 bytes, so extend the format accordingly if the field name
equals to/longer than 8 bytes.

After the patch applied:

C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
2       42      96      0.00    0.12            2.60            97.09           0.60

Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..73aa8738ae36 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -664,14 +664,16 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
 	for (mp = sys.tp; mp; mp = mp->next) {
-
+		int name_len = strlen(mp->name);
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
 				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), mp->name);
 			else
 				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), mp->name);
 		} else {
-			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+			if (((mp->type == COUNTER_ITEMS) && sums_need_wide_columns) ||
+				/* Deal with corner case: Cx_ACPI% is of 8 bytes. */
+				((mp->type == COUNTER_USEC) && name_len >= 8))
 				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), mp->name);
 			else
 				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), mp->name);
@@ -1005,6 +1007,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
+		int name_len = strlen(mp->name);
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
 				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
@@ -1016,9 +1019,13 @@ int format_counters(struct thread_data *t, struct core_data *c,
 			else
 				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			if (mp->type == COUNTER_USEC)
-				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
-			else
+			if (mp->type == COUNTER_USEC) {
+				/* Deal with corner case: Cx_ACPI% is of 8 bytes. */
+				if (name_len >= 8)
+					outp += sprintf(outp, "%s%-8.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
+				else
+					outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
+			} else
 				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
 		}
 	}
-- 
2.25.1

