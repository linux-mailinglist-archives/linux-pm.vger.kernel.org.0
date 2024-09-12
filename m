Return-Path: <linux-pm+bounces-14104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04354976FD2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 19:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7975A1F25209
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4411BFDE6;
	Thu, 12 Sep 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nyxzXIpE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65C188592;
	Thu, 12 Sep 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163466; cv=none; b=Vjt+VDbhPhjjs5yoeC2otftxsAqHzoPIBn7LBBiBqYwUSo/I0eUanbo5hxRmCnPoHz6XExXkBa8S3bOnSzS51PL2zlEafBMpmHxhBNBttbaLxX9XU7416CPqJAw8JiZP8rY6DZ7mFvEuSjytAE9yWKEhssyxyX/I7FfkBvw2OXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163466; c=relaxed/simple;
	bh=hE57exT5nkoakk6qpUhqx+qvtY8IHdaEVxrZ77/wNgs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/lFnQ3vcwzza7qQAFOGpfm0CL1fQHYv2aC3CAczsgQSiH5l2rKtg4rYhcwO6o3NqKHOuvg3MuulXmDL+CSgZMEy37vjk5qdtH7vDnMBSx2FlDO246CIE4XFBvgPCENGlGpyE1PqNqExW9wvGExxUyeBuMTy00t6B8dGicUQlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nyxzXIpE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBnZfC028261;
	Thu, 12 Sep 2024 17:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JvW5JjlIyW6t8pxCWnahq3
	wxHl71l61a8D2wN1+88W8=; b=nyxzXIpEARwySedRNcJS2PXMniR2rxOf5c1t4o
	XI/dzmp3y3F1LJNgYEUb2sZahIrN4KnwxJenNvCuCTDgGNlXmRIhWzHmMLxJBMZT
	o5YdpZ3aE+X7mlzrGhPrIMw2xbCUkGjWxcHSg9QyEP9OXKUTbjuP2wqWL9C+x9bt
	ak2W9ELyM9+Q/hQnKX7qZqrt+Ff+Dasf5p5tZN9QT6wj4i4oTMftfXVoP9tw+Rwq
	sg9Hgwd+Bc9fDvP0FEdq9iprwNaVyXy+bv2LTq1Cs42NQ6nqgO9bsU7DPEFHa+/Q
	X6HiOz8pF1IciI3VdXCYy69otUKW4pLYGCZN0k6Iv6u+S/Ug==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy736c0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 17:50:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CHowEe022686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 17:50:58 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Sep 2024 10:50:54 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>, Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3] dt-bindings: cpufreq: qcom-hw: document support for SA8255p
Date: Thu, 12 Sep 2024 10:50:43 -0700
Message-ID: <20240912175043.2262697-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MyqPSI2pmKsOsFPfAM7g4lts3ZTgt_wg
X-Proofpoint-GUID: MyqPSI2pmKsOsFPfAM7g4lts3ZTgt_wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=949 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409120132

Add compatible for the cpufreq engine representing support on SA8255p.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v3:
	- Added compatible to the correct constraint list
	- Removed the new constraint block added in v2
	- Removed the patch from original series[1]

Changes in v2:
	- Added new constraints

[1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 1e9797f96410..1d1f8637bc03 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -34,6 +34,7 @@ properties:
         items:
           - enum:
               - qcom,qdu1000-cpufreq-epss
+              - qcom,sa8255p-cpufreq-epss
               - qcom,sa8775p-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sc8280xp-cpufreq-epss
@@ -130,6 +131,7 @@ allOf:
           contains:
             enum:
               - qcom,qdu1000-cpufreq-epss
+              - qcom,sa8255p-cpufreq-epss
               - qcom,sc7180-cpufreq-hw
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdm670-cpufreq-hw
-- 
2.34.1


