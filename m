Return-Path: <linux-pm+bounces-24476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C9A6E262
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C5D18890B4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6230265638;
	Mon, 24 Mar 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCOfpkIF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22987264FB0;
	Mon, 24 Mar 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841196; cv=none; b=aOOripwVZMCHSP5wC+4VLecDv1yVh8VcR6TCY3URg+l6FONJlPzw6nIddTl21NfbURrIqyZUVD7xFaYNdr9g3r/Kx8f8YODZBvsUoxXmCmn4Jex6Nhy1r7VvIffM63iiVOZ6GMK17jmNX3VdrzAgdqYVzqls4JHToYWFaTNlBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841196; c=relaxed/simple;
	bh=OCSwKp5sPDIBKnstpmtOwKLiwZxCzjQdoa2tpAj/1OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyqMR/I0V0VG00w41grF6yVR9HQDwnOKeuUEQrgI27yKI8ndsWclLwo4/TWV1fumWZbN7FiSwZJfAruazHUX6HNhTRohroUGk1OWik1a54OH3s/x5457FgDg3JOh1zwq7beqQWBt68BeKTf+E0V+Ugk81K6iMgawhB3btrQ93wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nCOfpkIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PLhK025884;
	Mon, 24 Mar 2025 18:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tg+EJiys6eHMaIxa16j1lgtq6ZbILsvfhk/VQGYQL3M=; b=nCOfpkIFWjqJwvMV
	g2F6oaARDNqddznXLgwfGq9Bx6Ow5xOvIZ7AK6UQDJK6EkJT4VpXJDh4as8fMnX9
	Ni67fY/m8cm1IhiTDY1UXX8PfpHrHkaDFVcQkFxINstt/tRLfGRPj0p2Vg7coI+S
	at5/frm8W73/AnU6OtDY8h2AfLvy2QahLPWeNG3j2mi7NrHPJ77Jn9hGVSUMPkqE
	fD+UfJmT4unq6UARZLyArVJkeuHR+TWdIqhiLE2WSoUJxw1IEaDhOF1G2RM0d3go
	3r2fr07YVY3Q8ziWgn1Mdn1M5dSzo07l/nHh3VBdLyGSFCJmb5WbBsKqfYffHUrC
	cqOT8w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnnh1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:33:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52OIX52J018352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:33:05 GMT
Received: from 6cb0ec70778b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Mar 2025 11:33:00 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Raviteja
 Laggyshetty" <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V10 5/7] interconnect: qcom: sa8775p: Add dynamic icc node id support
Date: Mon, 24 Mar 2025 18:32:01 +0000
Message-ID: <20250324183203.30127-6-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e1a562 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=0ljW9RUYZQf_HuucqLQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zQxlNrjxYkZmyfTloQPgmjeAdSdK1Syr
X-Proofpoint-GUID: zQxlNrjxYkZmyfTloQPgmjeAdSdK1Syr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240132

To facilitate dynamic id allocation, discard the static IDs
from node data and set alloc_dyn_id in descriptor structure
to indicate dynamic ID allocation. Update the topology to use
node pointers for links instead of static IDs and forward declare
the node pointer to avoid undefined references.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/sa8775p.c | 952 ++++++++++------------------
 1 file changed, 347 insertions(+), 605 deletions(-)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index e2826af3ea2e..04b4abbf4487 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -15,1859 +15,1587 @@
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
 
