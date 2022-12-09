Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265564802E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLIJeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 04:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIJea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 04:34:30 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 01:34:28 PST
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 815481F637
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 01:34:28 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id EFA637F00053
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 17:25:23 +0800 (CST)
From:   lirongqing@baidu.com
To:     linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle-haltpoll: select haltpoll governor
Date:   Fri,  9 Dec 2022 17:25:23 +0800
Message-Id: <1670577923-39100-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

haltpoll driver should select haltpoll governor, ensure they
work together

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpuidle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index ff71dd6..cac5997 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -74,6 +74,7 @@ endmenu
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
 	depends on X86 && KVM_GUEST
+	select CPU_IDLE_GOV_HALTPOLL
 	default y
 	help
 	 This option enables halt poll cpuidle driver, which allows to poll
-- 
2.9.4

