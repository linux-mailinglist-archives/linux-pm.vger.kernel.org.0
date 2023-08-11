Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAF77903B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjHKNFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 09:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjHKNEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 09:04:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E130E3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so3020952e87.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759074; x=1692363874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSJuIpZoyaCZteiOEQ+bhjiLYz9YMkE1DlPauAqnlJc=;
        b=NVvPfntlukoh2QUA5g8tBdXvKChJ2A8uQwXz1YVo/e7+suobTGp6qyOkcmYK2oZZn3
         C9v76CaX6/zhQnFKA32ImPtlLGR/Ci/wQAld2RcoZLvmkx64aD/6TAH0vHgKtRe8ZqiQ
         iQNuxvUoflNaOnyy7UcZHC375j0TAeI2eI5csA4uRZlpwHwMVkUX2XfrSNFfNU1s8lC2
         +x8dcDjWy7wuY88G75+B4EoKdebwRbFbNhS+DNY1n4oNjQSNcB2WkocgXkZFs2N9JWnP
         GaMij9ED8vz8hi1Are3hbG3kSJTI1CGqnd3C2IZ2UmzeVr+JbUxG/QMSU2cUaY4Xyefs
         hMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759074; x=1692363874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSJuIpZoyaCZteiOEQ+bhjiLYz9YMkE1DlPauAqnlJc=;
        b=Lcs07A30qTHOYfckSv+xg/BJLlu1W/5dP1iugnLNJdWyq1NqmErlAF5Z4Jd2D2cabr
         VPCRmMd6NqGTqHcAQRXtuLVP1woouGVwR1Nny1JYfrzRtbuCvjmKfLvFGHPVggUwvuru
         CBCKlogv+aAbgAiITJPQClxWCsTbhfG4mrL4To8HEgci9VlQcIxPym+t312Uvhmm/IAu
         GG8kpFBrLOuTe35YJWYPSLQEhyrinfJ6C9abYSVMTYJaKsNq4Pp5OPFWIX++rgAHvamX
         43NmoBZFibGtRCTx2A6IWlPh2klFjl9WvbRxIjUNboIIwpbGOUkm0BZSGoy05VTxCYnL
         VFqg==
X-Gm-Message-State: AOJu0Yxvkt5nfi9f9fkaFNW8We9YaZQ2bswpevpYTgr9adWVr8JFPvlO
        Uet4IVW1RQ4TeCqzoiccw4SeFg==
X-Google-Smtp-Source: AGHT+IEjInuMQmk5V/KjNg7pZOc0B9XnSVQWmNuulyGuH3hAXCuDSfNpjmr2ACAaqjlNStLsyvDg7g==
X-Received: by 2002:a05:6512:304a:b0:4fd:fc36:68a2 with SMTP id b10-20020a056512304a00b004fdfc3668a2mr2094051lfb.1.1691759073960;
        Fri, 11 Aug 2023 06:04:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:17 +0200
Subject: [PATCH 10/11] interconnect: qcom: sm8250: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-10-a85b6e94f46d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=753;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kGjEAPVOoDaeRtsYH+fP8I1dp0NkUEZT0h8XOrWCYVA=;
 b=Ycy6izGPP5tobMelR/fzV82DWFa0msx/eOiLPCi99Li1eePJ24g7By5rYXJV7sSiobhFB5Oda
 ZbfHPZwB1zzB+vSXwKpPU41r800LthHV/HBfZXvDYB9L84ZpS/BKbNs
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

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 6df5b349491e ("interconnect: qcom: Add SM8250 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index d4a4ecef11f0..19d5ecbb5a48 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1397,6 +1397,7 @@ static struct qcom_icc_node qup2_core_slave = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

