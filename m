Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902C79B143
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 01:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbjIKVGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjIKN2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 09:28:39 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 06:28:34 PDT
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B19CD7;
        Mon, 11 Sep 2023 06:28:34 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 2412F1C3D9C;
        Mon, 11 Sep 2023 15:18:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from fluffy-mammal.fritz.box (dslb-092-072-011-192.092.072.pools.vodafone-ip.de [92.72.11.192])
        by srv01.abscue.de (Postfix) with ESMTPSA id 7F1151C3D99;
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
Subject: [PATCH 2/2] genpd: qcom: rpmpd: Add MSM8917, MSM8937 and QM215
Date:   Mon, 11 Sep 2023 15:16:27 +0200
Message-Id: <20230911131627.13494-3-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230911131627.13494-1-otto.pflueger@abscue.de>
References: <20230911131627.13494-1-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8917 uses the SMPA2 and LDOA3 regulators provided by the PM8937 PMIC
for the VDDCX and VDDMX power domains in voltage level mode,
respectively. MSM8937 also uses this PMIC and the same regulators.

QM215 is typically paired with a PM8916 PMIC and uses its SMPA1 and
LDOA2 regulators in voltage level mode.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/genpd/qcom/rpmpd.c | 92 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/genpd/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
index 3135dd1dafe0..d97f9642fc17 100644
--- a/drivers/genpd/qcom/rpmpd.c
+++ b/drivers/genpd/qcom/rpmpd.c
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
@@ -257,6 +300,24 @@ static struct rpmpd mx_l3a_corner_ao = {
 	.key = KEY_CORNER,
 };
 
+static struct rpmpd mx_l3a_lvl_ao;
+static struct rpmpd mx_l3a_lvl = {
+	.pd = { .name = "mx", },
+	.peer = &mx_l3a_lvl_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mx_l3a_lvl_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &mx_l3a_lvl,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
 static struct rpmpd mx_l12a_lvl_ao;
 static struct rpmpd mx_l12a_lvl = {
 	.pd = { .name = "mx", },
@@ -572,6 +633,20 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
+static struct rpmpd *msm8917_rpmpds[] = {
+	[MSM8917_VDDCX] =	&cx_s2a_lvl,
+	[MSM8917_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8917_VDDCX_VFL] =	&cx_s2a_vfl,
+	[MSM8917_VDDMX] =	&mx_l3a_lvl,
+	[MSM8917_VDDMX_AO] =	&mx_l3a_lvl_ao,
+};
+
+static const struct rpmpd_desc msm8917_desc = {
+	.rpmpds = msm8917_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8917_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&md_s1a_lvl,
 	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
@@ -672,6 +747,20 @@ static const struct rpmpd_desc qcs404_desc = {
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
@@ -764,6 +853,8 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
 	{ .compatible = "qcom,msm8909-rpmpd", .data = &msm8916_desc },
 	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
+	{ .compatible = "qcom,msm8917-rpmpd", .data = &msm8917_desc },
+	{ .compatible = "qcom,msm8937-rpmpd", .data = &msm8917_desc },
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
@@ -772,6 +863,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
 	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
+	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
-- 
2.39.1
