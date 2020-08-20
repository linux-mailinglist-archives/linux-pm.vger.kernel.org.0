Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A469F24C36F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgHTQjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 12:39:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63698 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729979AbgHTQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 12:39:11 -0400
Received: from 89-64-87-57.dynamic.chello.pl (89.64.87.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 1b514db4d289dfba; Thu, 20 Aug 2020 18:39:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/4] cpufreq: intel_pstate: Refuse to turn off with HWP enabled
Date:   Thu, 20 Aug 2020 18:36:22 +0200
Message-ID: <4103589.WxEslRmDz8@kreacher>
In-Reply-To: <2283366.Lr8yYYnyev@kreacher>
References: <2283366.Lr8yYYnyev@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive
mode with HWP enabled") it is possible to change the driver status
to "off" via sysfs with HWP enabled, which effectively causes the
driver to unregister itself, but HWP remains active and it forces the
minimum performance, so even if another cpufreq driver is loaded,
it will not be able to control the CPU frequency.

For this reason, make the driver refuse to change the status to
"off" with HWP enabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e0220a6fbc69..bcda1e700a73 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2716,9 +2716,15 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 {
 	int ret;
 
-	if (size == 3 && !strncmp(buf, "off", size))
-		return intel_pstate_driver ?
-			intel_pstate_unregister_driver() : -EINVAL;
+	if (size == 3 && !strncmp(buf, "off", size)) {
+		if (!intel_pstate_driver)
+			return -EINVAL;
+
+		if (hwp_active)
+			return -EBUSY;
+
+		return intel_pstate_unregister_driver();
+	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
 		if (intel_pstate_driver) {
-- 
2.26.2




