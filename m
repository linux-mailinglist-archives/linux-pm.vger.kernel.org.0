Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426A215CDC7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgBMWFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49429 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgBMWFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:05 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id de92bc5a3def8b46; Thu, 13 Feb 2020 23:05:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 6/9] intel_idle: Reorder declarations of static variables
Date:   Thu, 13 Feb 2020 23:02:09 +0100
Message-ID: <5376842.2I6NC9T2nD@kreacher>
In-Reply-To: <2960689.qre192dJKD@kreacher>
References: <2960689.qre192dJKD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Reorder declarations of static variables so that the __initdata ones
are declared together.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5e627c40f6b0..3a93cd1036fb 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -65,7 +65,7 @@ static struct cpuidle_driver intel_idle_driver = {
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask;
 
-static unsigned int mwait_substates __initdata;
+static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
 static unsigned long auto_demotion_disable_flags;
 static bool disable_promotion_to_c1e;
@@ -86,9 +86,10 @@ struct idle_cpu {
 };
 
 static const struct idle_cpu *icpu __initdata;
-static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static struct cpuidle_state *cpuidle_state_table __initdata;
 
+static unsigned int mwait_substates __initdata;
+
 /*
  * Enable this state by default even if the ACPI _CST does not list it.
  */
-- 
2.16.4





