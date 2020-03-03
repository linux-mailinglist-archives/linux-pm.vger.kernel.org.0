Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3421777CE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgCCNwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCNwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD1620675;
        Tue,  3 Mar 2020 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243530;
        bh=oSAwJuwZZke99vm8rocsC6A/BaGIh2GI4Jpuuu+iYYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxnENgzxwpXsmE3dtubVuBr9/LU6NSl+HbofJ79fS7inJ2vHZvsx+oUvF+ICTsB4P
         hUUTN4p4anj0+UoOAQxj+eXT9JsQ/hkb5f07gv50OX2EuUammhXSXLP3sgDvYVSI4b
         zYdiq+QwJ0jPigAsscEk/0K1FqKMWBUwo9WExpAs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j97xw-001YXR-3Y; Tue, 03 Mar 2020 14:52:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/5] docs: cpu-freq: convert index.txt to ReST
Date:   Tue,  3 Mar 2020 14:52:03 +0100
Message-Id: <7aed5eca5b3501328bc715c70613c21497467368.1583243272.git.mchehab+huawei@kernel.org>
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

