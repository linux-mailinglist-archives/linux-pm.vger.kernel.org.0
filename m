Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877D521F90D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGNSR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 14:17:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62378 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgGNSR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 14:17:27 -0400
Received: from 89-64-83-139.dynamic.chello.pl (89.64.83.139) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 5dfe8d161d0ab4fd; Tue, 14 Jul 2020 20:17:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported
Date:   Tue, 14 Jul 2020 20:17:24 +0200
Message-ID: <1776084.Fkt4dJnx8e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Although there are processors supporting hardware-managed P-states
(HWP) without the energy-performance preference (EPP) feature, they
are not expected to be run with HWP enabled (the BIOS should disable
HWP on those systems).  Missing EPP support generally indicates an
incomplete HWP implementation and so it is better to avoid using
HWP on those systems in production.

However, intel_pstate currently enables HWP on such systems, which
is questionable, so prevent it from doing that by making it check
EPP support before enabling HWP and avoid enabling it if EPP is not
supported by the processor at hand.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2899,7 +2899,12 @@ static int __init intel_pstate_init(void
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
 		copy_cpu_funcs(&core_funcs);
-		if (!no_hwp) {
+		/*
+		 * Avoid enabling HWP for processors without EPP support,
+		 * because that means incomplete HWP implementation which is a
+		 * corner case and supporting it is generally problematic.
+		 */
+		if (!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 			hwp_active++;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;



