Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7752326818
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBZULJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZUKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:10:54 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12FC0617AB;
        Fri, 26 Feb 2021 12:06:35 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 7E70D1F87C;
        Fri, 26 Feb 2021 21:06:32 +0100 (CET)
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
Subject: [PATCH 26/41] arm64: dts: qcom: Add device tree for SDM636
Date:   Fri, 26 Feb 2021 21:03:56 +0100
Message-Id: <20210226200414.167762-27-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This SoC is almost identical to its older brother,
SDM660, with a few minor exceptions like the
different GPU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm636.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm636.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm636.dtsi b/arch/arm64/boot/dts/qcom/sdm636.dtsi
new file mode 100644
index 000000000000..ae15d81fa3f9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm636.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
+ * Copyright (c) 2020, Konrad Dybcio <konradybcio@gmail.com>
+ * Copyright (c) 2020, Martin Botka <martin.botka1@gmail.com>
+ */
+
+#include "sdm660.dtsi"
+
+/*
+ * According to the downstream DTS,
+ * 636 is basically a 660 except for
+ * different CPU frequencies, Adreno
+ * 509 instead of 512 and lack of
+ * turing IP. These differences will
+ * be addressed when the aforementioned
+ * peripherals will be enabled upstream.
+ */
+
+&adreno_gpu {
+	compatible = "qcom,adreno-509.0", "qcom,adreno";
+	/* Adreno 509 shares the frequency table with 512 */
+};
-- 
2.30.1

