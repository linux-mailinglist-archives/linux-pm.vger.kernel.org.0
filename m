Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DB24EFB8F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 22:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352925AbiDAU3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352949AbiDAU3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 16:29:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7098490246
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 13:27:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so4273825edw.6
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGcM92/B69Odt+j3zm10CKYpIumT4VtZnYITOCq71P4=;
        b=nvEavRkXTEkPbNbO7kCnELyc/uSL6cKHn9MRaBtamo8osK9BUSk+Pkaq5ko3NWhUCc
         9BBpvx8Is2+pYULF2vkLVwF9EKEuw7HPGXkrk9treouKnIegPIdEGKIj6TUwyARGQid0
         3lPB6J41UTz0rcmzEnJT03PJ3O5EPo99IqmezhdYeBDZgIpsA5Q1BjtQTtS0zoma9B6b
         D28bYhUyxlfJABM032IVEIR3ejJQ60Vz+gdcgEpsWVgYMD6ElVWJOYfMJOSITuBUJUkx
         yrdJhIP/IjFVW9Dvoqr+us8/f3XyUSLp6+Bl2AM+3q14P8JwPfMVis1bW10tw0Zqs48P
         TWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGcM92/B69Odt+j3zm10CKYpIumT4VtZnYITOCq71P4=;
        b=aIDuN9lTrTvEFX6w0EvLfGp70mO/u1xhHNuqQmzincnrhZYCzqh9Qhs2KH1o5z+hPq
         Q43IUrT9JvGW3+O7gExclyGigt6ldccqo/PNTyCuWyehj+CoTSYjeVwvOxXeGYK9XEQ7
         PfcL1BuC8HrV9xfS0xHA6tgFLtYockhhRX5axl1IeYcbMhXVU+/7fP5o5DP2FMSNgYAE
         /m2zB2k1W0EtwL7k9pr2R3AVXNCE4qfuxnE9wf4y8w/PQ75X9AzHTgBqy7jgLeY9wCsN
         CujIx+NFYvce44AvTYJjj5SmuhoImFul8DpudsD7gMKxixlo0BocEsC5KDrBxkP2qjdx
         KccA==
X-Gm-Message-State: AOAM531njn45UvKdSjTETy+NPiVeV+/ccCyi3zD51b6Dbu9rzNfvs+lY
        XfgE/CDhx1DGViJ+A0G5hSfYwA==
X-Google-Smtp-Source: ABdhPJz1q+YQNpJlX9wVP1C2fs7Fih10c3/lnA+irKEH4cMDMwywftPpDhPnRJHumBbJfHjBylOtdA==
X-Received: by 2002:aa7:d445:0:b0:41b:5835:c6da with SMTP id q5-20020aa7d445000000b0041b5835c6damr19630730edr.309.1648844829024;
        Fri, 01 Apr 2022 13:27:09 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1619346edl.22.2022.04.01.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:27:08 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: qcom: sdm845-db845c: enable smb2
Date:   Fri,  1 Apr 2022 21:26:41 +0100
Message-Id: <20220401202643.877609-5-caleb.connolly@linaro.org>
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

Enable the smb2 charger driver on the db845c and add a simple-battery
node to report the correct VBAT voltage.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 40a290b6d4f3..812bd7fd7941 100644
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
 
+&pmi8998_smb2 {
+	status = "okay";
+
+	monitored-battery = <&battery>;
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.35.1

