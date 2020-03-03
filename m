Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9B1777FC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgCCN7e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbgCCN7e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:59:34 -0500
Received: from mail.kernel.org (ip-109-40-2-133.web.vodafone.de [109.40.2.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EE42086A;
        Tue,  3 Mar 2020 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243973;
        bh=GXfnyk+5mxcLxh7DS10kpV2zW4ajtTvIlfSvgF1m6HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNvmQkFkGTTZ9SAElkKCymrRmKBJg3ps3QC1Z3aRjJ2c3utTFZ1+PmQGzXHHjiqJk
         sx//8xzS7V6UorAHjnpn8vLH/hFdEfGxjUV+dwOEHeUr5CABp2Gu2t04GZbSkXgZVn
         zZgeBbVYg9DDirhCphReZIfKJnWJbn2mmfLFH+Zg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j9850-001Ycx-3n; Tue, 03 Mar 2020 14:59:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 01/18] docs: thermal: convert cpu-idle-cooling.rst to ReST
Date:   Tue,  3 Mar 2020 14:59:08 +0100
Message-Id: <7a50b03cd14972a0b7ba9be06ff02203f5284d79.1583243826.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583243826.git.mchehab+huawei@kernel.org>
References: <cover.1583243826.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Despite being named with .rst extension, this file doesn't
match the ReST standard. It actually causes a crash at
Sphinx:

	Sphinx parallel build error:
	docutils.utils.SystemMessage: /devel/v4l/docs/Documentation/driver-api/thermal/cpu-idle-cooling.rst:69: (SEVERE/4) Unexpected section title.

Add needed markups for it to be properly parsed.

While here, add it to the thermal index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../driver-api/thermal/cpu-idle-cooling.rst    | 18 ++++++++++++------
 Documentation/driver-api/thermal/index.rst     |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index 9f0016ee4cfb..357d2f023605 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+CPU Idle Cooling
+================
+
 
 Situation:
 ----------
@@ -45,7 +51,7 @@ idle state target residency, we lead to dropping the static and the
 dynamic leakage for this period (modulo the energy needed to enter
 this state). So the sustainable power with idle cycles has a linear
 relation with the OPP’s sustainable power and can be computed with a
-coefficient similar to:
+coefficient similar to::
 
 	    Power(IdleCycle) = Coef x Power(OPP)
 
@@ -136,7 +142,7 @@ Power considerations
 --------------------
 
 When we reach the thermal trip point, we have to sustain a specified
-power for a specific temperature but at this time we consume:
+power for a specific temperature but at this time we consume::
 
  Power = Capacitance x Voltage^2 x Frequency x Utilisation
 
@@ -145,7 +151,7 @@ wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
 fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
 because we don’t want to change the OPP. We can group the
 ‘Capacitance’ and the ‘Utilisation’ into a single term which is the
-‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have::
 
  Pdyn = Cdyn x Voltage^2 x Frequency
 
@@ -154,7 +160,7 @@ in order to target the sustainable power defined in the device
 tree. So with the idle injection mechanism, we want an average power
 (Ptarget) resulting in an amount of time running at full power on a
 specific OPP and idle another amount of time. That could be put in a
-equation:
+equation::
 
  P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
 			(Trunning + Tidle)
@@ -165,7 +171,7 @@ equation:
 
 At this point if we know the running period for the CPU, that gives us
 the idle injection we need. Alternatively if we have the idle
-injection duration, we can compute the running duration with:
+injection duration, we can compute the running duration with::
 
  Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
 
@@ -188,7 +194,7 @@ However, in this demonstration we ignore three aspects:
    target residency, otherwise we end up consuming more energy and
    potentially invert the mitigation effect
 
-So the final equation is:
+So the final equation is::
 
  Trunning = (Tidle - Twakeup ) x
 		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 5ba61d19c6ae..4cb0b9b6bfb8 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -8,6 +8,7 @@ Thermal
    :maxdepth: 1
 
    cpu-cooling-api
+   cpu-idle-cooling
    sysfs-api
    power_allocator
 
-- 
2.24.1

