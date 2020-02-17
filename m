Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967A71617B3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgBQQUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:20:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgBQQUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K50znw7T2d7ZLRRT/oJYwAV1nhjr/eNbyg/t950G8S8=; b=ZrcpYoaBUU5wE68Qol76U7axVb
        N8WaDAIkWm1DmDmhXq7Usu+VgGCpsxddGPgANHDWFlB62qmc1ZPb8Tv3QLId1hyQLTWPq1torn3r6
        3y0wu98eCbqhXbw+wJEa1vHjXGlQWdWltz43hddoTVNYScd+ZYPhTa8pxs3tr5YpcRKwO9uo0hVK5
        y0UjF8cpYWGelX6BjVOahV++qmYGnGVoj8toTWUERh9IADTtQ0XLBVx0zA3drvtN2hWxgtv/S5qsB
        ddup/9hbNI/4twqR7WXGZGH3+su74iq8YgAppg1Cop7PL/ii+xJpM8FUcdtChtCJCP5wVcZZKIwKk
        Mkd5HpGA==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042D-2n; Mon, 17 Feb 2020 16:20:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fpg-8O; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
Date:   Mon, 17 Feb 2020 17:20:32 +0100
Message-Id: <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581956285.git.mchehab+huawei@kernel.org>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

most of the stuff there can be re-used with ReST format,
but we need to add an empty TOC and remove the existing
entries, as the following conversion patches will be re-adding
them, as they're converted.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/cpu-freq/index.rst | 35 ++++++++++++++++++++
 Documentation/cpu-freq/index.txt | 56 --------------------------------
 Documentation/index.rst          |  1 +
 3 files changed, 36 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/cpu-freq/index.rst
 delete mode 100644 Documentation/cpu-freq/index.txt

diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
new file mode 100644
index 000000000000..1bff3dfddd23
--- /dev/null
+++ b/Documentation/cpu-freq/index.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================================
+Linux CPUFreq - CPU frequency and voltage scaling code in the Linux(TM) kernel
+==============================================================================
+
+Author: Dominik Brodowski  <linux@brodo.de>
+
+   Clock scaling allows you to change the clock speed of the CPUs on the
+   fly. This is a nice method to save battery power, because the lower
+   the clock speed, the less power the CPU consumes.
+
+
+.. toctree::
+   :maxdepth: 1
+
+Mailing List
+------------
+There is a CPU frequency changing CVS commit and general list where
+you can report bugs, problems or submit patches. To post a message,
+send an email to linux-pm@vger.kernel.org.
+
+Links
+-----
+the FTP archives:
+* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
+
+how to access the CVS repository:
+* http://cvs.arm.linux.org.uk/
+
+the CPUFreq Mailing list:
+* http://vger.kernel.org/vger-lists.html#linux-pm
+
+Clock and voltage scaling for the SA-1100:
+* http://www.lartmaker.nl/projects/scaling
diff --git a/Documentation/cpu-freq/index.txt b/Documentation/cpu-freq/index.txt
deleted file mode 100644
index c15e75386a05..000000000000
--- a/Documentation/cpu-freq/index.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
-
-
-		         L i n u x    C P U F r e q
-
-
-
-
-		    Dominik Brodowski  <linux@brodo.de>
-
-
-
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
-
-
-
-Documents in this directory:
-----------------------------
-
-amd-powernow.txt -	AMD powernow driver specific file.
-
-core.txt	-	General description of the CPUFreq core and
-			of CPUFreq notifiers.
-
-cpu-drivers.txt -	How to implement a new cpufreq processor driver.
-
-cpufreq-nforce2.txt -	nVidia nForce2 platform specific file.
-
-cpufreq-stats.txt -	General description of sysfs cpufreq stats.
-
-index.txt	-	File index, Mailing list and Links (this document)
-
-pcc-cpufreq.txt -	PCC cpufreq driver specific file.
-
-
-Mailing List
-------------
-There is a CPU frequency changing CVS commit and general list where
-you can report bugs, problems or submit patches. To post a message,
-send an email to linux-pm@vger.kernel.org.
-
-Links
------
-the FTP archives:
-* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
-
-how to access the CVS repository:
-* http://cvs.arm.linux.org.uk/
-
-the CPUFreq Mailing list:
-* http://vger.kernel.org/vger-lists.html#linux-pm
-
-Clock and voltage scaling for the SA-1100:
-* http://www.lartmaker.nl/projects/scaling
diff --git a/Documentation/index.rst b/Documentation/index.rst
index e99d0bd2589d..4cf37ad1cd1d 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -99,6 +99,7 @@ needed).
    accounting/index
    block/index
    cdrom/index
+   cpu-freq/index
    ide/index
    fb/index
    fpga/index
-- 
2.24.1

