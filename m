Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51717314DB0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 11:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhBIK6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 05:58:11 -0500
Received: from foss.arm.com ([217.140.110.172]:49620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhBIKzx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA17CED1;
        Tue,  9 Feb 2021 02:55:07 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.15.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8942B3F73B;
        Tue,  9 Feb 2021 02:55:05 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Cc:     len.brown@intel.com, pavel@ucw.cz, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, greg@kroah.com
Subject: [PATCH 1/2] PM / EM: update Kconfig description and drop "default n" option
Date:   Tue,  9 Feb 2021 10:54:34 +0000
Message-Id: <20210209105435.21036-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Energy Model supports now other devices like GPUs, DSPs, not only CPUs.
Thus, update the description in the config option. Remove also unneeded
"default n". If the "default" line is removed, it defaults to 'n'.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a7320f07689d..56dbc2616d5c 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -322,15 +322,14 @@ config CPU_PM
 	bool
 
 config ENERGY_MODEL
-	bool "Energy Model for CPUs"
+	bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
 	depends on SMP
 	depends on CPU_FREQ
-	default n
 	help
 	  Several subsystems (thermal and/or the task scheduler for example)
-	  can leverage information about the energy consumed by CPUs to make
-	  smarter decisions. This config option enables the framework from
-	  which subsystems can access the energy models.
+	  can leverage information about the energy consumed by devices to
+	  make smarter decisions. This config option enables the framework
+	  from which subsystems can access the energy models.
 
 	  The exact usage of the energy model is subsystem-dependent.
 
-- 
2.17.1

