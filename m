Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D3789D68
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjH0LvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjH0LvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:51:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E81B9
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff882397ecso3492690e87.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137053; x=1693741853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzx9Bm824S2wRWYFO7S2MdJvHvf/jzSVekqRFumNr7k=;
        b=VKlq61LG7eiUVDlCu1oOs0TkRJTbsYvQqWvjCRgyDh4261NSRyrk6YloVEyca0sTaF
         29YwGLcuj6pb1PlsAaw4qGzLFP67VXskypHQxXeV5Qoj1SFR7jCgT0H+msqeKhdMd9+M
         cDLwdt2Tdlf2U2bSFAIuRR1nqc/1EjZAQakEXu/Oh1IE526FkyhpBnL4ABWEgIlE3tEy
         juQNJrBC6Z3ON65rfiELxGYXrzkTeM4cmNs4EPGZF2ySaLVaHDq1d4DjwseGf6g5LVt7
         vDfduzDIUESXJZ0rz6Ly9LZtPTVI26zgg16V9AGPwTOn3T+ufczczVmkdEFTqBNf0OlG
         AkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137053; x=1693741853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzx9Bm824S2wRWYFO7S2MdJvHvf/jzSVekqRFumNr7k=;
        b=k2nhX3YydbXjpHQNHkajAn7uf8Dpr450Hf/gcGWrqreSqyEyPA5MY9nZe37xNRLmWm
         On7GhJP1QCWVTBfJpwH09rtFjnz1c4u2Xjz3uRrR9iaX5YiibZQOpM6mwxnJ+H3ONkBy
         TyPb+Zq1fv22PW2h3b7kCW0lPfSYEN1EJkbS0VU1LLQw3yMaKl/dchbG/kpN8BYT4M4r
         4kExDuXx2P5S02MTN90Trbz5jfXksGVKoHraQwXLxz68kUDsSobmo3P2/eTv/4NbxXoa
         Wg9lJ5dDP2Ls3xVlhEyZtWNuqrZ08VNagVbRkqcf+4V6pIrnkoloi3auYSiUJ76mX6JR
         g0MA==
X-Gm-Message-State: AOJu0YyFJHTxXPu/bXqTpomLDRjoJx11m1ozU3W/6z6cTjV779JhcYSn
        OaE0brLxWmVkJXE2/aNcOL51ww==
X-Google-Smtp-Source: AGHT+IGqlgoo4wUMXLVlAqHZbEMker1couiI+m+u0qpCzAbR2CI/aAjORLP/ZrpQrfkF8v7v6brvrA==
X-Received: by 2002:a05:6512:4026:b0:4f9:570c:7b28 with SMTP id br38-20020a056512402600b004f9570c7b28mr20427762lfb.32.1693137053533;
        Sun, 27 Aug 2023 04:50:53 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:53 -0700 (PDT)
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
Subject: [PATCH v4 23/23] ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices
Date:   Sun, 27 Aug 2023 14:50:33 +0300
Message-Id: <20230827115033.935089-24-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index c3677440b786..191d1cb27cb7 100644
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

