Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447B33A6DC
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhCNQsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhCNQsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020FC061574;
        Sun, 14 Mar 2021 09:48:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x4so46485254lfu.7;
        Sun, 14 Mar 2021 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fIJlDcd71TT0jmkUZNR3ad9dZBjMysjRYOjtsTZlr4=;
        b=mKV3MZpoO36TUQFcFLuG+Tn2Hdce+TPnf0EzISUvsjtS3JQBewFaRN3q7nTR5Vefdg
         wWqL8xVUb6xwE3pkXMMPQEjKa4Rp6cIDQTfaGdDtIfTFwqEuMP9+/xoL/KNEN0cOL8go
         Ca6RlJb1vxuZs2vKF6yUKd9+byYljyBhHgLyJTYD6CH+oJnia+WOCKps/3ti144ZFDLj
         JkVlrFjuTUJtwtMsolAUb3Dj/swBvSBJWiM90NfpBrpw39NWDbrrpqGzz87Ywz8sYHft
         wLB1pcP3z8Or0NTFEElYQYmDzuWRPyC3Ss5B8+eDgib+bi9ENpEKNlyXp8vo2ha77MXH
         i0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fIJlDcd71TT0jmkUZNR3ad9dZBjMysjRYOjtsTZlr4=;
        b=a0NmxoxByluJG4bhgVPl1gjVsFNOxMl84UmM9UxUx1ybhYf5Q1EB6tzcE1YN95wyrK
         EqU2f8OvtVCnyYs6EgmC64KGeDnG/CLWG2dapljo2AV9i8OMxEJpZY/OeLJBJyDZ0UVE
         +WamlSL4dlKv2oFUdSpzdkG2RsBVpzLTM3xtL2hVClwpH01SsoCThfoH6kwqhdYXshWq
         I4gHFp5wuZJwb3uNT2Jekz3TDiO3kz8S2deV9heuxuw1QE7f8ZnF8cuZeDDQ4rJpFd5p
         QGDYuaHXhb+egitiKIJxSTcr9mCgvKQKPLmYSH1ywY2WpFvgBvD3AnY2Mvb1LdtbGA13
         7DpA==
X-Gm-Message-State: AOAM530OjBTVjcRcHetU02Huj5SWUfgztIM02EgOIFm7DSgU/8huqv3g
        QIF4LnX5iusuSgEiDiM9bsY=
X-Google-Smtp-Source: ABdhPJztOtPxFLi6JgvnEmZbiJAiezCtcSFtFEDT+prwhQQKbGIkocxB3oQ9Zr76b8OiPgcjV6rvlg==
X-Received: by 2002:a05:6512:32ab:: with SMTP id q11mr5610987lfe.106.1615740499965;
        Sun, 14 Mar 2021 09:48:19 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:19 -0700 (PDT)
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
Subject: [PATCH v4 3/6] dt-bindings: power: tegra: Add binding for core power domain
Date:   Sun, 14 Mar 2021 19:48:07 +0300
Message-Id: <20210314164810.26317-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164810.26317-1-digetx@gmail.com>
References: <20210314164810.26317-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have a core power domain where majority of hardware
blocks reside. Add binding for the core power domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/nvidia,tegra20-core-domain.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
new file mode 100644
index 000000000000..4692489d780a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
@@ -0,0 +1,51 @@
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
2.30.2

