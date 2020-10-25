Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9C298475
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419195AbgJYWSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419246AbgJYWSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E93C061755;
        Sun, 25 Oct 2020 15:18:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h20so7720975lji.9;
        Sun, 25 Oct 2020 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWNk11rR3zsQMdytt/6fnv+TynDPjc7HuIWAQcw2oxg=;
        b=bmKU+d2lgw5ziYt2dnavqq/Qobws6M3xWT3qrB6T9DKe7MOJkP+K58tkKYQEOjoCMa
         1HJ6EHKr/I2L0oXpyHqhYuSq9XX7AVqTQrD2oIpEq2Lwfag8wpF5GCSwX3uVbMXlJNJh
         Yow9k/Ir70Up0bIAgn7JxkTABCdJMehW+vjgCsp304M1eKqcVbLj3MnJjpqLJE6ZznNW
         azReUgfGECkUkCeF04jDQERby2h5y3BbmlxDUP1wFMoofsDLXUS1WnWjckVXLiUllyI4
         1ELNhb0M7Ecw7R8bCWe+cVuDVwYvNf5SmptwJyexeiFHd/dthBkisjuLcS8hCUdWD3YY
         ox0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWNk11rR3zsQMdytt/6fnv+TynDPjc7HuIWAQcw2oxg=;
        b=dRSx2XJOLqHaxXfkbHT1BokXXcjXCTmM6RUSvKVbydfMoqg1dnaTtc+0SHMlpeDdT4
         Cjk8sDN2eME+ChhPpcnHtJ54cLW4gvPQtIpfPuejEYfz8qY38rRXR7L5Rq8Vmg8woFe5
         GYvR7I0PFQUQ95zkJV1HhqwscBKjJjPb2m2vEeZS6mOhBhSV3mBhFOrW/6DxWnGOY1dq
         A2fwONrjEG0dXrRRlN0Vdl7ZkwNFncbdtSkB8hrkzktc4gaR6ZSNCFiNBaXG6RDQVC6i
         yZ7uW8NDyzT9QC4gqDNCm6Z4IG6UJQBVGSE7SNWK7l3MDQV7/fwG7Php0pNKKt8U/ubi
         JaeQ==
X-Gm-Message-State: AOAM531+JRK/Rm2wMAOP/17A8M56levRYB3iFOOJYHdXCUblxQAqLw/0
        Y/RPywOXM5j9T9agWM4rqY0=
X-Google-Smtp-Source: ABdhPJy3W++AY9ujNDBt9x5Vu82+g5NvtUk81oKYjNm/Bu/PyMcGDDsesvMHISONbUDRWkn7o1/60g==
X-Received: by 2002:a2e:b04a:: with SMTP id d10mr4916649ljl.81.1603664283581;
        Sun, 25 Oct 2020 15:18:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:03 -0700 (PDT)
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
Subject: [PATCH v6 13/52] dt-bindings: memory: tegra124: emc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:56 +0300
Message-Id: <20201025221735.3062-14-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index 278549f9e051..ac00832ceac1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -29,6 +29,9 @@ properties:
     items:
       - const: emc
 
+  "#interconnect-cells":
+    const: 0
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -327,6 +330,7 @@ required:
   - clocks
   - clock-names
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -345,6 +349,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
     };
 
     external-memory-controller@7001b000 {
@@ -355,6 +360,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <0>;
+
         emc-timings-0 {
             nvidia,ram-code = <3>;
 
-- 
2.27.0

