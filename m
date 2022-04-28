Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DD51317F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiD1KqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiD1KqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 06:46:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987EC8594D
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh6so8796013ejb.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVrG7ytRhvfMLwg4sL6jbIdDhYj5gKeUGxhEwn4Bejk=;
        b=BJXlGK81Gi71Z8HxoEnY11K+gDOzQVNHqhtuUdEI8MGf68sHJf+x768slqQyn/S9+k
         iy1lDOkc1p3T4q9qa9V9Q10QQ5LBa9xudCJaVZBztiEy26LfiyjDRCO1rdrQTLzYmm2s
         mk3ffQ8YvBTwSzeP1rSXOljFCx0xNzu0/t1NQcz+Yt5FC4zWLRTgv9fHaOhJZScXwNoQ
         nUkkYbRoAzQbgodD7ONX4+jOvJtB2wQZeapWoFs+AhVRoaVhvpf5GZv/Eg3AebW8z7me
         f/dQHPs+Jx6tMj9vDgFTEhAcscAn2vDRMKSsKKY+kQBsrZjxExyBT8GoMhoEJW9dpjf4
         eovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVrG7ytRhvfMLwg4sL6jbIdDhYj5gKeUGxhEwn4Bejk=;
        b=uZxz+qpdea2DUNAZHd+wt+cinlLqYi8PhTJa/ZTD4xTVd5X7yLfmAu7FG66+bgGbgb
         zvvq6SdVZKW7SSR1ZX3DjShH28+pKGZbnSkM9q5f+cWUz8+4VpjefyPaIzCoQi61RBs9
         RqA8dlga0+TsNQpiP5vT1Sfecid1daDfwN51JI8mit+pzljnf/0uxtEFlKqAo8gmzHfl
         Im25mPLPsImv+mt2SyiMNaZMbiBycirpM0xr+zpE3kY9WEwS+29xlGBSxFmsC4679Z04
         0huAES+gB+4w5WilLuLnXz3V2C7yMChrX48IBb/YeNjei/RhYE0KbiQQsdkLHNpPdwfE
         G5EA==
X-Gm-Message-State: AOAM531xgifFeYdafp0Yqa1S3l9e8+Sd+DvrSnYH2Sur6fDlkriTlQyq
        OwJOCL8eXDFBUAjGun9D1R8SsQ==
X-Google-Smtp-Source: ABdhPJzqQ4xoq3ewwa2SFLN6+Qifk+2YjdCez3ZVLT7Mv4oKmLqYRUYKBKSzP6eNxb+f5xRpRHg7wg==
X-Received: by 2002:a17:906:804b:b0:6f3:8d78:ffa8 with SMTP id x11-20020a170906804b00b006f38d78ffa8mr20612885ejw.588.1651142573217;
        Thu, 28 Apr 2022 03:42:53 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id mf1-20020a1709071a4100b006f39f556011sm4982583ejc.125.2022.04.28.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:42:52 -0700 (PDT)
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
Subject: [PATCH v2 5/6] arm64: dts: qcom: sdm845-xiaomi-beryllium enable pmi8998 charger
Date:   Thu, 28 Apr 2022 11:42:32 +0100
Message-Id: <20220428104233.2980806-6-caleb.connolly@linaro.org>
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

Enable the smb2 charger driver and add a battery node to report the
battery stats correctly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index b3b6aa4e0fa3..1a5e127d7a43 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -109,6 +109,14 @@ rmtfs_mem: memory@f6301000 {
 		};
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <4000000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
 	vreg_s4a_1p8: vreg-s4a-1p8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_s4a_1p8";
@@ -302,6 +310,11 @@ vol_up_pin_a: vol-up-active {
 	};
 };
 
+&pmi8998_charger {
+	status = "okay";
+	monitored-battery = <&battery>;
+};
+
 &pm8998_pon {
 	resin {
 		compatible = "qcom,pm8941-resin";
-- 
2.36.0

