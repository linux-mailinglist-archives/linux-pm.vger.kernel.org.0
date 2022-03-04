Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C44CCFA4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 09:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiCDIK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 03:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiCDIK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 03:10:27 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 00:09:39 PST
Received: from bddwd-sys-mailin03.bddwd.baidu.com (mx411.baidu.com [124.64.200.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A702AE0AC1
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 00:09:39 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by bddwd-sys-mailin03.bddwd.baidu.com (Postfix) with ESMTP id 09C3D13D0004A;
        Fri,  4 Mar 2022 15:53:29 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id F0099D9932;
        Fri,  4 Mar 2022 15:53:28 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle-haltpoll: move cpuidle_poll_state_init after
Date:   Fri,  4 Mar 2022 15:53:28 +0800
Message-Id: <1646380408-57184-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

call cpuidle_poll_state_init only if it is needed to save
some cpu cycles

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index fcc5321..3a39a7f 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -108,11 +108,11 @@ static int __init haltpoll_init(void)
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
-	cpuidle_poll_state_init(drv);
-
 	if (!kvm_para_available() || !haltpoll_want())
 		return -ENODEV;
 
+	cpuidle_poll_state_init(drv);
+
 	ret = cpuidle_register_driver(drv);
 	if (ret < 0)
 		return ret;
-- 
2.9.4

