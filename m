Return-Path: <linux-pm+bounces-38915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BFC93BA6
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6679A3A8788
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCB275844;
	Sat, 29 Nov 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boe/txdt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvIvx/9W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463A26656F
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764409580; cv=none; b=YfBcDMcrtHpVw0bHUqRDkCj8NkzVlMDpzDIlj50rIXX6wo2NvtnzalKuRsqUiNwIC3LgsldexJ15I50QyosihVBaHSSmE1ZWIs3G49ab584+t8iTAMtRsWElOolI0Ngbnhe+OjKk9/+voWWqN5HzQ7Mwzu0cBYToT2hPAkfepUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764409580; c=relaxed/simple;
	bh=uRpd2cn2vp/H3EIwALlopjhJwKq2UcM/mwO6ghYAUeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTwoGIKFLRatc8hAQkKU76Ac2UjE+t/Vp4F+x+kG+WbjIvMXjYd9iF9p5/N01QwAeh4R4aNPZ/6bKod5JA9jS3furP7iFUzjLO4sd0922q/Ixm5IM+6RMtW3M1fUh4zXFH23Xnaj1XT1PI/0djiJcfifL6cJptbBxzWmksXf9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boe/txdt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvIvx/9W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AT28tGF1635517
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 09:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cv+2iS7qHjsBq/waCdbpd8WWRy6Fwb6PhkS
	0TY3pF6g=; b=boe/txdtHz3aIhmo96ti2OkhcKyIX3U28cMaghzUN2BObJuvCTt
	/WhMXnxyTsDqdutijRpyBsEYJ6PxoYagNS1plLKxtbWgvEgTr0bjbRh7+aU/eU+d
	jevhiWsX8ckeNSnu9mT7vTN3Ujnh+RsNdat+Ot267KOfvcCTY5FD58BrqNYps4xF
	fMPq+GwPyHsHMvk8zjRpIadznEWc2kf1Ouks6k/WLuSf1MqTQ7kAfXBR/TqXnDWA
	XFfui2RBUdWy4RMfS2HWVK7vIbeFN7XGFRtZVIUie1Lc/fCuaTzwH1tRkNsISvJO
	oWHgXY4WhD/Bam7bD3Ydvtu3A5JeYLRWemw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqqsqgj9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 09:46:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2ea3d12fcso444593885a.0
        for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764409576; x=1765014376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cv+2iS7qHjsBq/waCdbpd8WWRy6Fwb6PhkS0TY3pF6g=;
        b=MvIvx/9WmpPqeM7vdxGABt8R0KGt6d1XyegDVz3bbDR2Qts0mIhRx3xdnZMPzBi/LN
         dM4wGK3zuCyGxEU+U3o0u6pcO0NdyIOsUfQgJpGyaoLnpaIxxdthQdmnSWmncfbeDO9V
         h2Dlj14bSNsbn6YtMWxtkSn5eO/oR7GnFLdkKa4kGk4OiXkIlYA3nDjcyI+x6mnulrJT
         firJG8RJ0OMZXi96Ujd65Sw7hfwdbqG2hecsVQDhglKGpld0KFuUFbwdHDcw8d9XK/mo
         9eMb3RTboGcYnhK4k/KRLHJKEKTzNzUodX27DvZ9bXh7xQ41KgL25u6nYFCyByXlq5C6
         8zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764409576; x=1765014376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv+2iS7qHjsBq/waCdbpd8WWRy6Fwb6PhkS0TY3pF6g=;
        b=miS2a+QBT9sRLBvqaxk6GOiI8LBc5AuAWNkcOlcQySwQGCO0ijiWv5ZEeTqO6+My+Q
         TLO01ID6ZiPhUdVUNLJgn0gNRphkzmvflEX6BTkTsEnCYXQeKn/MghAJC1T2KJ5+6CZu
         1hMz5r4RxQ6cpN/FnXpbRwGv5R4C5+rixydT/TW1vCIRaCdSJEtpWVvRAyO2pL37hvQG
         B6Q6VaYABoY+ys8/zPBIOTvpBQteCPrhy6nXCGdCi10vkqBIcexVwu8wVUO7q6NQkrVk
         ESZmDzQoDQZQsSuspK5UOfDCkpl4aBrN3o+h6hONBooJpqZVgRR/cRiBxSOk8ut2+l4S
         0MSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYOSUD0aHeX2jW0bVUdtxBhq8kx7nw4+vEWs2z83izQZBmNI42v39MMgXBN/Fp/A7atMqf6skZMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4nsZ+paM96MUDeoM3tuhtJRVxzV970Ysyj/wkFk3hunfwJN4
	zvtswjDrUCfKZ6iywJ9NJHcI+dCpFhCGdMi1RkAZGVb2IkhVKzSwb8vLFMboNTmKU1r/IXzHUNQ
	2Z6oIMKQxTio3CAt8KU2mkzTXATCB77meCFMJGFJ2QH9jkZyYfdcSWXab7nvOaw==
