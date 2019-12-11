Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6211A8ED
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfLKKaw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:30:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64818 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfLKKaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 05:30:52 -0500
Received: from 79.184.253.70.ipv4.supernova.orange.pl (79.184.253.70) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 020f6036a60aed17; Wed, 11 Dec 2019 11:30:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Drop unnecessary type cast in cpuidle_poll_time()
Date:   Wed, 11 Dec 2019 11:30:50 +0100
Message-ID: <9680649.eAqxiQ8Vpk@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The data type of the target_residency_ns field in struct cpuidle_state
is u64, so it does not need to be cast into u64.

Get read of the unnecessary type cast.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the linux-next branch of linux-pm.git from today.

---
 drivers/cpuidle/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -381,7 +381,7 @@ u64 cpuidle_poll_time(struct cpuidle_dri
 		if (dev->states_usage[i].disable)
 			continue;
 
-		limit_ns = (u64)drv->states[i].target_residency_ns;
+		limit_ns = drv->states[i].target_residency_ns;
 		break;
 	}
 



