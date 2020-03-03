Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6831777D1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgCCNwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgCCNwM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:52:12 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC0720866;
        Tue,  3 Mar 2020 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243530;
        bh=AZhsOP+n9vMIfPgdtEYEwbieN3vi8OLcgUXrspt8wYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTHlDwf2yh3N/eA8YWYp9DLKg5ONBupNca3SpdIOdc+T25gCIJNk747oSHyBa7RAe
         aUdeor2B/A3Xv3+enbdBZLkMY4TOQoSkv2pMBydwI+zI9ZsQgGAnPvno3ILmHqjYeP
         NT/LBMZFzDlqIxzOmnvhmPsM+zFHVtrGMkStz2mA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j97xw-001YXa-71; Tue, 03 Mar 2020 14:52:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 4/5] docs: cpu-freq: convert cpu-drivers.txt to ReST
Date:   Tue,  3 Mar 2020 14:52:05 +0100
Message-Id: <47e77bf300ea19920161e4e903a72004dc246460.1583243272.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583243272.git.mchehab+huawei@kernel.org>
References: <cover.1583243272.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Add a SPDX header;
- Add a document title, based on the original contents of
  cpu-freq/index.txt;
- Use lists where needed;
- Comment out the existing text-only index;
- Adjust some title marks;
- Add table markups;
- Add notes markups;
- Mark literal blocks as such;
- use ``foo`` for literal texts;
- Some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{cpu-drivers.txt => cpu-drivers.rst}      | 129 +++++++++---------
 Documentation/cpu-freq/index.rst              |   1 +
 2 files changed, 64 insertions(+), 66 deletions(-)
 rename Documentation/cpu-freq/{cpu-drivers.txt => cpu-drivers.rst} (72%)

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.rst
similarity index 72%
rename from Documentation/cpu-freq/cpu-drivers.txt
rename to Documentation/cpu-freq/cpu-drivers.rst
index 6e353d00cdc6..a697278ce190 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -1,35 +1,27 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
+.. SPDX-License-Identifier: GPL-2.0
 
+===============================================
+How to Implement a new CPUFreq Processor Driver
+===============================================
 
-		         L i n u x    C P U F r e q
+Authors:
 
-			   C P U   D r i v e r s 
 
-		       - information for developers -
+	- Dominik Brodowski  <linux@brodo.de>
+	- Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+	- Viresh Kumar <viresh.kumar@linaro.org>
 
+.. Contents
 
-		    Dominik Brodowski  <linux@brodo.de>
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
-1.   What To Do?
-1.1  Initialization
-1.2  Per-CPU Initialization
-1.3  verify
-1.4  target/target_index or setpolicy?
-1.5  target/target_index
-1.6  setpolicy
-1.7  get_intermediate and target_intermediate
-2.   Frequency Table Helpers
+   1.   What To Do?
+   1.1  Initialization
+   1.2  Per-CPU Initialization
+   1.3  verify
+   1.4  target/target_index or setpolicy?
+   1.5  target/target_index
+   1.6  setpolicy
+   1.7  get_intermediate and target_intermediate
+   2.   Frequency Table Helpers
 
 
 
@@ -49,7 +41,7 @@ function check whether this kernel runs on the right CPU and the right
 chipset. If so, register a struct cpufreq_driver with the CPUfreq core
 using cpufreq_register_driver()
 
-What shall this struct cpufreq_driver contain? 
+What shall this struct cpufreq_driver contain?
 
  .name - The name of this driver.
 
@@ -108,37 +100,42 @@ Whenever a new CPU is registered with the device model, or after the
 cpufreq driver registers itself, the per-policy initialization function
 cpufreq_driver.init is called if no cpufreq policy existed for the CPU.
 Note that the .init() and .exit() routines are called only once for the
-policy and not for each CPU managed by the policy. It takes a struct
-cpufreq_policy *policy as argument. What to do now?
+policy and not for each CPU managed by the policy. It takes a ``struct
+cpufreq_policy *policy`` as argument. What to do now?
 
 If necessary, activate the CPUfreq support on your CPU.
 
 Then, the driver must fill in the following values:
 
