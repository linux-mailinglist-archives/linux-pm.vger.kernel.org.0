Return-Path: <linux-pm+bounces-16498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBA9B181B
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C08B214C1
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD91D63DA;
	Sat, 26 Oct 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i76+XeSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2901D61A2;
	Sat, 26 Oct 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945883; cv=none; b=OBo6YRTmH3UMUf4xyh63jwUM8ChfwJK1Mi6PMhQtOyOoRWH/GOXRqvUKdqzZTXyi9m/Ka/p+NlkIl+kcQyszvCm7MkpcNX6qn3P7yCqEqW75tP6A+Ig21kHZ/G4vgBObTxrGGais85qFaxV76wU1qxHQLsgvG10jqkFdI4dJaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945883; c=relaxed/simple;
	bh=S7HLmAAu8p0XUqTIKqRpICjoCy4W3zPLaoniMAtpTSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHeSiA0nD7exl4gqx70GjuVXc3nfQ1Sa84KDsuOcATCSIFf+hARPXXjt4cVIn2arP4Ip86sJdtExPoKUqeQWHTaYerA/giYsfeSyT6wCAp67iro2rOJ4reMVPtBQ9H4msL15eTnJ7dkPYXl2XOf+Cc1MwXN90+vBgdP5uaNwGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i76+XeSt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4Fp8w029417;
	Sat, 26 Oct 2024 12:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=otm6w+EPp6iLl+M3Oq4s0e
	Od2RpRt4rcgDL94HhHkpI=; b=i76+XeSt9h37qp7SfvGz86QzJww4EW2VS3+MXw
	8FMRsT7woGfYE8Cfq/cnOLstD8ZNASso2P+EqEtP491pFVlNimwnFllaToLbTJ/a
	SH2pl724LreSDYEVrTpjYkY/j63yWIUfi5jh233QwicYBcpKxU/NL70/ZlPkxwjb
	hmFmavMEnj0LoPjQxANRqKrvgoDDYThYApBffQTlPn7wTct03s0dAqmt9/HEXA3I
	1owkZ3BtIDBEyyBufDBOeVknvtUXrW1nzRRYHhYbp5JuCq5MmM5aaKUuJkyj1XhL
	MVtxuw59AzCdv23M6pZGIM+gnhHrq1Ewd3+TWRT6ctph7lJQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe5ryf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 12:31:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49QCVG7c001318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 12:31:16 GMT
Received: from 55f3af46090c.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 26 Oct 2024 05:31:12 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/3] Add EPSS L3 provider support on SA8775P SoC
Date: Sat, 26 Oct 2024 12:30:55 +0000
Message-ID: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: 6wZNPTUNQIUiXPlQHaWDasBTKJHEQbyL
X-Proofpoint-ORIG-GUID: 6wZNPTUNQIUiXPlQHaWDasBTKJHEQbyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260106

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Changes since v1:
 - Avoided the usage of static IDs and implemented dynamic ID assignment
   for icc nodes using IDA.
 - Withdrew separate compatibles for cluster0 and cluster1.
 - Added new generic compatible "qcom,epss-l3-perf" which can be
   used as fallback for all chipsets which support perf voting.

Raviteja Laggyshetty (3):
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
  interconnect: qcom: Add EPSS L3 support on SA8775P

 .../bindings/interconnect/qcom,osm-l3.yaml    |  4 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 ++++
 drivers/interconnect/qcom/osm-l3.c            | 86 ++++++++++++++-----
 3 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.39.2


