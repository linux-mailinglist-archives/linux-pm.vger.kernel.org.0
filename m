Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9879ECF4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjIMP3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIMP3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 11:29:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160D1FFC
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 08:28:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso9208312a12.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694618929; x=1695223729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQKsjBFvt2/0L/1F7kjkJsmdL2N5EGcnErgcVOrwWbM=;
        b=tQr94KIOOvObTwS7tE00SK4URXS2zORS2LxtSW2Y8+eLpMHPb1BE2+CCperM32yPjH
         L0MEBTAenRIdtctYIR28uvApRVMCx/LgQP7vTzmMe/zKxaIYygYZb1XHwSCq9WDDJuim
         0GB3n99MO6jUsEfVffWrJ9DWRgKeuJVwFM/7VCZ0ozlvWjR4StZ/6bnQ149WAGo/ZQ3k
         FyDjLIJIppqc/fjEda6qv2KZv1GEUJt+WLHlsJ3rl8x2ZdcW7tYVdnNQHcF1g1c2m7YG
         JQl+v+0maX+k3HuOAJfVzieNl+Jf+wuBy9IYy11KfrNk1zbOsEjZsDKNbwC6xSEYPPKZ
         aipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618929; x=1695223729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQKsjBFvt2/0L/1F7kjkJsmdL2N5EGcnErgcVOrwWbM=;
        b=NrCOmkVoYeHBgTG8iH053GqJZx8eTwlD1j1ldMPq6WP66gy4AMQ3STsJ10WGxvyWi/
         k9pRJG5gSieSeL6DgSZU8II2FSfy6vfhcMO4G5RIBW40gblQ4kJDDEqz19tHa6AZWE7c
         5Wqhml9+y894/E2I/bqFLdRC8MdH43fNLyTKzGE3bTmJCeGigyi21oYGKbsPe+ARjMkE
         X/e+C7l+jNqzINtb9FyBV/bT6eJzvh2TFyBKNXeb2RWVr4zEQwi+aenmfPNw3POv2yY9
         th4mdHegVjaW91aTZjMBp8WE+KlpMX5kblI3sHKdBXs4zc8csbZxtEf6bf3KwmO+gOwc
         ul+w==
X-Gm-Message-State: AOJu0YzTjN6DAfrBG5NRskKWiKrE03Mk+gAVvE/4FGjNXMKUpAMoF5Vj
        Kn7SSVvJmj8Qt//kKDA1HDWe2g==
X-Google-Smtp-Source: AGHT+IF1N0dH7NBwdsld1dadU/38+DoZHPAaHw3QYfBoM6Clc3uyK0g/1qrDqxDnarlnUznHb+fc/w==
X-Received: by 2002:aa7:c1d1:0:b0:52d:ea50:8b30 with SMTP id d17-20020aa7c1d1000000b0052dea508b30mr2868009edp.5.1694618929447;
        Wed, 13 Sep 2023 08:28:49 -0700 (PDT)
Received: from [10.167.154.1] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0052a404e5929sm7391979eds.66.2023.09.13.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:28:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 13 Sep 2023 17:28:44 +0200
Subject: [PATCH v3 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v3-2-781da361ec60@linaro.org>
References: <20230621-topic-mm8013-v3-0-781da361ec60@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v3-0-781da361ec60@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694618924; l=1502;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+uF0adwPQhjp9KC+P9UNR+pGm2F9OFhDZ4dy2nzuHuQ=;
 b=rZ2FLQkeXx9L1IBv/fSklUMLUVdwZob3h8heT6fA9q+Hucr4hgbUF50hNqd+auczPsRC6qSTt
 iekJ7LyR2zzD6wHc34nM126h9TzkIRmUEX4ut8mj/hJ0MXDaY3VXD8o
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Mitsumi MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
datasheet is available at [1]. Add bindings for this chip.

[1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/power/supply/mitsumi,mm8013.yaml      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
new file mode 100644
index 000000000000..6865640cbdfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsumi MM8013 fuel gauge
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: mitsumi,mm8013
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@55 {
+        compatible = "mitsumi,mm8013";
+        reg = <0x55>;
+      };
+    };

-- 
2.42.0