X-Gm-Gg: ASbGncsocpKvDgHP5xkP+X+WP+fyGwRhgqWyC2fSWZD+XPq5V4oFSg5N+T9xsy6FV9f
	nXyMHQteeo8FPGN+o6yjmJptOTU2NT3NgtI2QClCMGZJvI1Uq2FkiwD73JuJjjfTvT7htCrV6WK
	DH6/T2CJMQPSyw//gSPasqXjBMSmrpGUXf6pDYxQaus4Tu4S6QTiobz3uxmAJ002XsZcv+ooXc1
	+9Gd3P08orTuMV3b+589vjwW0ynLXfYQQZ4D3t6OBTAG+A+surOQLdHWFRIHgA4+7rSjFHg4vzu
	OW7JQUJ3hFRNIrrncsCkQ1Sksi8aFohIVJsRETjtVtzei0ZGesore+QHWaRBKVYEtj5c4tbR+ug
	tZ4tGSRjzGW41/CwteRlEhIGKS1Kt
X-Received: by 2002:a05:620a:1729:b0:8b3:3879:7dfb with SMTP id af79cd13be357-8b33d269d2bmr4024110485a.49.1764409576171;
        Sat, 29 Nov 2025 01:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbxU4P0DNxzVjULeiiVXoLtq1gZ/snvDZrCOwLHi9IB7JWNikxZfAdBZHFLnzoOJ36FCvvxg==
X-Received: by 2002:a05:620a:1729:b0:8b3:3879:7dfb with SMTP id af79cd13be357-8b33d269d2bmr4024109185a.49.1764409575696;
        Sat, 29 Nov 2025 01:46:15 -0800 (PST)
Received: from kuoka.. ([178.197.195.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90d5dsm6430966a12.12.2025.11.29.01.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:46:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix incorrectly added reg and clocks
Date: Sat, 29 Nov 2025 10:46:13 +0100
Message-ID: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=692ac0e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FPK7cjBCgYbqzSTDLBmM0Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gkUskBmUj5qaP5BcApMA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: c54C_lF2ciym2HBHCJBs0AnlKF7dCTpX
X-Proofpoint-GUID: c54C_lF2ciym2HBHCJBs0AnlKF7dCTpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDA3NiBTYWx0ZWRfX/miq3K5CLwE1
 qZ2ZeFqWZOvX1nNyMkGDyvMyZR6YXPWJ5ilCLwiAcxrEzQq0KR54J/04I/6kERo8AMpPPUC5YVU
 oHwQTaFwPIcEJUTCsB5pNsqyei4hSzSvp0SBdQbqS7qORBKx4aVAXCXtSDComV2Nd/22CeCWleY
 keFSjfBhrJr6ebsQNSMHhcmRa+0QHdVj7ddZj5li8TzGHsysg4mWvU/m1ohnW/xziLHVruNCJsY
 IsMUXDWSufmg9P+mSYSQcaP3BCEupuPENpuKB3UjPqFhkcTt/IxEY639b8CV9Hee14VgMoECcjO
 L5Si+mDLpHOEZhFqVyvNVp0riPucOPdDHwERR0Y9HVkk8mSa6CKxvkeYd6tSFXJjhbtID2pxjAP
 DdlTDmGDgxQ1mk/3hN3iE+lbkz4eDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511290076

Commit 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks
properties to enable QoS on sa8775p") claims that all interconnects have
clocks and MMIO address space, but that is just not true.  Only few
have.  Bindings should restrict properties and should not allow
specifying non-existing hardware description, so fix missing constraints
for 'reg' and 'clocks'.

Fixes: 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../interconnect/qcom,sa8775p-rpmh.yaml       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
index 71428d2cce18..3dbe83e2de3d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
@@ -74,6 +74,37 @@ allOf:
             - description: aggre UFS CARD AXI clock
             - description: RPMH CC IPA clock
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-config-noc
+              - qcom,sa8775p-dc-noc
+              - qcom,sa8775p-gem-noc
+              - qcom,sa8775p-gpdsp-anoc
+              - qcom,sa8775p-lpass-ag-noc
+              - qcom,sa8775p-mmss-noc
+              - qcom,sa8775p-nspa-noc
+              - qcom,sa8775p-nspb-noc
+              - qcom,sa8775p-pcie-anoc
+              - qcom,sa8775p-system-noc
+    then:
+      properties:
+        clocks: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-clk-virt
+              - qcom,sa8775p-mc-virt
+    then:
+      properties:
+        reg: false
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.48.1


