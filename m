Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB1422D99
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhJEQQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhJEQQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:16:24 -0400
X-Greylist: delayed 1184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Oct 2021 09:14:33 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A8C061749;
        Tue,  5 Oct 2021 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=csrmaSQcoepErVbpC8vwvkqM/QnjnY7CODP5fd4S9m0=; b=RQ
        SKx6JPMyv/YavFF9kzdaP07GENOkrc0EcHep5YFAuiVV5WR7pFU1bdwF7tGOIxqLFdk8blro7snQz
        n3IayK3tX/GyJUesI1qFn5BQIK3mjF7XVYqF2IQq1C7TacXdR7Fb9rnq0SfJvws7mfFr0v81KocIJ
        2wMajU5GVbA/Dsz78+r9JC+UeSCWVriGMwjPwAh4ZlKEO1HboZripUS5PJl2GYOzsWq7RWqjGgT9d
        niCRTkRDrA24+SFzyjXTxoKUZ8zPyDx9LcWh2PLFERjtKJdLEToT+mcg15z6oYO6mF96kmfSz5V+2
        QwdvTxqaPSqpJcw565VBHwsK6qN0zYMQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mXmmB-0001ef-7s; Tue, 05 Oct 2021 16:54:43 +0100
From:   John Keeping <john@metanate.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
Date:   Tue,  5 Oct 2021 16:54:27 +0100
Message-Id: <20211005155427.1591196-1-john@metanate.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
is no reason to have a special case using the former.  Furthermore,
spin_unlock() enables preemption meaning that a task in RESUMING or
SUSPENDING state may be preempted by a higher priority task running
pm_runtime_get_sync() leading to a livelock.

Use the non-irq_safe path for all waiting so that the waiting task will
block.

Note that this changes only the waiting behaviour of irq_safe, other
uses are left unchanged so that the parent device always remains active
in the same way as !RT.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/base/power/runtime.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 96972d5f6ef3..5e0d349fab4e 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -347,8 +347,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 {
 	int retval = 0, idx;
 	bool use_links = dev->power.links_count > 0;
+	bool irq_safe = dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT);
 
-	if (dev->power.irq_safe) {
+	if (irq_safe) {
 		spin_unlock(&dev->power.lock);
 	} else {
 		spin_unlock_irq(&dev->power.lock);
@@ -376,7 +377,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	if (cb)
 		retval = cb(dev);
 
-	if (dev->power.irq_safe) {
+	if (irq_safe) {
 		spin_lock(&dev->power.lock);
 	} else {
 		/*
@@ -596,7 +597,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 			goto out;
 		}
 
-		if (dev->power.irq_safe) {
+		if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			spin_unlock(&dev->power.lock);
 
 			cpu_relax();
@@ -777,7 +778,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 			goto out;
 		}
 
-		if (dev->power.irq_safe) {
+		if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			spin_unlock(&dev->power.lock);
 
 			cpu_relax();
-- 
2.33.0

