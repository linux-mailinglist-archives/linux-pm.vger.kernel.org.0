Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004D77901C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjHKNEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjHKNEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 09:04:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A630C1
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3155890e87.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759069; x=1692363869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrsS1RdwJdt4hRhY79G6muIkxzGJrJ15fGppe4O9U4E=;
        b=mo/nkRx9GtQa42080/8ig0mlhJap691CQKKfx1WDbmwSg5HGp2J9Bllc0DSpU8Bn7+
         QTSZMdaY0Ruz1Z83dWVZR5SsgVgJl9fubN+dc+DhAmgSFh40PZP8ODzogMU3GVwvQBE2
         DpCl9+bLWshdRFqmRKEn/bVwQ13f2KKvXxAWDnGTPxhYs5rO6PY0shL5M+P/P6lhomqK
         NQv2rSadk1vGDNWRmgG+nRLT9k77z2EfmBLRKfn4GxEON86A3ewWjby5Vn3N4RjEfllY
         UdIFGLIOSldI3f82Jn5MMHDLf1At5ubYAFsimK3KhXDRXTMLQQhXb5jDQBZECgpcn6Ai
         o9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759069; x=1692363869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrsS1RdwJdt4hRhY79G6muIkxzGJrJ15fGppe4O9U4E=;
        b=jY2EKpq1Rt8Xbdic2KUCRH8KcvzyOtu3P83+us8P8HH0U0zyS3ZHY4K8lWqqHYZmK9
         y1xhCUY9NAkQ/pQBcEzTw7UOhZi4udojDJ4DR9zRN7sx+lX3ndrDzIMLWVlCN4Tzm9ry
         f9NC0gZjW6L9WViLQRTv3YMaBKdxDNMKhxw1HnEs+ilyJlmCMsi1DEbfR7QaQ3NNh8W3
         Gs3tZFuP4Balr6xZCIHqXCMcRgtcWNSfIM46HjwniKtKilLdUWk3fZ9UT+PpDvzqb63Y
         BFTo5y2KaEmcc+4yzjpAseazk/kIUw6Bx2ytL6HOsJKt/KQU7M/obRL5IjJQQZEhBq1k
         isPA==
X-Gm-Message-State: AOJu0Yy2AEi3mIKQ/j2sa1R7SggW4o1fi1wh9alTwgSJpivRKdvYtVe5
        iQ5DOCn9vs2jNwOqKnRvfCT20g==
X-Google-Smtp-Source: AGHT+IE3ydocibSJR+UMH7S8wMTPlwdxdCqiXLE/t0Tmw8pyzihD7Jsc5WGkRiFIAHLtWfimoqlEWg==
X-Received: by 2002:ac2:464d:0:b0:4fb:7642:88dd with SMTP id s13-20020ac2464d000000b004fb764288ddmr1101507lfo.67.1691759069271;
        Fri, 11 Aug 2023 06:04:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:15 +0200
Subject: [PATCH 08/11] interconnect: qcom: sm6350: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-8-a85b6e94f46d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=738;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=V/GZq8eh1VOo41IyaL+j/2DIjXuhi0IdyE46etMX9YE=;
 b=9azOfRn/IWYr1GId7y41905epNcCeP6h9HsRTyDUd+E4wnz8LPrTUQiyvdfwGRApNmlT8glEX
 maqM4T/J7asClWhRrChJd/JwAREDUUDcIHfDeQX9M57wrU0pz6DPmnn
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

Fixes: 6a6eff73a954 ("interconnect: qcom: Add SM6350 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 49aed492e9b8..5b6b174735a4 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1164,6 +1164,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