-#define SA8775P_MASTER_GPU_TCU				0
-#define SA8775P_MASTER_PCIE_TCU				1
-#define SA8775P_MASTER_SYS_TCU				2
-#define SA8775P_MASTER_APPSS_PROC			3
-#define SA8775P_MASTER_LLCC				4
-#define SA8775P_MASTER_CNOC_LPASS_AG_NOC		5
-#define SA8775P_MASTER_GIC_AHB				6
-#define SA8775P_MASTER_CDSP_NOC_CFG			7
-#define SA8775P_MASTER_CDSPB_NOC_CFG			8
-#define SA8775P_MASTER_QDSS_BAM				9
-#define SA8775P_MASTER_QUP_0				10
-#define SA8775P_MASTER_QUP_1				11
-#define SA8775P_MASTER_QUP_2				12
-#define SA8775P_MASTER_A1NOC_SNOC			13
-#define SA8775P_MASTER_A2NOC_SNOC			14
-#define SA8775P_MASTER_CAMNOC_HF			15
-#define SA8775P_MASTER_CAMNOC_ICP			16
-#define SA8775P_MASTER_CAMNOC_SF			17
-#define SA8775P_MASTER_COMPUTE_NOC			18
-#define SA8775P_MASTER_COMPUTE_NOC_1			19
-#define SA8775P_MASTER_CNOC_A2NOC			20
-#define SA8775P_MASTER_CNOC_DC_NOC			21
-#define SA8775P_MASTER_GEM_NOC_CFG			22
-#define SA8775P_MASTER_GEM_NOC_CNOC			23
-#define SA8775P_MASTER_GEM_NOC_PCIE_SNOC		24
-#define SA8775P_MASTER_GPDSP_SAIL			25
-#define SA8775P_MASTER_GFX3D				26
-#define SA8775P_MASTER_LPASS_ANOC			27
-#define SA8775P_MASTER_MDP0				28
-#define SA8775P_MASTER_MDP1				29
-#define SA8775P_MASTER_MDP_CORE1_0			30
-#define SA8775P_MASTER_MDP_CORE1_1			31
-#define SA8775P_MASTER_MNOC_HF_MEM_NOC			32
-#define SA8775P_MASTER_CNOC_MNOC_HF_CFG			33
-#define SA8775P_MASTER_MNOC_SF_MEM_NOC			34
-#define SA8775P_MASTER_CNOC_MNOC_SF_CFG			35
-#define SA8775P_MASTER_ANOC_PCIE_GEM_NOC		36
-#define SA8775P_MASTER_SNOC_CFG				37
-#define SA8775P_MASTER_SNOC_GC_MEM_NOC			38
-#define SA8775P_MASTER_SNOC_SF_MEM_NOC			39
-#define SA8775P_MASTER_VIDEO_P0				40
-#define SA8775P_MASTER_VIDEO_P1				41
-#define SA8775P_MASTER_VIDEO_PROC			42
-#define SA8775P_MASTER_VIDEO_V_PROC			43
-#define SA8775P_MASTER_QUP_CORE_0			44
-#define SA8775P_MASTER_QUP_CORE_1			45
-#define SA8775P_MASTER_QUP_CORE_2			46
-#define SA8775P_MASTER_QUP_CORE_3			47
-#define SA8775P_MASTER_CRYPTO_CORE0			48
-#define SA8775P_MASTER_CRYPTO_CORE1			49
-#define SA8775P_MASTER_DSP0				50
-#define SA8775P_MASTER_DSP1				51
-#define SA8775P_MASTER_IPA				52
-#define SA8775P_MASTER_LPASS_PROC			53
-#define SA8775P_MASTER_CDSP_PROC			54
-#define SA8775P_MASTER_CDSP_PROC_B			55
-#define SA8775P_MASTER_PIMEM				56
-#define SA8775P_MASTER_QUP_3				57
-#define SA8775P_MASTER_EMAC				58
-#define SA8775P_MASTER_EMAC_1				59
-#define SA8775P_MASTER_GIC				60
-#define SA8775P_MASTER_PCIE_0				61
-#define SA8775P_MASTER_PCIE_1				62
-#define SA8775P_MASTER_QDSS_ETR_0			63
-#define SA8775P_MASTER_QDSS_ETR_1			64
-#define SA8775P_MASTER_SDC				65
-#define SA8775P_MASTER_UFS_CARD				66
-#define SA8775P_MASTER_UFS_MEM				67
-#define SA8775P_MASTER_USB2				68
-#define SA8775P_MASTER_USB3_0				69
-#define SA8775P_MASTER_USB3_1				70
-#define SA8775P_SLAVE_EBI1				512
-#define SA8775P_SLAVE_AHB2PHY_0				513
-#define SA8775P_SLAVE_AHB2PHY_1				514
-#define SA8775P_SLAVE_AHB2PHY_2				515
-#define SA8775P_SLAVE_AHB2PHY_3				516
-#define SA8775P_SLAVE_ANOC_THROTTLE_CFG			517
-#define SA8775P_SLAVE_AOSS				518
-#define SA8775P_SLAVE_APPSS				519
-#define SA8775P_SLAVE_BOOT_ROM				520
-#define SA8775P_SLAVE_CAMERA_CFG			521
-#define SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG		522
-#define SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG		523
-#define SA8775P_SLAVE_CLK_CTL				524
-#define SA8775P_SLAVE_CDSP_CFG				525
-#define SA8775P_SLAVE_CDSP1_CFG				526
-#define SA8775P_SLAVE_RBCPR_CX_CFG			527
-#define SA8775P_SLAVE_RBCPR_MMCX_CFG			528
-#define SA8775P_SLAVE_RBCPR_MX_CFG			529
-#define SA8775P_SLAVE_CPR_NSPCX				530
-#define SA8775P_SLAVE_CRYPTO_0_CFG			531
-#define SA8775P_SLAVE_CX_RDPM				532
-#define SA8775P_SLAVE_DISPLAY_CFG			533
-#define SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG		534
-#define SA8775P_SLAVE_DISPLAY1_CFG			535
-#define SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG		536
-#define SA8775P_SLAVE_EMAC_CFG				537
-#define SA8775P_SLAVE_EMAC1_CFG				538
-#define SA8775P_SLAVE_GP_DSP0_CFG			539
-#define SA8775P_SLAVE_GP_DSP1_CFG			540
-#define SA8775P_SLAVE_GPDSP0_THROTTLE_CFG		541
-#define SA8775P_SLAVE_GPDSP1_THROTTLE_CFG		542
-#define SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG		543
-#define SA8775P_SLAVE_GFX3D_CFG				544
-#define SA8775P_SLAVE_HWKM				545
-#define SA8775P_SLAVE_IMEM_CFG				546
-#define SA8775P_SLAVE_IPA_CFG				547
-#define SA8775P_SLAVE_IPC_ROUTER_CFG			548
-#define SA8775P_SLAVE_LLCC_CFG				549
-#define SA8775P_SLAVE_LPASS				550
-#define SA8775P_SLAVE_LPASS_CORE_CFG			551
-#define SA8775P_SLAVE_LPASS_LPI_CFG			552
-#define SA8775P_SLAVE_LPASS_MPU_CFG			553
-#define SA8775P_SLAVE_LPASS_THROTTLE_CFG		554
-#define SA8775P_SLAVE_LPASS_TOP_CFG			555
-#define SA8775P_SLAVE_MX_RDPM				556
-#define SA8775P_SLAVE_MXC_RDPM				557
-#define SA8775P_SLAVE_PCIE_0_CFG			558
-#define SA8775P_SLAVE_PCIE_1_CFG			559
-#define SA8775P_SLAVE_PCIE_RSC_CFG			560
-#define SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG		561
-#define SA8775P_SLAVE_PCIE_THROTTLE_CFG			562
-#define SA8775P_SLAVE_PDM				563
-#define SA8775P_SLAVE_PIMEM_CFG				564
-#define SA8775P_SLAVE_PKA_WRAPPER_CFG			565
-#define SA8775P_SLAVE_QDSS_CFG				566
-#define SA8775P_SLAVE_QM_CFG				567
-#define SA8775P_SLAVE_QM_MPU_CFG			568
-#define SA8775P_SLAVE_QUP_0				569
-#define SA8775P_SLAVE_QUP_1				570
-#define SA8775P_SLAVE_QUP_2				571
-#define SA8775P_SLAVE_QUP_3				572
-#define SA8775P_SLAVE_SAIL_THROTTLE_CFG			573
-#define SA8775P_SLAVE_SDC1				574
-#define SA8775P_SLAVE_SECURITY				575
-#define SA8775P_SLAVE_SNOC_THROTTLE_CFG			576
-#define SA8775P_SLAVE_TCSR				577
-#define SA8775P_SLAVE_TLMM				578
-#define SA8775P_SLAVE_TSC_CFG				579
-#define SA8775P_SLAVE_UFS_CARD_CFG			580
-#define SA8775P_SLAVE_UFS_MEM_CFG			581
-#define SA8775P_SLAVE_USB2				582
-#define SA8775P_SLAVE_USB3_0				583
-#define SA8775P_SLAVE_USB3_1				584
-#define SA8775P_SLAVE_VENUS_CFG				585
-#define SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG		586
-#define SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG		587
-#define SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG		588
-#define SA8775P_SLAVE_A1NOC_SNOC			589
-#define SA8775P_SLAVE_A2NOC_SNOC			590
-#define SA8775P_SLAVE_DDRSS_CFG				591
-#define SA8775P_SLAVE_GEM_NOC_CNOC			592
-#define SA8775P_SLAVE_GEM_NOC_CFG			593
-#define SA8775P_SLAVE_SNOC_GEM_NOC_GC			594
-#define SA8775P_SLAVE_SNOC_GEM_NOC_SF			595
-#define SA8775P_SLAVE_GP_DSP_SAIL_NOC			596
-#define SA8775P_SLAVE_GPDSP_NOC_CFG			597
-#define SA8775P_SLAVE_HCP_A				598
-#define SA8775P_SLAVE_LLCC				599
-#define SA8775P_SLAVE_MNOC_HF_MEM_NOC			600
-#define SA8775P_SLAVE_MNOC_SF_MEM_NOC			601
-#define SA8775P_SLAVE_CNOC_MNOC_HF_CFG			602
-#define SA8775P_SLAVE_CNOC_MNOC_SF_CFG			603
-#define SA8775P_SLAVE_CDSP_MEM_NOC			604
-#define SA8775P_SLAVE_CDSPB_MEM_NOC			605
-#define SA8775P_SLAVE_HCP_B				606
-#define SA8775P_SLAVE_GEM_NOC_PCIE_CNOC			607
-#define SA8775P_SLAVE_PCIE_ANOC_CFG			608
-#define SA8775P_SLAVE_ANOC_PCIE_GEM_NOC			609
-#define SA8775P_SLAVE_SNOC_CFG				610
-#define SA8775P_SLAVE_LPASS_SNOC			611
-#define SA8775P_SLAVE_QUP_CORE_0			612
-#define SA8775P_SLAVE_QUP_CORE_1			613
-#define SA8775P_SLAVE_QUP_CORE_2			614
-#define SA8775P_SLAVE_QUP_CORE_3			615
-#define SA8775P_SLAVE_BOOT_IMEM				616
-#define SA8775P_SLAVE_IMEM				617
-#define SA8775P_SLAVE_PIMEM				618
-#define SA8775P_SLAVE_SERVICE_NSP_NOC			619
-#define SA8775P_SLAVE_SERVICE_NSPB_NOC			620
-#define SA8775P_SLAVE_SERVICE_GEM_NOC_1			621
-#define SA8775P_SLAVE_SERVICE_MNOC_HF			622
-#define SA8775P_SLAVE_SERVICE_MNOC_SF			623
-#define SA8775P_SLAVE_SERVICES_LPASS_AML_NOC		624
-#define SA8775P_SLAVE_SERVICE_LPASS_AG_NOC		625
-#define SA8775P_SLAVE_SERVICE_GEM_NOC_2			626
-#define SA8775P_SLAVE_SERVICE_SNOC			627
-#define SA8775P_SLAVE_SERVICE_GEM_NOC			628
-#define SA8775P_SLAVE_SERVICE_GEM_NOC2			629
-#define SA8775P_SLAVE_PCIE_0				630
-#define SA8775P_SLAVE_PCIE_1				631
-#define SA8775P_SLAVE_QDSS_STM				632
-#define SA8775P_SLAVE_TCU				633
+static struct qcom_icc_node qxm_qup3;
+static struct qcom_icc_node xm_emac_0;
+static struct qcom_icc_node xm_emac_1;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb2_2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_cnoc_datapath;
+static struct qcom_icc_node qxm_crypto_0;
+static struct qcom_icc_node qxm_crypto_1;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_ufs_card;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qup3_core_master;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qup3_core_slave;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_ahb2phy3;
+static struct qcom_icc_node qhs_anoc_throttle_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_boot_rom;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_throttle_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute0_cfg;
+static struct qcom_icc_node qhs_compute1_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_cpr_nspcx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_display0_cfg;
+static struct qcom_icc_node qhs_display0_rt_throttle_cfg;
+static struct qcom_icc_node qhs_display1_cfg;
+static struct qcom_icc_node qhs_display1_rt_throttle_cfg;
+static struct qcom_icc_node qhs_emac0_cfg;
+static struct qcom_icc_node qhs_emac1_cfg;
+static struct qcom_icc_node qhs_gp_dsp0_cfg;
+static struct qcom_icc_node qhs_gp_dsp1_cfg;
+static struct qcom_icc_node qhs_gpdsp0_throttle_cfg;
+static struct qcom_icc_node qhs_gpdsp1_throttle_cfg;
+static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_hwkm;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_lpass_throttle_cfg;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_mxc_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie_rsc_cfg;
+static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg;
+static struct qcom_icc_node qhs_pcie_throttle_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_pke_wrapper_cfg;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qm_cfg;
+static struct qcom_icc_node qhs_qm_mpu_cfg;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_qup3;
+static struct qcom_icc_node qhs_sail_throttle_cfg;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_snoc_throttle_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_tsc_cfg;
+static struct qcom_icc_node qhs_ufs_card_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2_0;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_usb3_1;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_cvp_throttle_cfg;
+static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg;
+static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_gpdsp_noc_cfg;
+static struct qcom_icc_node qns_mnoc_hf_cfg;
+static struct qcom_icc_node qns_mnoc_sf_cfg;
+static struct qcom_icc_node qns_pcie_anoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qnm_cnoc_dc_noc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_pcie_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_cmpnoc0;
+static struct qcom_icc_node qnm_cmpnoc1;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpdsp_sail;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node srvc_even_gemnoc;
+static struct qcom_icc_node srvc_odd_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc_2;
+static struct qcom_icc_node qxm_dsp0;
+static struct qcom_icc_node qxm_dsp1;
+static struct qcom_icc_node qns_gp_dsp_sail_noc;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node qhs_lpass_core;
+static struct qcom_icc_node qhs_lpass_lpi;
+static struct qcom_icc_node qhs_lpass_mpu;
+static struct qcom_icc_node qhs_lpass_top;
+static struct qcom_icc_node qns_sysnoc;
+static struct qcom_icc_node srvc_niu_aml_noc;
+static struct qcom_icc_node srvc_niu_lpass_agnoc;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp0_0;
+static struct qcom_icc_node qnm_mdp0_1;
+static struct qcom_icc_node qnm_mdp1_0;
+static struct qcom_icc_node qnm_mdp1_1;
+static struct qcom_icc_node qnm_mnoc_hf_cfg;
+static struct qcom_icc_node qnm_mnoc_sf_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video1;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc_hf;
+static struct qcom_icc_node srvc_mnoc_sf;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qns_hcp;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qhm_nspb_noc_config;
+static struct qcom_icc_node qxm_nspb;
+static struct qcom_icc_node qns_nspb_gemnoc;
+static struct qcom_icc_node qns_nspb_hcp;
+static struct qcom_icc_node service_nspb_noc;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_lpass_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
 
 static struct qcom_icc_node qxm_qup3 = {
 	.name = "qxm_qup3",
-	.id = SA8775P_MASTER_QUP_3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
-	.id = SA8775P_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
-	.id = SA8775P_MASTER_EMAC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SA8775P_MASTER_SDC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SA8775P_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2_2 = {
 	.name = "xm_usb2_2",
-	.id = SA8775P_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SA8775P_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SA8775P_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SA8775P_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SA8775P_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SA8775P_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SA8775P_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
-	.id = SA8775P_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_0 = {
 	.name = "qxm_crypto_0",
-	.id = SA8775P_MASTER_CRYPTO_CORE0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_1 = {
 	.name = "qxm_crypto_1",
-	.id = SA8775P_MASTER_CRYPTO_CORE1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SA8775P_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = SA8775P_MASTER_QDSS_ETR_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = SA8775P_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SA8775P_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SA8775P_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_QUP_CORE_0 },
+	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SA8775P_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_QUP_CORE_1 },
+	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SA8775P_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_QUP_CORE_2 },
+	.link_nodes = (struct qcom_icc_node *[]) { &qup2_core_slave },
 };
 
 static struct qcom_icc_node qup3_core_master = {
 	.name = "qup3_core_master",
-	.id = SA8775P_MASTER_QUP_CORE_3,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_QUP_CORE_3 },
+	.link_nodes = (struct qcom_icc_node *[]) { &qup3_core_slave },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SA8775P_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 82,
-	.links = { SA8775P_SLAVE_AHB2PHY_0,
-		   SA8775P_SLAVE_AHB2PHY_1,
-		   SA8775P_SLAVE_AHB2PHY_2,
-		   SA8775P_SLAVE_AHB2PHY_3,
-		   SA8775P_SLAVE_ANOC_THROTTLE_CFG,
-		   SA8775P_SLAVE_AOSS,
-		   SA8775P_SLAVE_APPSS,
-		   SA8775P_SLAVE_BOOT_ROM,
-		   SA8775P_SLAVE_CAMERA_CFG,
-		   SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SA8775P_SLAVE_CLK_CTL,
-		   SA8775P_SLAVE_CDSP_CFG,
-		   SA8775P_SLAVE_CDSP1_CFG,
-		   SA8775P_SLAVE_RBCPR_CX_CFG,
-		   SA8775P_SLAVE_RBCPR_MMCX_CFG,
-		   SA8775P_SLAVE_RBCPR_MX_CFG,
-		   SA8775P_SLAVE_CPR_NSPCX,
-		   SA8775P_SLAVE_CRYPTO_0_CFG,
-		   SA8775P_SLAVE_CX_RDPM,
-		   SA8775P_SLAVE_DISPLAY_CFG,
-		   SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
-		   SA8775P_SLAVE_DISPLAY1_CFG,
-		   SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
-		   SA8775P_SLAVE_EMAC_CFG,
-		   SA8775P_SLAVE_EMAC1_CFG,
-		   SA8775P_SLAVE_GP_DSP0_CFG,
-		   SA8775P_SLAVE_GP_DSP1_CFG,
-		   SA8775P_SLAVE_GPDSP0_THROTTLE_CFG,
-		   SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
-		   SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG,
-		   SA8775P_SLAVE_GFX3D_CFG,
-		   SA8775P_SLAVE_HWKM,
-		   SA8775P_SLAVE_IMEM_CFG,
-		   SA8775P_SLAVE_IPA_CFG,
-		   SA8775P_SLAVE_IPC_ROUTER_CFG,
-		   SA8775P_SLAVE_LPASS,
-		   SA8775P_SLAVE_LPASS_THROTTLE_CFG,
-		   SA8775P_SLAVE_MX_RDPM,
-		   SA8775P_SLAVE_MXC_RDPM,
-		   SA8775P_SLAVE_PCIE_0_CFG,
-		   SA8775P_SLAVE_PCIE_1_CFG,
-		   SA8775P_SLAVE_PCIE_RSC_CFG,
-		   SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
-		   SA8775P_SLAVE_PCIE_THROTTLE_CFG,
-		   SA8775P_SLAVE_PDM,
-		   SA8775P_SLAVE_PIMEM_CFG,
-		   SA8775P_SLAVE_PKA_WRAPPER_CFG,
-		   SA8775P_SLAVE_QDSS_CFG,
-		   SA8775P_SLAVE_QM_CFG,
-		   SA8775P_SLAVE_QM_MPU_CFG,
-		   SA8775P_SLAVE_QUP_0,
-		   SA8775P_SLAVE_QUP_1,
-		   SA8775P_SLAVE_QUP_2,
-		   SA8775P_SLAVE_QUP_3,
-		   SA8775P_SLAVE_SAIL_THROTTLE_CFG,
-		   SA8775P_SLAVE_SDC1,
-		   SA8775P_SLAVE_SECURITY,
-		   SA8775P_SLAVE_SNOC_THROTTLE_CFG,
-		   SA8775P_SLAVE_TCSR,
-		   SA8775P_SLAVE_TLMM,
-		   SA8775P_SLAVE_TSC_CFG,
-		   SA8775P_SLAVE_UFS_CARD_CFG,
-		   SA8775P_SLAVE_UFS_MEM_CFG,
-		   SA8775P_SLAVE_USB2,
-		   SA8775P_SLAVE_USB3_0,
-		   SA8775P_SLAVE_USB3_1,
-		   SA8775P_SLAVE_VENUS_CFG,
-		   SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG,
-		   SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
-		   SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
-		   SA8775P_SLAVE_DDRSS_CFG,
-		   SA8775P_SLAVE_GPDSP_NOC_CFG,
-		   SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
-		   SA8775P_SLAVE_CNOC_MNOC_SF_CFG,
-		   SA8775P_SLAVE_PCIE_ANOC_CFG,
-		   SA8775P_SLAVE_SNOC_CFG,
-		   SA8775P_SLAVE_BOOT_IMEM,
-		   SA8775P_SLAVE_IMEM,
-		   SA8775P_SLAVE_PIMEM,
-		   SA8775P_SLAVE_QDSS_STM,
-		   SA8775P_SLAVE_TCU
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+		      &qhs_ahb2phy2, &qhs_ahb2phy3,
+		      &qhs_anoc_throttle_cfg, &qhs_aoss,
+		      &qhs_apss, &qhs_boot_rom,
+		      &qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg,
+		      &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl,
+		      &qhs_compute0_cfg, &qhs_compute1_cfg,
+		      &qhs_cpr_cx, &qhs_cpr_mmcx,
+		      &qhs_cpr_mx, &qhs_cpr_nspcx,
+		      &qhs_crypto0_cfg, &qhs_cx_rdpm,
+		      &qhs_display0_cfg, &qhs_display0_rt_throttle_cfg,
+		      &qhs_display1_cfg, &qhs_display1_rt_throttle_cfg,
+		      &qhs_emac0_cfg, &qhs_emac1_cfg,
+		      &qhs_gp_dsp0_cfg, &qhs_gp_dsp1_cfg,
+		      &qhs_gpdsp0_throttle_cfg, &qhs_gpdsp1_throttle_cfg,
+		      &qhs_gpu_tcu_throttle_cfg, &qhs_gpuss_cfg,
+		      &qhs_hwkm, &qhs_imem_cfg,
+		      &qhs_ipa, &qhs_ipc_router,
+		      &qhs_lpass_cfg, &qhs_lpass_throttle_cfg,
+		      &qhs_mx_rdpm, &qhs_mxc_rdpm,
+		      &qhs_pcie0_cfg, &qhs_pcie1_cfg,
+		      &qhs_pcie_rsc_cfg, &qhs_pcie_tcu_throttle_cfg,
+		      &qhs_pcie_throttle_cfg, &qhs_pdm,
+		      &qhs_pimem_cfg, &qhs_pke_wrapper_cfg,
+		      &qhs_qdss_cfg, &qhs_qm_cfg,
+		      &qhs_qm_mpu_cfg, &qhs_qup0,
+		      &qhs_qup1, &qhs_qup2,
+		      &qhs_qup3, &qhs_sail_throttle_cfg,
+		      &qhs_sdc1, &qhs_security,
+		      &qhs_snoc_throttle_cfg, &qhs_tcsr,
+		      &qhs_tlmm, &qhs_tsc_cfg,
+		      &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg,
+		      &qhs_usb2_0, &qhs_usb3_0,
+		      &qhs_usb3_1, &qhs_venus_cfg,
+		      &qhs_venus_cvp_throttle_cfg, &qhs_venus_v_cpu_throttle_cfg,
+		      &qhs_venus_vcodec_throttle_cfg, &qns_ddrss_cfg,
+		      &qns_gpdsp_noc_cfg, &qns_mnoc_hf_cfg,
+		      &qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
+		      &qns_snoc_cfg, &qxs_boot_imem,
+		      &qxs_imem, &qxs_pimem,
+		      &xs_qdss_stm, &xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SA8775P_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_PCIE_0,
-		   SA8775P_SLAVE_PCIE_1
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = SA8775P_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_LLCC_CFG,
-		   SA8775P_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_llcc, &qns_gemnoc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SA8775P_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
-	.id = SA8775P_MASTER_PCIE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SA8775P_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SA8775P_MASTER_APPSS_PROC,
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC,
-		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
 };
 
 static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
