Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE291617BD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBQQUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:20:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgBQQUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5fMHhLhtfxXOaPgcU7lG8IGkd6p13B5INTE+xMyZ9go=; b=lzXOBgAvMAStWUbm5UoDKjzdKF
        19U+BgIFZpJt1A3cTJfEXojBHvicJN6KZLzcYn/oUHYfd2twbkklm2rmvS5ca2TptfnKXmsdQRwLh
        ORFDCJXxWei1cThGOjmkh+r+P4a7KkSEB9YZ2Or/xNQpc9q3J6tuA9wX2R3MDdY30RzQ37l0BQ9fw
        R8wjV04kO1vg0or9V0rb6cl7Ovxp4T7RzpdjTf1fDS92QVZPLbvWvnyXR0+ssVKEJC/sQTi5VQ+/Z
        ASbhnvlwNxPFwEJHojR/3puXzjvhYYTIXQDEAoN/o5jPwifFvFVS4DYCWdwpbCsMCb+JsokWUzsko
        Ij+aBwyQ==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042E-8M; Mon, 17 Feb 2020 16:20:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fpq-AM; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 16/24] docs: cpu-freq: convert core.txt to ReST
Date:   Mon, 17 Feb 2020 17:20:34 +0100
Message-Id: <a99fb2be78fa83236ed92d177d5d050dcbe0cc75.1581956285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581956285.git.mchehab+huawei@kernel.org>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Add a SPDX header;
- Adjust the  document title, based on the original contents of
  cpu-freq/index.txt;
- Use lists where needed;
- Comment out the existing text-only index;
- use ``foo`` to mark a literal expression with asterisk;
- Adjust some title marks;
- Add table markups;
- Add notes markups;
- Some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/cpu-freq/{core.txt => core.rst} | 65 ++++++++++---------
 Documentation/cpu-freq/index.rst              |  1 +
 2 files changed, 34 insertions(+), 32 deletions(-)
 rename Documentation/cpu-freq/{core.txt => core.rst} (69%)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.rst
similarity index 69%
rename from Documentation/cpu-freq/core.txt
rename to Documentation/cpu-freq/core.rst
index ed577d9c154b..33cb90bd1d8f 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.rst
@@ -1,31 +1,23 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
+.. SPDX-License-Identifier: GPL-2.0
 
+=============================================================
+General description of the CPUFreq core and CPUFreq notifiers
+=============================================================
 
-		         L i n u x    C P U F r e q
+Authors:
+	- Dominik Brodowski  <linux@brodo.de>
+	- David Kimdon <dwhedon@debian.org>
+	- Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+	- Viresh Kumar <viresh.kumar@linaro.org>
 
-			  C P U F r e q    C o r e
+.. Contents:
 
-
-		    Dominik Brodowski  <linux@brodo.de>
-		     David Kimdon <dwhedon@debian.org>
-		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-		   Viresh Kumar <viresh.kumar@linaro.org>
-
-
-
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
-
-
-Contents:
----------
-1.  CPUFreq core and interfaces
-2.  CPUFreq notifiers
-3.  CPUFreq Table Generation with Operating Performance Point (OPP)
+   1.  CPUFreq core and interfaces
+   2.  CPUFreq notifiers
+   3.  CPUFreq Table Generation with Operating Performance Point (OPP)
 
 1. General Information
-=======================
+======================
 
 The CPUFreq core code is located in drivers/cpufreq/cpufreq.c. This
 cpufreq code offers a standardized interface for the CPUFreq
@@ -63,7 +55,7 @@ The phase is specified in the second argument to the notifier.  The phase is
 CPUFREQ_CREATE_POLICY when the policy is first created and it is
 CPUFREQ_REMOVE_POLICY when the policy is removed.
 
-The third argument, a void *pointer, points to a struct cpufreq_policy
+The third argument, a ``void *pointer``, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
 frequencies (in kHz) of the new policy).
 
@@ -80,10 +72,13 @@ CPUFREQ_POSTCHANGE.
 
 The third argument is a struct cpufreq_freqs with the following
 values:
-cpu	- number of the affected CPU
-old	- old frequency
-new	- new frequency
-flags	- flags of the cpufreq driver
+
+=====	===========================
+cpu	number of the affected CPU
+old	old frequency
+new	new frequency
+flags	flags of the cpufreq driver
+=====	===========================
 
 3. CPUFreq Table Generation with Operating Performance Point (OPP)
 ==================================================================
@@ -94,9 +89,12 @@ dev_pm_opp_init_cpufreq_table -
 	the OPP layer's internal information about the available frequencies
 	into a format readily providable to cpufreq.
 
-	WARNING: Do not use this function in interrupt context.
+	.. Warning::
+
+	   Do not use this function in interrupt context.
+
+	Example::
 
-	Example:
 	 soc_pm_init()
 	 {
 		/* Do things */
@@ -106,7 +104,10 @@ dev_pm_opp_init_cpufreq_table -
 		/* Do other things */
 	 }
 
-	NOTE: This function is available only if CONFIG_CPU_FREQ is enabled in
-	addition to CONFIG_PM_OPP.
+	.. note::
 
-dev_pm_opp_free_cpufreq_table - Free up the table allocated by dev_pm_opp_init_cpufreq_table
+	   This function is available only if CONFIG_CPU_FREQ is enabled in
+	   addition to CONFIG_PM_OPP.
+
+dev_pm_opp_free_cpufreq_table
+	Free up the table allocated by dev_pm_opp_init_cpufreq_table
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 6f7c2a024447..8babc5a212dd 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -15,6 +15,7 @@ Author: Dominik Brodowski  <linux@brodo.de>
    :maxdepth: 1
 
    amd-powernow
+   core
 
 Mailing List
 ------------
-- 
2.24.1

