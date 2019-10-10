Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F49D337E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfJJVeT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:34:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43958 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJJVeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:34:14 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id e382dcc9448de146; Thu, 10 Oct 2019 23:34:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/4] cpuidle: teo: Ignore disabled idle states that are too deep
Date:   Thu, 10 Oct 2019 23:32:17 +0200
Message-ID: <6803360.ubpITS43T2@kreacher>
In-Reply-To: <60416800.X4hXmAfbqi@kreacher>
References: <60416800.X4hXmAfbqi@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Prevent disabled CPU idle state with target residencies beyond the
anticipated idle duration from being taken into account by the TEO
governor.

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -258,6 +258,13 @@ static int teo_select(struct cpuidle_dri
 
 		if (s->disabled || su->disable) {
 			/*
+			 * Ignore disabled states with target residencies beyond
+			 * the anticipated idle duration.
+			 */
+			if (s->target_residency > duration_us)
+				continue;
+
+			/*
 			 * If the "early hits" metric of a disabled state is
 			 * greater than the current maximum, it should be taken
 			 * into account, because it would be a mistake to select



