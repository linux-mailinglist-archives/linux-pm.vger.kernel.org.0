Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650BCA45F2
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfHaTfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34995 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:36 -0400
Received: by mail-io1-f66.google.com with SMTP id b10so21164073ioj.2
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=m4A5h0f2b2nIrrIPM5usQ/YpBoauyjrswSSVHT+GqA4=;
        b=OTE1NmxrAPQTE79fVy3rHqSygD/ToDFmqIOgXu2AEpIXjahPUW32vjR/apVhWZSaFd
         Egf0PDwzEBYOj1N19A4thGRR5RZ7vpZavaqwBWEmj54lpOHKurBoO0WbolUvg7ZlVNK5
         5B+qwqIU0SAcdA3yUkSu3CVNL7ZzHY47IjdHRFuSW9LkxeYZE8AjNxMnBd09ja7D+iBq
         c/zNayemBQErDboHY3t9xygkZG+xAH7QNF3+nYbKk99BPWJLEkq9A1nGo/ZoHzJMlEll
         ZBb+E5dV6sn7JCdhnkrkjGcK8lfc7FZEnyGnhSxfjUuK/S/T1IFouQgh/t8ySzA7Ccdi
         Y5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=m4A5h0f2b2nIrrIPM5usQ/YpBoauyjrswSSVHT+GqA4=;
        b=aPp9vE0cMY5ysonEdGrAcZ6evuZpIbxsM7SrLvWwX/ptl/MBLWpWXmDe5HapQVOtG0
         GmBhgT7m4yRZOlOA9PeIQG/YbCu27eN8S14QVPxiTU/T41FNnyHARR2+LxwuRQlq27e8
         SD5qbbKHslpg9+wZpN/v//hRcyFVq8NvTr4Mibb0AKne5Vp1kG0wlGg7NLIyj9i+f54Q
         KlMyYud7RyZ6j2lwqERf2T11VnqzfiMy760KrqhPUW0b5WnCmX8+m2BfTC5Z+xlUDafT
         Z+WCQQtai06wLGU9uHZljJI6WAmpaQ0R3F0FIblmuo9EKgbyglmUw/kfZq9B/HclV/wV
         GGlw==
X-Gm-Message-State: APjAAAXZQqrDk9N0uI8lC2v31yVxCiPTaO55PFmCiajF0TeZK1aMog/5
        UC+bBZXRzB2KdsIe78ipavDcK/BX
X-Google-Smtp-Source: APXvYqyYI7mAUMw3DsAj31YazUrUV2bO7R4gVtjB0/jBA7cUIY99G3KhSABAedILEgNnJ68qAABS5Q==
X-Received: by 2002:a5d:9dc9:: with SMTP id 9mr17414434ioo.199.1567280135258;
        Sat, 31 Aug 2019 12:35:35 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:34 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 15/19] tools/power turbostat: do not enforce 1ms
Date:   Sat, 31 Aug 2019 15:34:54 -0400
Message-Id: <6ee9fc63d2e7999f93a466e202ae3b557e9c739c.1567277326.git.len.brown@intel.com>
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

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 095bd52cc086..7d72268e546d 100644
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
@@ -2994,8 +2993,6 @@ static void signal_handler (int signal)
 			fprintf(stderr, "SIGUSR1\n");
 		break;
 	}
-	/* make sure this manually-invoked interval is at least 1ms long */
-	nanosleep(&one_msec, NULL);
 }
 
 void setup_signal_handler(void)
@@ -3046,8 +3043,6 @@ void do_sleep(void)
 			rest.tv_nsec = (tout.tv_usec % 1000000) * 1000;
 			nanosleep(&rest, NULL);
 		}
-		/* make sure this manually-invoked interval is at least 1ms long */
-		nanosleep(&one_msec, NULL);
 	}
 }
 
-- 
2.20.1

