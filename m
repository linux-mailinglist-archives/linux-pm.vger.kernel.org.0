Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE86E4933
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjDQNDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjDQNDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 09:03:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1F7681
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 06:00:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1763ee85bso2701315e9.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681736331; x=1684328331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=MeOycZq3LbAiiK3Hm2X8W/COut++E+vIWCEtvBYWqenlv06pENIoUEQ6eZ6XufizqW
         c/IUnFjRoZx5Kh82hO7Xb381qBmCtD21juS/Cn6w9ecwglVp7oxZxnrxZgrAsHXfY5mq
         LsbgdBUI6g4cT8tuQ4BuoGShKwzaZHdQAN572xT4bEYp3Zv/NWTBfcPQt3eskP1WndI5
         CEtCP+Rbp5ZtWjKRW0C4RuUH4MzyDkUCOz7gR2lkgp8wcTU3qmjGf2PtjYRYrM92zFh3
         BOv7X6WX4W6YYSyUtOXlnJHuFSZHzniNJLbwbpw8imneTfm1K28gj68ULqVXsmNC0nRA
         qRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736331; x=1684328331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=K819ZskWmja9Aiwjtj9gTLydj9QPS9JwjPsJq61OUgl49hOE+/Ata2BtaAxFxRfDno
         vpiRUiE+kb6Nj7vqxUHUqJrmqvVZZjSHvCTBtBYWoSqhj67xKF2BPT2wf3xkKpi3+Wt9
         OiUDUKueRpmu73W2Gf2p1bpdgvF8OPin/vaDmGlvzXBz5yud/KQowzog4ZnVVCa7gMcu
         eJ3GAAcZw9fHeMC7oe/3pRafVwsjoHGYCg4aL6KEMjvNctYSkSIYvFaztFiNE0x9nHLR
         dIoWN9lftL4bFoBjze7jdxqnSnEmEsfS7LNqGcXAVWbiU4bR6r5x+xVX7qzS5SYoC9KW
         KaLQ==
X-Gm-Message-State: AAQBX9coxBFFULXqMjIKUp+rLbDJZmnvCuUd2jNVd//TS7Q11RNE627O
        vdebk459WcHSxYwkYCmHoXbGPw==
X-Google-Smtp-Source: AKy350aIVyNEBXkF1ad22KkjaB+EJlqbxjIr7CC8RxeYXKgwbn0e9AW2osiEulawxfmdhVqRDcIOWw==
X-Received: by 2002:a5d:5152:0:b0:2db:11f3:f7ee with SMTP id u18-20020a5d5152000000b002db11f3f7eemr4584684wrt.63.1681736331398;
        Mon, 17 Apr 2023 05:58:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15557546wmo.10.2023.04.17.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:58:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 3/5] arm64: dts: qcom: sa8775p: add the GPU clock controller node
Date:   Mon, 17 Apr 2023 14:58:42 +0200
Message-Id: <20230417125844.400782-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPUCC node for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index a23175352a20..191b510b5a1a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -591,6 +591,20 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sa8775p-gpucc";
+			reg = <0x0 0x03d90000 0x0 0xa000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.37.2

