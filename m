Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54E7A3FBD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjIRDmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Sep 2023 23:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjIRDmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Sep 2023 23:42:01 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2410A
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 20:41:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5779055a474so3410315a12.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1695008514; x=1695613314; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbBicPhgbOk81ajtZm9y4+w2cB1Rw13RUzYL5oauGGc=;
        b=RZCHRH4cAFaT9TTimn7g3orL1+wMMa+rqk8tPkdTFCmjGX8JUPxk1di1C/M6XomhVW
         bpCBNrknXinyRpylT2+E3voxj3SyT6gRwpTtiLUmwe23bvxf6I0E77nQegE7MiOHlbbU
         g/pdrwQIecHPCFLZ7lUEvS91f8LInN3roKCmI1EhuXE5O5Iok6VXlcjolmiJt/qpIYwN
         uPjwsvAQkqwF/1KXtTRz82SH5aN5xnzKtlhW+FS133HJZ7qvT6NYGMytdWFhJ1Jwer1F
         0JiAVeAgG/V+WPBs/pIwjtAZEL1h3vGorpU4wmslFYDO09Xr1WW3lv25Zt5SpTXFmnuY
         V/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008514; x=1695613314;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbBicPhgbOk81ajtZm9y4+w2cB1Rw13RUzYL5oauGGc=;
        b=XEe8HDOSb1ZKL6PiwJ67795h5n60XH/dVyCb8Qt0VDcXg+awOBD6TO1bPzwpo/OfFm
         5DjGqxIj0A1+aPJsZLGHDi21ZM2xbDYchApCbbAI9P9JwAVrMbFncn3knO8o2hNSliwc
         E+oDmB/tJEJfLocJqs+R4IweUp4XmM8yLtxRllyK60+iTGE7St8j018wjDh1vxBIuGxX
         U3F4TWSC02Bl/rTF/W++LLcw7/WhmIsktLdjBmuBQu4nyMYwWbjZeXsjHAqg+qbDMyQH
         LE11NG1RT5KcNIq3T6IlcJJCTZGGknhEN3EH8/eqlHOnhhxpiJv8TDfTJ1pr1NxHtOvO
         mENw==
X-Gm-Message-State: AOJu0YyOIAunE3g2aDEA6zTq+LxCIQtcd4cWzHTdxJBZgJnZ/rhOPyJ3
        l1hEPePRKwYSZgRUDdDtP+uzBw==
X-Google-Smtp-Source: AGHT+IH/FmnN92SMLSObezbOhoDJ423WkpTTMl1LEOM/RBFmpOFJtt/j7Xlqw6PEXj1dNPUiy1AKhw==
X-Received: by 2002:a05:6a21:1f2a:b0:14c:daa9:5e22 with SMTP id ry42-20020a056a211f2a00b0014cdaa95e22mr7721014pzb.45.1695008514079;
        Sun, 17 Sep 2023 20:41:54 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902708100b001bdeb6bdfbasm3379105plk.241.2023.09.17.20.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 20:41:53 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <rafael.j.wysocki@intel.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Mario.Limonciello@amd.com>,
        "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>, <Ray.Huang@amd.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <001701d9e9ae$02438120$06ca8360$@telus.net>
In-Reply-To: <001701d9e9ae$02438120$06ca8360$@telus.net>
Subject: [PATCH v2] tools/power/x86/intel_pstate_tracer: python minimum version
Date:   Sun, 17 Sep 2023 20:41:57 -0700
Message-ID: <002301d9e9e2$13424090$39c6c1b0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adnp4P7JD4W+FCWaQuOMb512kcA6vw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Doug Smythies <dsmythies@telus.net>

Change the minimum python version from 2.7 to 3.6.
Remove a 2.X backwards compatibility line.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---

v1 -> v2: Fix careless typos.

---

 .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index ec3323100e1a..6b0790e6465a 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 # -*- coding: utf-8 -*-
 #
@@ -11,9 +11,9 @@ then this utility enables and collects trace data for a user specified interval
 and generates performance plots.

 Prerequisites:
-    Python version 2.7.x or higher
+    Python version 3.6.x or higher
     gnuplot 5.0 or higher
-    gnuplot-py 1.8 or higher
+    python3-gnuplot 1.8 or higher
     (Most of the distributions have these required packages. They may be called
      gnuplot-py, python-gnuplot or python3-gnuplot, gnuplot-nox, ... )

@@ -23,7 +23,7 @@ Prerequisites:
     see print_help(): for Usage and Output details

 """
-from __future__ import print_function
+
 from datetime import datetime
 import subprocess
 import os
@@ -562,7 +562,7 @@ if __name__ == "__main__":

     # Temporary (or perhaps not)
     cur_version = sys.version_info
-    print('python version (should be >= 2.7):')
+    print('python version (should be >= 3.6):')
     print(cur_version)

     # Left as "cleanup" for potential future re-run ability.
--
2.25.1



