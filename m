Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4427373B821
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFWMvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFWMvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 08:51:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58B2135
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 05:50:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3110ab7110aso650548f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524647; x=1690116647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAo0phvh8fXAgVLYJP7h1GHACdN6ADqTUL6afCcu57w=;
        b=xE4pagFEoVKgK27AQ7A0dppKAEGPY907krpnMtq74wnGMEmU90LZ3wteVNTeiHKBsA
         wy74lzMRqUXuHl7Z5M7Tot2FQrRqKS1p+T3mrz0p3OPyKMjJ7z6c/IzKA98mTrFeQkKm
         C+bUWyzIciv2PKpz1oLMnKf7OU4PiNXHxsGUusqwaC46niy7eMVX0TuKuvv3zf4CAASj
         KRW92dDs373DEMmSK40Q+ZE1enWZPRhuzX5uBloFEmLBJ2bUJlkrZs41Jxpw0FBqtxhk
         5+ZfhTRBfLsNQkJdjG4HcLVBX9tGojZNhTMSGiwqSaNKm0C0m9/bEqJbgwFJ0smvlF68
         wkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524647; x=1690116647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAo0phvh8fXAgVLYJP7h1GHACdN6ADqTUL6afCcu57w=;
        b=b3hgFwi2TWABnY4C7IQ7tbHx+ZBGVdrNgWeLBhjkKuEfWYxtatjddWvNgYcS8qP359
         ioYgGv0GKVfmTWTrMlKUTOfsYZArIe0ZGacUM20MY/1aUPjR0dCdFiqrBqix5ES3g8EI
         LXB9TC047vUe2XYNGJOhe9l/N1LOEw/Qmr2cW2QGVOSW1C4GhscfWP7pX5H7zfimly7N
         cJq4W6C560VT+wBqPfWTyBUH/Y3STY4O/fwwm2UCJcdQNpCkwYZP4+FGI247ciW9kNNm
         xldZ+D7KzGtDJ90mCwCNchLVpk70x4A6vvyJ2kGKqf8hYWNBTrrgIK3SdDiUM1K/IWHP
         lJPg==
X-Gm-Message-State: AC+VfDxWN7wPoFgL7d0UrZDFhUTc3StqSWUIlB0Cq2EwhiNLcRJy3hTX
        X7cjZ4Li8G1+ab7lK8s1X0Auxw==
X-Google-Smtp-Source: ACHHUZ79qV9duzWdP1qO4ZEXEHVNLq1uN+415rg1emPDjRVpQBpP2AwsfJWvMkvDsYpDEQw41tmhQg==
X-Received: by 2002:adf:f04c:0:b0:30f:c2a3:6281 with SMTP id t12-20020adff04c000000b0030fc2a36281mr17367238wro.64.1687524647365;
        Fri, 23 Jun 2023 05:50:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm9455350wrs.108.2023.06.23.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:50:47 -0700 (PDT)
From:   neil.armstrong@linaro.org
Date:   Fri, 23 Jun 2023 14:50:42 +0200
Subject: [PATCH v2 1/4] interconnect: qcom: Add support for mask-based BCMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-1-709474b151cc@linaro.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mdtipton@codeaurora.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lhON1BygpqWXo4mzlesLcGDv9DQQuf0/+binWIHr1Jg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZUkn1/cWVgOHaes39IQW8BdSt/hN+IVbpKdp1+p
 q7rTDZ2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWVJAAKCRB33NvayMhJ0Tc0EA
 CVAaTKX9yFxZ8lSgp5rRqW97diQi2XK3nEOr2BTXAmTGDkcxenAuEYkFtiDVA+0rVZZAfmH2+/9cCS
 1b9LGLzSmJ05P0uMdt3c3/qW2OmNCYKBKM7SyNU2SAwXibZyf9nZ4FM0GlwueO9a7Qje1xbEjqQyEq
 F1FMQeLmFRyEfHwMMQZl1kZYoHy6+zKgeqC8tKgIN11rpEbC+4+Jn+w9vPW1GAe5Xh8x/m+SWwe+tR
 +Y/rgOPj/KgTH/Ao90dMdT2jQCqz1TgHPQ/SNJ0eaFFfQajSMjm17lP6360B1Pc5K4fOQ2zDnLFeob
 A3MH/G1+kXjRRxfCLSFrhvZyv03NtKbV6/JL579SI24ah0xpTmI+GrwG2J8WN0o0DrUqmaZWDO2NET
 WWakm91bFla6Jf+QnzjJprlGyv7CQ8+7KiBFqn0EwhL9FA42ilnhDqQoIkSq9aG8/ppuIMtEaTI1b9
 uZB/NvO265Tg8RuR/kcAyd7vnldsf/YbsH20UoC5SImsLPusR9SfnCF9tr6lFhwGzRAiaDXAVxvFkU
 qs/CNrwlmbV0LieNXyzDAMP7kYbsT/brSCb21gWHtNPmeU0qono9wCp4+aTaX6+Im9/zEDIzJh8D2c
 AEqzKrreD854DvoprkbGl59BUQua9n4q44yXon7UYKjHhSN7ZG2LlDKm8pqQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Tipton <mdtipton@codeaurora.org>

Some BCMs aren't directly associated with the data path (i.e. ACV) and
therefore don't communicate using BW. Instead, they are simply
enabled/disabled with a simple bit mask. Add support for these.

Origin commit retrieved from:
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
[narmstrong: removed copyright change from original commit]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 5 +++++
 drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 8f385f9c2dd3..d5f2a6b5376b 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -83,6 +83,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
 		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
+
+		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
+			bcm->vote_x[bucket] = 0;
+			bcm->vote_y[bucket] = bcm->enable_mask;
+		}
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 04391c1ba465..7843d8864d6b 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -81,6 +81,7 @@ struct qcom_icc_node {
  * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
  * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
  * @vote_scale: scaling factor for vote_x and vote_y
+ * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
  * @dirty: flag used to indicate whether the bcm needs to be committed
  * @keepalive: flag used to indicate whether a keepalive is required
  * @aux_data: auxiliary data used when calculating threshold values and
@@ -97,6 +98,7 @@ struct qcom_icc_bcm {
 	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_scale;
+	u32 enable_mask;
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;

-- 
2.34.1

