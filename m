Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A7244242
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgHNAH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgHNAH0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157ECC061757;
        Thu, 13 Aug 2020 17:07:26 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so3949155lfj.8;
        Thu, 13 Aug 2020 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hV/jfb1j57ds6uWusc67dwvrbgr9Nuaem2xPT64pOI=;
        b=ErKBwp+Pi3uw2mPs1tCdGXty9djbWFZh7U9QKleaHXoAfkxBNKfThE66Q/uzNnc7J4
         aTk8+/JsZmycsCyPcO8wlyCxP/+7dhTSQleHzgB8RAXh9y9JX/qoA3h0Dt4KqGsgqWgT
         32US2OzxXAYh3P3Bq+YMOkgwj1jgCvZwihVWC43so56FI4FPSpixkmxH7Ryz0yw9gdcO
         oycjad2ZwnRCk/P+MMGMiuHDdDaSqD6SW/HA2t+uraoAPUbv+yCSmeRz8aO8ak/Vfyco
         dauYMCWTVOLrANbGWhYaug2aCunXB+Mmt8gqYzR6ZB7AEUZVQQHPqWg9rQyiGNg8aABC
         xSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hV/jfb1j57ds6uWusc67dwvrbgr9Nuaem2xPT64pOI=;
        b=JsF5/m6Vo8IrQ2bGh5p1Szc0FRGeodkAXnBPQ5A9MOh0KlRvdZcED8EJD1blHyGqk6
         hselcLmLVARvN0FiKgDu+7lRTJeDKldP0zrZ2I0HrNHedHhfzff8ipWQqry4iPF2T+eb
         Wv5HMzKRVbMZuv8EFBHICpfod1KcGcmv3awNMnh+e3vFHpGD2+MyEtf4O2+kBrkzI+QA
         s8EOMK3QJL7mM5rKdpNTNID7tSeZdALb+S5TAmcPYv87hG02M1LfBNPf/lIrliNHczZR
         Dhlnd2dXuVDlE+mG7/afPHiy3xr/zqdPYmjNpTDmlE/aaNlRi1OUXDFilyavnHX4rnD0
         EGEg==
X-Gm-Message-State: AOAM5314hmV0lwt5UzIp/gCfKh/FBs0GV/JjR+hX0RUlttV7EmVIkS0U
        mgEOXq0Mgn2fEmIMvG2A7VU=
X-Google-Smtp-Source: ABdhPJyX4+8v8JUfhatSVHBEDRahqnCfgVnO8HrDC7HMA1cGJSRRGzDZfveHa/V3VlNsHtHH294fRg==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr3340219lfo.105.1597363644627;
        Thu, 13 Aug 2020 17:07:24 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:24 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 21/36] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Fri, 14 Aug 2020 03:06:06 +0300
Message-Id: <20200814000621.8415-22-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
external memory controller into interconnect provider.

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

