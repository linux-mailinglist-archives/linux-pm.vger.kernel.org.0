Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADB813B597
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 00:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANXA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 18:00:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53909 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgANXA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 18:00:57 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id eee50c245019ad78; Wed, 15 Jan 2020 00:00:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rafael Wysocki <rafael@kernel.org>
Subject: [PATCH 8/8][update] intel_idle: Clean up irtl_2_usec()
Date:   Wed, 15 Jan 2020 00:00:55 +0100
Message-ID: <2321946.4oVt5DIM6V@kreacher>
In-Reply-To: <43884200.5FZKizBWDr@kreacher>
References: <14127826.m9lEolTOYu@kreacher> <43884200.5FZKizBWDr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the irtl_ns_units[] definition into irtl_2_usec() which is the
only user of it, use div_u64() for the division in there (as the
divisor is small enough) and use the NSEC_PER_USEC symbol for the
divisor.  Also convert the irtl_2_usec() comment to a proper
kerneldo one.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The original patch went a bit too far with dropping the local variable
in irtl_2_usec(), so retain it and also document the function argument
in the kerneldoc.

---
 drivers/idle/intel_idle.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1292,16 +1292,17 @@ static void __init ivt_idle_state_table_
 	/* else, 1 and 2 socket systems use default ivt_cstates */
 }
 
-/*
- * Translate IRTL (Interrupt Response Time Limit) MSR to usec
+/**
+ * irtl_2_usec - IRTL to microseconds conversion.
+ * @irtl: IRTL MSR value.
+ *
+ * Translate the IRTL (Interrupt Response Time Limit) MSR value to microseconds.
  */
-
-static const unsigned int irtl_ns_units[] __initconst = {
-	1, 32, 1024, 32768, 1048576, 33554432, 0, 0
-};
-
 static unsigned long long __init irtl_2_usec(unsigned long long irtl)
 {
+	static const unsigned int irtl_ns_units[] __initconst = {
+		1, 32, 1024, 32768, 1048576, 33554432, 0, 0
+	};
 	unsigned long long ns;
 
 	if (!irtl)
@@ -1309,8 +1310,9 @@ static unsigned long long __init irtl_2_
 
 	ns = irtl_ns_units[(irtl >> 10) & 0x7];
 
-	return div64_u64((irtl & 0x3FF) * ns, 1000);
+	return div_u64((irtl & 0x3FF) * ns, NSEC_PER_USEC);
 }
+
 /*
  * bxt_idle_state_table_update(void)
  *



