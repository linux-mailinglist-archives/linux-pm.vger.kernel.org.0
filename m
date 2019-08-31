Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54929A45F1
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfHaTff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33349 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:35 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so21193189iog.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=W8IjgHJgjRQgzqQRCvs9HodXbINZHTbofSu+T/nBITE=;
        b=Ghawx0arY68zwQEv2cC8j36tNlC+m2OJTBOuCw4txYuGQAwettTvO/BFN9sjZexjqX
         0xCwueZyQ4swiCE2275lCufGuTosEpWSb/RhiqShE8kXtgx+qliJRRD4pHFC7+CEjUrB
         /X+TJFnRpThZBvoAFfEV5V4ZMDXGzixfAdkn4X3t3ytodKY95dCgtr+mBjLQ2Me2ZVKq
         2rvutO17MKgNj8okePcJWG1RlCC+zJtz6LQ9y62A2p6qhJT3nmik3j4vHypJceTJt6T5
         n8Fiy6n22TiEOuF4K8/9B50ACkpoDAIHkOiyfvdg8vkRzZCv8nC4dmOhTzESFEPgb3lw
         nqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=W8IjgHJgjRQgzqQRCvs9HodXbINZHTbofSu+T/nBITE=;
        b=lCDT30mRKX9LlR1l4uN9IdK3GVtQ6tpYYwEiPRXlsO8+1Cc/8F4ZfwHXr5n+Q6rdHU
         IT8Sxg7YvZ/kXqQe22fY2dZ6wnQ3kHbSQz0VMFDOXkpauIa91s5H9oz81qhyqYenNJAQ
         KJJg9w1RRWVJFIbHwJ7xydNvy4JVk5K/Xn3TM5uf84kjN/sIdxXYfgt5QBMSAshdVpZA
         Rz8CqXWcu95GKskuo8FUaosiAhcpfyc4J5dvSoYQVyIN9H20g0qO5EsPKzJOZbehtH55
         ct99HcPbqIBQl0H8xIURd5K/w3h1h2TJYpAH/DFXHKkYBQQQ6NMNG6hovC8TLRKnZ7nM
         rE1Q==
X-Gm-Message-State: APjAAAXwn0G/1CwksewitRQ6yTtbLrEuA5MHnqW5iJIOzXO+K1XwvNmR
        RxIH5FqMVJ7Mjfkv2hszAzJ/TP/w
X-Google-Smtp-Source: APXvYqw4njIhTizFyWCZ/Vqjy129RSUFopud4XHiqDxmyTFD1ot+FG130AFFIT80MpJcnmknFSloWw==
X-Received: by 2002:a6b:5a0b:: with SMTP id o11mr25364941iob.98.1567280134240;
        Sat, 31 Aug 2019 12:35:34 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:33 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 14/19] tools/power turbostat: read from pipes too
Date:   Sat, 31 Aug 2019 15:34:53 -0400
Message-Id: <c026c23629b825100fd4b8223227d9a395f9a56b.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Commit '47936f944e78 tools/power turbostat: fix printing on input' make
a valid fix, but it completely disabled piped stdin support, which is
a valuable use-case. Indeed, if stdin is a pipe, turbostat won't read
anything from it, so it becomes impossible to get turbostat output at
user-defined moments, instead of the regular intervals.

There is no reason why this should works for terminals, but not for
pipes. This patch improves the situation. Instead of ignoring pipes, we
read data from them but gracefully handle the EOF case.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 393509655449..095bd52cc086 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -100,6 +100,7 @@ unsigned int has_hwp_epp;		/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 unsigned int has_misc_feature_control;
 unsigned int first_counter_read = 1;
+int ignore_stdin;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -3013,26 +3014,37 @@ void setup_signal_handler(void)
 
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
+			 * 'stdin' is a pipe closed on the other end. There
+			 * won't be any further input.
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

