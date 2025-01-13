Return-Path: <linux-pm+bounces-20385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F6A0C34C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8025169BB5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666101D5CFD;
	Mon, 13 Jan 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPBFK+We"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560F1B6CFF;
	Mon, 13 Jan 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802518; cv=none; b=eEngBvudHS4yrKHlXcpzwM/9yhiZgNYWm3uASUvf53a9ChpvWqQd301d7UFdiukeuwR7x2H3ZjV6iXTifMxUFgN66D4T8QuiQ2RYlUtrMVDCNH/gzJz+PSykFzXmAPUULwQyiTtD+EL/4yMH2whjZK9ragVdtCNsfDaa6RXSXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802518; c=relaxed/simple;
	bh=A+IKdBw49yBMKZPgoOYixuhn42JSyN/bGCueE6lEQR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q8GhBv82YptppYYSYhN7EJG5C7Eak6AN4VtmUMJadIjSK3XKeBX4el8/FAEq9NPqj23GKC7sb8PzWQu/yL39H2DvxrIaBnCGK9qzdxOLl2UmJWEGhdIfoAVmJnCOfx2uzB221Ne8usk7r5WLGuqdWtwhbUAcui0b6qMPmAMAW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPBFK+We; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIixqk007959;
	Mon, 13 Jan 2025 21:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45bJIDsHtBaxppaN+h9fJL0A4+mfBqdfzShHQp4+jg8=; b=HPBFK+WetlFsy39F
	9HK7PtEEAPbA/P5ygOJFzUjozRJr3nRIQ3EPQNAPYbhdQB+s0kI151H7shbzhQbd
	S/hQ/TuVGsGIH6cVJRazIdQXFzyJ5ng/b5zqP1CfCRht05NNjLHW+rB4yY7w0xLJ
	ZQEibTdp1Qa6TJm39+3PUONkKipH2Rt3wfvU8ycxyMjdOLPaHemDdBZV2bP627HC
	DfsPMgXcn5FK7L9Q6j6qL3M58KFD/+o8tTVFj0sUjrFtPMtabw48rl/7QadMa4gx
	YG1PH8IRrRWRnEEtqNiuH4yWaaQEWWnrTSGT4zSQ3Dy1rR/1i0rMVpVUcrUpaTEf
	fpZBaA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4458cn09vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 21:08:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50DL8RLC021213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 21:08:27 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 Jan 2025 13:08:26 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Date: Mon, 13 Jan 2025 13:08:17 -0800
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM8750 CPU BWMONs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250113-sm8750_bwmon_master-v1-1-f082da3a3308@quicinc.com>
References: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
In-Reply-To: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Satya
 Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736802506; l=1069;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=3EX5RrjviP6mkyRjEaJp+3ZCIImrKPpFxESTEklVp8A=;
 b=t2VFEpaG2eY4MAGEGMXiYfsODri+xXA6JfneYNU2kY1S0nc75+vItz2dyY5LN8raj0YRmLaf2
 uLmS5iNFE5IBQhLxDapWNF40Vle9KPfkkj8T0XVxZtLinWqksXVonO9
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AckiseQRXi2xmzvesQYeNPGXQXIFgeCi
X-Proofpoint-GUID: AckiseQRXi2xmzvesQYeNPGXQXIFgeCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130168

From: Shivnandan Kumar <quic_kshivnan@quicinc.com>

Document the SM8750 BWMONs, which has one instance per cluster of
BWMONv4.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff24b5ee2c6613ba71f8c5f840e77226131edc3e..83bcf0575cd372926102e2764055c3576822c915 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
               - qcom,sm8650-cpu-bwmon
+              - qcom,sm8750-cpu-bwmon
               - qcom,x1e80100-cpu-bwmon
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:

-- 
2.46.1


