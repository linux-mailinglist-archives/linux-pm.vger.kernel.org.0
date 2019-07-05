Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4560CEC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 23:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfGEVEk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 17:04:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43071 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfGEVEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 17:04:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so4770239pgv.10;
        Fri, 05 Jul 2019 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=sbAlqJjNCGJl424Ou6oGUeB5IJHxp78XDTHPHiUjj1Y=;
        b=u5/0oRoCYAS/qKKIpQasbSnOCL4tBFKCjhre5Mu3E8OrxdKeDg+8ZtlJ3xlxjWUTT7
         ufmammpxRnEVutnj5RdBnB3GZpVhbpiNtLUo2WUfDqF92xiRbz3c+UpqPs3Rn9AEJJEy
         m+S7jtdqecKe3GlhTvLVtFrgMnwTCBxC/B/IfKqAE6kFdLqpR87SFTPRZpQwBchaBLnU
         3I41jNCrxkm4T3zRj2RUGSnk+GoUQkqxjqCaqmj8/mBrIrI28ZzrCfu/gMU1QmQ749IQ
         lKmPJOU0NrO3U0fIar3VIDG7URQ3iNnvtFNLZD1Z/j637p0LhupDktemQD6QUmtgUuDF
         y/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=sbAlqJjNCGJl424Ou6oGUeB5IJHxp78XDTHPHiUjj1Y=;
        b=D3NafB+P7u6NN/otoS4PCnc6Spi1vMpdqFEOfEDCWnpLBJhPsrx++hJkUeZcxok2Wm
         bQvswSN8O3WPTStlMlZ3IdWA98LfrYBvF1yLGrv0SHAwtLr5nxvKCpwQAqLrkrizhMdi
         OF5HEu53/zuHgIg+o5bxZtmUzMjjiHIt0GnZYgHhoePzV42ZzwIheri2HWU+HWPu2mwE
         RXjIBn/WxaVCyv8HK58guj/S3vyeMUu5aUpjZDcLVaWgOZdQGCiWso+xZ2uIhDHCU5bd
         uPpbceu0D6KtnqEoNLMTdgDurZgAFEc8pu60p9/5oi9XbcIHwnC2LJGB7XxK+BkayLkL
         /6xw==
X-Gm-Message-State: APjAAAULBhzSD1yHt/sWKAION3LomNlCNSy8ZlMI8IEsu662gwEkq40U
        50QbHx/Zykf/uh59SGZqZxk=
X-Google-Smtp-Source: APXvYqyJ13QswRiuXHluWAKOlzF64CGlrERs+baaYUxU1E0IHj41mSwePPzSSIGCnV8c3ulUbbTkCA==
X-Received: by 2002:a17:90a:3401:: with SMTP id o1mr7817671pjb.7.1562360678153;
        Fri, 05 Jul 2019 14:04:38 -0700 (PDT)
Received: from localhost.localdomain ([157.32.212.148])
        by smtp.gmail.com with ESMTPSA id n19sm10774461pfa.11.2019.07.05.14.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 14:04:37 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     skhan@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Documentation: cpu-freq: Convert core.txt file to ReST format
Date:   Sat,  6 Jul 2019 02:34:28 +0530
Message-Id: <20190705210428.8039-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert core file to ReST format, in order to allow it to
be parsed by Sphinx. Make a minor change of correcting the wrong
function name cpufreq_put_cpu to cpufreq_cpu_put.
Also create an index.rst file in cpu-freq and add it's entry
in the main Documentation/index.rst file.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 Documentation/cpu-freq/core.rst  | 114 +++++++++++++++++++++++++++++
 Documentation/cpu-freq/core.txt  | 120 -------------------------------
 Documentation/cpu-freq/index.rst |  14 ++++
 Documentation/index.rst          |   1 +
 4 files changed, 129 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/cpu-freq/core.rst
 delete mode 100644 Documentation/cpu-freq/core.txt
 create mode 100644 Documentation/cpu-freq/index.rst

