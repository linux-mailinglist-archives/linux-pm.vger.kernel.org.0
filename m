Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABD1A1E93
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgDHKLn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 06:11:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51281 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgDHKLn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 06:11:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TuzGZnF_1586340698;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TuzGZnF_1586340698)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Apr 2020 18:11:39 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle-haltpoll: Fix a small typo of haltpoll
Date:   Wed,  8 Apr 2020 18:11:36 +0800
Message-Id: <bb6be3ff924a6ade66a9c4be37a15adb315d47e1.1586340575.git.wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch fix a spelling typo in cpuidle-haltpoll.c

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index db124bc1ca2c..fcc53215bac8 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -94,7 +94,7 @@ static void haltpoll_uninit(void)
 	haltpoll_cpuidle_devices = NULL;
 }
 
-static bool haltpool_want(void)
+static bool haltpoll_want(void)
 {
 	return kvm_para_has_hint(KVM_HINTS_REALTIME) || force;
 }
@@ -110,7 +110,7 @@ static int __init haltpoll_init(void)
 
 	cpuidle_poll_state_init(drv);
 
-	if (!kvm_para_available() || !haltpool_want())
+	if (!kvm_para_available() || !haltpoll_want())
 		return -ENODEV;
 
 	ret = cpuidle_register_driver(drv);
-- 
2.20.1.2432.ga663e714

