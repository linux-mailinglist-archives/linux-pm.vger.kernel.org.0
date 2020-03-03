Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE51777D3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgCCNwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbgCCNwM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:52:12 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C162086A;
        Tue,  3 Mar 2020 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243530;
        bh=objKVpKHw0GyOrZuwLkpij67clPs3E6Zb+U1ueoSZWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BD8Rrg8AuHeVmvtkjR0+0XIscuz8H+qsnA4wM5KNS7+1NmyNf9P6Gj1yh6dGv3VPZ
         dTd0/sviH59zAiFXyvDH1ktWnSkFZMYrH8FKhFMefWNOteNLoE75zqzvr+afxoUzeC
         dZ3l2G+GzTShyJ70k6yUV7rbPTma66owwp4NwIrs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j97xw-001YXe-8m; Tue, 03 Mar 2020 14:52:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 5/5] docs: cpu-freq: convert cpufreq-stats.txt to ReST
Date:   Tue,  3 Mar 2020 14:52:06 +0100
Message-Id: <71273e4caef915672dc85746db020bdb44f92dac.1583243272.git.mchehab+huawei@kernel.org>
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
- Use bold on some places;
- Mark literal blocks as such;
- Some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{cpufreq-stats.txt => cpufreq-stats.rst}  | 121 ++++++++++--------
 Documentation/cpu-freq/index.rst              |   1 +
 2 files changed, 66 insertions(+), 56 deletions(-)
 rename Documentation/cpu-freq/{cpufreq-stats.txt => cpufreq-stats.rst} (53%)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.rst
similarity index 53%
rename from Documentation/cpu-freq/cpufreq-stats.txt
rename to Documentation/cpu-freq/cpufreq-stats.rst
index 14378cecb172..9ad695b1c7db 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.rst
@@ -1,21 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-     CPU frequency and voltage scaling statistics in the Linux(TM) kernel
+==========================================
+General Description of sysfs CPUFreq Stats
+==========================================
 
+information for users
 
-             L i n u x    c p u f r e q - s t a t s   d r i v e r
 
-                       - information for users -
+Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
+.. Contents
 
-             Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
-
-Contents
-1. Introduction
-2. Statistics Provided (with example)
-3. Configuring cpufreq-stats
+   1. Introduction
+   2. Statistics Provided (with example)
+   3. Configuring cpufreq-stats
 
 
 1. Introduction
+===============
 
 cpufreq-stats is a driver that provides CPU frequency statistics for each CPU.
 These statistics are provided in /sysfs as a bunch of read_only interfaces. This
@@ -28,8 +30,10 @@ that may be running on your CPU. So, it will work with any cpufreq_driver.
 
 
 2. Statistics Provided (with example)
+=====================================
 
 cpufreq stats provides following statistics (explained in detail below).
+
 -  time_in_state
 -  total_trans
 -  trans_table
@@ -39,53 +43,57 @@ All the statistics will be from the time the stats driver has been inserted
 statistic is done. Obviously, stats driver will not have any information
 about the frequency transitions before the stats driver insertion.
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
-total 0
-drwxr-xr-x  2 root root    0 May 14 16:06 .
-drwxr-xr-x  3 root root    0 May 14 15:58 ..
---w-------  1 root root 4096 May 14 16:06 reset
--r--r--r--  1 root root 4096 May 14 16:06 time_in_state
--r--r--r--  1 root root 4096 May 14 16:06 total_trans
--r--r--r--  1 root root 4096 May 14 16:06 trans_table
---------------------------------------------------------------------------------
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # ls -l
+    total 0
+    drwxr-xr-x  2 root root    0 May 14 16:06 .
+    drwxr-xr-x  3 root root    0 May 14 15:58 ..
+    --w-------  1 root root 4096 May 14 16:06 reset
+    -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
+    -r--r--r--  1 root root 4096 May 14 16:06 total_trans
+    -r--r--r--  1 root root 4096 May 14 16:06 trans_table
+
+- **reset**
 
--  reset
 Write-only attribute that can be used to reset the stat counters. This can be
 useful for evaluating system behaviour under different governors without the
 need for a reboot.
 
--  time_in_state
+- **time_in_state**
+
 This gives the amount of time spent in each of the frequencies supported by
 this CPU. The cat output will have "<frequency> <time>" pair in each line, which
 will mean this CPU spent <time> usertime units of time at <frequency>. Output
-will have one line for each of the supported frequencies. usertime units here 
+will have one line for each of the supported frequencies. usertime units here
 is 10mS (similar to other time exported in /proc).
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat time_in_state 
-3600000 2089
-3400000 136
-3200000 34
-3000000 67
-2800000 172488
---------------------------------------------------------------------------------
-
-
--  total_trans
-This gives the total number of frequency transitions on this CPU. The cat 
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat time_in_state
+    3600000 2089
+    3400000 136
+    3200000 34
+    3000000 67
+    2800000 172488
+
+
+- **total_trans**
+
+This gives the total number of frequency transitions on this CPU. The cat
 output will have a single count which is the total number of frequency
 transitions.
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat total_trans
-20
---------------------------------------------------------------------------------
+::
+
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat total_trans
+    20
+
+- **trans_table**
 
--  trans_table
 This will give a fine grained information about all the CPU frequency
 transitions. The cat output here is a two dimensional matrix, where an entry
-<i,j> (row i, column j) represents the count of number of transitions from 
+<i,j> (row i, column j) represents the count of number of transitions from
 Freq_i to Freq_j. Freq_i rows and Freq_j columns follow the sorting order in
 which the driver has provided the frequency table initially to the cpufreq core
 and so can be sorted (ascending or descending) or unsorted.  The output here
@@ -95,26 +103,27 @@ readability.
 If the transition table is bigger than PAGE_SIZE, reading this will
 return an -EFBIG error.
 
---------------------------------------------------------------------------------
-<mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
-   From  :    To
-         :   3600000   3400000   3200000   3000000   2800000 
-  3600000:         0         5         0         0         0 
-  3400000:         4         0         2         0         0 
-  3200000:         0         1         0         2         0 
-  3000000:         0         0         1         0         3 
-  2800000:         0         0         0         2         0 
---------------------------------------------------------------------------------
+::
 
+    <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
+    From  :    To
+	    :   3600000   3400000   3200000   3000000   2800000
+    3600000:         0         5         0         0         0
+    3400000:         4         0         2         0         0
+    3200000:         0         1         0         2         0
+    3000000:         0         0         1         0         3
+    2800000:         0         0         0         2         0
 
 3. Configuring cpufreq-stats
+============================
 
-To configure cpufreq-stats in your kernel
-Config Main Menu
-	Power management options (ACPI, APM)  --->
-		CPU Frequency scaling  --->
-			[*] CPU Frequency scaling
-			[*]   CPU frequency translation statistics
+To configure cpufreq-stats in your kernel::
+
+	Config Main Menu
+		Power management options (ACPI, APM)  --->
+			CPU Frequency scaling  --->
+				[*] CPU Frequency scaling
+				[*]   CPU frequency translation statistics
 
 
 "CPU Frequency scaling" (CONFIG_CPU_FREQ) should be enabled to configure
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index fcc58b2eee01..aba7831ab1cb 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -16,6 +16,7 @@ Author: Dominik Brodowski  <linux@brodo.de>
 
    core
    cpu-drivers
+   cpufreq-stats
 
 Mailing List
 ------------
-- 
2.24.1

