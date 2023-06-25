Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269273D404
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFYU0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFYU0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5EE65
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b698371937so13681181fa.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724768; x=1690316768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsB0kVQqX4mQM7Q3aDO7WkdZMCIaYUHODUHDaiQmm24=;
        b=rm7Pg0KmuGexdBAp36B8Gl2KIiLw78VIsMS5mILTXlIzw+V9xIZwQMkj+/7tcGJ2sZ
         znYdWyLd4iJBljNtWoSFrgHf8/rqIkLzs6pFDMbmS9lDCeWbzJ9poAq7sJUX3iobGPpJ
         JBjU772CnwXiz4jnwNjtauYqwekpxSp25TIs2OX//RQz7LRwfXdH7Zd5et9v68OAyUeT
         dHqVAzvgYHUCcV8oS2CYPli1Va9P8QNJ+AiySIu2L3Iy9qHLtF/rkVxNXLYF4ByIPoVg
         TsvCdzXGiyOH1o4lrb+JEIvHfDOlxd3pg8wIW3kZrq0O6y8iYo9Z/oJOD1Y4gpTMXVGe
         2Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724768; x=1690316768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsB0kVQqX4mQM7Q3aDO7WkdZMCIaYUHODUHDaiQmm24=;
        b=fGnM64tNn5QQnI+hH/FtFEnzVYyWy5WzLJTiI5LRtvI0k/MIyOu/KqJV1Nyxwptp7v
         saKgo0SDTQRHvCsK4dthMelHnHCa26IWmO1Io0rbxAlrBNKKnEgF6i3CooKzM6a3h0tq
         9e2yKb2Fcm3aBJjKuNFzeOttQTt358/IJOzk5pDP96k60/KRfMByyAxrqgLPro+wZEwJ
         +1bjjADonvVKRqv9Az3j0CdyYiE4waBaqmcAV4uTBg7xyXe/CdqoJ0yNtCLTqui9K4qc
         m8EEPv5K1T9xhGA6461S8MsybuoNSBqjnkE1z3PhNnPbnMEk73sOKAdw6bYVcfIvKmqb
         pElA==
X-Gm-Message-State: AC+VfDxCMa7qtDNAUWinURzep4DtMIB0aKxZF5W7gk6y9+rst9N/iIcK
        6kaO2GXdl09lt+ZUihRlZEungw==
X-Google-Smtp-Source: ACHHUZ7CHkogDyv44MiRPQkIPF8Zv0B5eSz5A9zcFea+knBkfFw+iSG6+3HjDMVst2VMERATa7MKcw==
X-Received: by 2002:a2e:9650:0:b0:2b6:9d4a:d67b with SMTP id z16-20020a2e9650000000b002b69d4ad67bmr857533ljh.44.1687724768085;
        Sun, 25 Jun 2023 13:26:08 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:07 -0700 (PDT)
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
Subject: [PATCH v2 21/26] ARM: dts: qcom: apq8064-ifc6410: constraint cpufreq regulators
Date:   Sun, 25 Jun 2023 23:25:42 +0300
Message-Id: <20230625202547.174647-22-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional constraints to the CPUfreq-related regulators, it is
better be safe than sorry there.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 96307550523a..ad3cd45362df 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -215,8 +215,8 @@ s1 {
 		};
 
 		s3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1400000>;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
@@ -262,6 +262,12 @@ l23 {
 			bias-pull-down;
 		};
 
+		l24 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
 		lvs1 {
 			bias-pull-down;
 		};
@@ -269,6 +275,14 @@ lvs1 {
 		lvs6 {
 			bias-pull-down;
 		};
+
+		/* HFPLL regulator */
+		lvs7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
 	};
 };
 
-- 
2.39.2

