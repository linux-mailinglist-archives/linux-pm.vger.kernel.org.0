Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6D2B17A0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 09:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgKMI6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 03:58:34 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51864 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgKMI6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 03:58:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UFAepvk_1605257910;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAepvk_1605257910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 16:58:31 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / suspend: fix kernel-doc markup
Date:   Fri, 13 Nov 2020 16:58:10 +0800
Message-Id: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add parameter explanation to fix kernel-doc marks:

kernel/power/suspend.c:233: warning: Function parameter or member
'state' not described in 'suspend_valid_only_mem'
kernel/power/suspend.c:344: warning: Function parameter or member
'state' not described in 'suspend_prepare'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> 
Cc: Len Brown <len.brown@intel.com> 
Cc: Pavel Machek <pavel@ucw.cz> 
Cc: linux-pm@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/power/suspend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 32391acc806b..502d86ed99c7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -224,6 +224,7 @@ EXPORT_SYMBOL_GPL(suspend_set_ops);
 
 /**
  * suspend_valid_only_mem - Generic memory-only valid callback.
+ * @state: Suspend state to be set
  *
  * Platform drivers that implement mem suspend only and only need to check for
  * that in their .valid() callback can use this instead of rolling their own
@@ -335,6 +336,7 @@ static int suspend_test(int level)
 
 /**
  * suspend_prepare - Prepare for entering system sleep state.
+ * @state: suspend state which sleep from
  *
  * Common code run for every system sleep state that can be entered (except for
  * hibernation).  Run suspend notifiers, allocate the "suspend" console and
-- 
2.29.GIT

