Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED71617BB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBQQUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:20:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgBQQUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pENrwyQGCHPWk+g+UqB2N09eq+FHO8Q3ndgRkaIJy9U=; b=if92APgiWWGXM8hhz4IaBL4aHN
        zHGIFA/aqE+RIP2rF699sP/uDX7uO/S2ef01vR2PIXxilAxU/Xr3gTZv80iXl6/aeSogc/U8r1KFk
        lcWMxgAUNRxcdoq8gG21TpINMo8KfC3rRNS96j2ZPCjdodwiVqlRxmkN/ce40KKzmSMz6fgUSif4l
        ma85VdpTDBGnf7sfeZhY6EL8OY00R2t5ZrrzVySva5nN+KQErHTFJBDT8tq799RlfKL7jq9n08rOI
        5+a/mrA7fJAQDR3XLs6uox7K/n/F2e8FnQfjoPbO5NPNVclQBxupg2dyCX474rQGhulzw6vRLFrVM
        FLAYx6kQ==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042H-9T; Mon, 17 Feb 2020 16:20:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fq0-Ct; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 18/24] docs: cpu-freq: convert cpufreq-nforce2.txt to ReST
Date:   Mon, 17 Feb 2020 17:20:36 +0100
Message-Id: <11b5000d757b77393170edafc02e2c96d9516a52.1581956285.git.mchehab+huawei@kernel.org>
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
- Add a document title, based on the original contents of
  cpu-freq/index.txt;
- Add table markups;
- Add notes markups;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 ...cpufreq-nforce2.txt => cpufreq-nforce2.rst} | 18 ++++++++++++++----
 Documentation/cpu-freq/index.rst               |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)
 rename Documentation/cpu-freq/{cpufreq-nforce2.txt => cpufreq-nforce2.rst} (55%)

diff --git a/Documentation/cpu-freq/cpufreq-nforce2.txt b/Documentation/cpu-freq/cpufreq-nforce2.rst
similarity index 55%
rename from Documentation/cpu-freq/cpufreq-nforce2.txt
rename to Documentation/cpu-freq/cpufreq-nforce2.rst
index babce1315026..aa0ef768a92e 100644
--- a/Documentation/cpu-freq/cpufreq-nforce2.txt
+++ b/Documentation/cpu-freq/cpufreq-nforce2.rst
@@ -1,3 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+nVidia nForce2 Platform Specifics
+=================================
 
 The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 platforms.
 
@@ -6,14 +11,19 @@ can be controlled independently from the PCI/AGP clock.
 
 The module has two options:
 
-	fid: 	 multiplier * 10 (for example 8.5 = 85)
-	min_fsb: minimum FSB
+	=======  ======================================
+	fid 	 multiplier * 10 (for example 8.5 = 85)
+	min_fsb  minimum FSB
+	=======  ======================================
 
 If not set, fid is calculated from the current CPU speed and the FSB.
 min_fsb defaults to FSB at boot time - 50 MHz.
 
-IMPORTANT: The available range is limited downwards!
-           Also the minimum available FSB can differ, for systems 
+.. Important::
+
+           The available range is limited downwards!
+
+           Also the minimum available FSB can differ, for systems
            booting with 200 MHz, 150 should always work.
 
 
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 1ab3fff53956..3fa69e6614f6 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -17,6 +17,7 @@ Author: Dominik Brodowski  <linux@brodo.de>
    amd-powernow
    core
    cpu-drivers
+   cpufreq-nforce2
 
 Mailing List
 ------------
-- 
2.24.1

