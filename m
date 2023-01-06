Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10165FBFF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAFHdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjAFHdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FC71FDE
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e13so740911ljn.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmoHH6Hgcnax4siMasK0u+Npv8V2UvkY+nngddvtueY=;
        b=LtDOu7nd3mhwhim5Dh7dNG8512puR0MGGiTUbR0rJDQ3Wunf0IWjy77k6qvW86aBi0
         rsDuXJ2f5Xs0g+JwANwnIGxiKKoB/JA8M0Q4+AA2dvYNGwpsYneQlolBoKBH11w7+3oy
         Xwx0o2q8FI455E87yzWc07NqVg2lsYJgoIprwE5juELIF6dqmp0vRebnxd+IWLMIEpVK
         cw50pKUEHMVDPJZ9d7//fSame7+CdD2BEeFgBYJDi1kgRGRdKv+dkP8nbed1S1OKq31b
         hnlmH2+M6KNGrTTI9ryQLvjI6e4+8RaRNNHwN9GBEuy/i/IdmJ/YvHMvr+L9+2eb/k1V
         JZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmoHH6Hgcnax4siMasK0u+Npv8V2UvkY+nngddvtueY=;
        b=5zQt+nIOIn6rxclk12pIPzofm8jBZxbPCLz57FNkg++Lk3NUWWGWLshFM//lttjccF
         Wm2Ra5maNKDPXuzzq2es9cC+hSOycMgCnuqd+GthJdXGWZKkvvoNx4lyFMox3szJmS1W
         ZzGM/rQTp7cfYz75RWyBjDBgYLboPo7iz59xLQFmDfuYJ/zdcLArvu+OUY7G9YROEtjk
         QNPtpPPCrTEjy5/BmX50Snws2nswV6pQu87xtnxyG24VR2Ts6ID+0QnYaQUHc0ls1/1Y
         dsvZnfBQt6SCb5a80iL2mxAwTuKrfQHsSBJCnnKbn1VL8mwUo3PKcLqI2NPBVp1dkKdP
         vRUg==
X-Gm-Message-State: AFqh2kpmIXNfLBAeNtghv49+BpXdnbRP7MhB/V79ocCsj7mSNDeD2/7S
        tENuCyLm0F6Kz8XP/mVfduO6lA==
X-Google-Smtp-Source: AMrXdXsYYIC7k1DVAtBaRJp04PBOPDYVuhFBXLnSyr+HGIuqywO3HMAf3rkAvXGdxYRNw6ElDUWUjQ==
X-Received: by 2002:a05:651c:1992:b0:27f:ae36:83af with SMTP id bx18-20020a05651c199200b0027fae3683afmr18496353ljb.9.1672990395477;
        Thu, 05 Jan 2023 23:33:15 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:15 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/9] clk: qcom: rpmh: define IPA clocks where required
Date:   Fri,  6 Jan 2023 09:33:05 +0200
Message-Id: <20230106073313.1720029-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
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

Follow the example of sc7180 and sdx55 and implement IP0 resource as
clocks rather than interconnects.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 586a810c682c..5f914cf36b10 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -445,6 +445,7 @@ static struct clk_hw *sm8150_rpmh_clocks[] = {
 	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
 	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a.hw,
 	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
@@ -484,6 +485,7 @@ static struct clk_hw *sc8180x_rpmh_clocks[] = {
 	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_d_ao.hw,
 	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_d.hw,
 	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_d_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sc8180x = {
@@ -504,6 +506,7 @@ static struct clk_hw *sm8250_rpmh_clocks[] = {
 	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
 	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a.hw,
 	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
@@ -546,6 +549,7 @@ static struct clk_hw *sc8280xp_rpmh_clocks[] = {
 	[RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,
 	[RPMH_PKA_CLK]          = &clk_rpmh_pka.hw,
 	[RPMH_HWKM_CLK]         = &clk_rpmh_hwkm.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sc8280xp = {
-- 
2.39.0

