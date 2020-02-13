Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86915CDC9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBMWFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60834 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBMWFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:03 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id fc8c1af34e20b89f; Thu, 13 Feb 2020 23:05:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 8/9] intel_idle: Define CPUIDLE_FLAG_TLB_FLUSHED as BIT(16)
Date:   Thu, 13 Feb 2020 23:03:51 +0100
Message-ID: <15991455.PHIGOLi8R1@kreacher>
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

Use the BIT() macro for defining CPUIDLE_FLAG_TLB_FLUSHED instead of
the hex bit encoding of the same value.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9575615c8f4a..de1367d996c5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -101,7 +101,7 @@ static unsigned int mwait_substates __initdata;
  * If this flag is set, SW flushes the TLB, so even if the
  * HW doesn't do the flushing, this flag is safe to use.
  */
-#define CPUIDLE_FLAG_TLB_FLUSHED	0x10000
+#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(16)
 
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
-- 
2.16.4





