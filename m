Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68B652B2E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiLUCFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiLUCF0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C651FCD0
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o6so16484973lfi.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvuwLhbvCBU1vTHX00Mr3U7sB++VpvhJ7GWo/kANsp8=;
        b=ys8NuEmamhHWTgJXz6E/sUh8zBu0Mi9FWtLR+rm2TpsnuLhMFzPJRTuqcQtIBKtbfD
         CGLj0B2In4zNFXcLcDR41SjJWyQUZKQtEKFFraLNHd6znBCONeJZ5ThKz4xIH3XWAzpr
         spe6JkptMLX+9lqQJgZCg+jvTwnXG8xQN+CtvUMxNPdVeKMnIB6kXGc1EvkprskrscyH
         tsATEpbZb++LM0Pe61H5V9HeE0tnvsgmUEnIdKqJ2BjCYEhUjXB+1wY6lYTN13Bn3hTA
         f79/NeS/5IQ1iZJY5AyDR4SPUu67haCsoyqS/lRTRqRoHLkOhrFFiwC9JIkjugOTF8xH
         KvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvuwLhbvCBU1vTHX00Mr3U7sB++VpvhJ7GWo/kANsp8=;
        b=j80bwAAeiA5rqvmrdsdNYy4BG/4iA/k5QY32tNhNBgCGMBUqdImX+WFcreGwqA+Jc3
         L4EjXC0RFDZS3gSsriWlkXKpfi5ERH/Sa49Mn6DWbnmluoaifmWd24Ey3YF//E/W78G1
         zoFz9X5ZGYau86PPAcENRb8oikQqzutBCrpdX5qPeGVGOtf2ZhgWXYdckFfoxC3dFniw
         V5bnmyPZyf9Ck8OBPI2fApw/9z+y2j/0E0I5uYkyISBzYOx6cvs6q0I3LnzKoeRmk9cE
         nMAT84kmsqhcU1k0jJqWGiknl/cqcCVrx/Z920w2CwWa5TxfCKrBKiGBqDxaGtlGTp7e
         Gbfg==
X-Gm-Message-State: AFqh2kqkvcaTaMkrvOqkysgfPDuoxSGC1dXtCDG/iwbUAeqieJIoB1t4
        H/MI2APL61L2klBniQxLwl5vTg==
X-Google-Smtp-Source: AMrXdXtt2jHcaBqkiRPXkRZqZX66xbNDlWNGwtuo5/JsPQq1R/r6laM0lToByew5x1NaRX4clS0PWw==
X-Received: by 2002:ac2:5589:0:b0:4b5:8237:5c12 with SMTP id v9-20020ac25589000000b004b582375c12mr92337lfg.15.1671588324033;
        Tue, 20 Dec 2022 18:05:24 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/20] dt-bindings: thermal: tsens: add per-sensor cells for msm8974
Date:   Wed, 21 Dec 2022 04:05:03 +0200
Message-Id: <20221221020520.1326964-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The msm8974 platform uses two sets of calibration data, add a special
case to handle both of them.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index da7b5bd4abd5..3e6ba0509bd0 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -91,6 +91,11 @@ properties:
         description: |
           Reference to nvmem cells for the calibration mode, two calibration
           bases and two cells per each sensor
+        # special case for msm8974 / apq8084
+      - maxItems: 51
+        description: |
+          Reference to nvmem cells for the calibration mode, two calibration
+          bases and two cells per each sensor, main and backup copies, plus use_backup cell
 
   nvmem-cell-names:
     oneOf:
@@ -137,6 +142,59 @@ properties:
           - const: s14_p2
           - const: s15_p1
           - const: s15_p2
+        # special case for msm8974 / apq8084
+      - items:
+          - const: mode
+          - const: base1
+          - const: base2
+          - const: s0_p1
+          - const: s0_p2
+          - const: s1_p1
+          - const: s1_p2
+          - const: s2_p1
+          - const: s2_p2
+          - const: s3_p1
+          - const: s3_p2
+          - const: s4_p1
+          - const: s4_p2
+          - const: s5_p1
+          - const: s5_p2
+          - const: s6_p1
+          - const: s6_p2
+          - const: s7_p1
+          - const: s7_p2
+          - const: s8_p1
+          - const: s8_p2
+          - const: s9_p1
+          - const: s9_p2
+          - const: s10_p1
+          - const: s10_p2
+          - const: use_backup
+          - const: mode_backup
+          - const: base1_backup
+          - const: base2_backup
+          - const: s0_p1_backup
+          - const: s0_p2_backup
+          - const: s1_p1_backup
+          - const: s1_p2_backup
+          - const: s2_p1_backup
+          - const: s2_p2_backup
+          - const: s3_p1_backup
+          - const: s3_p2_backup
+          - const: s4_p1_backup
+          - const: s4_p2_backup
+          - const: s5_p1_backup
+          - const: s5_p2_backup
+          - const: s6_p1_backup
+          - const: s6_p2_backup
+          - const: s7_p1_backup
+          - const: s7_p2_backup
+          - const: s8_p1_backup
+          - const: s8_p2_backup
+          - const: s9_p1_backup
+          - const: s9_p2_backup
+          - const: s10_p1_backup
+          - const: s10_p2_backup
 
   "#qcom,sensors":
     description:
-- 
2.35.1

