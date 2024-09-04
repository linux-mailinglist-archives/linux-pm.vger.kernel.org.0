Return-Path: <linux-pm+bounces-13607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0996C500
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AD51F26788
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67931E1339;
	Wed,  4 Sep 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XO6fBVLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303061E1327;
	Wed,  4 Sep 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469967; cv=none; b=Ud5x5DlWH20mXZG+R3xXZLdGpZTleHeqVLwHuW7+oe4d+kSL1O45xqyoEwoSMl/ClqX4L2G+MOiwPJOxepGtg+xk6bTvmMgedL5KadRV0f808aaOtGQqPp6fWE9Xtiwcl41KRygn5Uhd++e4nxYaaUNgQNk8B/AWzsA9GP8ObLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469967; c=relaxed/simple;
	bh=csfcuSio0Z+/gzpclygn21dGMeVU5TL3QNs0Q1Wf0RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+oajNWYNFLx8TEYhfVlIHArPE65kcKj7fDUue4eK3azU61bcubeqFuMDSJdbSYfRZQ+NrOihK4JbHmWWeKNWQpAUshcf5vj9bUcX+aTn673s3FhLctVwFV/t4CQ7ttbaAX+NNW15A8MhF2Ii1fR7Mb57nB47NOMWgXzumeHV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XO6fBVLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849ukOS006493;
	Wed, 4 Sep 2024 17:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CGFB8WsVupyzyKs5ZyBmTQ/TphBBa/wbLc7BHwWhTbE=; b=XO6fBVLU2uNSFKWO
	IYuktQycR7ALs1MyIMMCG4D5Bi0+r5wZjTjAKp/sF/Vcs0iKTqyyTbnUogM7ZaW9
	JuIH6/FKLf/Y2xp9lmIbql08qfvHl47tw8xbaBY2znGH6/QNesFmWbA3hs9/BPWh
	xB+LF/lInO93J3scQhMswDlHjm3603pvOz4DvMg7Wm53VlBj87GuPO/O83dPzFfA
	/e3YnvnARHbXf0FY4XGxHIUMt4vK4Ht99qHBDmJg7oWJ/ZeHygbGaicJe0jLmWGm
	lD1p1UDNUC/l5e0+HL0EQv9/mzJ+KjfrZDoYWKEI8SOM6FnWxpFae7yR9YuLpSBU
	knMiiA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41enbwh7rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:12:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HCdVm007324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:12:39 GMT
Received: from 0e63825dadb5.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 10:12:36 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Wed, 4 Sep 2024 17:12:07 +0000
Message-ID: <20240904171209.29120-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ucghPu8hP-_AIfDMGsukEkGiJgVfAC4v
X-Proofpoint-GUID: ucghPu8hP-_AIfDMGsukEkGiJgVfAC4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040131

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 21dae0b92819..de2c59ddc94a 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -33,6 +33,8 @@ properties:
               - qcom,sm6375-cpucp-l3
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
+              - qcom,sa8775p-epss-l3-cl0
+              - qcom,sa8775p-epss-l3-cl1
           - const: qcom,epss-l3
 
   reg:
-- 
2.39.2


