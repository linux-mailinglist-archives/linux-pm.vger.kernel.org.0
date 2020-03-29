Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD372196DFB
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgC2OsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 10:48:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:32557 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgC2OsL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 10:48:11 -0400
IronPort-SDR: iLd7iGvGspOVEtGFXGuVAv65b7ywRNq1dQb7N0Tiw4NOA+B7tpiGYw4ndBBW07zpIm2DWnHdc9
 Y+PtIyEcPwJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 07:48:10 -0700
IronPort-SDR: nBtIlt8xw3X87rGtSiAizW/ezAp70RXQNKCOhFd0IT1apP1sgku/UPl5TJEycg9t45f4eNxojk
 SoiuDVtLQgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,320,1580803200"; 
   d="scan'208";a="272123787"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2020 07:48:08 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH][v2] PM / sleep: Add pm_debug_messages boot command control
Date:   Sun, 29 Mar 2020 22:46:40 +0800
Message-Id: <20200329144640.20536-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Debug messages from the system suspend/hibernation infrastructure
is disabled by default, and can only be enabled after the system
has boot up via /sys/power/pm_debug_messages. This makes the hibernation
resume hard to track as it involves system boot up across hibernation.
There's no chance for software_resume() to track the resume process,
eg.

Turning on the pm_debug_messages during boot up by appending
'pm_debug_message'.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Randy's suggestion, add the command line
    option to Documentation/admin-guide/kernel-parameters.txt
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 kernel/power/main.c                             | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..105ec73743d7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3698,6 +3698,9 @@
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
+	pm_debug_message	[SUSPEND,KNL]
+			Enable suspend/resume debug messages during boot up.
+
 	pnp.debug=1	[PNP]
 			Enable PNP debug messages (depends on the
 			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 69b7a8aeca3b..1da3d7c15e03 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -535,6 +535,13 @@ static ssize_t pm_debug_messages_store(struct kobject *kobj,
 
 power_attr(pm_debug_messages);
 
+static int __init pm_debug_message_setup(char *str)
+{
+	pm_debug_messages_on = true;
+	return 1;
+}
+__setup("pm_debug_message", pm_debug_message_setup);
+
 /**
  * __pm_pr_dbg - Print a suspend debug message to the kernel log.
  * @defer: Whether or not to use printk_deferred() to print the message.
-- 
2.17.1

