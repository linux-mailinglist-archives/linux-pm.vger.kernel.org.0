Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64A28D8BD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfHNRCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 13:02:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:43794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfHNRCC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 13:02:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 10:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="376112586"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2019 10:02:00 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/2] tools/power turbostat: read from pipes too
Date:   Wed, 14 Aug 2019 20:01:58 +0300
Message-Id: <20190814170159.42952-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: root <root@bdwup0.bdwup0net>

Commit '47936f944e78 tools/power turbostat: fix printing on input' make
a valid fix, but it completely disabled piped stdin support, which is
a valuable use-case. Indeed, if stdin is a pipe, turbostat won't read
anything from it, so it becomes impossible to get turbostat output at
user-defined moments, instead of the regular intervals.

There is no reson why this should works for terminals, but not for
pipes. This patch imporves the situation. Instead of ignoring pipes, we
read data from them but gracefully handle the EOF case.

Change-Id: Iadf2f17d10bc0d3896bb96a6e466896ec70f2c4c
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..573230a774cd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -100,6 +100,7 @@ unsigned int has_hwp_epp;		/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 unsigned int has_misc_feature_control;
 unsigned int first_counter_read = 1;
+int ignore_stdin = 0;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -3005,26 +3006,37 @@ void setup_signal_handler(void)
 
 void do_sleep(void)
 {
-	struct timeval select_timeout;
+	struct timeval tout;
+	struct timespec rest;
 	fd_set readfds;
 	int retval;
 
 	FD_ZERO(&readfds);
 	FD_SET(0, &readfds);
 
-	if (!isatty(fileno(stdin))) {
+	if (ignore_stdin) {
 		nanosleep(&interval_ts, NULL);
 		return;
 	}
 
-	select_timeout = interval_tv;
-	retval = select(1, &readfds, NULL, NULL, &select_timeout);
+	tout = interval_tv;
+	retval = select(1, &readfds, NULL, NULL, &tout);
 
 	if (retval == 1) {
 		switch (getc(stdin)) {
 		case 'q':
 			exit_requested = 1;
 			break;
+		case EOF:
+			/*
+			 * 'stdin' is a pipe closed by the other end. There
+			 * won't be any input in the future.
+			 */
+			ignore_stdin = 1;
+			/* Sleep the rest of the time */
+			rest.tv_sec = (tout.tv_sec + tout.tv_usec / 1000000);
+			rest.tv_nsec = (tout.tv_usec % 1000000) * 1000;
+			nanosleep(&rest, NULL);
 		}
 		/* make sure this manually-invoked interval is at least 1ms long */
 		nanosleep(&one_msec, NULL);
-- 
2.20.1

