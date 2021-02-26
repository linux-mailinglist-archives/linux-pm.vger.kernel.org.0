Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710532689D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhBZUXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhBZUVe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:21:34 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E28C0611BE;
        Fri, 26 Feb 2021 12:06:11 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 3EFD61FAD3;
        Fri, 26 Feb 2021 21:06:08 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/41] arm64: dts: qcom: pm660: Support SPMI regulators on PMIC sid 1
Date:   Fri, 26 Feb 2021 21:03:51 +0100
Message-Id: <20210226200414.167762-22-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The PM660 PMIC has SPMI regulators on the PMIC SID 1: let's
declare the second pmic subtree and add the spmi vregs compatible
to probe them there.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 2e6a6f6c3b66..c6c57fe626e3 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -47,4 +47,15 @@ pm660_gpios: gpios@c000 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	pmic@1 {
+		compatible = "qcom,pm660", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm660_spmi_regulators: pm660-regulators {
+			compatible = "qcom,pm660-regulators";
+		};
+	};
 };
-- 
2.30.1

