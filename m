Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943779FC60
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 08:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjINGz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjINGz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 02:55:26 -0400
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A535CCE5;
        Wed, 13 Sep 2023 23:55:21 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id C34391C3D98;
        Thu, 14 Sep 2023 08:55:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on abscue.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=4.0.0
Received: from fluffy-mammal.fritz.box (dslb-092-072-000-199.092.072.pools.vodafone-ip.de [92.72.0.199])
        by srv01.abscue.de (Postfix) with ESMTPSA id 614391C3D99;
        Thu, 14 Sep 2023 08:55:19 +0200 (CEST)
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
Subject: [PATCH v3 3/3] pmdomain: qcom: rpmpd: Add QM215 power domains
Date:   Thu, 14 Sep 2023 08:54:23 +0200
Message-Id: <20230914065422.5452-4-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914065422.5452-1-otto.pflueger@abscue.de>
References: <20230914065422.5452-1-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QM215 is typically paired with a PM8916 PMIC and uses its SMPA1 and
LDOA2 regulators in voltage level mode for VDDCX and VDDMX, respectively.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/pmdomain/qcom/rpmpd.c | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 2980ebd6ed8c..d793cf2f3af8 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -105,6 +105,24 @@ static struct rpmpd cx_s1a_corner_ao = {
 	.key = KEY_CORNER,
 };
 
+static struct rpmpd cx_s1a_lvl_ao;
+static struct rpmpd cx_s1a_lvl = {
+	.pd = { .name = "cx", },
+	.peer = &cx_s1a_lvl_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd cx_s1a_lvl_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &cx_s1a_lvl,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_LEVEL,
+};
+
 static struct rpmpd cx_s2a_corner_ao;
 static struct rpmpd cx_s2a_corner = {
 	.pd = { .name = "cx", },
@@ -180,6 +198,13 @@ static struct rpmpd cx_s1a_vfc = {
 	.key = KEY_FLOOR_CORNER,
 };
 
+static struct rpmpd cx_s1a_vfl = {
+	.pd = { .name = "cx_vfl", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 1,
+	.key = KEY_FLOOR_LEVEL,
+};
+
 static struct rpmpd cx_s2a_vfc = {
 	.pd = { .name = "cx_vfc", },
 	.res_type = RPMPD_SMPA,
@@ -239,6 +264,24 @@ static struct rpmpd gx_rwgx0_lvl_ao = {
 };
 
 /* MX */
+static struct rpmpd mx_l2a_lvl_ao;
+static struct rpmpd mx_l2a_lvl = {
+	.pd = { .name = "mx", },
+	.peer = &mx_l2a_lvl_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mx_l2a_lvl_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &mx_l2a_lvl,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 2,
+	.key = KEY_LEVEL,
+};
+
 static struct rpmpd mx_l3a_corner_ao;
 static struct rpmpd mx_l3a_corner = {
 	.pd = { .name = "mx", },
@@ -704,6 +747,20 @@ static const struct rpmpd_desc qcs404_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
+static struct rpmpd *qm215_rpmpds[] = {
+	[QM215_VDDCX] =		&cx_s1a_lvl,
+	[QM215_VDDCX_AO] =	&cx_s1a_lvl_ao,
+	[QM215_VDDCX_VFL] =	&cx_s1a_vfl,
+	[QM215_VDDMX] =		&mx_l2a_lvl,
+	[QM215_VDDMX_AO] =	&mx_l2a_lvl_ao,
+};
+
+static const struct rpmpd_desc qm215_desc = {
+	.rpmpds = qm215_rpmpds,
+	.num_pds = ARRAY_SIZE(qm215_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
 	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -805,6 +862,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
+	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
-- 
2.39.1
