Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7E779039
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHKNFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjHKNEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 09:04:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF222270F
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so3002270e87.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759072; x=1692363872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntKtFbl2q7E1a85boIKcWxGhXsl0LBcTduCVXEQeYtM=;
        b=uExwrNJtNs+cm3RQ2dfyhAnJjc6mkBScgM9uiFgX8bhTmUh85PrhNIOQwGeO4igWZW
         h1zTv15QvRCjeU/xFQCQfbEEWLnxF9GAvk1Kd/zwzIi4z60bLf3pL+LCisk7mYrX0gJp
         Qn6pIOjy6JaOwM8GbLE74X6YEZOnNW3VSJc1rnZarDcLE4Vi7mfkV8PvJc499vuf2fML
         ad77Jg/rakv/QYVHs9+9ehAjghXcLLbdvWTXMpv2sWxHcDP5N6C7QGJavalq5Ipv2ITu
         TOZQZRPbstlQojU8q7h8r0SValHK+YnrwbM0Ue6oL+gVf4Qrbjb7uplNevm97upETW1n
         103Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759072; x=1692363872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntKtFbl2q7E1a85boIKcWxGhXsl0LBcTduCVXEQeYtM=;
        b=LWIFWyks8vmCHTD22zmOLmnGDlMsTd72p1/jxiSzsd9DTdBrK9tPCypxayjOfalOKA
         a4RmPxMSwZEHBuZQ/bonYgZ4MFI9K9OyI3vyQ5o8bC9+eWwWNOjXeXIuxGDGNU9iV/nl
         sr+w5IlseZbGOxE2dwZnOtdFleqSenhg5xTrrCSGF+yAKlgr5hnI8XaenfBFpNx899Df
         z/aGOePXrNtQynn4o8UAXvd+e7g3nIsIVfP+EJRyIAHPCIdlJlRM55OwctsiKas/8GKK
         JzN0fyCH3zyAkQuInfdkDgAKXElaTCQfwxpPdWQbe1mhOJFG1HQzZmK3A1MD9fAN/l+f
         /vmA==
X-Gm-Message-State: AOJu0Yy1zaPkVjWPpab5X17yNpnYCwgOkCOo9m88MLo8VUW9tNDOLxMt
        bsaDFRjLiSnDhr6B73PSXiiz1w==
X-Google-Smtp-Source: AGHT+IFNvP3nVII/0in2m5J1WxMEgi1V5KMaiXDYYzBIuuAxC1qmhG11U9shoCrvQtQkL/MU35LKqw==
X-Received: by 2002:a05:6512:1156:b0:4fb:89b3:3374 with SMTP id m22-20020a056512115600b004fb89b33374mr1420594lfg.54.1691759072138;
        Fri, 11 Aug 2023 06:04:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:16 +0200
Subject: [PATCH 09/11] interconnect: qcom: sm8150: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-9-a85b6e94f46d@linaro.org>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
In-Reply-To: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=752;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Nq32DQWDG3W3gZhFfaF7hP8k8AW3emAR81uznO7xuLU=;
 b=dbVodAFTBl9qaWZhPJb7Cjrq7rNknkl3x9hmzH/OP3CRv583H3WDljSYODzjw6QAF414YIjZE
 6pNLc0y5kgICVTQtSHyM2ONQ52wuEsDv8k6K8sYvIXNuvyF99Uc7Eij
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: a09b817c8bad ("interconnect: qcom: Add SM8150 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8150.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c7c9cf7f746b..1fc4323633ea 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1282,6 +1282,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

