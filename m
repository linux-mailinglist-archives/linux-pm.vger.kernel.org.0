Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADD32793
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 06:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFCEbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 00:31:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfFCEbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 00:31:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DFA0E60A05; Mon,  3 Jun 2019 04:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559536275;
        bh=ua7F1K+amXXB1vX6cvhC8jKC0nlsfYbYU1UwwZBJmPM=;
        h=From:To:Cc:Subject:Date:From;
        b=gJtElrekmixPnR9K5ZhDlNVmZyRCPpGq4u4CjwHrFVC0zAF1GucZKySTVJaEAVRGn
         Mqn8Xzfq1Sitaq50/b2GpjXfgqXZu269wFoY/mgDpC+VFHzfmHh3/y/popLRYy9D0V
         W3ZF51OgdklmSNjAaxY2YSHg3CwJVNYKIX7z4KhQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C1B26077A;
        Mon,  3 Jun 2019 04:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559536275;
        bh=ua7F1K+amXXB1vX6cvhC8jKC0nlsfYbYU1UwwZBJmPM=;
        h=From:To:Cc:Subject:Date:From;
        b=gJtElrekmixPnR9K5ZhDlNVmZyRCPpGq4u4CjwHrFVC0zAF1GucZKySTVJaEAVRGn
         Mqn8Xzfq1Sitaq50/b2GpjXfgqXZu269wFoY/mgDpC+VFHzfmHh3/y/popLRYy9D0V
         W3ZF51OgdklmSNjAaxY2YSHg3CwJVNYKIX7z4KhQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C1B26077A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Subject: [PATCH] cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending
Date:   Mon,  3 Jun 2019 10:01:03 +0530
Message-Id: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When "deep" suspend is enabled, all CPUs except the primary CPU
are hotplugged out. Since CPU hotplug is a costly operation,
check if we have to abort the suspend in between each CPU
hotplug. This would improve the system suspend abort latency
upon detecting a wakeup condition.

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f2ef104..784b33d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1221,6 +1221,13 @@ int freeze_secondary_cpus(int primary)
 	for_each_online_cpu(cpu) {
 		if (cpu == primary)
 			continue;
+
+		if (pm_wakeup_pending()) {
+			pr_info("Aborting disabling non-boot CPUs..\n");
+			error = -EBUSY;
+			break;
+		}
+
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
 		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

