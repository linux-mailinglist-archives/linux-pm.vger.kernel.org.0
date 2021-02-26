Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E043267C9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBZUGo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:06:44 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:51519 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhBZUGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:06:12 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 1ECFA1FACC;
        Fri, 26 Feb 2021 21:04:59 +0100 (CET)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH 06/41] arm64: dts: qcom: sdm630: Fix intc reg indentation
Date:   Fri, 26 Feb 2021 21:03:36 +0100
Message-Id: <20210226200414.167762-7-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Konrad Dybcio <konradybcio@gmail.com>

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index e0c6099d0810..274d39d4ab35 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1477,8 +1477,8 @@ frame@17928000 {
 
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
-			reg = <0x17a00000 0x10000>,	   /* GICD */
-				  <0x17b00000 0x100000>;	  /* GICR * 8 */
+			reg = <0x17a00000 0x10000>,	/* GICD */
+			      <0x17b00000 0x100000>;	/* GICR * 8 */
 			#interrupt-cells = <3>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.30.1