-	.id = SA8775P_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_cmpnoc1 = {
 	.name = "qnm_cmpnoc1",
-	.id = SA8775P_MASTER_COMPUTE_NOC_1,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SA8775P_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 4,
-	.links = { SA8775P_SLAVE_SERVICE_GEM_NOC_1,
-		   SA8775P_SLAVE_SERVICE_GEM_NOC_2,
-		   SA8775P_SLAVE_SERVICE_GEM_NOC,
-		   SA8775P_SLAVE_SERVICE_GEM_NOC2
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_even_gemnoc, &srvc_odd_gemnoc,
+		      &srvc_sys_gemnoc, &srvc_sys_gemnoc_2 },
 };
 
 static struct qcom_icc_node qnm_gpdsp_sail = {
 	.name = "qnm_gpdsp_sail",
-	.id = SA8775P_MASTER_GPDSP_SAIL,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SA8775P_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SA8775P_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_LLCC,
-		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc, &qns_pcie },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SA8775P_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC,
-		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SA8775P_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SA8775P_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_LLCC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SA8775P_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SA8775P_SLAVE_GEM_NOC_CNOC,
-		   SA8775P_SLAVE_LLCC,
-		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
 };
 
 static struct qcom_icc_node qxm_dsp0 = {
 	.name = "qxm_dsp0",
-	.id = SA8775P_MASTER_DSP0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qxm_dsp1 = {
 	.name = "qxm_dsp1",
-	.id = SA8775P_MASTER_DSP1,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SA8775P_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 6,
-	.links = { SA8775P_SLAVE_LPASS_CORE_CFG,
-		   SA8775P_SLAVE_LPASS_LPI_CFG,
-		   SA8775P_SLAVE_LPASS_MPU_CFG,
-		   SA8775P_SLAVE_LPASS_TOP_CFG,
-		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
-		   SA8775P_SLAVE_SERVICE_LPASS_AG_NOC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_core, &qhs_lpass_lpi,
+		      &qhs_lpass_mpu, &qhs_lpass_top,
+		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
-	.id = SA8775P_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 4,
-	.links = { SA8775P_SLAVE_LPASS_TOP_CFG,
-		   SA8775P_SLAVE_LPASS_SNOC,
-		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
-		   SA8775P_SLAVE_SERVICE_LPASS_AG_NOC
-	},
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_top, &qns_sysnoc,
+		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SA8775P_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_EBI1 },
+	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SA8775P_MASTER_CAMNOC_HF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SA8775P_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SA8775P_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_mdp0_0 = {
 	.name = "qnm_mdp0_0",
-	.id = SA8775P_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp0_1 = {
 	.name = "qnm_mdp0_1",
-	.id = SA8775P_MASTER_MDP1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp1_0 = {
 	.name = "qnm_mdp1_0",
-	.id = SA8775P_MASTER_MDP_CORE1_0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp1_1 = {
 	.name = "qnm_mdp1_1",
-	.id = SA8775P_MASTER_MDP_CORE1_1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf_cfg = {
 	.name = "qnm_mnoc_hf_cfg",
-	.id = SA8775P_MASTER_CNOC_MNOC_HF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SERVICE_MNOC_HF },
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf_cfg = {
 	.name = "qnm_mnoc_sf_cfg",
-	.id = SA8775P_MASTER_CNOC_MNOC_SF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SERVICE_MNOC_SF },
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_sf },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SA8775P_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
-	.id = SA8775P_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SA8775P_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = SA8775P_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SA8775P_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &service_nsp_noc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SA8775P_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_HCP_A, SLAVE_CDSP_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_hcp, &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qhm_nspb_noc_config = {
 	.name = "qhm_nspb_noc_config",
-	.id = SA8775P_MASTER_CDSPB_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SERVICE_NSPB_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &service_nspb_noc },
 };
 
 static struct qcom_icc_node qxm_nspb = {
 	.name = "qxm_nspb",
-	.id = SA8775P_MASTER_CDSP_PROC_B,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SA8775P_SLAVE_HCP_B, SLAVE_CDSPB_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_nspb_hcp, &qns_nspb_gemnoc },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SA8775P_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SA8775P_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = SA8775P_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SA8775P_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SA8775P_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
-	.id = SA8775P_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SA8775P_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SERVICE_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_snoc },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SA8775P_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SA8775P_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SA8775P_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_A1NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SA8775P_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_A2NOC_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SA8775P_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SA8775P_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SA8775P_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup3_core_slave = {
 	.name = "qup3_core_slave",
-	.id = SA8775P_SLAVE_QUP_CORE_3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SA8775P_SLAVE_AHB2PHY_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SA8775P_SLAVE_AHB2PHY_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = SA8775P_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy3 = {
 	.name = "qhs_ahb2phy3",
-	.id = SA8775P_SLAVE_AHB2PHY_3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_anoc_throttle_cfg = {
 	.name = "qhs_anoc_throttle_cfg",
-	.id = SA8775P_SLAVE_ANOC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SA8775P_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SA8775P_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
-	.id = SA8775P_SLAVE_BOOT_ROM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SA8775P_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
 	.name = "qhs_camera_nrt_throttle_cfg",
-	.id = SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SA8775P_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_compute0_cfg = {
 	.name = "qhs_compute0_cfg",
-	.id = SA8775P_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CDSP_NOC_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_compute1_cfg = {
 	.name = "qhs_compute1_cfg",
-	.id = SA8775P_SLAVE_CDSP1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CDSPB_NOC_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nspb_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SA8775P_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SA8775P_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SA8775P_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
-	.id = SA8775P_SLAVE_CPR_NSPCX,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SA8775P_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SA8775P_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display0_cfg = {
 	.name = "qhs_display0_cfg",
-	.id = SA8775P_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display0_rt_throttle_cfg = {
 	.name = "qhs_display0_rt_throttle_cfg",
-	.id = SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display1_cfg = {
 	.name = "qhs_display1_cfg",
-	.id = SA8775P_SLAVE_DISPLAY1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display1_rt_throttle_cfg = {
 	.name = "qhs_display1_rt_throttle_cfg",
-	.id = SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emac0_cfg = {
 	.name = "qhs_emac0_cfg",
-	.id = SA8775P_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emac1_cfg = {
 	.name = "qhs_emac1_cfg",
-	.id = SA8775P_SLAVE_EMAC1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gp_dsp0_cfg = {
 	.name = "qhs_gp_dsp0_cfg",
-	.id = SA8775P_SLAVE_GP_DSP0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gp_dsp1_cfg = {
 	.name = "qhs_gp_dsp1_cfg",
-	.id = SA8775P_SLAVE_GP_DSP1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpdsp0_throttle_cfg = {
 	.name = "qhs_gpdsp0_throttle_cfg",
-	.id = SA8775P_SLAVE_GPDSP0_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpdsp1_throttle_cfg = {
 	.name = "qhs_gpdsp1_throttle_cfg",
-	.id = SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg = {
 	.name = "qhs_gpu_tcu_throttle_cfg",
-	.id = SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SA8775P_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = SA8775P_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SA8775P_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SA8775P_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SA8775P_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SA8775P_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_lpass_throttle_cfg = {
 	.name = "qhs_lpass_throttle_cfg",
-	.id = SA8775P_SLAVE_LPASS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SA8775P_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mxc_rdpm = {
 	.name = "qhs_mxc_rdpm",
-	.id = SA8775P_SLAVE_MXC_RDPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SA8775P_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SA8775P_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_rsc_cfg = {
 	.name = "qhs_pcie_rsc_cfg",
-	.id = SA8775P_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg = {
 	.name = "qhs_pcie_tcu_throttle_cfg",
-	.id = SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_throttle_cfg = {
 	.name = "qhs_pcie_throttle_cfg",
-	.id = SA8775P_SLAVE_PCIE_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SA8775P_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SA8775P_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pke_wrapper_cfg = {
 	.name = "qhs_pke_wrapper_cfg",
-	.id = SA8775P_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SA8775P_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
-	.id = SA8775P_SLAVE_QM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
-	.id = SA8775P_SLAVE_QM_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SA8775P_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SA8775P_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SA8775P_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup3 = {
 	.name = "qhs_qup3",
-	.id = SA8775P_SLAVE_QUP_3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sail_throttle_cfg = {
 	.name = "qhs_sail_throttle_cfg",
-	.id = SA8775P_SLAVE_SAIL_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SA8775P_SLAVE_SDC1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SA8775P_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_throttle_cfg = {
 	.name = "qhs_snoc_throttle_cfg",
-	.id = SA8775P_SLAVE_SNOC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SA8775P_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SA8775P_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tsc_cfg = {
 	.name = "qhs_tsc_cfg",
-	.id = SA8775P_SLAVE_TSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SA8775P_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SA8775P_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb2_0 = {
 	.name = "qhs_usb2_0",
-	.id = SA8775P_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SA8775P_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SA8775P_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SA8775P_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
 	.name = "qhs_venus_cvp_throttle_cfg",
-	.id = SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg = {
 	.name = "qhs_venus_v_cpu_throttle_cfg",
-	.id = SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg = {
 	.name = "qhs_venus_vcodec_throttle_cfg",
-	.id = SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SA8775P_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CNOC_DC_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qns_gpdsp_noc_cfg = {
 	.name = "qns_gpdsp_noc_cfg",
-	.id = SA8775P_SLAVE_GPDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_mnoc_hf_cfg = {
 	.name = "qns_mnoc_hf_cfg",
-	.id = SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CNOC_MNOC_HF_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf_cfg },
 };
 
 static struct qcom_icc_node qns_mnoc_sf_cfg = {
 	.name = "qns_mnoc_sf_cfg",
-	.id = SA8775P_SLAVE_CNOC_MNOC_SF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_CNOC_MNOC_SF_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf_cfg },
 };
 
 static struct qcom_icc_node qns_pcie_anoc_cfg = {
 	.name = "qns_pcie_anoc_cfg",
-	.id = SA8775P_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SA8775P_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_SNOC_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_cfg },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = SA8775P_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 16,
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SA8775P_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SA8775P_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SA8775P_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SA8775P_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SA8775P_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SA8775P_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SA8775P_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SA8775P_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_GEM_NOC_CFG },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SA8775P_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_GEM_NOC_CNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SA8775P_SLAVE_LLCC,
 	.channels = 6,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_LLCC },
+	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SA8775P_SLAVE_GEM_NOC_PCIE_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SA8775P_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc_2 = {
 	.name = "srvc_sys_gemnoc_2",
-	.id = SA8775P_SLAVE_SERVICE_GEM_NOC2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_gp_dsp_sail_noc = {
 	.name = "qns_gp_dsp_sail_noc",
-	.id = SA8775P_SLAVE_GP_DSP_SAIL_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_GPDSP_SAIL },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gpdsp_sail },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SA8775P_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SA8775P_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SA8775P_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SA8775P_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
-	.id = SA8775P_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_LPASS_ANOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_noc },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SA8775P_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SA8775P_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SA8775P_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SA8775P_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc_hf = {
 	.name = "srvc_mnoc_hf",
-	.id = SA8775P_SLAVE_SERVICE_MNOC_HF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_mnoc_sf = {
 	.name = "srvc_mnoc_sf",
-	.id = SA8775P_SLAVE_SERVICE_MNOC_SF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_hcp = {
 	.name = "qns_hcp",
-	.id = SA8775P_SLAVE_HCP_A,
 	.channels = 2,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SA8775P_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_COMPUTE_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc0 },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SA8775P_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_nspb_gemnoc = {
 	.name = "qns_nspb_gemnoc",
-	.id = SA8775P_SLAVE_CDSPB_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_COMPUTE_NOC_1 },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc1 },
 };
 
 static struct qcom_icc_node qns_nspb_hcp = {
 	.name = "qns_nspb_hcp",
-	.id = SA8775P_SLAVE_HCP_B,
 	.channels = 2,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node service_nspb_noc = {
 	.name = "service_nspb_noc",
-	.id = SA8775P_SLAVE_SERVICE_NSPB_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SA8775P_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SA8775P_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SA8775P_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SA8775P_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SA8775P_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
@@ -2113,6 +1841,7 @@ static const struct qcom_icc_desc sa8775p_aggre1_noc = {
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -2140,6 +1869,7 @@ static const struct qcom_icc_desc sa8775p_aggre2_noc = {
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
@@ -2164,6 +1894,7 @@ static const struct qcom_icc_desc sa8775p_clk_virt = {
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const config_noc_bcms[] = {
@@ -2269,6 +2000,7 @@ static const struct qcom_icc_desc sa8775p_config_noc = {
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const dc_noc_bcms[] = {
@@ -2285,6 +2017,7 @@ static const struct qcom_icc_desc sa8775p_dc_noc = {
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const gem_noc_bcms[] = {
@@ -2321,6 +2054,7 @@ static const struct qcom_icc_desc sa8775p_gem_noc = {
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const gpdsp_anoc_bcms[] = {
@@ -2339,6 +2073,7 @@ static const struct qcom_icc_desc sa8775p_gpdsp_anoc = {
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(gpdsp_anoc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
@@ -2362,6 +2097,7 @@ static const struct qcom_icc_desc sa8775p_lpass_ag_noc = {
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
@@ -2379,6 +2115,7 @@ static const struct qcom_icc_desc sa8775p_mc_virt = {
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
@@ -2411,6 +2148,7 @@ static const struct qcom_icc_desc sa8775p_mmss_noc = {
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const nspa_noc_bcms[] = {
@@ -2431,6 +2169,7 @@ static const struct qcom_icc_desc sa8775p_nspa_noc = {
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
 	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
@@ -2451,6 +2190,7 @@ static const struct qcom_icc_desc sa8775p_nspb_noc = {
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
 	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
@@ -2468,6 +2208,7 @@ static const struct qcom_icc_desc sa8775p_pcie_anoc = {
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
 	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static struct qcom_icc_bcm * const system_noc_bcms[] = {
@@ -2496,6 +2237,7 @@ static const struct qcom_icc_desc sa8775p_system_noc = {
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+	.alloc_dyn_id = true,
 };
 
 static const struct of_device_id qnoc_of_match[] = {
-- 
2.43.0


