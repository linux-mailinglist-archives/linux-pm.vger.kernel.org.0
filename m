Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488AB1F0E90
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgFGS7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgFGS5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC78C061A0E;
        Sun,  7 Jun 2020 11:57:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so17737363ljh.13;
        Sun, 07 Jun 2020 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMNT0sLytr4m3uFIZANOy+2q8/EiZDnxOa5gRaq0ITs=;
        b=WxFPx9P951q6zhNwiu7nfhIwAwmMXaDNsPSAVwdgKPMJYHNXPcrt3D7bpEYjh9oxfL
         G1khneAFbD5BgxlsXZuDLDbyExuXUH4+mnjERHdGtYGD6hmVgWAKr9K+n/eGrF/A5/1L
         mOOpUKzx+3Jy9RNwWRpt7h0rq9oqkvVXwbIleWTqV/W7f2srEHpnblPKizlFgEh2OTdj
         /FLmepWnlGehT9uh4LT4xn1KUF6AEzC4raWPd65tmXAvD7/2JbVF8nORBhwyqLj9SEDj
         HTePsDwGIpaBVEbdIZm9gfXE7H7F3qdrIiM5G8whrl49JXUSJncCaUp7ZtUdhhH2OXV8
         JsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMNT0sLytr4m3uFIZANOy+2q8/EiZDnxOa5gRaq0ITs=;
        b=SrqMjtMOKgPIbv5M7bELMGOaCoTDpzRBqXHdH2ZqEYI37WhFKtEw5vWg+WV++eOMgs
         rN8zEdet9LkDYT/3LmWIakGtNI1T6qxSbfFxFgpDrm7DNcq+QrnubmvGKnMjiUd7Qj+z
         K1tGGp1gVx2CVJcgcKXzT3Bpo6EfWO6p7BfhVmkIVtC6sqcDqnJB+tiWNjYiuMiW+QV6
         pTaU4iG7PemFpmoB43kzaPTG1GBBn3OkMCfWTRtmEjsSPNuBxlcxFdVNfgwpQ7vauMRp
         sNHINC3P3Nm04sfwiGoUdS62IMlwvxBiDA/xYk+S7wdd7Ki+X7+dEU67++/icBnRFY5y
         QfRw==
X-Gm-Message-State: AOAM533vL09WB4+ElB5YcjbEl82vkX8pQiJGtbjBLYTJZcWGIDP8nQMc
        oY09+7WFzC9atM6zGT2+Too=
X-Google-Smtp-Source: ABdhPJxLKr5apcZwbX/f2uhEc3CycsYIiHiI+rBTaaOK8RepC6wg3htdlRjBBxc+G5WYkEl20EzXOA==
X-Received: by 2002:a2e:9c9:: with SMTP id 192mr8965864ljj.4.1591556257674;
        Sun, 07 Jun 2020 11:57:37 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:37 -0700 (PDT)
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
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 21/39] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Sun,  7 Jun 2020 21:55:12 +0300
Message-Id: <20200607185530.18113-22-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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
2.26.0