diff --git a/Documentation/cpu-freq/core.rst b/Documentation/cpu-freq/core.rst
new file mode 100644
index 000000000000..b4cf48633797
--- /dev/null
+++ b/Documentation/cpu-freq/core.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+CPUFreq Core
+============
+
+Authors:
+
+- Dominik Brodowski <linux@brodo.de>,
+- David Kimdon <dwhedon@debian.org>,
+- Rafael J. Wysocki <rafael.j.wysocki@intel.com>,
+- Viresh Kumar <viresh.kumar@linaro.org>
+
+
+Clock scaling allows you to change the clock speed of the CPUs on the
+fly. This is a nice method to save battery power, because the lower
+the clock speed, the less power the CPU consumes.
+
+
+1. General Information
+----------------------
+
+The CPUFreq core code is located in :file:`drivers/cpufreq/cpufreq.c`. This
+cpufreq code offers a standardized interface for the CPUFreq
+architecture drivers (those pieces of code that do actual
+frequency transitions), as well as to "notifiers". These are device
+drivers or other part of the kernel that need to be informed of
+policy changes (ex. thermal modules like ACPI) or of all
+frequency changes (ex. timing code) or even need to force certain
+speed limits (like LCD drivers on ARM architecture). Additionally, the
+kernel "constant" :c:data:`loops_per_jiffy` is updated on frequency changes
+here.
+
+Reference counting of the cpufreq policies is done by :c:func:`cpufreq_cpu_put`
+and :c:func:`cpufreq_cpu_put`, which make sure that the cpufreq driver is
+correctly registered with the core, and will not be unloaded until
+:c:func:`cpufreq_cpu_put` is called. That also ensures that the respective cpufreq
+policy doesn't get freed while being used.
+
+2. CPUFreq notifiers
+--------------------
+
+CPUFreq notifiers conform to the standard kernel notifier interface.
+See :file:`linux/include/linux/notifier.h` for details on notifiers.
+
+There are two different CPUFreq notifiers - policy notifiers and
+transition notifiers.
+
+
+2.1 CPUFreq policy notifiers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These are notified when a new policy is intended to be set. Each
+CPUFreq policy notifier is called twice for a policy transition:
+
+        1) During :c:macro:`CPUFREQ_ADJUST` all CPUFreq notifiers may change
+           the limit if they see a need for this - may it be thermal considerations
+           or hardware limitations.
+
+        2) And during :c:macro:`CPUFREQ_NOTIFY` all notifiers are informed of the
+           new policy - if two hardware drivers failed to agree on a new policy
+           before this stage, the incompatible hardware shall be shut down, and the user
+           informed of this.
+
+The phase is specified in the second argument to the notifier.
+
+The third argument, a :c:data:`void *pointer`, points to a :c:type:`struct cpufreq_policy`
+consisting of several values, including min, max (the lower and upper
+frequencies (in kHz) of the new policy).
+
+
+2.2 CPUFreq transition notifiers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These are notified twice for each online CPU in the policy, when the
+CPUfreq driver switches the CPU core frequency and this change has no
+any external implications.
+
+The second argument specifies the phase - :c:macro:`CPUFREQ_PRECHANGE` or
+:c:macro:`CPUFREQ_POSTCHANGE`.
+
+The third argument is a :c:type:`struct cpufreq_freqs` with the following
+values:
+
+| cpu   - number of the affected CPU
+| old   - old frequency
+| new   - new frequency
+| flags - flags of the cpufreq driver
+
+
+3. CPUFreq Table Generation with Operating Performance Point (OPP)
+------------------------------------------------------------------
+For details about OPP, see :file:`Documentation/power/opp.txt`
+
+:c:func:`dev_pm_opp_init_cpufreq_table` - This function provides a ready
+to use conversion routine to translate the OPP layer's internal information
+about the available frequencies into a format readily providable to cpufreq.
+
+WARNING: Do not use this function in interrupt context.
+
+	Example::
+
+	 soc_pm_init()
+	 {
+		/* Do things */
+		r = dev_pm_opp_init_cpufreq_table(dev, &freq_table);
+		if (!r)
+			policy->freq_table = freq_table;
+		/* Do other things */
+	 }
+
+NOTE: This function is available only if CONFIG_CPU_FREQ is enabled in
+addition to CONFIG_PM_OPP.
+
+:c:func:`dev_pm_opp_free_cpufreq_table` - Free up the table allocated by :c:func:`dev_pm_opp_init_cpufreq_table`
diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
deleted file mode 100644
index 073f128af5a7..000000000000
--- a/Documentation/cpu-freq/core.txt
+++ /dev/null
@@ -1,120 +0,0 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
-
-
-		         L i n u x    C P U F r e q
-
-			  C P U F r e q    C o r e
-
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
-
-1. General Information
-=======================
-
-The CPUFreq core code is located in drivers/cpufreq/cpufreq.c. This
-cpufreq code offers a standardized interface for the CPUFreq
-architecture drivers (those pieces of code that do actual
-frequency transitions), as well as to "notifiers". These are device
-drivers or other part of the kernel that need to be informed of
-policy changes (ex. thermal modules like ACPI) or of all
-frequency changes (ex. timing code) or even need to force certain
-speed limits (like LCD drivers on ARM architecture). Additionally, the
-kernel "constant" loops_per_jiffy is updated on frequency changes
-here.
-
-Reference counting of the cpufreq policies is done by cpufreq_cpu_get
-and cpufreq_cpu_put, which make sure that the cpufreq driver is
-correctly registered with the core, and will not be unloaded until
-cpufreq_put_cpu is called. That also ensures that the respective cpufreq
-policy doesn't get freed while being used.
-
-2. CPUFreq notifiers
-====================
-
-CPUFreq notifiers conform to the standard kernel notifier interface.
-See linux/include/linux/notifier.h for details on notifiers.
-
-There are two different CPUFreq notifiers - policy notifiers and
-transition notifiers.
-
-
-2.1 CPUFreq policy notifiers
-----------------------------
-
-These are notified when a new policy is intended to be set. Each
-CPUFreq policy notifier is called twice for a policy transition:
-
-1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
-    they see a need for this - may it be thermal considerations or
-    hardware limitations.
-
-2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
-   - if two hardware drivers failed to agree on a new policy before this
-   stage, the incompatible hardware shall be shut down, and the user
-   informed of this.
-
-The phase is specified in the second argument to the notifier.
-
-The third argument, a void *pointer, points to a struct cpufreq_policy
-consisting of several values, including min, max (the lower and upper
-frequencies (in kHz) of the new policy).
-
-
-2.2 CPUFreq transition notifiers
---------------------------------
-
-These are notified twice for each online CPU in the policy, when the
-CPUfreq driver switches the CPU core frequency and this change has no
-any external implications.
-
-The second argument specifies the phase - CPUFREQ_PRECHANGE or
-CPUFREQ_POSTCHANGE.
-
-The third argument is a struct cpufreq_freqs with the following
-values:
-cpu	- number of the affected CPU
-old	- old frequency
-new	- new frequency
-flags	- flags of the cpufreq driver
-
-3. CPUFreq Table Generation with Operating Performance Point (OPP)
-==================================================================
-For details about OPP, see Documentation/power/opp.txt
-
-dev_pm_opp_init_cpufreq_table -
-	This function provides a ready to use conversion routine to translate
-	the OPP layer's internal information about the available frequencies
-	into a format readily providable to cpufreq.
-
-	WARNING: Do not use this function in interrupt context.
-
-	Example:
-	 soc_pm_init()
-	 {
-		/* Do things */
-		r = dev_pm_opp_init_cpufreq_table(dev, &freq_table);
-		if (!r)
-			policy->freq_table = freq_table;
-		/* Do other things */
-	 }
-
-	NOTE: This function is available only if CONFIG_CPU_FREQ is enabled in
-	addition to CONFIG_PM_OPP.
-
-dev_pm_opp_free_cpufreq_table - Free up the table allocated by dev_pm_opp_init_cpufreq_table
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
new file mode 100644
index 000000000000..fd81d4f501cc
--- /dev/null
+++ b/Documentation/cpu-freq/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+CPU Frequency and Voltage Scaling Documentation
+===============================================
+
+.. class:: toc-title
+
+           Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   core.rst
diff --git a/Documentation/index.rst b/Documentation/index.rst
index a7566ef62411..934206bc1daf 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -102,6 +102,7 @@ needed).
    vm/index
    bpf/index
    misc-devices/index
+   cpu-freq/index
 
 Architecture-specific documentation
 -----------------------------------
-- 
2.17.1

