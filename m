Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B501F3BEE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFINRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgFINOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA99C08C5C6;
        Tue,  9 Jun 2020 06:14:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so24953046ljh.13;
        Tue, 09 Jun 2020 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMNT0sLytr4m3uFIZANOy+2q8/EiZDnxOa5gRaq0ITs=;
        b=lbMlxJS2Nz9rtjKFACkhNVig0C+NLEZNIUQjbCyAejsn/LTxC42QfroGOTv+8KLqAW
         6y5xkKZb09oaRg2UZVbz7aLFAAdIrJ+kgt1Tlq9Dq7iId7/Z+BWwMm2kxyu/SCDUYlql
         12ZVVrjXylQbQi5tuhR420Yw3BZrrE6CmUUR83gh8A0KjatkRl9Eo0KnlYRhSnq0OL2w
         zGw4GlwjSIo2wOuNRhjRMk48Q5E/srRH9rWAlnd72rQwqJNLphk4vbbXMbOBkoVP4G2b
         qWLWKcVCSFqFtQ7JqQSVJl50Sbqjzq7bnL5VmxGG7iA8V/hf8nZInlDgFPI8qJHjRRD6
         SLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMNT0sLytr4m3uFIZANOy+2q8/EiZDnxOa5gRaq0ITs=;
        b=fjfYOY1tKlgS+vGFRpzWAzxhq0ZtluaAjgic4J9yWBDc9cuXWyzJ48xM8VHpTMku7J
         7Mi04FNYRZfaV5am54nSMTYdJJs7JVzleQRzV+1J8Bs3RD13kE0geucqrKcFpH5pT0qO
         NUgjn/YDEukJPH2dLLgK05sHa1BdBuUXMzCbeME24UH8uhyPFl0Pzd0qaT965Q7CClir
         SzRUtH3WUNrQoz3PNpFiwVkXYgY8uPa9/K9UiO2ftYGTD1l5EcIElJmo/4t9x5P/n341
         1R9HfJ71Mr5j9KKGHaFNQp7cr13ha4OtnDcjoWkaLCb7ZIg2C/aEWmailtkAJOZuyN73
         LwVA==
X-Gm-Message-State: AOAM531tOWlYlZW5D8y/gG0hpSSJJsvMeznFr1p4o/7K1nixBiJ880nP
        OeIkZcYvbGWNCxUImK21Xag=
X-Google-Smtp-Source: ABdhPJzANPUwZcPwRmo0EzLdzFN781gP6GVzps4LmakICCdU1/D+4djzR//O5R7z6v44gq/opoA+KA==
X-Received: by 2002:a05:651c:384:: with SMTP id e4mr13499996ljp.410.1591708490782;
        Tue, 09 Jun 2020 06:14:50 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:50 -0700 (PDT)
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
Subject: [PATCH v4 21/37] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Tue,  9 Jun 2020 16:13:48 +0300
Message-Id: <20200609131404.17523-22-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

