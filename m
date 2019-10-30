Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA6E9F3C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfJ3PjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:39:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54764 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfJ3PjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:39:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so2594414wmk.4
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGJ4iUy7kzRHuML9MmU0ln8pdc2taAuOq/9kSKFneEA=;
        b=fCwevB+VkurnCVATJqQYDg571ypYrm5tfC8LTzNVt8K4Rap9YZgMFHMyRcKV4Wvk5B
         sW4i5XwdaCg0JuxCd0wtzVvY/rl0ui7MMWw1p86eopvigSmoiOMZ2v+HRDvZzEo/QnEW
         TI7oLN1ngc81NtWojTxW2pW4wdxySxId+JNilfjeR4oqUCb7Jt41svRT5mOeHkWIWgZE
         nzjGPLfb0gVJReaWN+WknD+KUJ0OetrK/ZqGDwcug/VYhmCYo1lTyM4e6OYlcs1UkNYT
         +Se9MvxzduySUosSf9l/J/25eI3WaOAYIhh5oJ+YT/QKDorwk0TGmq6uFUYIg9tO9oOn
         lVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGJ4iUy7kzRHuML9MmU0ln8pdc2taAuOq/9kSKFneEA=;
        b=geoaQVH4WJjvOlS5GfM0Kr9AOonxYXBLL4F9MBH2aeLMD7XbdQEFqCe90V6X2vWIZc
         JngwTGVwBM84jaPITZhSwaqI9ZqdyyHmKhzm6fXFdR1sPQVPbqWxE+eFopcyn523iskY
         skueTsvfzGRtCIYr7jImqq0LgZUzFKnPIGFVJjNH6fljpL43TAc/k84M+fbxDVAFwvoM
         Tx2GgldTzuElCqdNoHOHOMrhQlvFew1ah3tg+KECz+rOlxw15hchFStxpFy/MQLxtZjD
         mIh2j2gBel4TTjv9+mLQL3LcNwtlzZMFsAKz2v/FBIButZ4+U7tEtCgPl9Br78IkZjiv
         rqtQ==
X-Gm-Message-State: APjAAAXAeRGHh80KUHLFm1ioy2V2YM/Z5SqngUWgAQsQDro7jAiUtb0J
        aVmonwoQTCYtXavqkXQr8MDkrw==
X-Google-Smtp-Source: APXvYqz3Q6drLzEP7gjN8O8ha1iX2qF2icjYdi/IoHDlaqpgwwBgOkavnqDBFUPDp9mrqP9hEeWI+Q==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr93608wmh.102.1572449949424;
        Wed, 30 Oct 2019 08:39:09 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o25sm725524wro.21.2019.10.30.08.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 08:39:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 3/3] arm64: dts: msm8916: Add interconnect provider DT nodes
Date:   Wed, 30 Oct 2019 17:39:04 +0200
Message-Id: <20191030153904.8715-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030153904.8715-1-georgi.djakov@linaro.org>
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add nodes for the network-on-chip interconnect buses present on
MSM8916-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..9c4d89319e7c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,msm8916.h>
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -364,11 +365,38 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		bimc: interconnect@400000 {
+			compatible = "qcom,msm8916-bimc";
+			reg = <0x00400000 0x62000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		restart@4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0x4ab000 0x4>;
 		};
 
+		pcnoc: interconnect@500000 {
+			compatible = "qcom,msm8916-pcnoc";
+			reg = <0x00500000 0x11000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			compatible = "qcom,msm8916-snoc";
+			reg = <0x00580000 0x14000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		msmgpio: pinctrl@1000000 {
 			compatible = "qcom,msm8916-pinctrl";
 			reg = <0x1000000 0x300000>;
