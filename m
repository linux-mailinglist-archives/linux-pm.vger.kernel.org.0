Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1203B19BD27
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbgDBH6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 03:58:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:21192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgDBH6X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 03:58:23 -0400
IronPort-SDR: RMdMDC4xPTADYH2XmaMBFhhVvLroWAd6LDBKiIc4zhT05neeiG931pHXiOjIZ8ZZQCRvoFlqbp
 TK7xieU2L2GQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 00:58:22 -0700
IronPort-SDR: aWH9WU2pFjjgDUCmJAflWgcnacYwmqpUottW9hVSjKilfTfLSLozUVxCbsFcpHCXLgRBwcJ1GL
 zHXsu4/5/knQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="273469236"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2020 00:58:19 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH][v3] PM / sleep: Add pm_debug_messages boot command control
Date:   Thu,  2 Apr 2020 15:56:52 +0800
Message-Id: <20200402075652.13289-1-yu.c.chen@intel.com>
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
'pm_debug_messages'.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Randy's suggestion, add the command line
    option to Documentation/admin-guide/kernel-parameters.txt

v3: According to Rafael's suggestion, rename the boot command
    to pm_debug_messages
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 kernel/power/main.c                             | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ed73df5f1369..3fb9cbee8d28 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3720,6 +3720,9 @@
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
+	pm_debug_messages	[SUSPEND,KNL]
+			Enable suspend/resume debug messages during boot up.
+
 	pnp.debug=1	[PNP]
 			Enable PNP debug messages (depends on the
 			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 69b7a8aeca3b..40f86ec4ab30 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -535,6 +535,13 @@ static ssize_t pm_debug_messages_store(struct kobject *kobj,
 
 power_attr(pm_debug_messages);
 
+static int __init pm_debug_messages_setup(char *str)
+{
+	pm_debug_messages_on = true;
+	return 1;
+}
+__setup("pm_debug_messages", pm_debug_messages_setup);
+
 /**
  * __pm_pr_dbg - Print a suspend debug message to the kernel log.
  * @defer: Whether or not to use printk_deferred() to print the message.
-- 
2.17.1

