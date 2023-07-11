Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825074EEA4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGKMWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjGKMWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:22:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC82D5E
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso89591821fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077964; x=1691669964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+HpM+HCeMpSefmXK16C9YcJaoau/C3nDGJIkf8i7cM=;
        b=CwAdfORGkFA26br71Jzt54Ul1bfX4ar1+m6NVBPcPGiKuANkgW5//GCXZCHiy1bIqu
         xnqV3+Y+5V+zQqKZiB3TFbeqAiftTg+itRMrnRpj6sJEX0mMJ04rjAmmCj4S59Yh7ixn
         LdvqeEp9wzkCviMwePckTG9N/wDlssLWcdmVBiL39RK8SGmI1vHtJPzflgWAkfEoh9eE
         mTqEc263t3gsrBTGoLMHhC8CM+Lc101MBPwNczT58OabZJtctIepB88hZG1vxJ0iFtkz
         hwF3Ex/Im5dTKxrqUQAQ8qMRszX011b6myOwwbIyBeuNnLyct8ruAy98cVjTEV0jGKc8
         YYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077964; x=1691669964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+HpM+HCeMpSefmXK16C9YcJaoau/C3nDGJIkf8i7cM=;
        b=aNYikgnZl+ONuODwmMl6FHwEYmVDcSY/Zh1KcVr23Kg07TPhNkMUEVgvmtxIS4aw0w
         DhpLz+0p2tpy8cmacZAc/8Z/WabVtUXhFPxuQn0JuKG0Xd28L7TvU/8jWWfT6zewSBEx
         fLjiZPYnlV2raNEuyHDAOqc+qwnkqOioKQN0GBLR1nZYKhQtQp/bO95hKJGwTkvo/05l
         ohkK3x7HDV5VDcDkHjQMIopMsz4d+jnL+XM6J00UMGiYEqZ80f9tnQ6ilCrEyRIqVgWV
         33GVTGlCtTuba5cUbEUWj7oftpCJ1oghbBGW75K4oJZQpJHwEl8C8QllHkyFmx3rULuo
         Nhcg==
X-Gm-Message-State: ABy/qLbl8bx4TT1JfQjg3QjWmt/BYQOO6gmSCDElVnLmwcPQ8kH1QRsr
        0lrFCUzWuUMuPVa5HVf6PstQwA==
X-Google-Smtp-Source: APBJJlEQupFlCuRT7R8SseW9Y2wdzGnv9aFcooCUZ4hnjXBLeIT4wGij8HdFQ5+TYBuRWwliDkKCtg==
X-Received: by 2002:a05:651c:211:b0:2b6:da64:321 with SMTP id y17-20020a05651c021100b002b6da640321mr12309325ljn.45.1689077964399;
        Tue, 11 Jul 2023 05:19:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:43 +0200
Subject: [PATCH 44/53] arm64: dts: qcom: sm8250: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-44-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=999;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ebMrQjKmDTgpWjkINs/Atf2PQmSY9dkU3TIUUbwBPoQ=;
 b=2OP9+lUs6pA/83Z+vE3WXtNyqzqPquNrM8XqK7DknAXmP1+1Lj4UX4sVKsct2f4C6r3LDSIVi
 Etb83M3eBHhC59EcuJBb6ILh6z46QOGZc8myu/aS85weLkvbSCKm7x7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e03007e23e91..29994aae897c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8250.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -5674,6 +5675,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0

