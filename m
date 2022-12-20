Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76746651902
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiLTCra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiLTCr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46B13CDC
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so16668545lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvuwLhbvCBU1vTHX00Mr3U7sB++VpvhJ7GWo/kANsp8=;
        b=XjUBqRPLfJCukqsk2ihdeWgI9CEu7tGIOjxSZhz5YOrOqM+IUj0YR4e8UOe6CntMIg
         PEkkGo+v8QnPEu41ekCZcB4nW9QqbIVFtMJsUHHwnpFGpGvTD6ZrqhXnthoXT8IQq5tC
         WmVkVGJ2ptinGLgPZhF8Sdu887vkUR+PweSjKF5ZkQQSTAxVmet4nUJ7FQNGukYygwm3
         43KrtfT5s7LuLEK+liuRT1dE5TXy1c2ExBPRSaV5oU+VP6XIURktYn76G0beRKf+PTYq
         RzWdBAL0EO4Kh3W87+CHlyB5yBddpgG2nZR2dLltH2j5VBU0zf0wQ/VpArIZEDiUTZwP
         H38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvuwLhbvCBU1vTHX00Mr3U7sB++VpvhJ7GWo/kANsp8=;
        b=Mjb62lJ3bfN2n1JwSsc3a+28igrj+fZh8cTbhoU3ndcOtMsszRhto+P2ZEsg0qANDe
         26NR7n+K+4dDbHbwFINPTNpNEBFgnSRcVxghaEs70GrcDMlOO/Giaavjjf8N0JYAPwCF
         GaG07dyc7skGCyMoqACyGsckjOYktQqsPNkZr8ejgHY3aqLyIc6vHs704PSIBydOM/e+
         ebPoHeU9pTZU0RDmETb1zT1vWgmknj41g90yloA7nWawiA4jnrNtmkW+JXa5NX6o3WP7
         VUGOPKbFmHcAd2nYqM6oLoAaXBomUpsNg6qIS1Ojzhle1xH5C+MIRWDB0QtxYyJzeG5J
         2bEw==
X-Gm-Message-State: ANoB5pnroI4J8BOKzwPAottzdBjG9DfomnGtia84ay555fX5x94644Zx
        qd6mkx9AgMESIJucmErLymqQvQ==
X-Google-Smtp-Source: AA0mqf5KyJBUvWhns2WW55mkd8AnwfSXqUVWXIIPOvuLUHbBD29J/XkTjkYX5yDQRdm2V90aYL2wdw==
X-Received: by 2002:a05:6512:2023:b0:4b5:2bbc:e119 with SMTP id s3-20020a056512202300b004b52bbce119mr18211043lfs.65.1671504444969;
        Mon, 19 Dec 2022 18:47:24 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:24 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 03/15] dt-bindings: thermal: tsens: add per-sensor cells for msm8974
Date:   Tue, 20 Dec 2022 04:47:09 +0200
Message-Id: <20221220024721.947147-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

