Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B133298472
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419237AbgJYWSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419227AbgJYWSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4DC061755;
        Sun, 25 Oct 2020 15:18:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so7719693ljo.6;
        Sun, 25 Oct 2020 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaLXEDjIP3Iag/w2fX7ni9eaMug2cPZsxsXqnpeU2P0=;
        b=RDencuCb5Y6FxnxvSKraKK476CUoUGcrFMA6y9TBMMQtRuuOhSK+mzG7Umdg0uxjZj
         NcGWeqnplJ4XcQw1QW1PJu97jdNr3o4TtKLp8LXRbdgFszv/74srplgF1b9bgp27HJ0A
         EgTuqBgpUmL/RwzfBLJnnsRZwcRR5GxMxxuzUHNZjXfJ5929o0G9flJ52+n5sK8Vbs1k
         ni+vOzCRBOCFVabbOERAKBiGIBXcCrQa3nAEbNVS8TDm3gz/sYbuDvo4MBiUNnvaTiVo
         O41eE2wCTMvvJ3wfEiHdOqGKaDatnGEPJkImIr3ii0zgKER02po0rpg9iQNtLWSkZ45L
         eI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaLXEDjIP3Iag/w2fX7ni9eaMug2cPZsxsXqnpeU2P0=;
        b=jYwqsMuLQkMwtxVhXOc4wVJ/XsQgEP8ehqPWueEwP4RMpicwncMnaQbdzSUigvVOVD
         yYvQXn0fgsVmc2uUdmaJk3zhO4pAVbUnQ7+YCMMO8sWq5cleDgoK2CInlYImdcbAjJcY
         yFsQGLKa14zCC+n6xFlNcZCYDvvUGAWH2LGPGlfckzcRSNzFBdPtaNVbKH2amG33BHLZ
         cEMkc6dvXYRy35pf5d0ySrfGXP4hm9ncU/LnGnk3L5a8k/QhnzinHmWOh3ztdPpsdqjY
         oIOm9sUJQT64fNVvFLkGKHBGUqY4SFSIfcZgP70PaTtKHlmxJMTcweSUhCkIEFIrlxNK
         Fo1Q==
X-Gm-Message-State: AOAM530oCl1K8Yn27Jzss06ZSo/SMLRjnm9CIkgF6U082uME/ni1ZwqP
        hAtTFlnizodk18Kmgjnm1bw=
X-Google-Smtp-Source: ABdhPJwHNdos+BXaOsOCCap6LKKXDLIHLLbZkSkt3/MMApNT0gleMksSLiDUIBBERRGJ18qcGpIX3Q==
X-Received: by 2002:a2e:7a0a:: with SMTP id v10mr4399665ljc.188.1603664280192;
        Sun, 25 Oct 2020 15:18:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 10/52] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:53 +0300
Message-Id: <20201025221735.3062-11-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
External Memory Controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index 112bae2fcbbd..c243986db420 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -31,6 +31,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#interconnect-cells":
+    const: 0
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -214,6 +217,7 @@ required:
   - interrupts
   - clocks
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -227,6 +231,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <0>;
+
         emc-timings-1 {
             nvidia,ram-code = <1>;
 
-- 
2.27.0

