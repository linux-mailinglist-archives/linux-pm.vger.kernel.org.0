Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8060C2FBF77
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403867AbhASSvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 13:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404159AbhASSAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 13:00:47 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B37C061386
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 09:45:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3A9D93F1DA;
        Tue, 19 Jan 2021 18:45:31 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     nks@flawful.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v4 3/3] arm64: qcom: qcs404: Change CPR nvmem-names
Date:   Tue, 19 Jan 2021 18:45:29 +0100
Message-Id: <20210119174529.227074-4-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119174529.227074-1-angelogioacchino.delregno@somainline.org>
References: <20210119174529.227074-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPR driver's common functions were split and put in another
file in order to support newer CPR revisions: to simplify the
commonization, the expected names of the fuses had to be changed
in order for both new and old support to use the same fuse name
retrieval function and keeping the naming consistent.

The thread id was added to the fuse name and, since CPRv1 does
not support threads, it is expected to always read ID 0, which
means that the expected name here is now "cpr0_(fuse_name)"
instead of "cpr_(fuse_name)": luckily, QCS404 is the only user
so change it accordingly.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 339790ba585d..f9350b028435 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1168,19 +1168,19 @@ cpr: power-controller@b018000 {
 				<&cpr_efuse_ring2>,
 				<&cpr_efuse_ring3>,
 				<&cpr_efuse_revision>;
-			nvmem-cell-names = "cpr_quotient_offset1",
-				"cpr_quotient_offset2",
-				"cpr_quotient_offset3",
-				"cpr_init_voltage1",
-				"cpr_init_voltage2",
-				"cpr_init_voltage3",
-				"cpr_quotient1",
-				"cpr_quotient2",
-				"cpr_quotient3",
-				"cpr_ring_osc1",
-				"cpr_ring_osc2",
-				"cpr_ring_osc3",
-				"cpr_fuse_revision";
+			nvmem-cell-names = "cpr0_quotient_offset1",
+				"cpr0_quotient_offset2",
+				"cpr0_quotient_offset3",
+				"cpr0_init_voltage1",
+				"cpr0_init_voltage2",
+				"cpr0_init_voltage3",
+				"cpr0_quotient1",
+				"cpr0_quotient2",
+				"cpr0_quotient3",
+				"cpr0_ring_osc1",
+				"cpr0_ring_osc2",
+				"cpr0_ring_osc3",
+				"cpr0_fuse_revision";
 		};
 
 		timer@b120000 {
-- 
2.30.0

