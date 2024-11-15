Return-Path: <linux-pm+bounces-17614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821299CDCD8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493A62827CB
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF71B85F8;
	Fri, 15 Nov 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UXvI9o5H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75E1B4F2F;
	Fri, 15 Nov 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667259; cv=none; b=GNK4Ro3HwmLOC8NuyGZ8Xnsh7+TlfROwWRMDLb1ZmFSbeNotlxEHrBeLVN3UoMArnMACyMbQt6S6by4CWvHskncLJX/KMPt79NC+aTIuvV9fjxD7gN/ZlePEL/nbe2vAzjoLWqwNmpF9VSUdB0WQYQj/1p9Hh3utAc9Bsz5yn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667259; c=relaxed/simple;
	bh=1PKvv3LbeCAGUglm3YzCKZxWqmlBWeiGkLDSuSwnsVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpV9BsFZinbMgbAvlYmxn39rsGo0yw8nnqRyljbGppH1ei3Us5HTWpyrlxIxtB7g0TOq8zMYDe8n0+raA8Wp9x2YglUX/VEp6B7llZE3ryu4orXKGJy9fZ5zSqTzb3+JAcxw+77SNIm2ykStHK7vGZpGRe6riF9Hrbp7RxfR2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UXvI9o5H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF2IWIe012771;
	Fri, 15 Nov 2024 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gGg/sc8LCJO5nirmdZWHEbP/oaVVWNUFohfqZcBusO8=; b=UXvI9o5H02vnTqtO
	n/t2r8IKJPtm44Ge6lnu9ay84U/HckwHgIFKi3MfqyOXLxjDX+mfKG7oTibI52WK
	y1SXL0nsFKry78psb84RlxM3AQSTsQFYLi/NnzoiOgxGrqJnwT8tiNfh0SdEG6MF
	gAljT3J12NcZ12l8/QalhpXD0j3PaNyLxG9JsVLGhARyWH4xQmd9RcvkeBrVl9jP
	gODMil33NTBxz2a6xIJMeCECg+sKnDgZXY6xwBiKk6U5P2QWAEQSe2G/CE3FSsdk
	NkzIem6lMaxYPSKSgKR6hGslxHgQd/HnwhdrgJkKncLPEkRinU3cBmzv/VfcIdqV
	yZGUcA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wwdd9832-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAeo5A012364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:50 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:40:45 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 2/7] dt-bindings: nvmem: Add compatible for IPQ5424
Date: Fri, 15 Nov 2024 16:09:52 +0530
Message-ID: <20241115103957.1157495-3-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d2BU0ntuz6-EmA1CWchvCXAoWiVqRor0
X-Proofpoint-ORIG-GUID: d2BU0ntuz6-EmA1CWchvCXAoWiVqRor0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090

Document the QFPROM block found on IPQ5424

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V8:
	- No change.

 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae4..507671a75cb7 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq5332-qfprom
+          - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
           - qcom,ipq8064-qfprom
           - qcom,ipq8074-qfprom
-- 
2.34.1


