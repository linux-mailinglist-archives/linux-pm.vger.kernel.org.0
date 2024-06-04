Return-Path: <linux-pm+bounces-8548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE638FA75A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 03:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C987D1C234E1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 01:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F37D524;
	Tue,  4 Jun 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lUXSKbLJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FFB676;
	Tue,  4 Jun 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463599; cv=none; b=HlzIU8/KGcD1VQiJywtr0IGjRWdpmIkIlEJDPrE+epPsQhV74BXpd6I/VTWFTFRmpleGw0goyAuoIblImrox5dcBga827gfKHySld+WcJETmILDOQBLXRHvjHJMqiqFksQkLPKlbo1/Mz658m8axXfslDIKFIRTRmNAfDquMT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463599; c=relaxed/simple;
	bh=jztKnnlHdZ0d5U7J26a873QAPkRWX0J2JKqleIiDpXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYIlJObi9iEG+08iMKQ8ixYhwb98VRndoajqCDDhsvfZ67DDvnZH2k4leLuFiaBFi71/Q5MbQBSlOK3mavNixG0EIIbawl/d3Rdgh5zaiF/1R66VlDx6Jsc/PeDzRcEOI3LyukDHTYoluEb4WEWi8tuQVE0IvddgJ8Ak+FJ+LAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lUXSKbLJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453CGM3E028674;
	Tue, 4 Jun 2024 01:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgu+d5dPRwrokhzDKM/ctW6lufP8HCeLXFdMNcJSK+I=; b=lUXSKbLJRM2Co1Nh
	q7GApxKpWeCsPdtmhV8ZJeiVmnGTkP4AYRuoknImPbOsW7if02vxZPDBTlPbYjT5
	6957l3o55huJ2Rz5NY8I2f4U7d9HSr6TngWIAszRda3cw/zzBH/sz8IeUYh9nqOR
	nYhdA2IlH4aSbd+YHPrm1xMDReilrq+HHmEqeECVK9hByr0nw2i4PaHbbbl0wadh
	AsSU/qaxn89nRRgXaPRYRTlIO4VgnU2x3MdfGQpc71vq13MW1ZpzOnyx3J2C2GPe
	06KfKIQPrH91PtNCYWIHA971mcFtSw9Qxdsa7gj3y7dtgh0Vh5ZlllAUHCnxI+jL
	484RGg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t55j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 01:13:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4541DCrp012450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 01:13:12 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 18:13:07 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON instances
Date: Tue, 4 Jun 2024 06:41:54 +0530
Message-ID: <20240604011157.2358019-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604011157.2358019-1-quic_sibis@quicinc.com>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QHaZdCR_blpBm4C63wfQ2rnQZEAJhwJZ
X-Proofpoint-GUID: QHaZdCR_blpBm4C63wfQ2rnQZEAJhwJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040008

Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
path.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 05067e197abe..05f6bd348138 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
               - qcom,sm8650-cpu-bwmon
+              - qcom,x1e80100-cpu-bwmon
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
@@ -44,6 +45,7 @@ properties:
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon
               - qcom,sm8650-llcc-bwmon
+              - qcom,x1e80100-llcc-bwmon
           - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
-- 
2.34.1


