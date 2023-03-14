Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FE6B9047
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCNKhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCNKgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 06:36:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4A169C9B1;
        Tue, 14 Mar 2023 03:35:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01CFD1BB2;
        Tue, 14 Mar 2023 03:35:51 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 719423F71A;
        Tue, 14 Mar 2023 03:35:04 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 17/17] Documentation: EM: Describe the API of runtime modifications
Date:   Tue, 14 Mar 2023 10:33:57 +0000
Message-Id: <20230314103357.26010-18-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314103357.26010-1-lukasz.luba@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Describe the Energy Model runtime modification API and how it can
be used.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 31 ++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index a6ceeeb72868..2fd6e82a8124 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -213,10 +213,37 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
 More details about the above APIs can be found in ``<linux/energy_model.h>``
-or in Section 3.4
+or in Section 3.5
 
 
-3.4 Description details of this API
+3.4 Runtime modifications
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Drivers willing to modify the EM at runtime should use the following API::
+
+
+  int em_dev_update_perf_domain(struct device *dev,
+			struct em_data_callback *cb, void *priv);
+
+Drivers must provide a callback .update_power() returning power value for each
+performance state. The callback function provided by the driver is free
+to fetch data from any relevant location (DT, firmware, ...) or sensor.
+The .update_power() callback is called by the EM for each performance state to
+provide new power value. In the Section 4.2 there is an example driver
+which shows simple implementation of this mechanism. The callback can be
+declared with EM_UPDATE_CB() macro. The caller of that callback also passes
+a private void pointer back to the driver which tries to update EM.
+It is useful and helps to maintain the consistent context for all performance
+state calls for a given EM.
+The artificial EM also supports runtime modifications. For this type of EM
+there is a need to provide one more callback: .get_cost(). The .get_cost()
+returns the cost value for each performance state, which better reflects the
+efficiency of the CPUs which use artificial EM. Those two callbacks:
+.update_power() and get .get_cost() can be declared with one macro
+EM_ADV_UPDATE_CB() and then passed to the em_dev_update_perf_domain().
+
+
+3.5 Description details of this API
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .. kernel-doc:: include/linux/energy_model.h
    :internal:
-- 
2.17.1

