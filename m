Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6707A58B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfG3KFN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:05:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57843 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3KFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:05:12 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 29803c6a92586caf; Tue, 30 Jul 2019 12:05:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 8/8] ACPI: EC: PM: Make acpi_ec_dispatch_gpe() print debug message
Date:   Tue, 30 Jul 2019 12:04:58 +0200
Message-ID: <5021710.3QdRCBUraa@kreacher>
In-Reply-To: <7528887.mqcfy9PZua@kreacher>
References: <7528887.mqcfy9PZua@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a pm_pr_dbg() debug statement to acpi_ec_dispatch_gpe() to print
a message when the EC GPE has been dispatched (because its status
was set).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New in v2.

---
 drivers/acpi/ec.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1980,7 +1980,11 @@ bool acpi_ec_dispatch_gpe(void)
 		return false;
 
 	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	return ret == ACPI_INTERRUPT_HANDLED;
+	if (ret == ACPI_INTERRUPT_HANDLED) {
+		pm_pr_dbg("EC GPE dispatched\n");
+		return true;
+	}
+	return false;
 }
 #endif /* CONFIG_PM_SLEEP */
 



