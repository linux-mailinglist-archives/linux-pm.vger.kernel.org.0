Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6929D159D50
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBKXiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63829 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBKXiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:50 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 0f8f0401ec19126a; Wed, 12 Feb 2020 00:38:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH 15/28] x86: platform: iosf_mbi: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:10:00 +0100
Message-ID: <2577606.BoWb2c14C5@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/update/remove_request() instead of
pm_qos_add/update/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/platform/intel/iosf_mbi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 9e2444500428..526f70f27c1c 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -265,7 +265,7 @@ static void iosf_mbi_reset_semaphore(void)
 			    iosf_mbi_sem_address, 0, PUNIT_SEMAPHORE_BIT))
 		dev_err(&mbi_pdev->dev, "Error P-Unit semaphore reset failed\n");
 
-	pm_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
 
 	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
 				     MBI_PMIC_BUS_ACCESS_END, NULL);
@@ -301,8 +301,8 @@ static void iosf_mbi_reset_semaphore(void)
  * 4) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
  *    if this happens while the kernel itself is accessing the PMIC I2C bus
  *    the SoC hangs.
- *    As the third step we call pm_qos_update_request() to disallow the CPU
- *    to enter C6 or C7.
+ *    As the third step we call cpu_latency_qos_update_request() to disallow the
+ *    CPU to enter C6 or C7.
  *
  * 5) The P-Unit has a PMIC bus semaphore which we can request to stop
  *    autonomous P-Unit tasks from accessing the PMIC I2C bus while we hold it.
@@ -338,7 +338,7 @@ int iosf_mbi_block_punit_i2c_access(void)
 	 * requires the P-Unit to talk to the PMIC and if this happens while
 	 * we're holding the semaphore, the SoC hangs.
 	 */
-	pm_qos_update_request(&iosf_mbi_pm_qos, 0);
+	cpu_latency_qos_update_request(&iosf_mbi_pm_qos, 0);
 
 	/* host driver writes to side band semaphore register */
 	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
@@ -547,8 +547,7 @@ static int __init iosf_mbi_init(void)
 {
 	iosf_debugfs_init();
 
-	pm_qos_add_request(&iosf_mbi_pm_qos, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
 
 	return pci_register_driver(&iosf_mbi_pci_driver);
 }
@@ -561,7 +560,7 @@ static void __exit iosf_mbi_exit(void)
 	pci_dev_put(mbi_pdev);
 	mbi_pdev = NULL;
 
-	pm_qos_remove_request(&iosf_mbi_pm_qos);
+	cpu_latency_qos_remove_request(&iosf_mbi_pm_qos);
 }
 
 module_init(iosf_mbi_init);
-- 
2.16.4





