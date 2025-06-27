Return-Path: <linux-pm+bounces-29701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69AAEC027
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F047A189CFF2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C692D97BF;
	Fri, 27 Jun 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROk4uKlO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E9CA6F;
	Fri, 27 Jun 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053123; cv=none; b=GYGJNXfB00aJp2XfBxtUZWHGe03/b58zTW5+mdm2xF0YA3+26dEDQSaVJYTHBbkXb7dvemuWb/V8pOHLR/dAeOj5jmKNjlLSs556DPtllOHh/kmRe9CPld/oCRIbYYSiyuL/XeFHYvpa1S7c56j5X+2Bgv8WGv6r7D1G7/GCUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053123; c=relaxed/simple;
	bh=x1DtyRDo07iKA9PNt0SsmbIIR40pE0+r5kNrF7Wj93o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RakwI3sntnaPpaPw5bp+LOY5J6Lq0IHhyLA+cRhV5mmFUvjnjwPlGJsjsHW6tRL16KYrM2QsVoJNmZ9U8gK9bAOICuMBB/yDPd/Ij6ULrkxO9yYGTxGOw5F3ThsxNkaaheo02KlmKaKZ6Y5bP18HCdGEeWTdKCYM9po/Jxe36UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROk4uKlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685F8C4CEE3;
	Fri, 27 Jun 2025 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053123;
	bh=x1DtyRDo07iKA9PNt0SsmbIIR40pE0+r5kNrF7Wj93o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ROk4uKlO+BdSv+kyv2sCD2nxLPz9LWMlkf/NVauATVtO9RoADPge0RITL3/Eob1lw
	 ekXIe7xpdD8ldpVsCRDRcu1KjEaKUgrJji6gOeKx5kI+KtO4KDuw8Fi8WAgeasESIa
	 Rm+Zp36sdXO5C8tjDHXVrT2WHYWtOf/KCW9RqS39bHznhOcxmFOCnci+wjyF6cUeNz
	 1MYlwrv+dhdEGqZUEf+CE+wzcwnCbHWvqMfdevhz2HYlmTl+GqDVJx7NMs1cMG5vtf
	 anTJYtv3ZNUj0+XoyCe2OfiDcXq162y2eKg/aXV1uc42/3R3FBneahKk9rsRJRf05y
	 VhLLw6sTlW3Mg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 27 Jun 2025 21:37:56 +0200
Subject: [PATCH 2/4] interconnect: qcom: qcs615: Drop IP0 interconnects
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topic-qcs615_icc_ipa-v1-2-dc47596cde69@oss.qualcomm.com>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751053092; l=3018;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=oaRW++GhRvdhfgpw4nLgwJtefNfOYZc/9wEF6st5FnU=;
 b=KdHInwwhbqRUveqZNGE36gfR33bpmQ1KVDksn2jPSjA1nfxBQEsyWKoURgj9gRXTS2n36nILC
 koMyUmuKgvACDSbw1iHFVOLSPHMgywCTFAkZPQOZNn3H/ywEbIHGtkL
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

In the same spirit as e.g. Commit b136d257ee0b ("interconnect: qcom:
sc8280xp: Drop IP0 interconnects"), drop the resources that should be
taken care of through the clk-rpmh driver.

Fixes: 77d79677b04b ("interconnect: qcom: add QCS615 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs615.c | 42 --------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 7e59e91ce886d641599a780b0f0d56a9e64b7de4..0549cfcbac64e4284ae5df1de3683985fffdcac8 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -342,15 +342,6 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.links = { QCS615_SLAVE_LLCC },
 };
 
-static struct qcom_icc_node ipa_core_master = {
-	.name = "ipa_core_master",
-	.id = QCS615_MASTER_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_IPA_CORE },
-};
-
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
 	.id = QCS615_MASTER_LLCC,
@@ -942,14 +933,6 @@ static struct qcom_icc_node srvc_gemnoc = {
 	.num_links = 0,
 };
 
-static struct qcom_icc_node ipa_core_slave = {
-	.name = "ipa_core_slave",
-	.id = QCS615_SLAVE_IPA_CORE,
-	.channels = 1,
-	.buswidth = 8,
-	.num_links = 0,
-};
-
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
 	.id = QCS615_SLAVE_EBI1,
@@ -1113,12 +1096,6 @@ static struct qcom_icc_bcm bcm_cn1 = {
 		   &qhs_sdc1, &qhs_sdc2 },
 };
 
-static struct qcom_icc_bcm bcm_ip0 = {
-	.name = "IP0",
-	.num_nodes = 1,
-	.nodes = { &ipa_core_slave },
-};
-
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
@@ -1260,7 +1237,6 @@ static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,
 	&bcm_sn3,
 	&bcm_sn14,
-	&bcm_ip0,
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
@@ -1411,22 +1387,6 @@ static const struct qcom_icc_desc qcs615_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
-	&bcm_ip0,
-};
-
-static struct qcom_icc_node * const ipa_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &ipa_core_master,
-	[SLAVE_IPA_CORE] = &ipa_core_slave,
-};
-
-static const struct qcom_icc_desc qcs615_ipa_virt = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
@@ -1525,8 +1485,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	  .data = &qcs615_dc_noc},
 	{ .compatible = "qcom,qcs615-gem-noc",
 	  .data = &qcs615_gem_noc},
-	{ .compatible = "qcom,qcs615-ipa-virt",
-	  .data = &qcs615_ipa_virt},
 	{ .compatible = "qcom,qcs615-mc-virt",
 	  .data = &qcs615_mc_virt},
 	{ .compatible = "qcom,qcs615-mmss-noc",

-- 
2.50.0


