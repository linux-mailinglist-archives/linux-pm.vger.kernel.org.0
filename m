Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FE74132D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjF1OAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjF1OAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 10:00:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9012D50
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 07:00:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6403412e87.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960848; x=1690552848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPo5IxcZGqbsYAtBW/avfH07eeJrRORrjdw+dNFtBTI=;
        b=oCIoTeFp554vyWqiLBoNJP5+Fkwpy0gW9Z42J7Q2pjF5cEZueHuqr/X+WNLn9/peMy
         WTZLFUE0MWglLkq1A0sd2tufzELezVVnh/CKim6ukUBIRBLWG2ekVbmF9v4mMs+KL5Ac
         q2qnCHUUFRNCxEKPlfJo4uh+DXU/zdi53ZWmhQhbkszwPmKBLeWeOzszuib9wWO0mtug
         TaxP5S5NJ53t6giDsrTQOF7oL+Fop1nik8+hMykUDWEKKc9c1aRMQ0rjkkg/GQRjNoS5
         0LzQWSfCZsaUcjzAlK5X/h8v1j6LK7gBepaCGOL/5CkGdjCZi8T+r1eWgsVBNVclzWkF
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960848; x=1690552848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPo5IxcZGqbsYAtBW/avfH07eeJrRORrjdw+dNFtBTI=;
        b=JNsEBHhyl2aRpbi5trTd7F5/blM9YDbvEwYPcfPySRj95BDlOzDVBevL9vwdL5r/PO
         yN/GiZDlD3j2bmLTG1ercVJwfon9QL4VCKI0cK6O2SgZ5aqGP1G6mJY9NV/n5HClOM9Y
         IxOZJNTh5BN6YeaXBeQvy2WqBgSM3wRXmm3wAD31qrcsHdEs4eSsqzY4RTa8xLEC/Q2O
         BTWrcCdwCIHuXD4o1WZ2ajmst6h0HdDW6L5O6f7LJkLBdJghVXdqw7mt9DzFDVBf+Wj0
         zfvWJWUfBhRSA66LjiFNz218LETT1l8Ij0v6xvXh8HYalBhkKARy6X4uHVKzKCmHvf6x
         ivaw==
X-Gm-Message-State: AC+VfDxY9Hmc935ipcq3TqoQaKSeU2wg//nyI6815pvZT4NT+k7QSSz9
        vyZKhifHph6kGIXqMfIW0hmrSA==
X-Google-Smtp-Source: ACHHUZ6JsV1oeo2MlCSJshBkz1AM6f7rfRr0+EGLaErZuvelPeucwW9PJRI9tN7Atiq2lkpF/oPvdg==
X-Received: by 2002:a19:e612:0:b0:4f8:742f:3bed with SMTP id d18-20020a19e612000000b004f8742f3bedmr14519429lfh.37.1687960847988;
        Wed, 28 Jun 2023 07:00:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:41 +0200
Subject: [PATCH v12 02/10] MAINTAINERS: Add entry for Qualcomm
 CPRv3/v4/Hardened driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-2-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=932;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dr0pvAH0vsRUz7z04jyiD7L2OFZkKiQQ83XjJTz9onM=;
 b=b/ssDcVoAb2/obulGNoHznAhiY6DgCz8kwBvR2rLPHheY1JoCazdSxhh7fJfNDzaAH3JrMRzR
 gk+BsCJXpQ2AKOCsgoxj/ryqQhUyxqWTYBHixAixlKCMVsXQE2tqklG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, update AGdR's email]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4545d4287305..f4218f7a7c33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17581,6 +17581,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/soc/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.41.0

