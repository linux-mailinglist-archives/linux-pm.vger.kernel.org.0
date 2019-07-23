Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A955171A3D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfGWOXy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:23:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35075 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfGWOXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 10:23:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so41293042ljh.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDpgs4kc8gBaUxp23KFk53vgDP4GMAmynScdrpg6lYE=;
        b=CoY3Oay8ZaCT128Y2bWNSSbFb3uMpDJ2Bp+xjt/YohQLcrV1u1a9uTiTS8KLFEj/af
         VmUOL2DVKqYo7RNf+Tj8dczI6Cc4YE/QvJ/SSsHETvkytka/uzESl88ZPHDTVrxoTNkP
         sypRf5NseH5LR/CBenpH1ZFUI6f4zhX360l/ALdYVBsYRWm5EoXxYarbvdWJdbwKtuEU
         g3UME1eyhgfz+3zpk3jAiTUxYWAvZ/eIcNACpR5LzZgHeePtDm6wu9UAGs9KPbF60yrN
         HaAHXG49MBpfq8ewv/Gc0Hj32JQgNmbRyfHUUt7v1okUiHRxkRgpUsZ/OiV/XYIl0de8
         7c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDpgs4kc8gBaUxp23KFk53vgDP4GMAmynScdrpg6lYE=;
        b=Vy0qQfGw9TIxI/wrzmWfecGr4zBrRzLdvgyNUQFtwtu5lDcVERA4LiJSVk6TNl4Elc
         JzUQRAwb8w9v4vNhMZ8IJn8RLLwjf/yQjVDV9rOeCDE/Ivtk1irzZHR0kKpoH7TqseaL
         LBPauBJIYQFYfo8gSWUYCEoQj+WnXPquPzxbFkZePYRuAuBo3nsHHwuF14BkoO+jZj89
         pH2ZcafL01O+dpNX3zSfgVPHwkRlXsOXwioRE2+0apQKmqfHr2OkcoKeUsI/SJ2bapNG
         9kHgGIRh1Ak5bfSWnb8qS2PvqW5VZVZpc51m4V+IYEdpN9I9+jLMFF9ABArnn62Ppbzj
         0s3w==
X-Gm-Message-State: APjAAAXkTGrVS442RgpAp7jdNM50qOCvFv0BAJDfiSecFov/Z9iHFSnH
        ebVL+WnC1JLB7x857u60ThExxw==
X-Google-Smtp-Source: APXvYqyrbG0lK7NZ3pbUKygUSGqDL/p43+50/wl/9Gh/mhpvEQsXgY3NW7YETGp4lGQ5U2uMOtrWrw==
X-Received: by 2002:a2e:9b81:: with SMTP id z1mr40094137lji.101.1563891832070;
        Tue, 23 Jul 2019 07:23:52 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z17sm8048519ljc.37.2019.07.23.07.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jul 2019 07:23:51 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 5/5] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Tue, 23 Jul 2019 17:23:39 +0300
Message-Id: <20190723142339.27772-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723142339.27772-1-georgi.djakov@linaro.org>
References: <20190723142339.27772-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v5:
- Rebased to v5.3-rc1

v4:
- Insert the NoC DT nodes after rng@ to keep the nodes sorted by address.
- Pick Bjorn's r-b.

v3:
- Update according to the new binding: add reg property and moved under the
  "soc" node.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3d0789775009..8b9352347622 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,turingcc-qcs404.h>
@@ -273,6 +274,15 @@
 			clock-names = "core";
 		};
 
+		bimc: interconnect@400000 {
+			reg = <0x00400000 0x80000>;
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
 			reg = <0x004a9000 0x1000>, /* TM */
@@ -283,6 +293,24 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		pcnoc: interconnect@500000 {
+			reg = <0x00500000 0x15080>;
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			reg = <0x00580000 0x23080>;
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		remoteproc_cdsp: remoteproc@b00000 {
 			compatible = "qcom,qcs404-cdsp-pas";
 			reg = <0x00b00000 0x4040>;
