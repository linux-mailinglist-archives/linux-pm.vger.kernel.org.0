Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCE526AE0
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383999AbiEMUFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384000AbiEMUFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 16:05:52 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D82E0B3
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 13:05:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id a23-20020a4ad5d7000000b0035ee70da7a9so2957258oot.1
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2022 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FNc4+E7R9DWe4jsWEchkQcKgvIwL99iFpvVJNfnsaG0=;
        b=MARQN5F1mEDGoD2kB5aanu/uC+SB+s3j2AOqS7UovJUQnPYsEcz4rJPSZvlN7m5scD
         DGxiq02tBHDnc8zyZVVIH3jpDaXCsUZIsSQj9F84c+Utsj0PuXh8+avR1+jKoXBs/awV
         qRtVM123NYF4Ju5WCbaV80MmB0xuF2tpTf1zaIefPYcmzxi/xRlGNMYtZF5Sbr2f4Z8k
         a9ZqE7Lm5nP1mbVHZudX8dnDpYuEIS1O7sM0rgg7s41jDshb45uxuHmNzRJ7bhj4A5FK
         jaheYH+6nVUqakkijPbsPJp4cXHTuDU41tMdJuPpgiWtCKNXxYNL1Et95ACefwtIgoTw
         noRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNc4+E7R9DWe4jsWEchkQcKgvIwL99iFpvVJNfnsaG0=;
        b=5rmlMfTKH/CFijZH0zrH87O2ut/+qPNGs4WTJUaalG/vSJLli5HMAkFq+cir0WHbB8
         4zrCFU0RMblVrc2iEhe4YfhXxQhqxpLKpZpAoJrz4ofOhksLk8LdSgbI0uhqWu0LtWA9
         VYHfrOUDQ7SU/RFV6aT1l8KiOSteCLgjWxGAfqMrxcLJ5aCn+iaVIGg6cxQkiUR9E7cy
         BMPc/jbdOpJlhQjU42XAjbdiTcifkL6XktibOQ09JaOtf1RyeOqRl0NZ+GLxzux9TPsv
         OWUpv0GUjTodQMg4WlAHsbVKc1eZ05Ig06wZy30ck+FFdXzYnqd7tYfymRfubtiI/7Eh
         OjLQ==
X-Gm-Message-State: AOAM530icpbe19iAmn9LZQU2tvhF/8yGL1ihY+hOHpKz7GNNUx9iJzfS
        UacbC8nps6Mrf42vMBIa6gTu3Q==
X-Google-Smtp-Source: ABdhPJzybVpEt1LjJVfc9U/3VtYItBFuGfcwYM/1XQsuFZifxLE2uypJHF0OzI4ldp/Bimw5i2XBWA==
X-Received: by 2002:a4a:ea16:0:b0:35e:9a71:4826 with SMTP id x22-20020a4aea16000000b0035e9a714826mr2530720ood.76.1652472349551;
        Fri, 13 May 2022 13:05:49 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm1456962oti.16.2022.05.13.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:05:49 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 3/6] arm64: dts: sdm845-oneplus: enable pmi8998 charger
Date:   Fri, 13 May 2022 21:05:09 +0100
Message-Id: <20220513200512.501156-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513200512.501156-1-caleb.connolly@linaro.org>
References: <20220513200512.501156-1-caleb.connolly@linaro.org>
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
index 9c91ddc766af..b1fa00a8047b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -461,6 +461,10 @@ pinconf {
 	};
 };
 
+&pmi8998_charger {
+	status = "okay";
+};
+
 &pmi8998_rradc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index bf2cf92e8976..4e119a78c568 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -32,3 +32,7 @@ &display_panel {
 &bq27441_fg {
 	monitored-battery = <&battery>;
 };
+
+&pmi8998_charger {
+	monitored-battery = <&battery>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 1b6b5bf368df..0b610e3a8d9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -33,6 +33,10 @@ &bq27441_fg {
 	monitored-battery = <&battery>;
 };
 
+&pmi8998_charger {
+	monitored-battery = <&battery>;
+};
+
 &rmi4_f12 {
 	touchscreen-y-mm = <148>;
 };
-- 
2.36.1

