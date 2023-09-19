Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B27A636D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjISMqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjISMqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 08:46:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E5130
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso6973656a12.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695127567; x=1695732367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMuJsymgFdsKAjrQm0VavHQLfVQtcng3/FrcyEkfn3s=;
        b=QthGcJwZLcU4Owdd9tmIeYu+cw4+qDAmK8Dkn+KhTbAeTDfawtgh4Pd6fTFbIAjxMw
         UvzcvQ2+y3vy3JjNcOBKl9q4oIy8wzUCu5E22mtX1XOcEKVC1QYlRScxlYsJdT9aTdeH
         kxvWdKIXcoqI6be1m27GvgUKN4SprlGSAATCfdfDSNmu6IQk2qgpnbPqcTBXa2YK1WCE
         eOfkrVsg/G7X1ZdmsfxyN28/S8q0n6mloPBmp8WuqhsqiwZjlhKYw3LG4/HDkl0BOCkR
         qjrlZs6MvafszOlZ/U0Ntsfi3sFzehz4cpE3kA2Cu1hAcVTx10dZ+YseolZ4hHc6kZvE
         MjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127567; x=1695732367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMuJsymgFdsKAjrQm0VavHQLfVQtcng3/FrcyEkfn3s=;
        b=nS79qlLwLuT3NjzHQeor8wkJyoAFK42pIxObvvbo3pUK3h/apEWE+37iocNiwpv+ew
         xj47cnAA5ZVOSn4QR4lGG8Knew9y3aOoXHI92FaDMQRtPDiwq5hY4So3vNK/0FRvzkL2
         Jelx1A5zgOi1aPE+CMH+eR59rhdbSexfGXb6ua4X2Rw+jHYr1qAqQwtbewCr6TjgkQJj
         LVx6NyPL3EpkdQGYPckhAlavJV5xAQdsncMq8DYoemM35JrzGieB84/lD9+MJu7JVB8y
         0ZvMGRW9ycouVYMOiEyYF3XlcE09lhK/xrESwGKIObGFMcnochcGJqwRu87mHEbsQK7K
         Sc5Q==
X-Gm-Message-State: AOJu0Yyj0cLPVYWZxXUVkfLoCWimgYKMUQ80ClclgpQ6t2uRrc4THlfp
        rV3n8H++BCCDWSdisG8PJpLfaw==
X-Google-Smtp-Source: AGHT+IESN3P4tFPFTmoegpAyu0985VeUnYTtETuttZ8u4RCYd1u27yyNjPxim8n3sd0Ww2U2wL5r/g==
X-Received: by 2002:a05:6402:5165:b0:530:8a59:a01d with SMTP id d5-20020a056402516500b005308a59a01dmr9886341ede.27.1695127567136;
        Tue, 19 Sep 2023 05:46:07 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm635878edb.66.2023.09.19.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:46:06 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 19 Sep 2023 14:45:58 +0200
Subject: [PATCH v2 4/7] arm64: dts: qcom: pm8350c: Add flash led node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fp5-initial-v2-4-14bb7cedadf5@fairphone.com>
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a node for the led controller found on PM8350C, used for flash and
torch purposes.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm8350c.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
index f28e71487d5c..aa74e21fe0dc 100644
--- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
@@ -30,6 +30,12 @@ pm8350c_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
+		pm8350c_flash: led-controller@ee00 {
+			compatible = "qcom,pm8350c-flash-led", "qcom,spmi-flash-led";
+			reg = <0xee00>;
+			status = "disabled";
+		};
+
 		pm8350c_pwm: pwm {
 			compatible = "qcom,pm8350c-pwm";
 			#pwm-cells = <2>;

-- 
2.42.0

