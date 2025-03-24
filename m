Return-Path: <linux-pm+bounces-24471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A0A6E251
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 19:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7ED188E725
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970E4264A76;
	Mon, 24 Mar 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i9oG38dv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4286334;
	Mon, 24 Mar 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841151; cv=none; b=iwltm/PCiS5ypyz62X2inh13hDHdSCQLVXYUZJXh7PRONcTV9J29+LFHm68EKY4XpQG3f/dSYjt2Xp0o0cioaZO07ZUnEKSC0QH/dTH437USi2DqzJemrqm/a4poF2cUsudcn7iPles5FO2aNqajHv6Unw1g9oizMLjD2DJQ5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841151; c=relaxed/simple;
	bh=f1USm1Z03QEpQEnY/ASY10LS6grKhuWvY35gLpR3JX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7HhxH9LpwSNW0Ed8ZTjJUG/sftg4F6P7D8hS95KybPEKm8YKRnciPUk4wnnypIuZ9UEu/80Y4bSIiDZXD4zVOCWkGqCS+8qJA01WVWk/7CkbGoFCXlxokZK80OVcZgVAFQB+eF+SK+/Rkd0iEHD45TJbQJZ268xJwOx3q8B3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i9oG38dv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PQAU018018;
	Mon, 24 Mar 2025 18:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TXgMcowWnNTFQX4lNoQBGp
	nfi3+MvRFOzzseBxcnPDM=; b=i9oG38dvvqcXK6w8GJaewF2qR9wrD/1+3xs9Ph
	1qdhWEXIZo7XaaiZaAyrL4MoJezEGsjb2JVpltO130papzboyCxrI5rYQHq0AV/B
	QiK4+E4Ny+/C72f5ZPzU5gXDCffSdOmT9hzZfv+jNGqSPV+RlEUKf26XjnPMaCCM
	O5mxbEon2fVsUf7hrxIFSbnSlQdQMEcHmHhsSTYGdyIhO8Y4b11n/Y76YNHG3WLy
	jtAG3H4lTWlaye0bXI2nT+DVUAlUeYqyUTcex5UjU9xgPSB25ol2Anq9OXqAEnbP
	ygoMlbA72lEg4oPaQgJHKSuyp6siIIgUPv9LdRQw9zNlFuBg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hne5w975-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:32:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52OIWPsE022617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:32:25 GMT
Received: from 6cb0ec70778b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Mar 2025 11:32:21 -0700
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
Subject: [PATCH V10 0/7]Add EPSS L3 provider support on SA8775P SoC
Date: Mon, 24 Mar 2025 18:31:56 +0000
Message-ID: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: Q0NapzANP2xhE55MepcvkqFgf562AEPx
X-Proofpoint-ORIG-GUID: Q0NapzANP2xhE55MepcvkqFgf562AEPx
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=67e1a53a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=MOw52E1g2SAjk1dFLq8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240132

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Current interconnect framework is based on static IDs for creating node
and registering with framework. This becomes a limitation for topologies
where there are multiple instances of same interconnect provider.
Modified interconnect framework APIs to create and link icc node with
dynamic IDs, this will help to overcome the dependency on static IDs.

Change since v9:
 - Renamed macro ALLOC_DYN_ID to ICC_ALLOC_DYN_ID.
 - Added APIs icc_node_create_dyn() and icc_link_nodes() for node 
   creation with dynamic ID allocation and linking.
 - To optimize the memory, declared the link nodes as double pointer
   "struct qcom_icc_node **link_nodes" instead of array of pointers 
   "struct qcom_icc_node *link_nodes[MAX_LINKS]".
 - Added struct icc_node as member in struct qcom_icc_node to help in
   tracking the node creation and avoid duplicates.

Change since v8:
 - Moved the macro ALLOC_DYN_ID to interconnect.h header.
 - Declared back the array of pointers and global structs as const in
   L3 driver.
 - Separated node creation and node linking in EPSS L3 driver probe, 
   cleaned up unused variables id, links and num_links.
 - Dropped the opp labels for CPU OPP entries and used 
   (clockrate * buswidth) convention as per review comments.

Change since v7:
 - Updated interconnect framework APIs icc_node_create() and
   icc_link_create() to dynamically allocate IDs for interconnect nodes
   during creation.
 - Moved naming conventions to the framework and replaced snprintf() with
   devm_kasprintf() as suggested.
 - Updated the icc-rpmh driver and SA8775P SoC provider driver to support
   dynamic ID allocation.
 - Revised commit text to explain the use of the existing generic 
   compatible "qcom,epss-l3".
 - Addressed other comments regarding the alphabetical ordering of 
   compatible properties.

Change since v6:
 - Added icc_node_create_alloc_id() API to dynamically allocate ID while
   creating the node. Replaced the IDA (ID allocator) with
   icc_node_create_alloc_id() API to allocate node IDs dynamically.
 - Removed qcom,epss-l3-perf generic compatible as per the comment.
 - Added L3 ICC handles for CPU0 and CPU4 in DT, as per Bjorn comment.
   Link to comment:
   https://lore.kernel.org/lkml/ww3t3tu7p36qzlhcetaxif2xzrpgslydmuqo3fqvisbuar4bjh@qc2u43dck3qi/

Change since v5:
 - Reused qcom,sm8250-epss-l3 compatible for sa8775p SoC.
 - Rearranged the patches, moved dt changes to end of series.
 - Updated the commit text.

Changes since v4:
 - Added generic compatible "qcom,epss-l3-perf" and split the driver
   changes accordingly.

Changes since v3:
 - Removed epss-l3-perf generic compatible changes. These will be posted
   as separate patch until then SoC specific compatible will be used for
   probing.

Changes since v2:
 - Updated the commit text to reflect the reason for code change.
 - Added SoC-specific and generic compatible to driver match table.

Changes since v1:
 - Removed the usage of static IDs and implemented dynamic ID assignment
   for icc nodes using IDA.
 - Removed separate compatibles for cl0 and cl1. Both cl0 and cl1
   devices use the same compatible.
 - Added new generic compatible for epss-l3-perf.

Jagadeesh Kona (1):
  arm64: dts: qcom: sa8775p: Add CPU OPP tables to scale DDR/L3

Raviteja Laggyshetty (6):
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  interconnect: core: Add dynamic id allocation support
  interconnect: qcom: Add multidev EPSS L3 support
  interconnect: qcom: icc-rpmh: Add dynamic icc node id support
  interconnect: qcom: sa8775p: Add dynamic icc node id support
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 229 +++++
 drivers/interconnect/core.c                   |  83 +-
 drivers/interconnect/qcom/icc-rpmh.c          |  17 +-
 drivers/interconnect/qcom/icc-rpmh.h          |   5 +
 drivers/interconnect/qcom/osm-l3.c            |  36 +-
 drivers/interconnect/qcom/sa8775p.c           | 952 +++++++-----------
 include/linux/interconnect-provider.h         |  12 +
 include/linux/interconnect.h                  |   3 +
 9 files changed, 705 insertions(+), 633 deletions(-)

-- 
2.43.0


