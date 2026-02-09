Return-Path: <linux-pm+bounces-42333-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOthJDytiWndAgUAu9opvQ
	(envelope-from <linux-pm+bounces-42333-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:47:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E068210DBD4
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44FA303A84F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CD3659F1;
	Mon,  9 Feb 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGWDRPis";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNOruTbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB23659E1
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630343; cv=none; b=k5kQevjgGJFIUFLPRVykiCoSDidZtr3CriD/KgyqHvMNdhMSLdxOF5a8xMk9ESq2GB3rTxhguCoeV5Xul7EhV2DLzDsCSszeLgN0pjThN/U6/Jl6TDoFtaq25F5q3UKCEL8gajm+QDXOLsf2fACQw4WC0hFy692n6hYFkSxRjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630343; c=relaxed/simple;
	bh=oKNF0N7cqyEnboK27aDoi+F+5Ov9TOA8icBvW8Cx2J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVEL9grSTRuPJweNUCuy/3Bz9uwhgf48FiqNDyGpofCQX5xGtUMsxI5FWmpuzrGYO9YDOFKc3HduGEuwU5ryjtV2paNnWEeg6zuEvFo3/M8cqoVeYlyHGO6o/DidPFUbzJk7PGAipOzotUdFkPillHbiBoAq5DQhG824NnwpfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGWDRPis; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNOruTbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6197PP4Z1222214
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 09:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p3sweEmsyWgmrL7m/ay0mlvztGrs55ayCJvJ8XDgymc=; b=WGWDRPiszHL0D22d
	BDFl28XXYqsuf4CoR8A2mIXRZCNgAlS5PfbGHKlWTavjWuJuHQFJF0mf9/BjegO1
	z6IO6D37HqxvIfzlmbgm2XyXmfQUcvoOyA1px0DJe+LrFLuxvcL+EHKVIPnots3Z
	1S4JrAOkaQgEPbWV2bZ+KFSNzJ1td64VdCuHkaqXK9TtSQNQEuYCkm0TK8s2rImG
	N33Y0HEHFWYYPa6UoDkqMgezIR16Ny1zxu64OXMtEOU3pJ6kDn76lN62znjrMjEc
	AS1Lgj6lNVNRpJmWdM8tBOOPcaKauND0L9BP93aIxnMr5uj6fL2WWGLJZl8Z7akv
	DIJAQA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xhrcnq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 09:45:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8243c83d108so4496260b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770630339; x=1771235139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3sweEmsyWgmrL7m/ay0mlvztGrs55ayCJvJ8XDgymc=;
        b=QNOruTbcScFjdkDw3SG3GPtxgxg+j3unhKFgnNDwwkRnPw2hDDnSUp6pw8RAgLaBni
         HIlIbTFf9MWkgJppx/HO0Iin+jYru29N5QTunULcUYUNysxCp7rhnSIyL3LLmDFWxZdA
         C2vOxSmgoK5xwyv0cB5tSKAlqHPJ0AMchI3f1KiD8GqUoWBZR8WKRl1NwGf97vY/+y2k
         RZPwqwlcSUNG0ZipOde3IhsnYeotQYIDKKDexQ4Sq+1SyaTk4WPtgy6ZGoDUOVoyN0ph
         F2HmY+Vy4HgGcA330UDJwPhUekuNBQnvb7PL+bOyGHp1BgdnvyyD3G91YtK0PJNRv9eh
         106A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630339; x=1771235139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3sweEmsyWgmrL7m/ay0mlvztGrs55ayCJvJ8XDgymc=;
        b=w5X25oWr9nzfQkCeYbRVyR6i19eUuruG1NeaweaqlsJ9rfQppRtCxWhf6KdPc8pMr+
         QKa5ZewwAV3UBvY9rYtx7qo8YqDSfcRe/aqS1107LJWEd/RdzF6tAuMawMCOEauEUYnu
         Kvflx9xm1OzafaR3aRoHYRuvwvfVyXH/6Cv44kuQjH8fMj2oDeH75M2zI74vxJyPxZy1
         SvEVSfeYsyVspUWnLZfjYNpCyuwQldfykAMDF2tz4AEu3be1pH0gp91cs0XZ/iLVegz5
         j8xe2KVGfOSlub4SFvOUS9JrGLiWlQuM7T6Od/VzpqjuWVn7AzNygLxP5cHwtxCs+vFA
         t13A==
X-Forwarded-Encrypted: i=1; AJvYcCX0ma+ujMN89jNo6deX5vs8Bw69Fpm+pFb5wZxEac739XfPjvPVwm3YLwdKHm1xwhljKY1PbMtXlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzht6OEErIsOj5t6FU2J1sDoQGR+/ftyT2jGh2roef1Ro9Vjl/2
	Qt9CrX6hele7unqjiFx/5n2lE7jTOqxCfYD5UzJh99uT5qMBGYju/NsfloMUG0Kre+/A8+6trin
	VKFQPdp/waGyvLlbNQryQzwv3A7vQ0jYyg2naWR7KIkUNBu+nQG1ZrQXvgtGcOA==
X-Gm-Gg: AZuq6aJY+kVbWA3UPFQp38a2l2c1uoXbotc7qyTRlnvqEeAAJqHI08gNpmWFWwytt23
	lN4kmvmnnKQjhh2kVKisjzqU0RGvyyjl+vcKz09CIaPkSLONYOeQKHze72bHG91rc3y6lwEHeKa
	w8Xp+OFRr0YD5d8r7hkXPLrVCLl+iriMIgREH6KYiS37VSG9icZpWFq1NuLlHbYXmypRiW59IJ7
	pvjnENioGxPxcTTDGk8pwerZh+0mjN7ZGsNLAYJOqNB2xW5UkAQ8+jXyaVIximX3ExDnPacqfWq
	3u5zDp/a4YosiiPmRf1MwkyOeC00JGCv2Xr2ie53+NtOmixWWfmzmGOncI/OQc2rxR+3MGkiTKP
	Xu3WWXcKQSMCeozjZC9FywQxiQ3G22jMq
X-Received: by 2002:a05:6a00:760c:b0:824:4a22:ec16 with SMTP id d2e1a72fcca58-8244a22f168mr7681179b3a.34.1770630338731;
        Mon, 09 Feb 2026 01:45:38 -0800 (PST)
X-Received: by 2002:a05:6a00:760c:b0:824:4a22:ec16 with SMTP id d2e1a72fcca58-8244a22f168mr7681156b3a.34.1770630338218;
        Mon, 09 Feb 2026 01:45:38 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441884b75sm10748666b3a.39.2026.02.09.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:45:37 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 09:44:29 +0000
Subject: [PATCH v3 2/2] interconnect: qcom: glymur: Add Mahua SoC support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mahua_icc-v3-2-c65f3dfd72c8@oss.qualcomm.com>
References: <20260209-mahua_icc-v3-0-c65f3dfd72c8@oss.qualcomm.com>
In-Reply-To: <20260209-mahua_icc-v3-0-c65f3dfd72c8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RwpITFv4dyZ6H-vvn34igcOod07lNP62
X-Authority-Analysis: v=2.4 cv=AJ+v8NAg c=1 sm=1 tr=0 ts=6989acc6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=niA-Db4sJa1Ec6H3ubUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4MCBTYWx0ZWRfX2L4ZSGw6aq3M
 Cbj9Tn5yBksFGMT3YzvRMzGVEP0sSA/aDN330/8II4eqZbDI+x96nY/7ONNgbKlP7WqEhHYJiIb
 skzzNcrw3w7ARhGAhOhkBibWnKc1Gt1yWRCYU0WMYbhvbyGjeN1zxG8TeURW4P91BsDHia1NtzC
 6q75ttYkRggXb8GOzwYR2dzQg+4Rup5HMlJXyQX4stcVppQe8ypyH/gwvGyQyAOE0SLuiSWQSDP
 klx2AP6TiC7ubWWxJHaeKYam9XvlWR3Wbso64qEfeT6MdDmIzX0wb7eopUfH3mRu1HXgSBtlwuO
 0pcK8jDxstjw9rOsuNqCw7ebBL9sfIV5ywHlq7wnnhaap/kYXASiBFyNMbhi4+/cGGxaFpofcB9
 xcGU5axyp+5JFoqT4eNBiI0bsPTVpL0mKpx0F+yxSsmI8llN6rl8qinVwxu+nxCxBHRMDBbEsLf
 vO5HT4jBl3zWwwk5Q1g==
X-Proofpoint-ORIG-GUID: RwpITFv4dyZ6H-vvn34igcOod07lNP62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-42333-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E068210DBD4
X-Rspamd-Action: no action

Mahua is a derivative of the Glymur SoC. Extend the
Glymur driver to support Mahua by:

  1. Adding new node definitions for interconnects that differ from Glymur
     (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
  2. Reusing existing Glymur definitions for identical NoCs.
  3. Overriding the channel and buswidth, with Mahua specific values for
     the differing NoCs

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/glymur.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
index e5c07795a6c67ab8a59daf2fc4b8a5fa6dd014d6..cfe061c1a75a692c252c4a0d4ea63e71308223ba 100644
--- a/drivers/interconnect/qcom/glymur.c
+++ b/drivers/interconnect/qcom/glymur.c
@@ -9,6 +9,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/property.h>
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 
 #include "bcm-voter.h"
@@ -1985,7 +1986,7 @@ static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
 	&bcm_cn1,
 };
 
-static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+static struct qcom_icc_node *cnoc_cfg_nodes[] = {
 	[MASTER_CNOC_CFG] = &qsm_cfg,
 	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
 	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
@@ -2093,7 +2094,7 @@ static struct qcom_icc_bcm * const hscnoc_bcms[] = {
 	&bcm_sh1,
 };
 
-static struct qcom_icc_node * const hscnoc_nodes[] = {
+static struct qcom_icc_node *hscnoc_nodes[] = {
 	[MASTER_GPU_TCU] = &alm_gpu_tcu,
 	[MASTER_PCIE_TCU] = &alm_pcie_qtc,
 	[MASTER_SYS_TCU] = &alm_sys_tcu,
@@ -2377,7 +2378,7 @@ static struct qcom_icc_bcm * const pcie_west_anoc_bcms[] = {
 	&bcm_sn6,
 };
 
-static struct qcom_icc_node * const pcie_west_anoc_nodes[] = {
+static struct qcom_icc_node *pcie_west_anoc_nodes[] = {
 	[MASTER_PCIE_WEST_ANOC_CFG] = &qsm_pcie_west_anoc_cfg,
 	[MASTER_PCIE_2] = &xm_pcie_2,
 	[MASTER_PCIE_3A] = &xm_pcie_3a,
@@ -2409,7 +2410,7 @@ static struct qcom_icc_bcm * const pcie_west_slv_noc_bcms[] = {
 	&bcm_sn6,
 };
 
-static struct qcom_icc_node * const pcie_west_slv_noc_nodes[] = {
+static struct qcom_icc_node *pcie_west_slv_noc_nodes[] = {
 	[MASTER_HSCNOC_PCIE_WEST] = &qnm_hscnoc_pcie_west,
 	[MASTER_CNOC_PCIE_WEST_SLAVE_CFG] = &qsm_cnoc_pcie_west_slave_cfg,
 	[SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG] = &qhs_hscnoc_pcie_west_ms_mpu_cfg,
@@ -2470,6 +2471,28 @@ static const struct qcom_icc_desc glymur_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
+static int glymur_qnoc_probe(struct platform_device *pdev)
+{
+	if (device_is_compatible(&pdev->dev, "qcom,mahua-mc-virt")) {
+		llcc_mc.channels = 8;
+		ebi.channels = 8;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-hscnoc")) {
+		qns_llcc.channels = 8;
+		chm_apps.channels = 4;
+		qnm_pcie_west.buswidth = 32;
+		hscnoc_nodes[MASTER_WLAN_Q6] = NULL;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-pcie-west-anoc")) {
+		qns_pcie_west_mem_noc.buswidth = 32;
+		pcie_west_anoc_nodes[MASTER_PCIE_3A] = NULL;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-cnoc-cfg")) {
+		cnoc_cfg_nodes[SLAVE_PCIE_3A_CFG] = NULL;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-pcie-west-slv-noc")) {
+		pcie_west_slv_noc_nodes[SLAVE_PCIE_3A] = NULL;
+	}
+
+	return qcom_icc_rpmh_probe(pdev);
+}
+
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-aggre1-noc", .data = &glymur_aggre1_noc},
 	{ .compatible = "qcom,glymur-aggre2-noc", .data = &glymur_aggre2_noc},
@@ -2477,12 +2500,15 @@ static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-aggre4-noc", .data = &glymur_aggre4_noc},
 	{ .compatible = "qcom,glymur-clk-virt", .data = &glymur_clk_virt},
 	{ .compatible = "qcom,glymur-cnoc-cfg", .data = &glymur_cnoc_cfg},
+	{ .compatible = "qcom,mahua-cnoc-cfg", .data = &glymur_cnoc_cfg},
 	{ .compatible = "qcom,glymur-cnoc-main", .data = &glymur_cnoc_main},
 	{ .compatible = "qcom,glymur-hscnoc", .data = &glymur_hscnoc},
+	{ .compatible = "qcom,mahua-hscnoc", .data = &glymur_hscnoc},
 	{ .compatible = "qcom,glymur-lpass-ag-noc", .data = &glymur_lpass_ag_noc},
 	{ .compatible = "qcom,glymur-lpass-lpiaon-noc", .data = &glymur_lpass_lpiaon_noc},
 	{ .compatible = "qcom,glymur-lpass-lpicx-noc", .data = &glymur_lpass_lpicx_noc},
 	{ .compatible = "qcom,glymur-mc-virt", .data = &glymur_mc_virt},
+	{ .compatible = "qcom,mahua-mc-virt", .data = &glymur_mc_virt},
 	{ .compatible = "qcom,glymur-mmss-noc", .data = &glymur_mmss_noc},
 	{ .compatible = "qcom,glymur-nsinoc", .data = &glymur_nsinoc},
 	{ .compatible = "qcom,glymur-nsp-noc", .data = &glymur_nsp_noc},
@@ -2490,14 +2516,16 @@ static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-pcie-east-anoc", .data = &glymur_pcie_east_anoc},
 	{ .compatible = "qcom,glymur-pcie-east-slv-noc", .data = &glymur_pcie_east_slv_noc},
 	{ .compatible = "qcom,glymur-pcie-west-anoc", .data = &glymur_pcie_west_anoc},
+	{ .compatible = "qcom,mahua-pcie-west-anoc", .data = &glymur_pcie_west_anoc},
 	{ .compatible = "qcom,glymur-pcie-west-slv-noc", .data = &glymur_pcie_west_slv_noc},
+	{ .compatible = "qcom,mahua-pcie-west-slv-noc", .data = &glymur_pcie_west_slv_noc},
 	{ .compatible = "qcom,glymur-system-noc", .data = &glymur_system_noc},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qcom_icc_rpmh_probe,
+	.probe = glymur_qnoc_probe,
 	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-glymur",

-- 
2.43.0


