Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854C778EFA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjHKMRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbjHKMQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 08:16:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638393C1B
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 05:16:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so30171491fa.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756152; x=1692360952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scoeTIYy4vb5EgheFAepiFWqi4fXeq1lFa7JMfWYqi4=;
        b=C5hjA2S/Uccx24YZCltvH14WW1DjSgehLr2zvEQ1zUpYLvp3Ep2058M7NUD/fJGVzK
         e2XH3FuUjUGSCMCKGE8UbXPsSJyr266p/higTc21BDWeZ/m6QeBr7Z127hQcuKGMQm72
         KJOL9opmyXTRykWJGm2Y6o41dhy7hnmD0ctwV/rrEWseng6GJEEjMlnRXQPn2Whtjf73
         3FQAwBYlL5YlGWGvW14+omJmvN/gheBRiurkr4HOQCIz0xIHh0xEAon/DpMd9VeREqvC
         F+ikY6h5TT28GPwhHi2GWpHflDc77C2fJGCdgitJCCFrfqu5UEDw69hsHTbJhUhM4P/U
         CLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756152; x=1692360952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scoeTIYy4vb5EgheFAepiFWqi4fXeq1lFa7JMfWYqi4=;
        b=axM7v/+PXW3OtYaBuhvPZJ2CXPh7dKKgU6mTmIG43zfkYSLcmwcnkBarYN9egZkHA0
         7R/CNcKnFNpYczxWOW6pO0Dl5auYOon66N9mRSjq1H0aV7gXlBn9iOMxDPKm62doxYgu
         9bzA80yeuCldsyQS5QeJ+Mw6s/IywTRsr/UJK8xudoy1Vw/q7wNlyAwovYRVs27AHp2U
         IWMwauKP2t20UQK6Lp2VTPsBG5m/OYooQtmi3/nprNp52/1bVPQXbWl+kQj1luv4bGqM
         HlSosUv5BHSug4M8BXoNo0EcSfxaqV2K86Bz9VTAI1WJ+5Ercb3Pzmhx6AqLb6rt8Dls
         HQpw==
X-Gm-Message-State: AOJu0YxOIGZkTMwg4yYCuKtYAEb44GK/aJ7pj5B9vZUsH5pi3wnKM6Ks
        9JyGbrfiJxpoJ8Daa6obC0sUsQ==
X-Google-Smtp-Source: AGHT+IHUQj4nlzIpMERyWnRpPlm8/hRJlhu2LuR3NUI9A+k9Uov93YlmNF9lJlfR1mhihnZVThwHlQ==
X-Received: by 2002:a2e:7e0f:0:b0:2b7:344c:a039 with SMTP id z15-20020a2e7e0f000000b002b7344ca039mr1516337ljc.33.1691756152190;
        Fri, 11 Aug 2023 05:15:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:31 +0200
Subject: [PATCH 20/20] interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-20-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=1036;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=d/FxCw9vPsUH66qzqeSqW0F14Dv5hGAeVeTLrU6DYfA=;
 b=9QE5KS8si/WcCOpbrLw414HVV5vapAeqBDPdSGPCaJePvsiXpQVgYDPEb06sIUCTNNw1thasA
 6zdLGvveLtKB2JHjNFvHKEXfBCdO0HaDXN87WN7arvIF3dFtHTIBI7o
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This helper has no users anymore. Kill it with heavy fire.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index 0f64c0bab2c0..b4d36e349f3c 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -12,14 +12,6 @@
 
 #include "icc-rpmh.h"
 
-#define DEFINE_QBCM(_name, _bcmname, _keepalive, ...)			       \
-static struct qcom_icc_bcm _name = {					       \
-	.name = _bcmname,						       \
-	.keepalive = _keepalive,					       \
-	.num_nodes = ARRAY_SIZE(((struct qcom_icc_node *[]){ __VA_ARGS__ })),  \
-	.nodes = { __VA_ARGS__ },					       \
-}
-
 struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);

-- 
2.41.0

