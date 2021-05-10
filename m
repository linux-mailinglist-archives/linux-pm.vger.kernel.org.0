Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067ED37821D
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhEJKcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 06:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhEJKah (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 May 2021 06:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC1936191A;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=EU2r5/qQuL1o99O82KhZSnDOsgNg5571ceroSUVJZiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9ltI7mA23iDZx3X4S7668m4sgK93aCcGX+u2aYe+Nh+zkBRX7EwPOxbNtLwkVgxe
         o+F9aoYAOFQtHJPWJh233eFQkDxkghfAs/ycG6hp+JXUBkiGu6dw6qAsyydTmVzoUP
         3i7eoqNQ5D/eJuE3zxR+yMs+b47Oy/2pAxj/X38R+/otw4DKmDdJBs++/0DHe77ci/
         aYLa1biXpVj92c/oo+C2hQyVb0u3ETyBDNdJaTwq5AzQTcx5kZMlYUNkQ68LlUUk5g
         nXB45cPS9y1h2gsf7shU+mw1T/UxdbuLcHs6fWogMJPUB3js9aSbRDSwM5c+A2qFXB
         uxgKzabP0Z5OA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPI-29; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 15/53] docs: driver-api: thermal: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:27 +0200
Message-Id: <211acd2166c5ede7b50ebb90225c11386a48cadf.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../driver-api/thermal/cpu-idle-cooling.rst        | 14 +++++++-------
 .../driver-api/thermal/intel_powerclamp.rst        |  6 +++---
 .../thermal/x86_pkg_temperature_thermal.rst        |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index c2a7ca676853..60934a518560 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -49,7 +49,7 @@ belong to the same cluster, with a duration greater than the cluster
 idle state target residency, we lead to dropping the static and the
 dynamic leakage for this period (modulo the energy needed to enter
 this state). So the sustainable power with idle cycles has a linear
-relation with the OPP’s sustainable power and can be computed with a
+relation with the OPP's sustainable power and can be computed with a
 coefficient similar to::
 
 	    Power(IdleCycle) = Coef x Power(OPP)
@@ -134,7 +134,7 @@ The idle injection duration value must comply with the constraints:
   user experience, reactivity vs performance trade off we want. This
   value should be specified.
 
-- It is greater than the idle state’s target residency we want to go
+- It is greater than the idle state's target residency we want to go
   for thermal mitigation, otherwise we end up consuming more energy.
 
 Power considerations
@@ -146,11 +146,11 @@ power for a specific temperature but at this time we consume::
  Power = Capacitance x Voltage^2 x Frequency x Utilisation
 
 ... which is more than the sustainable power (or there is something
-wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
-fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
-because we don’t want to change the OPP. We can group the
-‘Capacitance’ and the ‘Utilisation’ into a single term which is the
-‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have::
+wrong in the system setup). The 'Capacitance' and 'Utilisation' are a
+fixed value, 'Voltage' and the 'Frequency' are fixed artificially
+because we don't want to change the OPP. We can group the
+'Capacitance' and the 'Utilisation' into a single term which is the
+'Dynamic Power Coefficient (Cdyn)' Simplifying the above, we have::
 
  Pdyn = Cdyn x Voltage^2 x Frequency
 
diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
index 3f6dfb0b3ea6..d349c1b64281 100644
--- a/Documentation/driver-api/thermal/intel_powerclamp.rst
+++ b/Documentation/driver-api/thermal/intel_powerclamp.rst
@@ -29,7 +29,7 @@ By:
 INTRODUCTION
 ============
 
-Consider the situation where a system’s power consumption must be
+Consider the situation where a system's power consumption must be
 reduced at runtime, due to power budget, thermal constraint, or noise
 level, and where active cooling is not preferred. Software managed
 passive power reduction must be performed to prevent the hardware
@@ -39,7 +39,7 @@ Currently, P-states, T-states (clock modulation), and CPU offlining
 are used for CPU throttling.
 
 On Intel CPUs, C-states provide effective power reduction, but so far
-they’re only used opportunistically, based on workload. With the
+they're only used opportunistically, based on workload. With the
 development of intel_powerclamp driver, the method of synchronizing
 idle injection across all online CPU threads was introduced. The goal
 is to achieve forced and controllable C-state residency.
@@ -264,7 +264,7 @@ CPUs).
 Usage and Interfaces
 ====================
 The powerclamp driver is registered to the generic thermal layer as a
-cooling device. Currently, it’s not bound to any thermal zones::
+cooling device. Currently, it's not bound to any thermal zones::
 
   jacob@chromoly:/sys/class/thermal/cooling_device14$ grep . *
   cur_state:0
diff --git a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
index 2ac42ccd236f..5b95af96e40f 100644
--- a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
+++ b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
@@ -13,7 +13,7 @@ Authors: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 Reference
 ---------
 
-Intel® 64 and IA-32 Architectures Software Developer’s Manual (Jan, 2013):
+Intel® 64 and IA-32 Architectures Software Developer's Manual (Jan, 2013):
 Chapter 14.6: PACKAGE LEVEL THERMAL MANAGEMENT
 
 Description
-- 
2.30.2

