Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71A72FA96
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjFNKXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbjFNKXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:23:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FD2106
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1b8593263so6132481fa.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738155; x=1689330155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=BIZHwdmylq8XnS0ujWwkuaE3rkZeTQZjpBUZbMlf0K6Bp+CRopR0T+LF+zzXMEMJMW
         Sn/wLTfL7CBdygpbTeKZOs1TFl1aZrSYcM/7/6/vQuG8+RihZJ96+3T96fWUZqCqidJa
         /gxZBEevNZkSxR3CRp/ZI7+YnpeMSrzSBKdxN1fNi0dPMjzz4sM2IKVjj/iokBStgWCq
         IR46VXKUZXAA7hoBr1outcbux9TswM0E8qmXlIspdHYBxhy194AmY3oCWIS7cRpswNS0
         nLtNC3MROiOKxvUSUIthrVwLNW2aPawDRGMHmmqe8EOur14+ZHQrsU/6vl6jM7yHJGRE
         rpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738155; x=1689330155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=WMNKmUy1adGcVLvgej7LriJZyudFTpN7c8q+TuAO+vfjuEuB+IUVjSYtdd846xa6PW
         G4xbNLvtorhmiWsE3jIr1Whqrub+nTUlFuvAaS9KWCk59uarkuKnZdwkd/eKNXEoMS4x
         arHDwgLQZsiMAXGrenUljGkqJ9aeYBBB2BLaS1Khm4mD69/Keqjd7B9LdCk0fF4cNiMv
         yh7GXjQ1YlYjr2Ri0kEhhebrWOLccsLpYgS6OKUL3ilSSceMqzYVO4PzKka2nYo2HRXK
         dA7cOEEMwkCX75z0ZVyOS9U6AdldBPb632Grrs2HRYjukux38xt+sAl8RBmURjiPKvpe
         F3iQ==
X-Gm-Message-State: AC+VfDy6BhFupppbWQydW5T6hWC5FkjL01d3nXUvJjRrs1UlTnGeGZiF
        Z6rWhFypW5Zh7LbPmjYYhh2CBA==
X-Google-Smtp-Source: ACHHUZ6iFWM9dqTN6nxWdCXjS6+t+lLhqlb4Y97wXbFYcWkZCSdIKKZ6OGvTs840I9ubTKsY8c5+hg==
X-Received: by 2002:a2e:804b:0:b0:2af:1622:a69 with SMTP id p11-20020a2e804b000000b002af16220a69mr7029583ljg.48.1686738155343;
        Wed, 14 Jun 2023 03:22:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:24 +0200
Subject: [PATCH v5 13/22] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-13-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=1291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NibH4RmX92w9jFbYbYmeVzyLtbX9fV3dfXE9S9JnGAI=;
 b=P0snEP2xSmr4E11bZbkcZ7eGLOZz6cp9bVMOzN6StclFv1qJAd3ahBkL2m2StBp5YDYHbY3yp
 hQZFjamP31uDtkizxszA7dhetnPqBnKFyEwYYvV4vH+pcb+xeZdrXaF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 938283ddd0e3..9deb4d81104e 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -984,6 +984,7 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_bimc = {
+	.bus_clk_desc = &bimc_clk,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1038,6 +1039,7 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_pcnoc = {
+	.bus_clk_desc = &bus_0_clk,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1066,6 +1068,7 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_snoc = {
+	.bus_clk_desc = &bus_1_clk,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };

-- 
2.41.0

