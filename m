Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D425400D0D
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhIDVZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 17:25:02 -0400
Received: from m-r1.th.seeweb.it ([5.144.164.170]:46095 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhIDVZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 17:25:02 -0400
Received: from localhost.localdomain (83.6.166.194.neoplus.adsl.tpnet.pl [83.6.166.194])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 50B981F614;
        Sat,  4 Sep 2021 23:15:16 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: thermal: tsens: Add msm8992/4 compatibles
Date:   Sat,  4 Sep 2021 23:15:07 +0200
Message-Id: <20210904211508.317560-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatibles for msm8992/4 TSENS hardware.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:
- Separate this into a standalone patch

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 4a2eaf28e3fd..8a8e4d27aed4 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -37,6 +37,8 @@ properties:
         items:
           - enum:
               - qcom,msm8976-tsens
+              - qcom,msm8992-tsens
+              - qcom,msm8994-tsens
               - qcom,qcs404-tsens
           - const: qcom,tsens-v1
 
-- 
2.33.0

