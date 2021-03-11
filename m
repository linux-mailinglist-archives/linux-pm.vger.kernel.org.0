Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8333812D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 00:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhCKXPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 18:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCKXP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:15:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A6C061574;
        Thu, 11 Mar 2021 15:15:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x13so732997wrs.9;
        Thu, 11 Mar 2021 15:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZPDfAK/GaZZk1byDwisDbQmbG69Ki4SSVrhCiS1D80=;
        b=N12BWlr0M5KU//v0sBEXxL7IXPJdEcy4qW1vxeL6ptHTdH37YkEs/0ke8kfjZdv+ye
         FYklpPTxlvjTVSai4knlL2sMq0250IMnU+9kKNc+067zV6gLrpc8JNwtAy3aWKzG0kpl
         Da5mJUipQcw2/yHdRB463OldHLFDk3m2ex55WISlzexH6P3DdRuj2Ch2+kNkVEMlNXQd
         br3Lc+1ueoYua/w4/rpiZZGYohTkhVezl1ZGT7derL2iZT6Z8YPP/BfWujNI+uXNd/UM
         MeV33Xa8PLLB1vKmp354SGTwaNjq7xFJVnaiA136c8rsiMWWbV5DlrpjPwf7uA2AOLUL
         4MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZPDfAK/GaZZk1byDwisDbQmbG69Ki4SSVrhCiS1D80=;
        b=MKcIRObEY1BDCAmVh4JnCBbH4N9wUsEw0kwb6eOuipkYxajyDrEgBVJrtp/dY6pg/B
         xiu8tGA72UU4W4Y4JbewypYzzZbj7T7+NVVpgKH+YPKzHD+9L1v6QFWGUvzm0DXWj4GF
         kHbqo8oTyD368eFplVS1h1L7GMrufpUeOYnNyHBtOCAK8SByIQs6x+C/z1WhiiHsmtYg
         9q4+QtbOYU5vE/dGq/IyQ62LtjLW8LF/g6+UHTyRKEmeWYU+3dvNuU5fRju79Wjxmy7v
         15TKi6/LkPkjn0uIlJJj7ZcViVsJc917s7GGT4kkMppD+/gHS5E82krBpfC65Ck6Jxqc
         9/FA==
X-Gm-Message-State: AOAM531MNB1OwbjssjvCwGimsDCI4kbS4e165bjHLoj4B4SMzib2b/KO
        2rd7y2z+hl+pAaM0zg9WCto=
X-Google-Smtp-Source: ABdhPJzbQvhEVffnsKZg3UZPO25ccig+sda6lz+ibiCyMdjzTDC2P4mR/kl00LYpDj2rNc9qziT1lg==
X-Received: by 2002:adf:f0c1:: with SMTP id x1mr10826975wro.7.1615504527037;
        Thu, 11 Mar 2021 15:15:27 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id j203sm263918wmj.40.2021.03.11.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:15:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: power: tegra: Add binding for core power domain
Date:   Fri, 12 Mar 2021 02:12:05 +0300
Message-Id: <20210311231208.18180-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311231208.18180-1-digetx@gmail.com>
References: <20210311231208.18180-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have a core power domain where majority of hardware
blocks reside. Add binding for the core power domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/nvidia,tegra20-core-domain.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
new file mode 100644
index 000000000000..bc68c5757d45
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/nvidia,tegra20-core-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Core Power Domain
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra20-core-domain
+      - nvidia,tegra30-core-domain
+
+  operating-points-v2:
+    description:
+      Should contain level, voltages and opp-supported-hw property.
+      The supported-hw is a bitfield indicating SoC speedo or process
+      ID mask.
+
+  "#power-domain-cells":
+    const: 0
+
+  power-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to voltage regulator connected to the SoC Core power rail.
+
+required:
+  - compatible
+  - operating-points-v2
+  - "#power-domain-cells"
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    power-domain {
+        compatible = "nvidia,tegra20-core-domain";
+        operating-points-v2 = <&opp_table>;
+        power-supply = <&regulator>;
+        #power-domain-cells = <0>;
+    };
-- 
2.29.2

