Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A415473D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBFPLm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 10:11:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBFPLm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=bJnoUKgVIb6mtplglvS+byAU4SeZA8CY+LwJLXnSv9Q=; b=d4FOvoR9mB6MjJZx9PSZuP7cMs
        8Lk51gnZiYVTlTMhF4EsGFD6ToJ60uQM4F1z/tfidYrtd2Z/d3Vx1/tAepsJS+vX2Vw5bvtQvSWfQ
        ITfIfsrOEY8H2nNNRxEZDdHdOO7oj/3nnHnagHEO00aPO9n8HaloG3GVtAQ4new1L8StvMrPtqCuf
        AELbxsHSqcEJMEB0sfJ9tE13gQIfWXMGH9eD02llxz7qLW4xZElg8JIvwpWyCTuaSDaQfHRDMMhH9
        VuN5tgp9ETqldP3c5p8VhzSkHgX7KwccuTklXw9xyz17FIEYmDivSlD4WDzJseFR+HhumxXQ+bsXV
        AuF0dzug==;
Received: from [179.95.15.160] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izioc-000432-UC; Thu, 06 Feb 2020 15:11:42 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1izioV-002oMm-N9; Thu, 06 Feb 2020 16:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/11] docs: thermal: convert cpu-idle-cooling.rst to ReST
Date:   Thu,  6 Feb 2020 16:11:20 +0100
Message-Id: <67d691731dc980b0dc9f599c8b6d031bdaba122d.1581001737.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581001737.git.mchehab+huawei@kernel.org>
References: <cover.1581001737.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

