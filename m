Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24514F6EA
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 07:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBAGZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 01:25:33 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40878 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBAGZd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Feb 2020 01:25:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so3995261pjb.5;
        Fri, 31 Jan 2020 22:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwW5brYUYv8gFhSywa79JltgG0iP7wrzsLavgEtl/jc=;
        b=gZgMdPIKvXzU+Llx5HKvmluy3JF3/ShJyO6RLPPIx2Gs8JJIEpFTjreVX+lsxj2Sf0
         kGFd70SVrLlm0a0Qq6WEoh3yQ+VO2s4PFKNShrfYkcy9J0qdQ9nmRps89kL8u0kLER36
         QoOr7YlZXyMBSpLHcNKjeotfTJuYD2q36cbenQT3pc+v7Qp3/zLwPyrnfTl6XsH8wyQL
         +fAwDXh/TLFIS+ykSvu01zmtBUn8mLfCewx3VKN+onpUBJCkZafDQ6YvZISmBiViRsDN
         ghiplu0dnUXt3jWcgsQMJEhBiyDCj//YF7LzirpOe+gtUtQk3qBRohdabi64wpI/fvFQ
         DX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwW5brYUYv8gFhSywa79JltgG0iP7wrzsLavgEtl/jc=;
        b=lYQtR92vIyN1ss2E49sHSwir696seg495TN7f/W7o3NxLjWuMyh1kclxElnsf6wwHs
         0OFkSAnCn17GJ9eKpFn4cqCzoW4g69xicmN9MfD2yef9vpRfhAQjMvciYUwBOrHVkJ8v
         ESfG6nQ3scAmB9uqh2/qj8OWQEBk0Iea9XuKZWeHYXZ0sZIzECEwtbjWxk+oXfwMSYUW
         2b5BAkO50PmRi+OTpuPXS+RN5/ABRfoKcHVx3ZzY1BKPXj9UcZHtPIzcq9mEYbskoaaE
         4cW4asf/hfZ6d9N1DPOPoKScDP6Z8FTF6DhnZpV35lrJIUbXwQMdUlMyD5DHJ3oMcZOb
         syZw==
X-Gm-Message-State: APjAAAVrAo/TWw38w8GB8wiXlnK4QpK4jpMZ/k1SeoOW/8voQCX/tzLA
        1ppCnGBU+n8AvcVfpNfNbD4=
X-Google-Smtp-Source: APXvYqzO2sbFotgP55sn1T4NlLmwcxwv0fr60FrLk465LmMOZYsXhSoOiKysqyiWaa3EFAn/DDswrQ==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr13304534ple.226.1580538330840;
        Fri, 31 Jan 2020 22:25:30 -0800 (PST)
Received: from localhost.localdomain ([149.248.18.167])
        by smtp.gmail.com with ESMTPSA id e9sm12057094pjt.16.2020.01.31.22.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 22:25:30 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] Documentation: Fix build error for cpu-idle-cooling.rst and client.rst
Date:   Sat,  1 Feb 2020 14:25:21 +0800
Message-Id: <20200201062521.7296-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.

Sphinx parallel build error:
docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.

Sphinx parallel build error:
docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/driver-api/dmaengine/client.rst | 14 ++++++---
 .../driver-api/thermal/cpu-idle-cooling.rst   | 29 +++++++++++--------
 Documentation/driver-api/thermal/index.rst    |  1 +
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index a9a7a3c84c63..2104830a99ae 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,8 +151,8 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
-  Optional: per descriptor metadata
-  ---------------------------------
+  **Optional: per descriptor metadata**
+
   DMAengine provides two ways for metadata support.
 
   DESC_METADATA_CLIENT
@@ -199,12 +199,15 @@ The details of these operations are:
   DESC_METADATA_CLIENT
 
     - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
          construct the metadata in the client's buffer
       2. use dmaengine_desc_attach_metadata() to attach the buffer to the
          descriptor
       3. submit the transfer
+
     - DMA_DEV_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. use dmaengine_desc_attach_metadata() to attach the buffer to the
          descriptor
