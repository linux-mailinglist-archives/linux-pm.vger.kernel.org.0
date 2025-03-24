Return-Path: <linux-pm+bounces-24472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A451A6E254
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD329188E66C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F57264A94;
	Mon, 24 Mar 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EIqiI79y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF726159E;
	Mon, 24 Mar 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841160; cv=none; b=MglGvyKtPEkKrfCLBtgbM2dMXFa53pbvIE939zyyW7/yqsSTYeQDcPAtBP7CA6n0GgvvxkU393xBATQ/fwS8TEhCvM3wpfZYca+3vSLnvWvasx5T/MkbSPZFL6jR1emLIThd9bedXWydo4cVKFeq4kGSH8QJpvsmCYcnG53LOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841160; c=relaxed/simple;
	bh=ZpjANrkvsSnHCk6h/AbL6jM93e39NH50QwlC+ZXsiUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTcqkSbxhOeEF9d5VWQ4MehobQy2aeHeosqyEGn3P8Z3xrouUxk3R+GV19wgeXJwPSqYcmRq+7wr0sfhAfYz1l+wjlkBjuH44I7abAbRcc7/Jwmukqtqt1oca9OzE4HMfdTA5xWPokT9BFdTqX0RyKjuN9DmFH4K2PBSi9z97c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EIqiI79y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PUqH005056;
	Mon, 24 Mar 2025 18:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6tGP+sqFgniXRjVGKZE3XbgZS6XrIMuMCDwtYl/eIWM=; b=EIqiI79yx+jgOuOI
	WwLCTAqB+jTye6LRqOp0I2MuBVccIv+fKU0GCksIAxQvtZ5WKvfErypmWT8peYT5
	UWc/a7ZvDj3wZy+Z5p0Ey7sBhmGDOUcEG5DzXYSg07wg4xhuyJ/bCk66iLBNVWgW
	OpIVNmbUp4uRBr/pleTQLz1q0MVfDEau00lPlrv1qWqH5U4yU3OKtfI8Qp17NHEm
	DgwD+x3fHFsYzPDj/k6gXpV1bcpBQg4BMR4UA1xFCoMwis/BmEpbC5nsU1R5K16w
	9BxPUpDW2mxSWYB1TJ5F7/68bD4WWiBOz9mZig1AYVYTMgiU3TFK5vxTVFCDhFJ5
	w6zRZA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79ncbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:32:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52OIWXJt032421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:32:33 GMT
Received: from 6cb0ec70778b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Mar 2025 11:32:28 -0700
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
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH V10 1/7] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Mon, 24 Mar 2025 18:31:57 +0000
Message-ID: <20250324183203.30127-2-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: L0xrLeW63gqYqRQfKJIzBKkCMg6oBTcx
X-Proofpoint-ORIG-GUID: L0xrLeW63gqYqRQfKJIzBKkCMg6oBTcx
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e1a542 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=1I5iHLyJ9m56SxkymIEA:9 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240132

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.
The L3 instance on the SA8775P SoC is similar to those on SoCs
like SM8250 and SC7280. These SoCs use the PERF register instead
of L3_REG for programming the performance level, which is managed
in the data associated with the target-specific compatibles.
Since the hardware remains the same across all EPSS-supporting SoCs,
the generic compatible is retained for all SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 4ac0863205b3..cd4bb912e0dc 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -28,6 +28,7 @@ properties:
           - const: qcom,osm-l3
       - items:
           - enum:
+              - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3
               - qcom,sm6375-cpucp-l3
-- 
2.43.0


