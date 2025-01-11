Return-Path: <linux-pm+bounces-20271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E9A0A498
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F15188B221
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E74192B63;
	Sat, 11 Jan 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j8QtUdTt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC082899;
	Sat, 11 Jan 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612096; cv=none; b=lmYnFsZVfHRI/8Ixhv7mfd5qvOcfnkWTEJvGtdDV0bc7FdfNbs/gi+uzSbYQie3YNNRhK9DsSrXhDBX9iTLUeLTKjLCXREApkdse07T0hAx8EVf/44ek801RLsCsZaGfC0EiCYW2BGppAq5m3vjErkW/g6JrlUzAl6+N2h7Si7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612096; c=relaxed/simple;
	bh=4BCNF1K5gTtzLMK6o3TysxdxJB/SU9lvn8Zp9GdSb1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRwAEmtkyUHwnn9E2jRA3JeGU+8ZaiE9xnwh8YRwHE0HV+OKQR8wCGQakeDECMknbc85dSO0aZ69NofOoIOaXyrV1eJTRb1+LrTXhnREMarw6wIRGmsV5kWtgEPEpqkExNOiasGLPdDNEBwGOF7NbGxzDNa6mSPWgUYBvkq94fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j8QtUdTt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50BDqUaR030543;
	Sat, 11 Jan 2025 16:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nvhPutBJiDRCgnRY3Qtk+K
	UVHKnWzw+UEKOTJOLWw5Q=; b=j8QtUdTtETBGXYVHcYGqx9XGKmIQ2GJwZBXdoC
	R06Nl5oIhVx6+PGkUWsyqiN+k3WQVHQwL+KBgR3PMJ0omq0s1W7FfFRApMHX5Lzz
	gIWGcixxy54Srfxn8cXbOnT4ZG69sZQIWoBEm34sWYxyZrjsblomg2c+tGU/bn7X
	nv9RhkC7g/2cmPj602/a07/suB1tVg8eIwHiJvbfLM5cPWsVKYZ4CqXC3kckJdNb
	fiz4/nb5KAFY6Cg4AAaA/Uj7bFIc5Ni0841EQdD9rDQuKL8GNUrXDoByizU1DX0e
	ipiKPLgeu/3TLfIryEVsA6tjRkwTYgDlI8sWZjyJc9sVtFrw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hx70rev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:14:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50BGEpjA005533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:14:51 GMT
Received: from 4206f847eb12.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 08:14:47 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdptipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [V7 0/5]  Add EPSS L3 provider support on SA8775P SoC
Date: Sat, 11 Jan 2025 16:14:24 +0000
Message-ID: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YK8JJJ7OeKc_JLW59iq-vL_21V-1WMnf
X-Proofpoint-ORIG-GUID: YK8JJJ7OeKc_JLW59iq-vL_21V-1WMnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110138

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Current interconnect framework is based on static IDs for creating node
and registering with framework. This becomes a limitation for topologies
where there are multiple instances of same interconnect provider. Add
icc_node_create_alloc_id() API to create icc node with dynamic id, this
will help to overcome the dependency on static IDs.

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

Raviteja Laggyshetty (4):
  interconnect: core: Add dynamic id allocation support
  interconnect: qcom: Add multidev EPSS L3 support
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 229 ++++++++++++++++++
 drivers/interconnect/core.c                   |  32 +++
 drivers/interconnect/qcom/osm-l3.c            |  91 +++++--
 include/linux/interconnect-provider.h         |   6 +
 5 files changed, 335 insertions(+), 24 deletions(-)

-- 
2.39.2