@@ -215,6 +218,7 @@ The details of these operations are:
   DESC_METADATA_ENGINE
 
     - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
          engine's metadata area
@@ -222,7 +226,9 @@ The details of these operations are:
       4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
          amount of data the client has placed into the metadata buffer
       5. submit the transfer
+
     - DMA_DEV_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. submit the transfer
       3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get
@@ -278,8 +284,8 @@ The details of these operations are:
 
       void dma_async_issue_pending(struct dma_chan *chan);
 
-Further APIs:
--------------
+Further APIs
+------------
 
 1. Terminate APIs
 
diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index e4f0859486c7..d8b522d37eb9 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -1,6 +1,9 @@
+================
+CPU Idle Cooling
+================
 
-Situation:
-----------
+Situation
+---------
 
 Under certain circumstances a SoC can reach a critical temperature
 limit and is unable to stabilize the temperature around a temperature
@@ -24,8 +27,8 @@ with a power less than the requested power budget and the next OPP
 exceeds the power budget. An intermediate OPP could have been used if
 it were present.
 
-Solutions:
-----------
+Solutions
+---------
 
 If we can remove the static and the dynamic leakage for a specific
 duration in a controlled period, the SoC temperature will
@@ -45,12 +48,12 @@ idle state target residency, we lead to dropping the static and the
 dynamic leakage for this period (modulo the energy needed to enter
 this state). So the sustainable power with idle cycles has a linear
 relation with the OPP’s sustainable power and can be computed with a
-coefficient similar to:
+coefficient similar to::
 
 	    Power(IdleCycle) = Coef x Power(OPP)
 
-Idle Injection:
----------------
+Idle Injection
+--------------
 
 The base concept of the idle injection is to force the CPU to go to an
 idle state for a specified time each control cycle, it provides
@@ -64,6 +67,7 @@ latencies as the CPUs will have to wakeup from a deep sleep state.
 We use a fixed duration of idle injection that gives an acceptable
 performance penalty and a fixed latency. Mitigation can be increased
 or decreased by modulating the duty cycle of the idle injection.
+::
 
      ^
      |
@@ -90,6 +94,7 @@ computed.
 
 The governor will change the cooling device state thus the duty cycle
 and this variation will modulate the cooling effect.
+::
 
      ^
      |
@@ -132,7 +137,7 @@ Power considerations
 --------------------
 
 When we reach the thermal trip point, we have to sustain a specified
-power for a specific temperature but at this time we consume:
+power for a specific temperature but at this time we consume::
 
  Power = Capacitance x Voltage^2 x Frequency x Utilisation
 
@@ -141,7 +146,7 @@ wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
 fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
 because we don’t want to change the OPP. We can group the
 ‘Capacitance’ and the ‘Utilisation’ into a single term which is the
-‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have::
 
  Pdyn = Cdyn x Voltage^2 x Frequency
 
@@ -150,7 +155,7 @@ in order to target the sustainable power defined in the device
 tree. So with the idle injection mechanism, we want an average power
 (Ptarget) resulting in an amount of time running at full power on a
 specific OPP and idle another amount of time. That could be put in a
-equation:
+equation::
 
  P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
 			(Trunning + Tidle)
@@ -160,7 +165,7 @@ equation:
 
 At this point if we know the running period for the CPU, that gives us
 the idle injection we need. Alternatively if we have the idle
-injection duration, we can compute the running duration with:
+injection duration, we can compute the running duration with::
 
  Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
 
@@ -183,7 +188,7 @@ However, in this demonstration we ignore three aspects:
    target residency, otherwise we end up consuming more energy and
    potentially invert the mitigation effect
 
-So the final equation is:
+So the final equation is::
 
  Trunning = (Tidle - Twakeup ) x
 		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 5ba61d19c6ae..4cb0b9b6bfb8 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -8,6 +8,7 @@ Thermal
    :maxdepth: 1
 
    cpu-cooling-api
+   cpu-idle-cooling
    sysfs-api
    power_allocator
 
-- 
2.24.0

