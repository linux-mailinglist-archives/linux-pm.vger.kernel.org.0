Return-Path: <linux-pm+bounces-16942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD59BB4EB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A4BB250C3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C021B86CC;
	Mon,  4 Nov 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ELuohUq+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433401B85CA;
	Mon,  4 Nov 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724295; cv=none; b=UyTRsA5+C0Orzo2MUAs8iCmWvpoWP7ZUM6vamJFJImeCruta3F2IetiEgeY6mQ3NMHu1BdNMBlzuCH9AYN70n4BjTdlpEgYcptDd1OKqJ1a4Cim3yEH2YclqqdVLvZGs0hWdzwzTNDXZNV5MFrv4vBWgcc84mFXNYQB/HDz93k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724295; c=relaxed/simple;
	bh=TI/RDbkPtk+kkT4MgGbWG9dLvM7OXi+bNzRzfeg1poc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwyli/ZqCS73GBJji39Ax64tj3F7pGlYZ0BrYwzR9UIDT4LDzBM63mlTg5Fs1QqVOhVQwIZeBwQegZ+p5fgvoqOhfbulc87+0jRZmDBGt0kVJnk8vcLj/KoBTudrXhTQLgiYfMHdwW5r0LBmGfFV0kQ+zp6Dn/UtC7zkL2fY/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ELuohUq+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bj2Rg004768;
	Mon, 4 Nov 2024 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	spOyXe8kbSaok6CscC3jp3MLTht7E7vmIeAaARr3KN8=; b=ELuohUq+v7EWp1kY
	d/G4Ngv20iTyC4RsbsZef+/54pBTuXYAoO5prWNl/g1gFON0xHJHuqeELREkaIos
	+43FJgkke1n7acl4BRBFDllfY27EvaQ/cVFf9CeRHcypkwrfz/LNT6u2bxotj5XL
	MDKI9Osm0P8u7E0BSCQTqkO0OZR3uCfy1dojXSNxr9dgk3U4u5T6+xHNEmdBysfq
	wRZLFxKSmPtXOM1XRkFGSYWIkcjTYLDcypyM432P+16dT4+Llwj9/Rcnkyn32iqg
	90wucx2wMNwve6Dyui5Xt/G/wEyeqYnpiEIfldVpdM+Bh9EoDgsro18lWPIyVmiO
	lZHQ8w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2849bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:44:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4CijoM009774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 12:44:45 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 04:44:40 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
Date: Mon, 4 Nov 2024 18:14:07 +0530
Message-ID: <20241104124413.2012794-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CcFdRoznEhF0nOXygxD4IzA9obsouszP
X-Proofpoint-GUID: CcFdRoznEhF0nOXygxD4IzA9obsouszP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040111

From: Praveenkumar I <quic_ipkumar@quicinc.com>

The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
RPM is not available in these SoCs, hence adding new compatible
to have the sensor enablement and calibration function. Also add
nvmem-cell-names.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V6:
	- Remove the R-b tag because support for IPQ5424 has been added

 .../bindings/thermal/qcom-tsens.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc81955..c9570d647fea 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -73,6 +73,8 @@ properties:
 
       - description: v2 of TSENS with combined interrupt
         enum:
+          - qcom,ipq5332-tsens
+          - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
 
       - description: v2 of TSENS with combined interrupt
@@ -209,6 +211,18 @@ properties:
           - const: s9_p2_backup
           - const: s10_p1_backup
           - const: s10_p2_backup
+      - minItems: 8
+        items:
+          - const: mode
+          - const: base0
+          - const: base1
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
 
   "#qcom,sensors":
     description:
@@ -268,6 +282,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
+              - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
     then:
       properties:
@@ -283,6 +299,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
+              - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
-- 
2.34.1


