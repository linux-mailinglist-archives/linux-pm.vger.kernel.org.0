Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB46FB4A8
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjEHQFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjEHQE5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:04:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F855B6
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:04:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso5329225e87.2
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683561894; x=1686153894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+Jhe48VXAoN+8wGaqTOooemilYAfgL+ZuJTPfMlkfg=;
        b=TTypQOY+hHf3wO324ueVxAch2AT6S/ea9n9ojC3nDAJa//ZeKbhvoDg9Qc6oiJRs/z
         EurZywZXEK3V8VIIoX6hdy6T2zvDXKlu6pVryNV22xBgwSZeuC9mZCU+fFy+5kZMuJna
         9az+ATyULir7gLKnRp2k/d+4kKVXBYAio/SfehztA5iphcnl54J5VV9iYQnKQgQF1CXw
         AgoaNxA9azUsNz5Cl39fQhsY8eiCBQjywtpQC0FibEPnXsa0CqP2C1GTXbGqJ2Ziqcbe
         43RVpkZUR6+c+FNXZeJpUaitMFsF517n+vQiu+kmjoUFVSpN1mMg3EwAUYyxqLfANO1U
         Jn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561894; x=1686153894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+Jhe48VXAoN+8wGaqTOooemilYAfgL+ZuJTPfMlkfg=;
        b=R1nrRUmTguHFXH99ro2oW5c1UIv+7y0519pJHuLTLhCWNI03SpeM2ppCTc70VBWX8o
         rS8rAbeKLP4dTs8II8eOTY0YsD+oYVYlfvoNYjAy7aQsXlafoktPRLv3E400hNUyOJUW
         M/YQW3RSimGX2gann2NjFauImOOHbu9oW0VaOhDg0yrELHA9CXY6k/FZz6dAwzbxrZlL
         84/cSkKhFVKsbBQgfo1haiBvmiXFZJMW91PPaV9Os6T/WEwjza662cjoyelE3Yv5hvek
         cuun/64jf+TtM1++/Nuteuhxk1NaD0K4pw///nbLxpn13HpbMiKXUSvNsh/9yHjXHltZ
         YkQw==
X-Gm-Message-State: AC+VfDyCt8AUTzPLkRRGiePRTvSH+pJj/nPIBwNKjWyt9o14KnHhXGIm
        F7iZ1vSh0E4qlUVZ0V1+Ekog2Q==
X-Google-Smtp-Source: ACHHUZ5+5DsVvjw0JvnA7oomUxPS+m38axatsdA/piUWxUQ3chP4cbNENEf1Gzs+rCD6LYZbeco5uA==
X-Received: by 2002:a19:f007:0:b0:4ed:b061:18ee with SMTP id p7-20020a19f007000000b004edb06118eemr2697395lfc.22.1683561894413;
        Mon, 08 May 2023 09:04:54 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004eff4ea8dd3sm32372lfp.76.2023.05.08.09.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:04:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: qcom: apq8074-dragonboard: enable coincell charger
Date:   Mon,  8 May 2023 19:04:46 +0300
Message-Id: <20230508160446.2374438-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
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

Enable coincell charger for the coin battery which can be installed on
the APQ8074 dragonboard.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 07db6451f273..93a059641957 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -58,6 +58,12 @@ eeprom: eeprom@52 {
 	};
 };
 
+&pm8941_coincell {
+	qcom,rset-ohms = <2100>;
+	qcom,vset-millivolts = <3000>;
+	status = "okay";
+};
+
 &pm8941_gpios {
         msm_keys_default: pm8941-gpio-keys-state {
 		pins = "gpio5", "gpio23";
-- 
2.39.2

