Return-Path: <linux-pm+bounces-21428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81865A29905
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEED3AA56A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A21FECDC;
	Wed,  5 Feb 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IYEXCGmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4381FDA89;
	Wed,  5 Feb 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780096; cv=none; b=c88ntnwsqv37A9jj15D0rJHtHg6doO4mhhtIRtW5ySSM+X098UMUxoX4TQOxtS8Ue1nv3/joB8b6oTPCDgceOb/xjBZT/1jcG3ZPew59oFoNowsp9dKK5d/xFzNzANZ3zi1v8MUeyTT3WICwqqaeJW41dINXoXH6fuqgBfFQjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780096; c=relaxed/simple;
	bh=WIK77QSHrwjdjXP5YguhdLZZtWO37MnzcX3h68pNHDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsFNsKxlMWsClsTpLKag01mtEV/mN7trBWhD9W6NHRgDM4r8D2/q56ZjU4UldAek1AuZOFLP7m6SdgYTiNAYCtUIjKjFg4eOoWl+wVgNv9gpMu1djg6i3kkdvHSSLyY/+gxXFRbj1ys2qm/lIeDF4CXBUswFJAe5Ltt4krcc2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IYEXCGmN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515ErZnn011015;
	Wed, 5 Feb 2025 18:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wox7ET7OjT930xo72QvX45
	kqjJCIhhqSOwlX3tfnH80=; b=IYEXCGmNG6hONudpz33g2FBHXMJICjkmPr6Fnz
	8NN6ygTIr+we3IH5Alq8masAF/TpcUqLDE2LXSStauL+RuceqssK/mzCQQJJej0L
	we8T5IOZugRoKR0WO7OjISkWX/y9Nh0P4bygEcqcHe1hmcrrVQV9v9+C8nFyYS+7
	ROE+rLT+1cQjWhukKptfTB538MAtXSOTuvYFmNY+2vEQWwikksg+ZDq/8CLpRCq5
	VVXZ+DUaI77X1JXL8tRIPYyt4lKbel3d7U8TElMwUGURehecEHAerxusYczW+qS0
	dLb4hyWtwUnaroXaRchgFv2rdfw9mdGhpPwOwg+1vhV6M/AQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ma598jkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:28:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515IS74S016733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 18:28:07 GMT
Received: from c194c8e2f407.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 10:28:02 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        "Andrew Halaney" <ahalaney@redhat.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V8 0/7] Add EPSS L3 provider support on SA8775P SoC
Date: Wed, 5 Feb 2025 18:27:36 +0000
Message-ID: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
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
X-Proofpoint-GUID: IgTQUmUuDmjRCzOMCz8lzRAYCDFPBQkY
X-Proofpoint-ORIG-GUID: IgTQUmUuDmjRCzOMCz8lzRAYCDFPBQkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050141

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Current interconnect framework is based on static IDs for creating node
and registering with framework. This becomes a limitation for topologies
where there are multiple instances of same interconnect provider.
Modified interconnect framework APIs to create and link icc node with
dynamic IDs, this will help to overcome the dependency on static IDs.

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
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  229 ++
 drivers/interconnect/core.c                   |   13 +-
 drivers/interconnect/qcom/icc-rpmh.c          |   16 +-
 drivers/interconnect/qcom/icc-rpmh.h          |    3 +-
 drivers/interconnect/qcom/osm-l3.c            |   46 +-
 drivers/interconnect/qcom/sa8775p.c           | 2194 ++++++++---------
 7 files changed, 1246 insertions(+), 1256 deletions(-)

-- 
2.39.2


