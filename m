Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90385613BA3
	for <lists+linux-pm@lfdr.de>; Mon, 31 Oct 2022 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiJaQrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJaQrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 12:47:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430991181E
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 09:47:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l14so16836510wrw.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOvjAXevhTkIKEozXkDl99JqlY+Qi6ewDIiwMUqw+eI=;
        b=qY2IeKDRG1F4poEQPiAWWwD+glIBmz2L95iZxZiagfOCWZPnnMTf3cBx/VNmUR3OSl
         O2CLdUJ8mHfln5H75LZ1mzfbQ/cAL6C3oMFXSNSbbavXhhQNkMD2qQ897BCUKTSa+SHS
         L4bV0YSEwLQQeIegTJV3MIJgFJSYs5K5tdIR8H2MRRYvESbxB8zqP7qdblVFmAIFgm5o
         IycEid4/5BbtDlltxbKqLS9INDgq8xCg13tVBe+RaIVPMTe6gCdrWRLx8yjueLjRmeC+
         JWLK42+UZHM2V5bL1ZYpVuUu1r3KY9BDCEn/a5Z1YyiuGrHONQQ2NKE7BnRGprS0Mqev
         vV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOvjAXevhTkIKEozXkDl99JqlY+Qi6ewDIiwMUqw+eI=;
        b=GUlqfgYTj9KoK2nzVENRt1BELw3XMgyKZQ2UarDPTpOXYoQQ0bb0OL3RH07z+HWvxy
         PPmXKYMIo6m8K67deguwP8jeDlvEQ6mlmee4pR1JTEIkLu+sGLNb863UyYxKoWLAVgvv
         s8HJjk8BpvXIR8WTVVMAJU6FUilNuVveSqi4T5F4HCE3WrQgsZlc8VFmkFCjZ7Nkt0XO
         nV+a/M3kgCgWvsGWFzDluqs6V0GafgtWT6JHIkM5qdyvXqi7DABjSZ210wFIG5hG7NYb
         +BIyTg0bsTheAoe/TgT/AZ+TcukTVutGX5ZmlU7nHrmIma7EQSVehAYituyAxLqE/i6R
         si/Q==
X-Gm-Message-State: ACrzQf3ihuEz6ZtjUPnXXBUv6exDJxyT7ZFsLGJeBZfCFEMM56HfCaM+
        XOWerSVW/TmBF6CKjisCFk/h5A==
X-Google-Smtp-Source: AMsMyM70WHblAByJ4Qi+nU6doCl8thqDKuH5Zl1XoFQhfj9UxiE9dDkzhRNahah6ucvCPCN5k67C1Q==
X-Received: by 2002:adf:da4f:0:b0:236:cdd4:4ce2 with SMTP id r15-20020adfda4f000000b00236cdd44ce2mr3330832wrl.626.1667234848824;
        Mon, 31 Oct 2022 09:47:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003b4868eb71bsm7488871wmo.25.2022.10.31.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:47:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:47:25 +0100
Subject: [PATCH 1/4] dt-bindings: reset: document Odroid Go Ultra power-off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
to its two PMICs in order, this represents the poweroff scheme needed to complet
a clean poeroff of the system.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../reset/hardkernel,odroid-go-ultra-poweroff.yaml | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
new file mode 100644
index 000000000000..65e42258717c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hardkernel Odroid Go Ultra poweroff
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
+  to its two PMICs in order, this represents the poweroff scheme needed to complete
+  a clean poeroff of the system.
+
+properties:
+  compatible:
+    const: hardkernel,odroid-go-ultra-poweroff
+
+  hardkernel,rk817-pmic:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the RK817 PMIC node
+
+  hardkernel,rk818-pmic:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the RK818 PMIC node
+
+required:
+  - compatible
+  - hardkernel,rk817-pmic
+  - hardkernel,rk818-pmic
+
+additionalProperties: false
+
+examples:
+  - |
+    poweroff {
+        compatible = "hardkernel,odroid-go-ultra-poweroff";
+        hardkernel,rk817-pmic = <&rk817>;
+        hardkernel,rk818-pmic = <&rk818>;
+    };

-- 
b4 0.10.1
