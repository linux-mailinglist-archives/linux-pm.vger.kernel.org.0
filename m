Return-Path: <linux-pm+bounces-23086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDA8A4838D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DB11888559
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B41A8402;
	Thu, 27 Feb 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AvHNtl9j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71519F10A;
	Thu, 27 Feb 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671562; cv=none; b=AucPPhNCBNSStG7UJpVRQUDVgfQcofipBq0PR5JgQ9UhVABkRzZj3p5BdMG0ZzWOdOymMh1AOF49iJUHDwz74EMzP4OOj+ZDaooMYeu+6o+UtAVMa+PYrZCbfdqe3MPG/PZkPY6ZiP2PotrE5ubpbfXmjQ4eXTmuy5Tt0Bsk9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671562; c=relaxed/simple;
	bh=H0/o7x/XMHrgbkQzVKya/hSYMW6AFkgHvBMDb+HCtmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijQbAAZfQQ0YkvUTKUkFqG/LU6YpU1l0YCsPG/tXMLbnhSnwwpNA1IqhgRlJUv26AKopeHXEwWDWsr4Z+wqFI2WbhtdUqcdzmUqit+K56XfJbYULMfrm9afyjIj2IZUfkqNSXpQqoOV2WlpYU9R+3NINMRCS/EZ7yHUGYGr8OG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AvHNtl9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8UlMI011698;
	Thu, 27 Feb 2025 15:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RrjxORoRGAIQCQvEW3xRH8
	uWUdQALoUxeJXNwJM2jto=; b=AvHNtl9jUJx7FsLoTtN1jPtaVbUXarWj2LHJdV
	qzN9gdDQR+Uqt0idKDyzqcApWx1iMCPh9hjIr83LBMCazy8UIbjDd6SytDCSMxwI
	AzRuv2xLmoy85gs6fMl/m3tgQtmzKpO11dEYjSQgEzBMiUKRaHeT/7qBI3XyVpEG
	8hYEnWwJJz7hoYrymT4nS7wNw7hfRwsYmAg1maIbPh+CgM6XGNLfEp7SbehojlKr
	yofxZpFyWo+gzgIvNpkE4PkjPxjxcFKt7CDwWiWj7JOVy09bWaaGhjzbLv/wAEYU
	oPbD4OrIfO888zMtS4y96chw7SNJT4zcle/HRE/6W4mmhOrA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prke883-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFqYVK018181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:34 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:52:30 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>
Subject: [PATCH V9 0/7] Add EPSS L3 provider support on SA8775P SoC
Date: Thu, 27 Feb 2025 15:52:06 +0000
Message-ID: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: iioeFWoL2n4rc7rx0S0EeFuUTD_E31sw
X-Proofpoint-ORIG-GUID: iioeFWoL2n4rc7rx0S0EeFuUTD_E31sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Current interconnect framework is based on static IDs for creating node
and registering with framework. This becomes a limitation for topologies
where there are multiple instances of same interconnect provider.
Modified interconnect framework APIs to create and link icc node with
dynamic IDs, this will help to overcome the dependency on static IDs.

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

 .../bindings/interconnect/qcom,osm-l3.yaml    |    1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  229 ++++
 drivers/interconnect/core.c                   |   13 +-
 drivers/interconnect/qcom/icc-rpmh.c          |   16 +-
 drivers/interconnect/qcom/icc-rpmh.h          |    3 +-
 drivers/interconnect/qcom/osm-l3.c            |   37 +-
 drivers/interconnect/qcom/sa8775p.c           | 1131 ++++++++---------
 include/linux/interconnect.h                  |    3 +
 8 files changed, 799 insertions(+), 634 deletions(-)

-- 
2.43.0


