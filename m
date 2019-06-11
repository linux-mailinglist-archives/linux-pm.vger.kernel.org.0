Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084603D2B7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfFKQmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 12:42:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39330 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405698AbfFKQmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 12:42:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so9829081lfo.6
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9ZNAv59f40CG0/uv7rXh/uSMAgb1GDNS6rT6AHe4V0=;
        b=MPBPbkqOsdx6Pgbk2vEFmxS5Pr880M9VCzpqIHdZhtmyBG/0cIrysoqL5qR3okl18m
         Yewt/oQAkaKm9tdPLdgZShNqbf6GQw3NdF8b2KRS6lOnxvlHayU+ipYY+be+4ktyxrK+
         84TKjJfHcoJBUwBhLhAhHVxHiq6UHoAkBJj9MByuCArn0WXBhxbHpBzeRjv9abYHIwIc
         xSjPmIauD3/MkeS9lAcYpeCFVy4J/Z0cVkZqR5X0ZfH77F6PifP648MLw0cKq9vSYHD1
         6FnoNTcmSnRHAkqM/0qe1TujvS5o9o1qs6syuDfI4Q/qQw3Awa9qUwalv2yRA3e0i4Xz
         Sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9ZNAv59f40CG0/uv7rXh/uSMAgb1GDNS6rT6AHe4V0=;
        b=bEadgQY6eio7FBsBTyT83Wl/iyh/8v9IYAeZXq5HEhPwyAHXECYex9gBjINDDNHbA7
         hNk0+QSx2kdfq41lBYhn2Aet8rHqZBtMtMRcQlKJdATtL9jx3nvpFwkb5xXAy2hefd9d
         F+yE0+UShR/oLPo7lmdqAG1ecwzQiJvb2XFdObp/BJHLrBdc5FiAaLUPbVmuwsbb0SdX
         jNeaHWCjXNlf78vuN+k2PheVUtNWDSu8QW0YaaCF4maC1jsfWxi26V/TIrwh84C5vQ0L
         bhjRPBOKNz8J8+TbybFfQtqFMbsjrffpe7pTu0Y8MqZO8VvjLtqFjKejO0yTHA31qsX7
         a1Gg==
X-Gm-Message-State: APjAAAUR9+AbrngSh0txRsMQW715KBW+lzHAQOQmgMSB1R5YlcXauj8q
        4ekJ9gOeEwhG9kIkehCw9iI4Sg==
X-Google-Smtp-Source: APXvYqycwmxnoSVnWNq3Dg51LluxipGxNUXj8qojZFmb2wWWZLGvVF1+NYMNmjxgnVC8lZZnSVvJsQ==
X-Received: by 2002:a19:f20d:: with SMTP id q13mr33978637lfh.65.1560271333633;
        Tue, 11 Jun 2019 09:42:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r14sm2616772lff.44.2019.06.11.09.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 09:42:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Tue, 11 Jun 2019 19:41:57 +0300
Message-Id: <20190611164157.24656-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611164157.24656-1-georgi.djakov@linaro.org>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v3:
- Updated according to the new binding: added reg property and moved under the
  "soc" node.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..07ff592233b6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -411,6 +412,33 @@
 			#interrupt-cells = <4>;
 		};
 
+		bimc: interconnect@400000 {
+			reg = <0x00400000 0x80000>;
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		pcnoc: interconnect@500000 {
+			reg = <0x00500000 0x15080>;
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			reg = <0x00580000 0x23080>;
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
