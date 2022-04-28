Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B387513170
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiD1KqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbiD1KqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 06:46:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22886AD7
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dk23so8702694ejb.8
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6G/xcwWCTxvb9G73B2XRdjPPr2MF5UR6WrCerpPvtI=;
        b=afWohOX5/h2MitoomFn4Jj8HmGwDFi7+I/qKFfXl0zbDW9GdlQkwYMey7qtsBr3Ut1
         TR7fex2X69k0Cp2nVHj872HxReTMTtAvQTwWSkAvLf4qQ/bf61S0bLDLBz8wd3wFuzXH
         yKD2w9FSumkw5kppYJYUWZrv/uZr5XQkDtCKvafl0Xjj5tCqSLL3DOgrLjupTq/ntaa7
         pLyW0LqZwJcnvnHdImBM+yizghmC92CE+HINrK3gdkGgy2Rbq4iGIn83WPG7S+NBcARV
         JDdZoTxujQyzHMp5QHHx31Q6p6gZeIMd6e4KLwJB05j6dEopWTxcYv3FQugld09DK9jS
         /m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6G/xcwWCTxvb9G73B2XRdjPPr2MF5UR6WrCerpPvtI=;
        b=3YARrCpgh3ADIUAxyRY/Ngd4KvHJ5Y/OE+ER/UVWNQV1MG9V+cWTx7yUqE1VggaaQq
         DkMamFfvWZusQt8LBTjT4/9cj6JWhS6gIVswA+JjVxBcvbeIS+RwwCnPuNfbtuEScAv7
         d0RyAxV/wjnc7sdrhW8b4X4OiFeLFhBQUtn720QdA99iF5pxRvd2Rled/uJiaWaHfU4w
         f68kAoqaj3XCya5PDRlCzHFYnN8c200T/uP1QYGgez2wD2/X4n5TJvAl093XnLLnXa5I
         fPRY4Op8nUgYkq2XKHtDrfSwCye3pvf4HO+Nis03a4NbgoKjdb13tfBIaHJSZovTw1yt
         1MgA==
X-Gm-Message-State: AOAM531neBTubz60wCTKO5kSllPQHgUTSm5Rrh7A4vn0IXfGgnloiIBR
        IsYpKFRRrVDjeZApMmVhQ/MIjg==
X-Google-Smtp-Source: ABdhPJzY6ALvKxPFzbFvnzPx2ZcFkFDikyd243cj8RSnwSMgEbc4UqYIIjNQwxII4daU9PNt4+euHQ==
X-Received: by 2002:a17:907:3e1e:b0:6ef:ebf8:4059 with SMTP id hp30-20020a1709073e1e00b006efebf84059mr31076153ejc.657.1651142571177;
        Thu, 28 Apr 2022 03:42:51 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id mf1-20020a1709071a4100b006f39f556011sm4982583ejc.125.2022.04.28.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:42:50 -0700 (PDT)
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
Subject: [PATCH v2 4/6] arm64: dts: qcom: sdm845-db845c: enable pmi8998 charger
Date:   Thu, 28 Apr 2022 11:42:31 +0100
Message-Id: <20220428104233.2980806-5-caleb.connolly@linaro.org>
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

Enable the smb2 charger driver on the db845c and add a simple-battery
node to report the correct VBAT voltage.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 40a290b6d4f3..3b73b5305c51 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -240,6 +240,18 @@ vph_pwr: vph-pwr-regulator {
 
 		vin-supply = <&vbat_som>;
 	};
+
+	/*
+	 * The db845c doesn't actually have a battery, but the charger circuitry
+	 * is still wired up to support one, it needs to be programmed for nominal
+	 * vbat voltage. See the vbat-regulator above.
+	 */
+	battery: battery {
+		compatible = "simple-battery";
+
+		voltage-min-design-microvolt = <4200000>;
+		voltage-max-design-microvolt = <4200000>;
+	};
 };
 
 &adsp_pas {
@@ -603,6 +615,12 @@ &pmi8998_rradc {
 	status = "okay";
 };
 
+&pmi8998_charger {
+	status = "okay";
+
+	monitored-battery = <&battery>;
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.36.0

