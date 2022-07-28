Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E4583DA7
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiG1LiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiG1Lh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 07:37:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDF52DEB
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:37:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p11so2435822lfu.5
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8f7AzP41RwjwjZoc5Fi63P8k3nDowsYtu1Mq4bqqV00=;
        b=uRee3hHcuqRucHOZB3WCx5VdGAyydjYM5zjTsBKtDKgkMtOI8MOv66+a+0HMyNLZd6
         6Q1LcPPX/b6nOZ83WoVq1Jyme1AH4prpuQxj9AL3BZ1SPAYUdZLDOVLZXL3zEcP3tYZm
         wa/N2d6kHIMjSvytZl+GnFZbnn4RO8PTrZdhRTNqThr54komn5FXDxzf7wyr/7Vrfx7e
         FSPxtGVDVr84TYiKy799uFEP7t73w8tvbWGZ/1LQ0wbk4mHxTVuwLA2yqrIKhnlA+m+m
         DbMop+WnD/kcQTfHz7+MVwdFxdcVu7m63MNahhCIzUXa04cOUOefM1g+5rSkGiT4CjhJ
         Ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8f7AzP41RwjwjZoc5Fi63P8k3nDowsYtu1Mq4bqqV00=;
        b=2d0F5iG8Ls94klgz/TkOV+BawAf7ajvlbtiVmTFMj2WsyjkEsQaw2Yqq36AeFu5ujI
         RZNm60eKj5JfjITFOsj0juYc5h36O0Mpt9NzhcAUX8qq/qYWmkrW7zvOF5WE6KHw9Pey
         wvRyg3vcmI1+Ok1YjhzmqeTNYP/D46Nigpai7ZzudHo5Ryv0uHsuqFAl5PbLy0Tis3TL
         Vx4uFjGhIwXzc0EYW+pvzd6T/W1lIjdBdu/Ks4AMQbt/PtXSdLh+5VK4kH1+ZlLatNDE
         Sw/26i6eUUj8GeYZlNqZE9Ol1qS3xfsroJmz1OAPZUWe08DBbVkx4QAM57XVas+fAm0k
         Nhpg==
X-Gm-Message-State: AJIora/WhJZktwWZtvqwwq9sYKGyp6VSFkkUhT24vx7antnAyI0D3G02
        /QxG8G1bgoU8cHJXVpOb5we5hg==
X-Google-Smtp-Source: AGRyM1svL/jAfEzurLOoAGAE0tDhv8inIGoxoPYrjBITobXC5679QnZn5OdPRm4PKEqAmE4ETI/Oiw==
X-Received: by 2002:a05:6512:1291:b0:48a:9148:64e6 with SMTP id u17-20020a056512129100b0048a914864e6mr6720951lfs.480.1659008275675;
        Thu, 28 Jul 2022 04:37:55 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:37:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 02/11] soc: qcom: icc-bwmon: re-use IRQ enable/clear define
Date:   Thu, 28 Jul 2022 13:37:39 +0200
Message-Id: <20220728113748.170548-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interrupt enable, status and clear registers have the same layout,
so BWMON_GLOBAL_IRQ_ENABLE_ENABLE define can be used also for clearing
IRQ, instead of hard-coded value.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/soc/qcom/icc-bwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index bea3ea1de7a4..3415f42523cd 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -162,7 +162,8 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * interrupt is cleared.
 	 */
 	writel(BWMON_IRQ_ENABLE_MASK, bwmon->base + BWMON_IRQ_CLEAR);
-	writel(BIT(0), bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
+	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
+	       bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
-- 
2.34.1

