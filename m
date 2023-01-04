Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4A65DB0B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 18:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjADRQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjADRQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 12:16:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C9EE27
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 09:16:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bf43so51358270lfb.6
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsrAfu8WB+ADcxi8fs7MNUMoEHOQMutxstluF7jI5jI=;
        b=CDLvO1acOx2Ye0jrgyUN0SxiS+VjfdiAhsGbdkMb/cM1XVGv3iDrBRdhY1XNJmd5mN
         9B2ukKnaTXd2CQj8haaSQEsWdQJZ6XfcVsqQ3BALG+47gnFjIDYvWvDnQd7wE5eA/FGl
         onwFZ3ufUReX013ldkWGqhmdfiEDXI21iIphsnKXxy+ZC1EvAf4adNDnowF1ik5MzTWq
         CKn+//Xy0GwtamOxkYq+OiDf05vSFLQA6Wm6on7zIqkVDu4GlnEEA3m1O6kGb01eDonY
         X9qSWAIvCh5+rH9I6yA6/X3U28ahuo/exzrypc2iZh7ZmR2goXzft2OA7Pa53zwS7tKT
         ieLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsrAfu8WB+ADcxi8fs7MNUMoEHOQMutxstluF7jI5jI=;
        b=iPDvFiHbSCmIOZ+tUQyoUaeBQAPESHWGyLsDbUBLZ2xa0JpMkY8NnPPLG8JhojEpLV
         iuJIv2/uvGYoXRr1xuxUlnnj9f3ZsVGQ5SDukNsOFAwHzDWFX2x9QXFPEnfGq4eHedbS
         s0vFz8xOBhePjKOAg++g1P06zv0JnpsU6iSai6FIBUjb0RZVuEcdzbz6Rj8EjDTW3EmS
         UM3ONSph8hrts2vaB6yu0uZ+o+Vqz/R7LVL1oB7snHdcqZ0RgUoZaOXz8QopccQ/EAtn
         7iMBssd888HcJp2LfJ+7KyczVzFHbz6mwkSiNWaMNcFMZ1kejYERpVIiMVUfpxTn2/2e
         82xw==
X-Gm-Message-State: AFqh2kpn105M0jOl1zOVa4jBti2uAN+/xmWdLzJ1Zlh4eMaj0DoJH1Xp
        RHlo00I0Lfqi6VTLkaPTMAutiBbUgmiiCp8w
X-Google-Smtp-Source: AMrXdXvQgxPQ/Ei03+3mymsd1M7IUkebY85kln+wQVeDgKFnSIzfcGfemMQjEsOHV0lCLPa3uSz9jQ==
X-Received: by 2002:a05:6512:318d:b0:4b5:70e0:f2e6 with SMTP id i13-20020a056512318d00b004b570e0f2e6mr17105422lfe.24.1672852606343;
        Wed, 04 Jan 2023 09:16:46 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o22-20020a056512051600b004a44ffb1050sm5179520lfb.171.2023.01.04.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible
Date:   Wed,  4 Jan 2023 18:16:40 +0100
Message-Id: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

SM6350, similarly to SDM845, uses OSM hardware for L3 scaling.
Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 00afbbca9038..9d0a98d77ae9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
               - qcom,sdm845-osm-l3
+              - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
           - const: qcom,osm-l3
       - items:
-- 
2.39.0

