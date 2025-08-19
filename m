Return-Path: <linux-pm+bounces-32626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2808B2C04C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA0016379E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F332A3F6;
	Tue, 19 Aug 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiCN2wLW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5C32A3D2
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602702; cv=none; b=bNk8qlD7PqT62AXKmEWhXXwEie9ofimaoIs+lAGIy3vMU3lBQATbb68Qb11VYHA0kK1AO3LMM6nGYNvgGYIkm+P4ot9flxRJW3b3ud8iEYd9/lqJIJfoOKxWXVvb+CkF1bVvqX3Yicz9KBXE0DcQx5THAiIs1yXqOccey8BYgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602702; c=relaxed/simple;
	bh=jfFVMew13aow9LdiRL7XgiGeNSFwWq+iSxzZgyk6PJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2Ggiwhc7mYW6VCQFgxtA3CuNAesieR5tiwELKWvp4Vywrpjw3DzOsck+YIPGjYqm6oUdeJ7umMxV9e5dSO6jiY8erAWVKe2IM1iwu82BmvId8340BJfZwX10rysKWYDZicxGr5T7RH3nfExK43MM+LIPlPZX7KZ2De57oS2HCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GiCN2wLW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90YTE023093
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ylwnfePZhDFnBtzP9R6qdkGXQk7pZlCHWwEtxVPDs/4=; b=GiCN2wLWXZoVgDfs
	stxoqHqyku4mAKBsijfyWxc5WVTIOoboBVDDr0PGY/tggKGqyPeqJpcqv4CSH81n
	0LDsiGFU//+iViRO+1dUk4J9igxdo0JK6iuEErpivW/zAX173KvQFagg9Pw7ahEZ
	bAwsC9epKHMRu1M3kXIbbhSyQQifZAioEFQpmRTnzmKm10EjJM4206Sp6r8Nheau
	eQL6dqJqkWdcfkhmgWPs/wTrIjSdK4xZOv6tNckGttSKk5X9mdYj6Q/ei3F4145v
	60N5hNd9hsNykmDrqcgfYdq6bUktvUOcRTzshhHxlMmEasH6lmna+UoFEui/NLJC
	aV3Jiw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5j0m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:24:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e1fc66de5so5379109b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602699; x=1756207499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylwnfePZhDFnBtzP9R6qdkGXQk7pZlCHWwEtxVPDs/4=;
        b=skm7kvZx0GnEFnhytOPA665vn+BVoJNYDBAd5P+9udDRdlivH/CkOMBJtJLFdNOjy7
         gbONgryftJo1sWbKU+dXlVA/iAMFSMiEsHRvqw3Wnd9JjuvHOtFYjdcgyaoXnEr77kNc
         r/CTem2CN1OUd5qqY+s4kST34OKdgZl1N1nHNIJehQP3m6px+dnXccYtMftYSGt1JfLa
         BjGLJqK53dCQfjlXW9Pmjjf6O3sJhC/r2eltB5F8ATVaZ66R5l/k5/ckfgRJyBMzOGPn
         Q7SjjdHj+J46MVsZsnyFLnV6QDRGWaprkwEBx6CEQLdvYFoNlI7Q8ZbQahuSrPcLLqds
         dqgg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/BUAyKlmmESOrZx0KYr5wpMP7FntxAy8AIpnRuyfzCfZ+WhsE3/v72d+i8z3z2VBHjXGYnclDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33U1AjVON82oLqeN7/A9SBvFaVvipPZXv3KFNu4EgsmDdDD6k
	vVTb4TuSGnOmZVxNtt6x6DMpWyhX8/s8T10NGg2ZvMITl/xKUBv6sS2QK6kdaziou94IcoeMNPi
	fy3ptwzwueCDOStVnZsECmvtCCNUIzIdzV9gBHK+TLSxF7p0ofj06bekjtNM0zg==
X-Gm-Gg: ASbGnctHDxEJnmF7qLQ53LxGQYLQ6Iu+/r0DQNcLMS3kPJ9cOZ5ijNx+RH8WFa9+78F
	ZrTWrSHsGWLl81zpMuxgv6b7kZmanbtxttXMRLYCnx0CwoNcJ4xrY1o+ocjV9efyWWZhpcB7esA
	VSS8EkJSQIIgLG8wgZ4MAUnNiKBNtuF5M3HfxQNXVqj+dV0LuazL1wwyOVriHBX2r/3IYuvZ2EV
	5EuudFXioL9lxde3ABwAuVdyvwyRBb0Bkh60j7dTdApao0gw9L5LAzRST0/JHobkN6c4A88e9F6
	8IysfKlKZJQF882CHYupXeF9G3M2ysXvgSm9ZLnLj4N7aR6/7ZJbKhjQo7cgHxI=
X-Received: by 2002:a05:6a00:4b46:b0:76e:7aba:cb41 with SMTP id d2e1a72fcca58-76e81a1848cmr2455145b3a.13.1755602698948;
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOHVGcTe73LweODTfsXqIUxD7/Iwwz6sW8zqb7EGuvXAkkHJ30P27NxGICxJsbheDjqrKJQ==
X-Received: by 2002:a05:6a00:4b46:b0:76e:7aba:cb41 with SMTP id d2e1a72fcca58-76e81a1848cmr2455114b3a.13.1755602698489;
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm2202258b3a.63.2025.08.19.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:24:46 +0000
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add OSM L3 compatible
 for QCS615 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-talos-l3-icc-v3-1-04529e85dac7@oss.qualcomm.com>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
In-Reply-To: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a45f0b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: w0N00kzBavo3MA3OvW1Dj7l1A7zEsqvb
X-Proofpoint-GUID: w0N00kzBavo3MA3OvW1Dj7l1A7zEsqvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX5wYoXnWw6nv5
 0KB4iQOLYUgBBnY8YOYzijgdAwefXUr+eztosy5hB/+DduuT/YAfFv3ljDGbxQNpdJsqz0km6VJ
 N91bBtaNXgDWMQPwH+EgkrdzH39lOx4sQH2/sT5c726MZPmhtOZGIF29/L/mx9twkp6hgwOgGup
 zHETT5fIR7Ejy0crpJjiwVIhFHlGoCi4mhn3e+fEN4BJlFCLJplqy2SebLQchurRFrBUXShB+sH
 GkRBSDRdJdt1g6oTBlImYXnJAOi8jjIP80JZTF6wGcYRniU+IQTba2IywcHwFpzv7lFeiAhVhcq
 JA/5c0rnGYsrKS+ncOoB3tLB6JCuVJwLNp6s8q/CDvkvHKkhS2Fn2N6NWUbu6VEwaxjrZmsUxiZ
 +dLCsrtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

Add Operation State Manager (OSM) L3 interconnect provider binding for
QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
added a family-level compatible for SM8150 SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index ab5a921c3495298546e4bd34ed3b9e4e85d3c747..4b9b98fbe8f22258c209e8337bb4517e5f5888e8 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -41,6 +41,11 @@ properties:
               - qcom,qcs8300-epss-l3
           - const: qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs615-osm-l3
+          - const: qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
 
   reg:
     maxItems: 1

-- 
2.43.0


