Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C30A661B88
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjAIA35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjAIA3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:48 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D3BF7D
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:47 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f21so2941667ljc.7
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjPB6qMW5CCrupsiViZnWcfIPvSm2Sn0b8lV/kmvycs=;
        b=pUuT17G5e0SejScAgjZJ4OGuD7+c3+MmW8gn7O29vf7SlvLrktwyWySTxyCCAFgACA
         mESJmOBBXdqVb4U+iaNL1FVeaZ8DyeCqKHqDkLCEHWN+6ckcMgQp9mQ8LIDNxdDhiRJL
         fmPoXejJTJoE3gVCFUlCnrHKKbcZ0egicdDIGL6+Q7asbuQrgWlqQyUbD3rroJyfx57u
         GQQGOV0/qQjfLZvk7b5RNZWhY7TKAyPR31Pe6sPOjFcK6D1FDjDO5SVX4BD7WU3I3h3s
         3tooVG0P27Gsv3yfsbR7IAfMDZmhEg/rHoNJBa2qmscC4yKS7GLKzBxpncWFLRXPOBXN
         OTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjPB6qMW5CCrupsiViZnWcfIPvSm2Sn0b8lV/kmvycs=;
        b=KYc6rL/FkdC6Y1zzItuuZqncEoaN1puyo2Ac4AhrXNPTaeCTBWRzdz/reJij+5U6e8
         g9oFb20DNw7UP7K5bBrvmSSKAldhOmCFnFr/LR+HtCorSDe9r1IOepT0u4lO7fQCIdzp
         3adzhSwZyjTM94VNNOgicZc6qBAMAbB8zznfb9gmnWCrdWxB/dNb/AI6gEWqmXiQa3PT
         HuUT/bUVsqL+OQnpP0RFjYt1FFPXmwafiT4lhrcyJyUtQQUjtzj+wC97VyFZskX8Mtzs
         j4YXFH23igWuUVkPJZ4d5izNLyYjCyAfKAJ3mnfK2BPkjYpRbPYkwpfp4Hm7+Xt3EqRm
         9f2w==
X-Gm-Message-State: AFqh2kqksSNdf4R/dxrvqbk5/KiW/T7Nu9Oplvtm1Tyq0jryxMXFsn3B
        m0/x5Qr/LUgLmx8wQ6jODpXn0Q==
X-Google-Smtp-Source: AMrXdXs3V9UJ/f8K620dLDOGLZs16j/yzMCMU6ioDI8fxXAgltRsxmGtpsNXnRrtM3QBfZ851+yWQg==
X-Received: by 2002:a05:651c:b24:b0:27b:4975:a468 with SMTP id b36-20020a05651c0b2400b0027b4975a468mr21475901ljr.36.1673224186839;
        Sun, 08 Jan 2023 16:29:46 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:46 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 12/12] arm64: dts: qcom: sm8250: drop the virtual ipa-virt device
Date:   Mon,  9 Jan 2023 02:29:35 +0200
Message-Id: <20230109002935.244320-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the virtual ipa-virt device. The interconnects it provided are
going to be represented as <&rpmhcc RPMH_IPA_CLK> clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b3ab2896a6cc..af298dec0568 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2215,13 +2215,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
-		ipa_virt: interconnect@1e00000 {
-			compatible = "qcom,sm8250-ipa-virt";
-			reg = <0 0x01e00000 0 0x1000>;
-			#interconnect-cells = <1>;
-			qcom,bcm-voters = <&apps_bcm_voter>;
-		};
-
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.39.0

