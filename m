Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E014779B29
	for <lists+linux-pm@lfdr.de>; Sat, 12 Aug 2023 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjHKXVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjHKXVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 19:21:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1624E58
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:20:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso38006891fa.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796053; x=1692400853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh7fU8NmO8/UcOfW6vHCmz4/QJs08Kw6cNQ84bDLCFc=;
        b=XVuGsRLfm5G/D6jlSM7/70QNVZODY68z4XvsEeRUidWlDUEkNl7cZ8MGhpspTJLvEw
         JCA9jaK8G9DGBhTLuW9zQh0TDt1//LqMoaZulx45n+FKzycfDgiYZ8C1uiE5wlzugU6Y
         fTnkWufSi0YMxnD4ohfZjiNRPdJkTC0Q8b5Z59VEQe8PdPfzFdHxPPOWeSBvmD18pggD
         3rn6hLO+TZTusfKNsJlTR3pU7XuHtb9P+pad7hOVJ6Uz38FvlYpAUdOj/Eiis5O5fA3z
         f02yg6khrH+UmpvAFM28QsNTf3l8SESTM2lEGxyxPe/lUgKLE1BKIFT0U5QKSnCmE1Cg
         JNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796053; x=1692400853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh7fU8NmO8/UcOfW6vHCmz4/QJs08Kw6cNQ84bDLCFc=;
        b=DFQKPzC0fP2u/XIe7Sg3XQHyY7YyRWeA4tye2Mi9sXWUUge3CPVToeEnLEdM1ZhWmy
         XXMM+/FNsvaY3NINTWYgLZD8iSKJ01Rv/dhJJEmpiIjVBB8mRvxImZjhEIjLCIW4StJN
         A+uTlQVfkLfvYbz1GUz1j3f1cu5pbDpp2w8sZiU1QjpyVATZ/WFTUJ1GK0uuNLsdpbQZ
         tjvgST6/lvCmD6st6EHc3iGPhpDO4osowxzp5VrPpAG2cnqoNL/A6Ykfgsur6GGJ5TZ5
         ZRO5kqu9H024TBGGzbL3epcyb+2z/hVc7gQ1DNeJPyQ4rvSstRX6V/p0MS3pkkXDFVD7
         6MSw==
X-Gm-Message-State: AOJu0Yze5oiSqehJeq4xfMnfMqKW2cxYc34KkDxJx6FXT3Ti48pmawy3
        VLTW4culiLSGDu0bcy5k/9QWBQ==
X-Google-Smtp-Source: AGHT+IGDuezCpOBEkkvhhW24ZzuzCHSnI7l+oj9xXV5tgxeHvqlM6YUi9ZKwYssbVvbPxWK8jaA9Yg==
X-Received: by 2002:a2e:900f:0:b0:2b6:e651:8591 with SMTP id h15-20020a2e900f000000b002b6e6518591mr2569479ljg.37.1691796053233;
        Fri, 11 Aug 2023 16:20:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:46 +0200
Subject: [PATCH v2 03/11] interconnect: qcom: sc7280: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-3-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=723;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/LuGobzmfY6RaftG8ABXorxORG59wqVEv4OciN9yVuY=;
 b=6QHQ+sMMD+ZD4VdfCOTFoNHBWu1P5a8ou07Y1jxcm6haQwdt61bSMkorzpTT9cMK4v+CxFtII
 7Q0eVaJI7F2CHvMXgxl5WcAwLOPeW58dHl4FPnMesP9YSU717+tcfoL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 46bdcac533cc ("interconnect: qcom: Add SC7280 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 6592839b4d94..a626dbc71999 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1285,6 +1285,7 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };

-- 
2.41.0

