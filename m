Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED0E394CC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfFGSzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 14:55:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbfFGSyl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2J2gC9Vs88UenWpiQZnFm6PaAxca9INOF19LE67/S2I=; b=aNhl8dacQHaQT8ZWBlETCijC8Y
        lg1YPVn8DDjHbLyWw+r8yZBYDGye95GZmFRXwYSibTcBF0fZOmeKblvMuYhGxXBEZ2yshGFyeC5rg
        AcMvZuiJ1NryVFqZCchbDpGTq8Y/o9os+EZkOTbizFgqvG1JG+yW2Jzyjkn9ZsXOR66jrsDiO0W7b
        huDodtsOQYzZhbYLFDi6k4PhhzQU+g43uhYWXZqj0C46A5hVQ6ddU4OGu6+cXuG2g2S1bfTm9BApU
        qNe8G1pW4/N1nG2SDTivv0NafqWQ5dR2qYUQtARfji3bYp8K931C+ZTlCho5lklVmvXebTm4T3keb
        R8eBrTmg==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sm-Nx; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Em-BH; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 06/20] docs: mark orphan documents as such
Date:   Fri,  7 Jun 2019 15:54:22 -0300
Message-Id: <0bea1c7c4fc06c7edabbf3185c0cbbc6e85eafd0.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sphinx doesn't like orphan documents:

    Documentation/accelerators/ocxl.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/overview.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/stm32f429-overview.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/stm32f746-overview.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/stm32f769-overview.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/stm32h743-overview.rst: WARNING: document isn't included in any toctree
    Documentation/arm/stm32/stm32mp157-overview.rst: WARNING: document isn't included in any toctree
    Documentation/gpu/msm-crash-dump.rst: WARNING: document isn't included in any toctree
    Documentation/interconnect/interconnect.rst: WARNING: document isn't included in any toctree
    Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree
    Documentation/powerpc/isa-versions.rst: WARNING: document isn't included in any toctree
    Documentation/virtual/kvm/amd-memory-encryption.rst: WARNING: document isn't included in any toctree
    Documentation/virtual/kvm/vcpu-requests.rst: WARNING: document isn't included in any toctree

So, while they aren't on any toctree, add :orphan: to them, in order
to silent this warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/accelerators/ocxl.rst             | 2 ++
 Documentation/arm/stm32/overview.rst            | 2 ++
 Documentation/arm/stm32/stm32f429-overview.rst  | 2 ++
 Documentation/arm/stm32/stm32f746-overview.rst  | 2 ++
 Documentation/arm/stm32/stm32f769-overview.rst  | 2 ++
 Documentation/arm/stm32/stm32h743-overview.rst  | 2 ++
 Documentation/arm/stm32/stm32mp157-overview.rst | 2 ++
 Documentation/gpu/msm-crash-dump.rst            | 2 ++
 Documentation/interconnect/interconnect.rst     | 2 ++
 Documentation/laptops/lg-laptop.rst             | 2 ++
 Documentation/powerpc/isa-versions.rst          | 2 ++
 11 files changed, 22 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index 14cefc020e2d..b1cea19a90f5 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ========================================================
 OpenCAPI (Open Coherent Accelerator Processor Interface)
 ========================================================
diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arm/stm32/overview.rst
index 85cfc8410798..f7e734153860 100644
--- a/Documentation/arm/stm32/overview.rst
+++ b/Documentation/arm/stm32/overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ========================
 STM32 ARM Linux Overview
 ========================
diff --git a/Documentation/arm/stm32/stm32f429-overview.rst b/Documentation/arm/stm32/stm32f429-overview.rst
index 18feda97f483..65bbb1c3b423 100644
--- a/Documentation/arm/stm32/stm32f429-overview.rst
+++ b/Documentation/arm/stm32/stm32f429-overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 STM32F429 Overview
 ==================
 
diff --git a/Documentation/arm/stm32/stm32f746-overview.rst b/Documentation/arm/stm32/stm32f746-overview.rst
index b5f4b6ce7656..42d593085015 100644
--- a/Documentation/arm/stm32/stm32f746-overview.rst
+++ b/Documentation/arm/stm32/stm32f746-overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 STM32F746 Overview
 ==================
 
diff --git a/Documentation/arm/stm32/stm32f769-overview.rst b/Documentation/arm/stm32/stm32f769-overview.rst
index 228656ced2fe..f6adac862b17 100644
--- a/Documentation/arm/stm32/stm32f769-overview.rst
+++ b/Documentation/arm/stm32/stm32f769-overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 STM32F769 Overview
 ==================
 
diff --git a/Documentation/arm/stm32/stm32h743-overview.rst b/Documentation/arm/stm32/stm32h743-overview.rst
index 3458dc00095d..c525835e7473 100644
--- a/Documentation/arm/stm32/stm32h743-overview.rst
+++ b/Documentation/arm/stm32/stm32h743-overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 STM32H743 Overview
 ==================
 
diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
index 62e176d47ca7..2c52cd020601 100644
--- a/Documentation/arm/stm32/stm32mp157-overview.rst
+++ b/Documentation/arm/stm32/stm32mp157-overview.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 STM32MP157 Overview
 ===================
 
diff --git a/Documentation/gpu/msm-crash-dump.rst b/Documentation/gpu/msm-crash-dump.rst
index 757cd257e0d8..240ef200f76c 100644
--- a/Documentation/gpu/msm-crash-dump.rst
+++ b/Documentation/gpu/msm-crash-dump.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 =====================
 MSM Crash Dump Format
 =====================
diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
index c3e004893796..56e331dab70e 100644
--- a/Documentation/interconnect/interconnect.rst
+++ b/Documentation/interconnect/interconnect.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+:orphan:
+
 =====================================
 GENERIC SYSTEM INTERCONNECT SUBSYSTEM
 =====================================
diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
index aa503ee9b3bc..f2c2ffe31101 100644
--- a/Documentation/laptops/lg-laptop.rst
+++ b/Documentation/laptops/lg-laptop.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
+:orphan:
+
 LG Gram laptop extra features
 =============================
 
diff --git a/Documentation/powerpc/isa-versions.rst b/Documentation/powerpc/isa-versions.rst
index 812e20cc898c..66c24140ebf1 100644
--- a/Documentation/powerpc/isa-versions.rst
+++ b/Documentation/powerpc/isa-versions.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 CPU to ISA Version Mapping
 ==========================
 
-- 
2.21.0

