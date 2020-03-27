Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75259195614
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0LNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 07:13:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:65535 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgC0LNa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 07:13:30 -0400
IronPort-SDR: 5mjP/eToJptF8XXS5ET8vWaZummJ0kMenL1I1P/2o0XsuxHnDZzcqfsS+D8G5YyICgox8m3sbx
 POOqDJW9xEqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 04:13:29 -0700
IronPort-SDR: 1TMMu0bX7LuJ4UwoUGRyHRf7VQ5nlu/6g+WiYeRMJZo1fivt+FUk4Ryr2Nt3AW5nK7X87H6Ptg
 Iu4ikqUsaBqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; 
   d="scan'208";a="247854794"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 04:13:27 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] PM / sleep: Add pm_debug_messages boot command control
Date:   Fri, 27 Mar 2020 19:11:41 +0800
Message-Id: <20200327111141.14324-1-yu.c.chen@intel.com>
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
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

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

