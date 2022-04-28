Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F5513187
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbiD1KqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244629AbiD1KqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 06:46:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32385956
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p18so5015736edr.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PDc4kwfq5Abwa8nZKwgraCJqPwJeISvtFvxURCWRYI=;
        b=Ew5KCg2phGMV+OlxGFxDY0ICfO7GTUKjam96t6qlNWEPwnXxSVtiVZ7gex/Rucl3Cl
         ToXn4Md9FB1/iF/Xp7Li/DTXFuOh4p3UP1VA20OaZEuBL4tceMnqjlzaziITbJEWE2sp
         8nGfWopm/bIIvlBozwjemM/p718KG1l1Kj6TU0LpqWcoY+3WOi8SgN9zOZe33rOqEzvb
         NtTkre3sDE0CoW3ek7xpQVcPxoWHqPuOmoe0c8MQcbpZ+Ivv4ZUSaE/DlckMYEPIhLn2
         e0Pw1ZmW79aNMLT6MMTiCPxbDeMJ0hcpBRARjyLQVyZhDwhBsvVGkSsl29ydfh2zLKC2
         DBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PDc4kwfq5Abwa8nZKwgraCJqPwJeISvtFvxURCWRYI=;
        b=G5n3gEJ8lu+EYc1SUCwcJfht85Ot2xEx2xUeMwO0Y219oqpwKCYAZJ9bKhO2aZ8OCl
         OjqrMWAEyqkL4ziColnUH9AXegrFpjLgFf9bOim7WLf1wY5+hmXv3dq0SuOvM/rBzEIZ
         MPMcJKJ0YH/UCN+m7Di1KqNcR7Q1hCU9nE/mLvkCdrMbrJnifxkDbB8jpWrzwL9m7cMY
         SMEQER6O4vw5MX4fu++5nMuKjOk3EuKPvqcoBO1hku0tHlLjYug0iMzj5O+AP/tjWN09
         NyxOdaGyG53C56XTjVpdGe5GCmcNvnvu7Hr2TZeYxpJnMzqqDT5mYxylSN8JxVRR88eH
         abSA==
X-Gm-Message-State: AOAM533aypub47EGMVqD9PWfu4OQYuYwHNPXG4C6t5YgKGZE05i2V2Un
        WIi/1CNrYsm0x36/do76VyQG9g==
X-Google-Smtp-Source: ABdhPJy+Z7OawzbDT2c6fhA1n0JDALjZMKnTFACGqeHKsRKc9FV+bC5HddeI8Rw53Qh9jaOOXd8nkA==
X-Received: by 2002:a05:6402:270b:b0:424:7dd:9d7b with SMTP id y11-20020a056402270b00b0042407dd9d7bmr35038575edd.92.1651142568227;
        Thu, 28 Apr 2022 03:42:48 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id mf1-20020a1709071a4100b006f39f556011sm4982583ejc.125.2022.04.28.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:42:47 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 2/6] arm64: dts: qcom: pmi8998: add charger node
Date:   Thu, 28 Apr 2022 11:42:29 +0100
Message-Id: <20220428104233.2980806-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220428104233.2980806-1-caleb.connolly@linaro.org>
References: <20220428104233.2980806-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a node for the smb2 charger hardware found on the pmi8998.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index da10668c361d..962a8719b07a 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -9,6 +9,23 @@ pmi8998_lsid0: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8998_charger: charger@1000 {
+			compatible = "qcom,pmi8998-charger";
+			reg = <0x1000>;
+
+			interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+			io-channels = <&pmi8998_rradc 3>,
+				      <&pmi8998_rradc 4>;
+			io-channel-names = "usbin_i", "usbin_v";
+
+			status = "disabled";
+		};
+
 		pmi8998_gpio: gpios@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.36.0

