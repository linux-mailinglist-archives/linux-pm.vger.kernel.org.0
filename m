Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA9744F3C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGBRnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGBRnQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2DAE5E
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5c231f842so54009301fa.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319793; x=1690911793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SRMw2832DQB4senqNrBO6nhVQ4RvkIxirBPWKvUG+w=;
        b=WYcGYHYQSTykDSVs/CC+hPWYKiefIFjasm6fBAXi7bBXdeowIypy3eU1E6xjtBLAwD
         z0F4Ri8LsJtQMK4x9gDLbuR7fngKyj5tACmEvBIPAP/BJSpY5dTJgUDGV2pkpcKuIWMc
         NtHvyRmmh9iUmpdyRXA7woz/IaErGtg1fFKcDTyX5lhbuBfLaJbn6/CF2St2rlH+Y1oi
         T8xVY0sRVDzMmV/qEnNv4WeGqA6JGAMlfD0/XjtZDj1iutnYwkzZzs6fE7LYis1ccs4W
         fjnsTJ2u0pYGB2aEcgQ80L6V8hlmj/rYzNMNJwmTbDXlyH14HzpW0xpLLZaZstC4m8DS
         mo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319793; x=1690911793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SRMw2832DQB4senqNrBO6nhVQ4RvkIxirBPWKvUG+w=;
        b=haKcpdanMqAgA9TE+TDcipswwoHZNpJiGbrVk1P3pQGkMZJdQvE2boohsaBH73a+uv
         E7W6qTyUysFTzm5XBALUTXpa9u9+LDzgRGg1/WIYZvB/Uk92spPLcf449peurlRdbwEU
         fZ1qNQukXMXSPfPsaTIO20IUk2s2izpH9dgkx4iptG2rGsXpYhcKugmeAbz0Jg/+owaj
         yNVyo1zit/iK9pm5iEb6rrBb9YuuGuus2pMvE/miXpDppHRMnnwREEIL4KA/Wm6sFTwi
         TeekcpvNMsrDHNA9V50nHPKW+n878g+mJ3fsAVRjH2f5/vLFvZU6sEFpqHV+DVh4oJ6U
         rBiA==
X-Gm-Message-State: ABy/qLZTOeFVhfFNhTcMTm8Gszi549sjl/CyRF9nujIXRmQUUodUE03l
        qQPkOj7kFaTqoTeaoU/rGy0Zow==
X-Google-Smtp-Source: APBJJlHcTkVDz57v9uEaWfG/MgSJY5N/hkVOJefQpd3rwFselpcTuYqdhD6ecBmFMV1lnrdGZrv9Wg==
X-Received: by 2002:a05:651c:22f:b0:2b6:ba66:8b4 with SMTP id z15-20020a05651c022f00b002b6ba6608b4mr5414161ljn.8.1688319793640;
        Sun, 02 Jul 2023 10:43:13 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 28/28] ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices
Date:   Sun,  2 Jul 2023 20:42:46 +0300
Message-Id: <20230702174246.121656-29-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator nodes show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6198f42f6a9c..ecb99e104de0 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -589,7 +589,6 @@ acc0: clock-controller@2088000 {
 		saw0: regulator@2089000 {
 			compatible = "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
-			regulator;
 		};
 
 		acc1: clock-controller@2098000 {
@@ -604,7 +603,6 @@ acc1: clock-controller@2098000 {
 		saw1: regulator@2099000 {
 			compatible = "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-			regulator;
 		};
 
 		nss_common: syscon@3000000 {
-- 
2.39.2

