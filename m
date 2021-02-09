Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3200314DB1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 11:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhBIK6Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 05:58:16 -0500
Received: from foss.arm.com ([217.140.110.172]:49632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhBIKz5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48BF11042;
        Tue,  9 Feb 2021 02:55:12 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.15.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21A083F73B;
        Tue,  9 Feb 2021 02:55:09 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Cc:     len.brown@intel.com, pavel@ucw.cz, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, greg@kroah.com
Subject: [PATCH 2/2] PM / Kconfig: remove unneeded "default n" options
Date:   Tue,  9 Feb 2021 10:54:35 +0000
Message-Id: <20210209105435.21036-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209105435.21036-1-lukasz.luba@arm.com>
References: <20210209105435.21036-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove "default n" options. If the "default" line is removed, it
defaults to 'n'.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 56dbc2616d5c..6bfe3ead10ad 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -139,7 +139,6 @@ config PM_SLEEP_SMP_NONZERO_CPU
 config PM_AUTOSLEEP
 	bool "Opportunistic sleep"
 	depends on PM_SLEEP
-	default n
 	help
 	Allow the kernel to trigger a system transition into a global sleep
 	state automatically whenever there are no active wakeup sources.
@@ -147,7 +146,6 @@ config PM_AUTOSLEEP
 config PM_WAKELOCKS
 	bool "User space wakeup sources interface"
 	depends on PM_SLEEP
-	default n
 	help
 	Allow user space to create, activate and deactivate wakeup source
 	objects with the help of a sysfs-based interface.
@@ -293,7 +291,6 @@ config PM_GENERIC_DOMAINS
 config WQ_POWER_EFFICIENT_DEFAULT
 	bool "Enable workqueue power-efficient mode by default"
 	depends on PM
-	default n
 	help
 	  Per-cpu workqueues are generally preferred because they show
 	  better performance thanks to cache locality; unfortunately,
-- 
2.17.1

