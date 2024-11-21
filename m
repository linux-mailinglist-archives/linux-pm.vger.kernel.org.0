Return-Path: <linux-pm+bounces-17850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0A9D4BE9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 12:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991032839E4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344A1D0B8B;
	Thu, 21 Nov 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B8VpjR/s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B21CACDB;
	Thu, 21 Nov 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188634; cv=none; b=f13d+Sx4E7j+uRxtvet70LiJaS3t3Xn6ybxIyEL6iCuAuxBAn6boh89nvw3SsYebbUzXyTV7UyqUxw5o6kDesX7crO79DbgXRXMZq9DuXPhSHrsL+jNWo3LT5cWn74lRc732WQBd96JR0jH98JVYc37lueNtirRH+CkCCpktEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188634; c=relaxed/simple;
	bh=UMreKP+v6tu8224jbuZZ9nmRAyt4+ugjB6wJMYoK2JM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQPFyLjSZJkrERpgTdBXD/tXxigd5ex3uoNKuPqYzwdjOsj0jPRS4h9pcFcstZkG8zEhFepABhJxXwKaBoVffVZt+M7Cnyd9kAgZ9CCnPf6inhZndgiikYRjg1+FtPZ7b9FdRSv+yGvthQ/+23K3Ma7QHr1h3XrSeV/9N7pO68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B8VpjR/s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8wTct007659;
	Thu, 21 Nov 2024 11:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MnhtH4MUV/BFBOZDW/xgAP
	on4gBnsNZB1HJShLjHV0g=; b=B8VpjR/sJVtA6lvUS5pd/H6maJ5QzBF3k48Fct
	4qa+aJt5QppezquHgt8gFjrfTfKYp3w4G4fAtUMGfzal+kfwxRRduoZXm2bq4d05
	Gohrg/qy68ddEc5yjQXYNfeROWxbkgNb5EAeGU3q5hmXtEc0BjywuEWBK+kFso4P
	DFxjoIIHRO2nk+bbK87U6WVEkgQrbDprRkJTtxFSJvRc5cKe4nxs7vvp7DiSLyrg
	FClQc6GJEhW3ptO6iYW3TygzQ3Hs4i9UY8u2iB4ImARvs8iHKfoiN2y1MdhZzUjo
	cryQyG7anZ8DlNa56Q9m8Iz285Gi1mKxZ2qbAdy16CPj8Gtg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4318uvmckg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALBURHb019461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:27 GMT
Received: from 41ee23f3c785.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 03:30:22 -0800
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
Subject: [PATCH V5 0/4] Add EPSS L3 provider support on SA8775P SoC
Date: Thu, 21 Nov 2024 11:30:02 +0000
Message-ID: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wTvJruUlQZKCEfQCPGmLLWCPB-nKAssN
X-Proofpoint-GUID: wTvJruUlQZKCEfQCPGmLLWCPB-nKAssN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210090

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Changes since v4:
 - Added generic compatible "qcom,epss-l3-perf" changes.
 - Split the driver code into two patches, with one containing multidev
   support and other containing the compatible additions.

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
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
  interconnect: qcom: Add EPSS L3 support on SA8775P
  interconnect: qcom: osm-l3: Add epss compatibles for SA8775P SoC

 .../bindings/interconnect/qcom,osm-l3.yaml    |  4 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 ++++
 drivers/interconnect/qcom/osm-l3.c            | 87 ++++++++++++++-----
 3 files changed, 88 insertions(+), 22 deletions(-)

-- 
2.39.2


