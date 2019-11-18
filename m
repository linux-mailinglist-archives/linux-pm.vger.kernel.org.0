Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698D3100CDC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRUFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37289 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfKRUFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so14913406lfp.4;
        Mon, 18 Nov 2019 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=micXsJQgXBCNNJcKoZJTQ5HIZ0M5FUK3UrWoG3KSyWo=;
        b=rrVfi5v2JRE5SJXHPGiSfi6I6jin/l9B/rf4X0kWlViljiZGz+LWP/0ECjy2YGt2Ly
         H/qRg2521GJkwgtpvApOD5aA7+DBwPWsifAzGVha+jXC143rC5gQLR6jUJ54cWKsePel
         uv1TjMi/1ZiuGlvwBXSwxK89SV9WxRJoC2qLxlJpL1hpk3wd9mEQKoWOUsxGpeTF8y9p
         9bSc8VsKBip5qLTPIkaLaW/w7hnUZEXyxCP+yfEc9oFSgqF1y8cbOxJENorysq10GLcz
         ck9Y8swJz86xZjgEW5OGTmiSuS4KYRXAYxWg5bcRHsIojz5ciUvmrY1ZlkrrAMMWG+Rz
         Yu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=micXsJQgXBCNNJcKoZJTQ5HIZ0M5FUK3UrWoG3KSyWo=;
        b=Zd9xVqdn1UcKq4kbWUlhyLHFwX+W7fw4g6kJqjD+tTdSegxb+ZkGpPJq2JCAu0F8RF
         7ij1v4yQ2Ol9TC7q36JvNqegFfn3iTePmOFgwr0ZY+cRPUqKLxDF2dCkS0tBq6YH6uQx
         ZiFV0T91kc2jLyBBKr0RFsFAjvSHfnLxDutiioGNg/hcYQMhDJ/0cfKoq5ajQ+/rvLiP
         WqIc5OHwikhsswE8l9iGI4wOA+FpnmmGE/t2RP8dpPxrsOFPxdGBBelV3XeY5Z26/dyl
         x2jZdzcun0NMJHh5DOvxj5Bdlf9vahVLSqHso+hJoTLqCaFWC8DrXdTI9feyFOlYvU8e
         VMew==
X-Gm-Message-State: APjAAAXsFYP2ZTKImiXxQU9VxMOoYnODzIqmmUoP7bQWUFcaBSOvc+9+
        NpyYF6axNd/QucKMEHqhxMmE/wZr
X-Google-Smtp-Source: APXvYqwTb+6t99vmQH3iQttgGiopbKJ92e1WabIoG/JiwFJ61DaC2tawmiw81YDXtJmNSG9zjh6Nnw==
X-Received: by 2002:a05:6512:4db:: with SMTP id w27mr895831lfq.4.1574107534975;
        Mon, 18 Nov 2019 12:05:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 05/29] dt-bindings: memory: tegra124: mc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:23 +0300
Message-Id: <20191118200247.3567-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
designates memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 30d9fb193d7f..b3aa3e6b7006 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -40,6 +40,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -104,6 +107,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -119,6 +123,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-3 {
             nvidia,ram-code = <3>;
-- 
2.23.0

