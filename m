Return-Path: <linux-pm+bounces-18096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562999D8B88
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7F1166886
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4A1B4F24;
	Mon, 25 Nov 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bcw0hXGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EB2A1BB;
	Mon, 25 Nov 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556739; cv=none; b=afpcgAszks2OwN1kyQnYBSSOqf+YaChW7R30xg8z7BuoG6mC9BSqNlOmKxKmt5VWQTsAhj19XhrTWxiuBFiVRZJmeuY9v01JOHglXO7k2YewcRjQZvFAj9rN4hlr0/8DKxStuMyGDKUMoq5Ko2OmLx4xkIgm44VTgCEiols1flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556739; c=relaxed/simple;
	bh=T9fVaT+0crdQGN5Ke4mNVRBXg3jKEtGHXAOxNToizak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VveY4zfdCJ/rBNHfzQsWvmsY84EPc6BckRTDjXxBBlAAbJV0QEyai51PRoFq2QlasSV3PITvaoOMhRoylIF1vrzXMvtRJui2J/smTkdS/fPWRO7DKCgWIMlVruAS3h9E0Wz0quQ344LzcBz0C1xf0e29uYdxRLk8a+BGTTZrZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bcw0hXGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBI4er006014;
	Mon, 25 Nov 2024 17:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W0PykMQ/fsXhY7K98PI6/8
	vSG5xM41Hr4sbjk5al7+0=; b=bcw0hXGc0NkP682gl5SD9/dGb4ILXR8tqEdJYW
	tFcbD8Ky0B5luHTuZe++oEm5+rjo763oTwrY30dzanbPvNtf4fbVM1GAV+KqwR9q
	m8H0kJcxtWkfkuPnZIPQeKu+2/q+oG/TX0yAnl53ZiPpNMngv+1kCsf/hT0doFu+
	M1uM5zt5N6+cecCH0VXLirD3WqMGEyEuifrGw7Mnre2uhUl9ZzR5I3GtDTD5relj
	o7K+5SEyvVdsVSSTbCpaedmdoGRamIk7j6qoWth9sHqeAVY4d/KwsZfk7KJrynRV
	IVTOLctEuQAdeSc0Z2RMJiuNTgIMt0LqLh6D9RucBjxHsBRg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfnp1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APHjVWg032572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:31 GMT
Received: from 4215f72c9660.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 09:45:27 -0800
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
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 0/4] Add EPSS L3 provider support on SA8775P SoC
Date: Mon, 25 Nov 2024 17:45:07 +0000
Message-ID: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: eCLmpnNKbUEHKE9gW5-IJoyI5p0hvRKW
X-Proofpoint-ORIG-GUID: eCLmpnNKbUEHKE9gW5-IJoyI5p0hvRKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250147

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

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

Raviteja Laggyshetty (4):
  interconnect: qcom: Add multidev EPSS L3 support
  interconnect: qcom: osm-l3: Add generic compatible for epss-l3-perf
  dt-bindings: interconnect: Add generic compatible qcom,epss-l3-perf
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider

 .../bindings/interconnect/qcom,osm-l3.yaml    |  7 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  2 +-
 drivers/interconnect/qcom/osm-l3.c            | 86 ++++++++++++++-----
 5 files changed, 90 insertions(+), 26 deletions(-)

-- 
2.39.2


