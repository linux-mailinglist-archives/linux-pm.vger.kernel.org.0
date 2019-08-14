Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB28D8BE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHNRCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 13:02:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:43794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfHNRCD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 13:02:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 10:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="376112591"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2019 10:02:02 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 2/2] tools/power turbostat: do not enforce 1ms
Date:   Wed, 14 Aug 2019 20:01:59 +0300
Message-Id: <20190814170159.42952-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814170159.42952-1-dedekind1@gmail.com>
References: <20190814170159.42952-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Turbostat works by taking a snapshot of counters, sleeping, taking another
snapshot, calculating deltas, and printing out the table.

The sleep time is controlled via -i option or by user sending a signal or a
character to stdin. In the latter case, turbostat always adds 1 ms
sleep before it reads the counters, in order to avoid larger imprecisions
in the results in prints.

While the 1 ms delay may be a good idea for a "dumb" user, it is a
problem for an "aware" user. I do thousands and thousands of measurements
over a short period of time (like 2ms), and turbostat unconditionally adds
a 1ms to my interval, so I cannot get what I really need.

This patch removes the unconditional 1ms sleep. This is an expert user
tool, after all, and non-experts will unlikely ever use it in the non-fixed
interval mode anyway, so I think it is OK to remove the 1ms delay.

Change-Id: Id2075036e7e2c682b34c9597d2dade13ea28acf6
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 573230a774cd..57e236187cdb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -39,7 +39,6 @@ FILE *outf;
 int *fd_percpu;
 struct timeval interval_tv = {5, 0};
 struct timespec interval_ts = {5, 0};
-struct timespec one_msec = {0, 1000000};
 unsigned int num_iterations;
 unsigned int debug;
 unsigned int quiet;
@@ -2986,8 +2985,6 @@ static void signal_handler (int signal)
 			fprintf(stderr, "SIGUSR1\n");
 		break;
 	}
-	/* make sure this manually-invoked interval is at least 1ms long */
-	nanosleep(&one_msec, NULL);
 }
 
 void setup_signal_handler(void)
@@ -3038,8 +3035,6 @@ void do_sleep(void)
 			rest.tv_nsec = (tout.tv_usec % 1000000) * 1000;
 			nanosleep(&rest, NULL);
 		}
-		/* make sure this manually-invoked interval is at least 1ms long */
-		nanosleep(&one_msec, NULL);
 	}
 }
 
-- 
2.20.1

