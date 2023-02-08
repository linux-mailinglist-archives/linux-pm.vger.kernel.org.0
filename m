Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B568F20E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjBHP30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 10:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjBHP3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 10:29:04 -0500
X-Greylist: delayed 2020 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 07:28:56 PST
Received: from mx1.net9.ga (mx1.net9.ga [IPv6:2a04:dd00:23:4:b9:6a:78:99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AA3E096
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 07:28:55 -0800 (PST)
Received: from u34 by mx1.net9.ga with local (@Mail Server)
        (envelope-from <u34@net9.ga>)
        id 1pPlqm-0008w6-Ou; Wed, 08 Feb 2023 14:55:08 +0000
Date:   Wed, 08 Feb 2023 14:55:08 +0000
To:     Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: kernel/power/Kconfig: patch, typo a single letter missing at
 line 32: should have been run-time, not run-tim
User-Agent: s-nail v14.9.22
Message-Id: <E1pPlqm-0008w6-Ou@mx1.net9.ga>
From:   u34@net9.ga
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

typo at line # 32: a single letter is missing: should have been run-time, not run-tim

config SUSPEND_SKIP_SYNC
..
--- a/kernel/power/Kconfig	2023-02-05 23:31:11.897067253 +0000
+++ b/kernel/power/Kconfig	2023-02-05 23:31:04.410465595 +0000
@@ -29,7 +29,7 @@
 	  of suspend, or they are content with invoking sync() from
 	  user-space before invoking suspend.  There's a run-time switch
 	  at '/sys/power/sync_on_suspend' to configure this behaviour.
-	  This setting changes the default for the run-tim switch. Say Y
+	  This setting changes the default for the run-time switch. Say Y
 	  to change the default to disable the kernel sys_sync().
 
 config HIBERNATE_CALLBACKS

--
u34
