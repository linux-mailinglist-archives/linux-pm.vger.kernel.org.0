Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEC465AB5F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAATlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAATk4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:56 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1010109E
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bf43so38893490lfb.6
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZBrWGsgyNha7RW/93aBTXd8U+HviEYa+gXS5auCDeY=;
        b=WXFj8kiF8wjeKgfs/iuZBoFg/xKb0CYaYlNtA+zqP64hC2+AtxjgEcyzNP1AU3ZXCH
         XHTYBdGke3qpI8CLEV4EGd0DvEwith5f872E7/8OUbY575zGlRhwPAucSli4fi/zqzED
         xjl+4FOrM+o5oQs/3Sz/iFZPnkoZfyM1vhdJDkbJDqgN/4/Sm3HmOKLK7AfoCp9VubnL
         FFkdB42U7+Cmm2cza1V0N+p9C5wqV4KVUiuLlIlUWMyF4LxGz9E6nlOTeyYHFPmKbZWH
         TpJj1dt5ytmhUvQRWMbcYQJg4DfIZVQyi3mu1XMzx8AsNxL3iGPPLz6CW1Tte9RVHhpg
         mArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZBrWGsgyNha7RW/93aBTXd8U+HviEYa+gXS5auCDeY=;
        b=5iCxWqi2a19tqW2AsBbWcONQl7CTmQGCy1BbWjv6FZLppMnWVYRJBP2PvMZPoVS0YH
         H6E1vdhi7d8iCI5yRZ4cjFQfDZtjjj9Fn4iig+raE0jpqREhE6qbKPIX3KdpgWlaFYpy
         v2Zx8N4AKEEG7h0iXnMHCZCKHW+giGb+XuNjvQ7TrHMNNNUquxri2B0gRFsZgHxgux27
         bJ3mavVHoCQlibo/t+LKv3WS8k8IVh+bWmw5SsxxAp7YcFX5XFLDaNAphyLa/sMp4Dlz
         7diZ8Pz/d9xc+AGiVpQPX7L90BO6B+BD8yfTt3hFk2RMt4BFmq86YjQp1f3B+eEYA3rp
         KnhA==
X-Gm-Message-State: AFqh2komb0HlmSpMLsh1ph0j/HYbG9yrlwvQLuxYBKGKkYCPDEljdp/j
        gHrFNcMZ8Py5Ccxi3WZVuLuByg==
X-Google-Smtp-Source: AMrXdXsnmPW7gHWrbB6yajAVaDxCZJZqZWU8PHoSXYkHSMAbHLDj1tSumJs0lEhHhVxU2aw3XFCnHQ==
X-Received: by 2002:ac2:5604:0:b0:4b5:8507:9ae6 with SMTP id v4-20020ac25604000000b004b585079ae6mr9708657lfd.2.1672602049399;
        Sun, 01 Jan 2023 11:40:49 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:49 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 15/20] arm64: dts: qcom: msm8956: use SoC-specific compat for tsens
Date:   Sun,  1 Jan 2023 21:40:29 +0200
Message-Id: <20230101194034.831222-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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

The slope values used during tsens calibration differ between msm8976
and msm8956 SoCs. Use SoC-specific compat value for the msm8956 SoC.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8956.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
index e432512d8716..668e05185c21 100644
--- a/arch/arm64/boot/dts/qcom/msm8956.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
@@ -12,6 +12,10 @@ &pmu {
 	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 };
 
+&tsens {
+	compatible = "qcom,msm8956-tsens", "qcom,tsens-v1";
+};
+
 /*
  * You might be wondering.. why is it so empty out there?
  * Well, the SoCs are almost identical.
-- 
2.39.0