-policy->cpuinfo.min_freq _and_
-policy->cpuinfo.max_freq -	the minimum and maximum frequency 
-				(in kHz) which is supported by 
-				this CPU
-policy->cpuinfo.transition_latency   the time it takes on this CPU to
-				switch between two frequencies in
-				nanoseconds (if appropriate, else
-				specify CPUFREQ_ETERNAL)
-
-policy->cur			The current operating frequency of
-				this CPU (if appropriate)
-policy->min, 
-policy->max, 
-policy->policy and, if necessary,
-policy->governor		must contain the "default policy" for
-				this CPU. A few moments later,
-				cpufreq_driver.verify and either
-				cpufreq_driver.setpolicy or
-				cpufreq_driver.target/target_index is called
-				with these values.
-policy->cpus			Update this with the masks of the
-				(online + offline) CPUs that do DVFS
-				along with this CPU (i.e.  that share
-				clock/voltage rails with it).
++-----------------------------------+--------------------------------------+
+|policy->cpuinfo.min_freq _and_	    |					   |
+|policy->cpuinfo.max_freq	    | the minimum and maximum frequency	   |
+|				    | (in kHz) which is supported by	   |
+|				    | this CPU				   |
++-----------------------------------+--------------------------------------+
+|policy->cpuinfo.transition_latency | the time it takes on this CPU to	   |
+|				    | switch between two frequencies in	   |
+|				    | nanoseconds (if appropriate, else	   |
+|				    | specify CPUFREQ_ETERNAL)		   |
++-----------------------------------+--------------------------------------+
+|policy->cur			    | The current operating frequency of   |
+|				    | this CPU (if appropriate)		   |
++-----------------------------------+--------------------------------------+
+|policy->min,			    |					   |
+|policy->max,			    |					   |
+|policy->policy and, if necessary,  |					   |
+|policy->governor		    | must contain the "default policy" for|
+|				    | this CPU. A few moments later,       |
+|				    | cpufreq_driver.verify and either     |
+|				    | cpufreq_driver.setpolicy or          |
+|				    | cpufreq_driver.target/target_index is|
+|				    | called with these values.		   |
++-----------------------------------+--------------------------------------+
+|policy->cpus			    | Update this with the masks of the	   |
+|				    | (online + offline) CPUs that do DVFS |
+|				    | along with this CPU (i.e.  that share|
+|				    | clock/voltage rails with it).	   |
++-----------------------------------+--------------------------------------+
 
 For setting some of these values (cpuinfo.min[max]_freq, policy->min[max]), the
 frequency table helpers might be helpful. See the section 2 for more information
@@ -151,8 +148,8 @@ on them.
 When the user decides a new policy (consisting of
 "policy,governor,min,max") shall be set, this policy must be validated
 so that incompatible values can be corrected. For verifying these
-values cpufreq_verify_within_limits(struct cpufreq_policy *policy,
-unsigned int min_freq, unsigned int max_freq) function might be helpful.
+values cpufreq_verify_within_limits(``struct cpufreq_policy *policy``,
+``unsigned int min_freq``, ``unsigned int max_freq``) function might be helpful.
 See section 2 for details on frequency table helpers.
 
 You need to make sure that at least one valid frequency (or operating
@@ -163,7 +160,7 @@ policy->max first, and only if this is no solution, decrease policy->min.
 1.4 target or target_index or setpolicy or fast_switch?
 -------------------------------------------------------
 
-Most cpufreq drivers or even most cpu frequency scaling algorithms 
+Most cpufreq drivers or even most cpu frequency scaling algorithms
 only allow the CPU frequency to be set to predefined fixed values. For
 these, you use the ->target(), ->target_index() or ->fast_switch()
 callbacks.
@@ -175,8 +172,8 @@ limits on their own. These shall use the ->setpolicy() callback.
 1.5. target/target_index
 ------------------------
 
-The target_index call has two arguments: struct cpufreq_policy *policy,
-and unsigned int index (into the exposed frequency table).
+The target_index call has two arguments: ``struct cpufreq_policy *policy``,
+and ``unsigned int`` index (into the exposed frequency table).
 
 The CPUfreq driver must set the new frequency when called here. The
 actual frequency must be determined by freq_table[index].frequency.
@@ -184,9 +181,9 @@ actual frequency must be determined by freq_table[index].frequency.
 It should always restore to earlier frequency (i.e. policy->restore_freq) in
 case of errors, even if we switched to intermediate frequency earlier.
 
-Deprecated:
+Deprecated
 ----------
-The target call has three arguments: struct cpufreq_policy *policy,
+The target call has three arguments: ``struct cpufreq_policy *policy``,
 unsigned int target_frequency, unsigned int relation.
 
 The CPUfreq driver must set the new frequency when called here. The
@@ -210,14 +207,14 @@ Not all drivers are expected to implement it, as sleeping from within
 this callback isn't allowed. This callback must be highly optimized to
 do switching as fast as possible.
 
-This function has two arguments: struct cpufreq_policy *policy and
-unsigned int target_frequency.
+This function has two arguments: ``struct cpufreq_policy *policy`` and
+``unsigned int target_frequency``.
 
 
 1.7 setpolicy
 -------------
 
-The setpolicy call only takes a struct cpufreq_policy *policy as
+The setpolicy call only takes a ``struct cpufreq_policy *policy`` as
 argument. You need to set the lower limit of the in-processor or
 in-chipset dynamic frequency switching to policy->min, the upper limit
 to policy->max, and -if supported- select a performance-oriented
@@ -278,10 +275,10 @@ table.
 
 cpufreq_for_each_valid_entry(pos, table) - iterates over all entries,
 excluding CPUFREQ_ENTRY_INVALID frequencies.
-Use arguments "pos" - a cpufreq_frequency_table * as a loop cursor and
-"table" - the cpufreq_frequency_table * you want to iterate over.
+Use arguments "pos" - a ``cpufreq_frequency_table *`` as a loop cursor and
+"table" - the ``cpufreq_frequency_table *`` you want to iterate over.
 
-For example:
+For example::
 
 	struct cpufreq_frequency_table *pos, *driver_freq_table;
 
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 53501c58f41d..fcc58b2eee01 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -15,6 +15,7 @@ Author: Dominik Brodowski  <linux@brodo.de>
    :maxdepth: 1
 
    core
+   cpu-drivers
 
 Mailing List
 ------------
-- 
2.24.1

