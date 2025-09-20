Return-Path: <linux-pm+bounces-35095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529CB8C6B4
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03597E0301
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE702FABF5;
	Sat, 20 Sep 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYTlVtsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE731DC9B1
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758367883; cv=none; b=RgXrEdSZP4KhVR/tHbo+66sv4cfJZb4661Sag/o2/BSIjWQW1YChaEQ6oXeA3zWzs/MNk/GUQUo77fPnGDcFs7e45+KiPzphzYu3qq2FGqL2WI9e/beeT2xvjxNYMBOIWjAS8tv6fc03NyNyKDxRt7n/+7XeLtwWDDZkVZQRqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758367883; c=relaxed/simple;
	bh=wRFzW4gTxw8RSbwpMQZx26SwQa/TSHZp7SP5PI7C/IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xc77wnqde2kGrmGpZTvSMdj1IFCNzgsMNU6XZVxUjid4XetW9aKTi7Tap+SRijUX6Nh88NYCysMTqoXGOiEowRcqioU4OuDK5z1UTUXnM96Zc3Bc/0vtR156i/6cIXVj+u/rNsDuEXgThjAEGUlQxKRF/eh1GTGN1qAkM0CgXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYTlVtsc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FYug000535
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=t2PWzWr+rmTAvxWPqAkysS0sBuB2h0DCVbB
	pWs6MT24=; b=kYTlVtscNrzvQuS/Nwh+4aZA/gfZ32XyClXtFdtfoejSUezMiKf
	TSk3wj0It1Auae/zTngf7dispx4oOGBx6t/lPmLzOMl7sLP73RzkQSqJSqFsndyY
	xBfEkzogyJhnwdm1txuHg4XN3A/SZZhXlNAn/D6IyvJR+w81oiajEPKpKX0NtXD2
	nZPUqKBPtdc+gI2Bn3Z6JNX0+ymgXtr566yo4CjUjJwLiSdkoKHukrKGHGHJvebj
	2PoP1vICOWKeLmYPmVz6Smh1WanWIt7g0359JQbH6kzGubkKLmpKDiQPH2wk6Isv
	Sv5srQXMSN+lF5OK1ZGWj6htkQY5k4u6klQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmngvw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:31:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681642efd9so26155495ad.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758367874; x=1758972674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2PWzWr+rmTAvxWPqAkysS0sBuB2h0DCVbBpWs6MT24=;
        b=l6GFMeg3tD2TaJMIiH44EzNVSvtkEnSxadAzrc2yusSRrhS8fSrB7wZvzlpE8S08t0
         T05NBVRUcewZ7yOuhqu4PfvL3oUOsIeiRFhDEfvBzbdOLpPGx2NfRKhC3ynC2E1mUOEf
         Fnz6mrEbcYfSsqhYLLSe/BTb9StS5o5yZPSYsN1IVw86varE4SAZ7tgmz+HEvZsha/4I
         eC0pa33pzr9t+ObDv5ZmsgxT0ZNzIDTBWxp7J05HFSYyxi4G/swftVwHz/2n/lHV9RsW
         oIXi+Wk+Tt0dxJjIrUEYIdZoVHQGY4UmcBPYOx7JtUPf9AnZo5iU+JwFtOZBWeqQmTYt
         Ls4Q==
X-Gm-Message-State: AOJu0YyPHjUKMvKFMaZZIHbrKH/I52sPplDcayvMCWaGIDOAKKmta1wd
	0R8zFlXw+cJh3bEXiVav95m/HKmqx2kXMVxwQgfKBpnR+vDpxtsWz0fKUe0MQWR8n3qN+sPfi1C
	SUTCCl+lmn6vxTEZXCgYCv87llBWcFJbt8f1uKGKvTIuKaRLIgqeRLG92WfSPEg==
X-Gm-Gg: ASbGncuTjRsOrS0NymdSp+6cXbcHIIsbynaLae2E7GdbZYdf6FmnZDFfNxwo8oBf1i7
	PrqzFXSKDdaih1Ppni2/n7IpPAvuTmvKBjIIe0edHzzb07xWBYRFfQt1dwRxBvS2oYFlXa//q34
	5qb9WDPhcEdy581K0CBturplsSHGAOUgLg7b0VnCHawDFWcESXvTWPmp+1NVP8EMSvuazxIyhkN
	mWxbjP7gdsE2G0StqaKoL0uC71mY0TCFg0Q2gt0NoFf/O9xNN+pzDNBA5eImYpb4fOHTRDHMMX+
	OMdUgz32WdjO9x95O1ZJMi8iBo41cEe0lqGNogExLgPg0nQtJKtsnqzjYyvg1Nzbjm4hZB+J4jB
	YWKj2T3hOwfoeAI89DTbhssM4lKHTTCnlwUCBAzbol7XBA7NLidx3/gpl+nCb
X-Received: by 2002:a17:903:40cb:b0:26b:61d3:cd66 with SMTP id d9443c01a7336-26b62201c03mr69924775ad.29.1758367874214;
        Sat, 20 Sep 2025 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHhe73x0XLBwB2louUzFMWyY5HexOtrXj3J/yR43zYP6wQ+HGnLlOCgGTD/Jfpqkyg5lA9rQ==
X-Received: by 2002:a17:903:40cb:b0:26b:61d3:cd66 with SMTP id d9443c01a7336-26b62201c03mr69924465ad.29.1758367873744;
        Sat, 20 Sep 2025 04:31:13 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm81109635ad.93.2025.09.20.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 04:31:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: document the glymur Temperature Sensor
Date: Sat, 20 Sep 2025 17:00:52 +0530
Message-Id: <20250920113052.151370-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68ce9083 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zzSzb4EmsE6u5SiZLnAA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5HbKMZDe8UGOKiTfqKasTLWWpnpFtXMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX0+vSzMYIQoq6
 o0TZcecWVBT7Y7oAPKH/4e1Go3wjvxlh0Fw8mb+PPUGvrus3hVv3UEbbhQbSe/sIledsT8OWdP9
 OjHk8RQ2KvqgxUOb8PnFNX9ERG13AJ0g42f8s/2diW35vtC2OvH4l3MWdZ940zB05pRvrxHNrXf
 dgAQkEvof3QsewITeDauVSa3kEB7as1yCnpMPWoaYWtDPP5wii/nfZp4R0WV5Ag8wJqaJleuECe
 HiP+SAX82EoJiH+4qLcOhhBHIqZsTf/qBDYrDaUqxgDaIt28xpQgw7Ou5SM9BqTKe0+dSPmOMLY
 z+Gnm19J0YZum8xb8s0BabPtH4YqdzE6Y9Rhyib775/KR4DBz8aXqBLEmEZiodwlc3Mr1fqoiSZ
 sD8uZfcv
X-Proofpoint-GUID: 5HbKMZDe8UGOKiTfqKasTLWWpnpFtXMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>

Document the Temperature Sensor (TSENS) on the glymur Platform.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f65dc829574c..bfbacba1dc55 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -50,6 +50,7 @@ properties:
         items:
           - enum:
               - qcom,milos-tsens
+              - qcom,glymur-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
-- 
2.34.1


