Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C057136B7E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgAJK5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:57:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51129 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgAJK5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:55 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 06a198698930fd50; Fri, 10 Jan 2020 11:57:52 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 8/8] intel_idle: Clean up irtl_2_usec()
Date:   Fri, 10 Jan 2020 11:53:49 +0100
Message-ID: <43884200.5FZKizBWDr@kreacher>
In-Reply-To: <14127826.m9lEolTOYu@kreacher>
References: <14127826.m9lEolTOYu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the irtl_ns_units[] definition into irtl_2_usec() which is the
only user of it, drop the ns local variable from irtl_2_usec() as it
is not really necessary in there, use div_u64() for the division in
there as the divisor is small enough and use the NSEC_PER_USEC symbol
for the divisor.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1292,25 +1292,24 @@ static void __init ivt_idle_state_table_
 	/* else, 1 and 2 socket systems use default ivt_cstates */
 }
 
-/*
- * Translate IRTL (Interrupt Response Time Limit) MSR to usec
+/**
+ * irtl_2_usec - IRTL to microseconds conversion.
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
-	unsigned long long ns;
+	static const unsigned int irtl_ns_units[] __initconst = {
+		1, 32, 1024, 32768, 1048576, 33554432, 0, 0
+	};
 
 	if (!irtl)
 		return 0;
 
-	ns = irtl_ns_units[(irtl >> 10) & 0x7];
-
-	return div64_u64((irtl & 0x3FF) * ns, 1000);
+	return div_u64((irtl & 0x3FF) * irtl_ns_units[(irtl >> 10) & 0x7],
+		       NSEC_PER_USEC);
 }
+
 /*
  * bxt_idle_state_table_update(void)
  *



