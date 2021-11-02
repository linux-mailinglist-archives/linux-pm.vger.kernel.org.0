Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13FD443503
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKBSEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 14:04:32 -0400
Received: from foss.arm.com ([217.140.110.172]:41142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234282AbhKBSEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 14:04:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D614011B3;
        Tue,  2 Nov 2021 11:01:56 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.28.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F3C33F7B4;
        Tue,  2 Nov 2021 11:01:55 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] Documentation: power: Describe 'advanced' and 'simple' EM models
Date:   Tue,  2 Nov 2021 18:01:44 +0000
Message-Id: <20211102180144.1647-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211102180144.1647-1-lukasz.luba@arm.com>
References: <20211102180144.1647-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) can be registered in two ways:
1) Using a helper function, which under the hood relies on OPP framework
   and DT entry in CPU node: 'dynamic-power-coefficient'. This is
   a 'simple' EM because it's tight to the math formula:
   Power = dynamic-power-coefficient * V^2 * f
2) Using em_dev_register_perf_domain() API function with a driver
   custom callback which provides power for each performance state.
   This is an 'advanced' EM, since it can better reflect real power
   measurements for each performance state. It's not limited to any math
   formula and can better reflect real physics of the device.

Add description of these two methods to the documentation, so developers
could choose the suitable registration method (option).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 7af0e1760962..5ac62a7b4b7c 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -84,6 +84,16 @@ CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
 2.2 Registration of performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
+Registration of 'advanced' EM
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The 'advanced' EM gets it's name due to the fact that the driver is allowed
+to provide more precised power model. It's not limited to some implemented math
+formula in the framework (like it's in 'simple' EM case). It can better reflect
+the real power measurements performed for each performance state. Thus, this
+registration method should be preferred in case considering EM static power
+(leakage) is important.
+
 Drivers are expected to register performance domains into the EM framework by
 calling the following API::
 
@@ -103,6 +113,18 @@ to: return warning/error, stop working or panic.
 See Section 3. for an example of driver implementing this
 callback, or Section 2.4 for further documentation on this API
 
+Registration of 'simple' EM
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The 'simple' EM is registered using the framework helper function
+cpufreq_register_em_with_opp(). It implements a power model which is tight to
+math formula::
+
+	Power = C * V^2 * f
+
+The EM which is registered using this method might not reflect correctly the
+physics of a real device, e.g. when static power (leakage) is important.
+
 
 2.3 Accessing performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.17.1

