Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823B11617D2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgBQQU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:20:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgBQQUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jLWQhdjlNUCvPW2x0jtz8CREosgEHwxuovRUzRlgqDg=; b=hsSIlzNJdpuYMfFdAgTlQr4cMW
        OBEQozCh2VV0JPvYBKObSHXd2OnmJ15hhPh06NffSd7dVkESle6A6+56gBRO8AoQWPk2DUTxFqgD3
        rfhwg5p4XjO6+z2Pdv3GU4I6as2jlXa7SZtuFFTYEblb4q3ppiU8+ZVjcJUcP5dkE6vImtbM+fFWx
        lYizYDJaZ1ySNMPoRyAS7qtQq7WAPi9VqFa75qWUN7Ya/jIq+E0ZzUMYrIe0peLvV5lyiK1ZmIRYR
        cIP+1MKPMaPlofi/rUkhF0Zyj6CWm8bHkeH46zFGQ6sP+Z32/jGfF5+mLWpQgmNMx5Noz8tuIQFD5
        Y5jc6IeA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j8Y-00042J-Cn; Mon, 17 Feb 2020 16:20:51 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8W-000fqA-Ef; Mon, 17 Feb 2020 17:20:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 20/24] docs: cpu-freq: convert pcc-cpufreq.txt to ReST
Date:   Mon, 17 Feb 2020 17:20:38 +0100
Message-Id: <63ed3462eb3083290d9bc41332ab45524a71b3d9.1581956285.git.mchehab+huawei@kernel.org>
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
- Add copyright symbol;
- Remove a c-like comment, adding the useful info not covered
  by the SPDX and document title headers as text;
- Comment out the existing text-only index;
- Mark literal blocks as such;
- Some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/cpu-freq/index.rst              |  1 +
 .../{pcc-cpufreq.txt => pcc-cpufreq.rst}      | 86 ++++++++-----------
 2 files changed, 38 insertions(+), 49 deletions(-)
 rename Documentation/cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst} (80%)

diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index d12ef0bb78a5..fb2db2eb7eaf 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -19,6 +19,7 @@ Author: Dominik Brodowski  <linux@brodo.de>
    cpu-drivers
    cpufreq-nforce2
    cpufreq-stats
+   pcc-cpufreq
 
 Mailing List
 ------------
diff --git a/Documentation/cpu-freq/pcc-cpufreq.txt b/Documentation/cpu-freq/pcc-cpufreq.rst
similarity index 80%
rename from Documentation/cpu-freq/pcc-cpufreq.txt
rename to Documentation/cpu-freq/pcc-cpufreq.rst
index 9e3c3b33514c..6fd891f757a7 100644
--- a/Documentation/cpu-freq/pcc-cpufreq.txt
+++ b/Documentation/cpu-freq/pcc-cpufreq.rst
@@ -1,45 +1,29 @@
-/*
- *  pcc-cpufreq.txt - PCC interface documentation
- *
- *  Copyright (C) 2009 Red Hat, Matthew Garrett <mjg@redhat.com>
- *  Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
- *      Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or NON
- *  INFRINGEMENT. See the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+=========================================================
+Processor Clocking Control (PCC) CPUFreq Driver Specifics
+=========================================================
 
-			Processor Clocking Control Driver
-			---------------------------------
+Copyright |copy| 2009 Red Hat, Matthew Garrett <mjg@redhat.com>
 
-Contents:
----------
-1.	Introduction
-1.1	PCC interface
-1.1.1   Get Average Frequency
-1.1.2	Set Desired Frequency
-1.2	Platforms affected
-2.	Driver and /sys details
-2.1	scaling_available_frequencies
-2.2	cpuinfo_transition_latency
-2.3	cpuinfo_cur_freq
-2.4	related_cpus
-3.	Caveats
+Copyright |copy| 2009 Hewlett-Packard Development Company, L.P.,
+Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
+
+
+.. Contents:
+
+   1.	Introduction
+   1.1	PCC interface
+   1.1.1   Get Average Frequency
+   1.1.2	Set Desired Frequency
+   1.2	Platforms affected
+   2.	Driver and /sys details
+   2.1	scaling_available_frequencies
+   2.2	cpuinfo_transition_latency
+   2.3	cpuinfo_cur_freq
+   2.4	related_cpus
+   3.	Caveats
 
 1. Introduction:
 ----------------
@@ -140,7 +124,9 @@ Internally, there is no need for the driver to convert the "target" frequency
 to a corresponding P-state.
 
 The VERSION number for the driver will be of the format v.xy.ab.
-eg: 1.00.02
+eg::
+
+   1.00.02
    ----- --
     |    |
     |    -- this will increase with bug fixes/enhancements to the driver
@@ -168,21 +154,21 @@ A) Often cpuinfo_cur_freq will show a value different than what is declared
 in the scaling_available_frequencies or scaling_cur_freq, or scaling_max_freq.
 This is due to "turbo boost" available on recent Intel processors. If certain
 conditions are met the BIOS can achieve a slightly higher speed than requested
-by OSPM. An example:
+by OSPM. An example::
 
-scaling_cur_freq	: 2933000
-cpuinfo_cur_freq	: 3196000
+	scaling_cur_freq	: 2933000
+	cpuinfo_cur_freq	: 3196000
 
 B) There is a round-off error associated with the cpuinfo_cur_freq value.
 Since the driver obtains the current frequency as a "percentage" (%) of the
 nominal frequency from the BIOS, sometimes, the values displayed by
-scaling_cur_freq and cpuinfo_cur_freq may not match. An example:
+scaling_cur_freq and cpuinfo_cur_freq may not match. An example::
 
-scaling_cur_freq	: 1600000
-cpuinfo_cur_freq	: 1583000
+	scaling_cur_freq	: 1600000
+	cpuinfo_cur_freq	: 1583000
 
 In this example, the nominal frequency is 2933 MHz. The driver obtains the
-current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency:
+current frequency, cpuinfo_cur_freq, as 54% of the nominal frequency::
 
 	54% of 2933 MHz = 1583 MHz
 
@@ -193,8 +179,10 @@ corresponds to the frequency of the P0 P-state.
 -----------------
 The related_cpus field is identical to affected_cpus.
 
-affected_cpus	: 4
-related_cpus	: 4
+::
+
+	affected_cpus	: 4
+	related_cpus	: 4
 
 Currently, the PCC driver does not evaluate _PSD. The platforms that support
 PCC do not implement SW_ALL. So OSPM doesn't need to perform any coordination
-- 
2.24.1

