Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8A661B84
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjAIA3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjAIA3r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:47 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D189DFA0
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:46 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s22so7363017ljp.5
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUZkGu7n26m3Xs47uNyxkgnrLNsx2oRREgP537Zptxo=;
        b=BjAIsfiL8ioFaNCr494zDu8a1xs4OAvZZM7zXchq+DNsPrCh32EWqsbkNh/uIgF/wP
         po+ltNrn4bt9LEGdXuWWEwzMc3SqB7SzaMb2dleO+OdjCEo4k9LgyH3ruFCXvsL6xwYB
         pAnrOAQrRBKssUwXwiHIeYkJBal5CNwYDl5HiyPEgMLqODOontMXDTCgQOhS1qJnecMo
         bkmO3VIBc8voe28OuWjKLD8bPIKtHW+4c9dSI/NNNZG+eW+3Gb11DdOIoe9MWI/ucXkd
         +qEFP3864dmhFzeZitrTB6CFqtreDqOMhV2M2ialkJ2EY90QzoDLUrK0aDNrEirez2fE
         i6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUZkGu7n26m3Xs47uNyxkgnrLNsx2oRREgP537Zptxo=;
        b=jr5hUQ5zZAqVG3ZsVG8PJc1v2faavGdRVCaiJyNb+9QoDA5QSJnkkhY4FTA0SirQvc
         2rI9ejwy3hJnNQvs7vzj9jGxXrgE4GxTFVCSGAl2IXh9sjILO4836pmfWLzqs/rkIzwk
         DhkcOc8JC63aObwOZlRaqd7kU5/h5DDdkCUvJ4qHPQywauCqTTIsjVP8XJH+CXVyb6D/
         mnm2ab1Ea0TkdrZDZSsVQ1F39YiTbR9QKWmZt/SgUGQDaTOLQorFCb07/LT2WtB9aq6A
         znAOwIhgfMXbu8FqAi7ahkm+Mv9oqan3YDofCpmuGhbQfxUSzCBBzPsPacdnFl5Z5Hvs
         6dAg==
X-Gm-Message-State: AFqh2kpKb/EQVAqdFxtOlz5uJ/fpsGFzOej53zQ5UausvLn+BgaPD6lF
        8Cen4yjzB+N4t5PH4TtQ4ed6Gw==
X-Google-Smtp-Source: AMrXdXsm0qvQ28CsJDKyvreI4c4N14eIL3NRwxEH2oxQksOZyIYDsPnwgFapJDXViBeZVLGQU4yNAw==
X-Received: by 2002:a2e:be27:0:b0:27f:b724:e98a with SMTP id z39-20020a2ebe27000000b0027fb724e98amr18505484ljq.18.1673224185894;
        Sun, 08 Jan 2023 16:29:45 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:45 -0800 (PST)
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
Subject: [PATCH v3 11/12] arm64: dts: qcom: sm8150: drop the virtual ipa-virt device
Date:   Mon,  9 Jan 2023 02:29:34 +0200
Message-Id: <20230109002935.244320-12-dmitry.baryshkov@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 99750987c9d6..0759bc22d0c2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2057,13 +2057,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
-		ipa_virt: interconnect@1e00000 {
-			compatible = "qcom,sm8150-ipa-virt";
-			reg = <0 0x01e00000 0 0x1000>;
-			#interconnect-cells = <1>;
-			qcom,bcm-voters = <&apps_bcm_voter>;
-		};
-
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.39.0

