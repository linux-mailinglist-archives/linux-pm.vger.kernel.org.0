Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119F4EFB8C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbiDAU3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352929AbiDAU3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 16:29:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2791AC2
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 13:27:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c62so4281279edf.5
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EcbH8C06sbTvlj74VImlROx9fT7kiTAHj1cznf1og8=;
        b=HVostgqO9ijPRrzVm+/N5vnVlDc2a2ADFntKm8u891rPiZ8JwpXJXqj1vML4NLcsWN
         leXSL75FtMkwb3dDyr6CwwYW+y8BO+aeRhGie9oWTpB160LiIgjSMTBA77YuyyPG/+Kh
         lIZYXCg9twtkNLgx67c6S4PmAEk5g/LaSzAS/MeMwz33o/jPtQDGspqjMG+94jIknCvb
         LjnIJB8CK7Jc5Nz0NZ+S21Tpc3gjQjzQecuSHPeIJDPykGYe6iD0M9derVY06C0l2Fqy
         go8wIi9p2IIs+EYLihONFAKgMGaUO3i3BkB8R8+HNAKVPNmBVXFKBsO6Fq9bH1BFVxRp
         FTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EcbH8C06sbTvlj74VImlROx9fT7kiTAHj1cznf1og8=;
        b=TAcbX9c7j7TaDbQwRU+LfYhLBp4gl1xnCnRMTTXnql8zcPDUHv0ybG1bp+RpWj6KOM
         r16HtjeLL5Fa7IwMrG4P0Xc39liGeYPqyTQU/n85Kj7qbBA3uxRJChs7S/B7FO62eAbh
         l2FlDOc3ZvtALRA8BENQ+xm2hws97BZ/vGzCW/cn7o1NdgwzW4O3TF/0+21WZUj65QMd
         r6CIC+8qu+hE36oJVKtktqgudzi7yGAmuW5yawnDuBVxSaejRJO/j5OZrKMWDLKotsDl
         Wo+h0GbudkwRvItmzXaAgVMoYrYmTt78n6m4Sgjqy/K3SvmZj35EKYzuYUuCx4/bUwOY
         onjg==
X-Gm-Message-State: AOAM530+Utky/O6JPEI/UDjjoNANFVeisbFEqdkqULjxQT+Dvtp3s6t8
        8boZVHqGBGFMk8a4u5i2pPdvVQ==
X-Google-Smtp-Source: ABdhPJwRSLi250Su9ajmam0SO1iSbT66aIOeUt1cJ8/y6EbBmdH8LL85Ta4dfMZvVTIM+pxHahEIYw==
X-Received: by 2002:a05:6402:4247:b0:419:3990:3db6 with SMTP id g7-20020a056402424700b0041939903db6mr22428286edb.193.1648844827858;
        Fri, 01 Apr 2022 13:27:07 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1619346edl.22.2022.04.01.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:27:07 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 3/6] arm64: dts: sdm845-oneplus: enable smb2
Date:   Fri,  1 Apr 2022 21:26:40 +0100
Message-Id: <20220401202643.877609-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401202643.877609-1-caleb.connolly@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
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

Enable the smb2 charger to expose usb attach/detach events, charging
stats etc.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 3f1b05603701..afc8b0c3aed7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -461,6 +461,10 @@ pinconf {
 	};
 };
 
+&pmi8998_smb2 {
+	status = "okay";
+};
+
 &pmi8998_rradc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index bf2cf92e8976..b0fb2f8ca6d8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -32,3 +32,7 @@ &display_panel {
 &bq27441_fg {
 	monitored-battery = <&battery>;
 };
+
+&pmi8998_smb2 {
+	monitored-battery = <&battery>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 1b6b5bf368df..3e3c757fe6f2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -33,6 +33,10 @@ &bq27441_fg {
 	monitored-battery = <&battery>;
 };
 
+&pmi8998_smb2 {
+	monitored-battery = <&battery>;
+};
+
 &rmi4_f12 {
 	touchscreen-y-mm = <148>;
 };
-- 
2.35.1

