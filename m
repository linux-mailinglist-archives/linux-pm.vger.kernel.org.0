Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86C879AF4C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 01:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjIKVGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbjIKN2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 09:28:39 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 06:28:34 PDT
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D8198;
        Mon, 11 Sep 2023 06:28:34 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id E32F11C3D9B;
        Mon, 11 Sep 2023 15:18:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from fluffy-mammal.fritz.box (dslb-092-072-011-192.092.072.pools.vodafone-ip.de [92.72.11.192])
        by srv01.abscue.de (Postfix) with ESMTPSA id 13A4A1C3D98;
        Mon, 11 Sep 2023 15:18:41 +0200 (CEST)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 1/2] dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
Date:   Mon, 11 Sep 2023 15:16:26 +0200
Message-Id: <20230911131627.13494-2-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230911131627.13494-1-otto.pflueger@abscue.de>
References: <20230911131627.13494-1-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSM8917, MSM8937 and QM215 SoCs have VDDCX and VDDMD power domains
controlled in voltage level mode. Define the MSM8937 and QM215 power
domains as aliases because these SoCs are similar to MSM8917 and may
share some parts of the device tree.

Also add the compatibles for these SoCs to the documentation.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml |  3 +++
 include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 9b03c41d3604..2c58abe958f7 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -20,6 +20,8 @@ properties:
       - qcom,msm8226-rpmpd
       - qcom,msm8909-rpmpd
       - qcom,msm8916-rpmpd
+      - qcom,msm8917-rpmpd
+      - qcom,msm8937-rpmpd
       - qcom,msm8939-rpmpd
       - qcom,msm8953-rpmpd
       - qcom,msm8976-rpmpd
@@ -29,6 +31,7 @@ properties:
       - qcom,qcm2290-rpmpd
       - qcom,qcs404-rpmpd
       - qcom,qdu1000-rpmhpd
+      - qcom,qm215-rpmpd
       - qcom,sa8155p-rpmhpd
       - qcom,sa8540p-rpmhpd
       - qcom,sa8775p-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 83be996cb5eb..7f4e2983a4c5 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -278,6 +278,27 @@
 #define MSM8909_VDDMX		MSM8916_VDDMX
 #define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
 
+/* MSM8917 Power Domain Indexes */
+#define MSM8917_VDDCX		0
+#define MSM8917_VDDCX_AO	1
+#define MSM8917_VDDCX_VFL	2
+#define MSM8917_VDDMX		3
+#define MSM8917_VDDMX_AO	4
+
+/* MSM8937 Power Domain Indexes */
+#define MSM8937_VDDCX		MSM8917_VDDCX
+#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
+#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
+#define MSM8937_VDDMX		MSM8917_VDDMX
+#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
+
+/* QM215 Power Domain Indexes */
+#define QM215_VDDCX		MSM8917_VDDCX
+#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
+#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
+#define QM215_VDDMX		MSM8917_VDDMX
+#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
+
 /* MSM8953 Power Domain Indexes */
 #define MSM8953_VDDMD		0
 #define MSM8953_VDDMD_AO	1
-- 
2.39.1
