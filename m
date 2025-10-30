Return-Path: <linux-pm+bounces-37125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1964C2166E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7441C4EF76C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304B3678A9;
	Thu, 30 Oct 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="grbAu8AS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L7n8e600"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1A313260
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844154; cv=none; b=LGD6wF5en1MAYaiDeMOVIMSuFXxvrZyKcHd8IrE6Sf0G1wTwC1dgZ2Unifgw7xhXpcJQEpZzcvDpOVDKuL3wOoEgEQcHV38hdcOxj39oXPEbcplbIDqKSaFJsuUu+9wjjHt6HtQ9KYeJobrOPPU4MHGtNEKaG/mpI58RwxCZyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844154; c=relaxed/simple;
	bh=Iky1opZleo3Ag9ocUUqw9H0ccbMwe2ZQMmig7sL4bG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OftgYZuIfYz1DTer8/YqcNWAeLvW4YqAhfxSJK++3LrClYInFTVm5Ag6zdA2/ON1heIbH4LezLUoMa1WK3Gzc18kFNfqdKOxtowj1AD3+5KapEQsSs889pubgmpMYO8EhFbD7evNTyHyjQaEOFCkJtxmWxdByWyfadDhWJytkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=grbAu8AS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L7n8e600; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PGux3509222
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pV0A1g/A4D3sZXswjBbm/Y
	b1RvRv+HhWS69DFFGbS/Q=; b=grbAu8ASANjJR1nMZH5QHqSUz+7mEeorYqFjoT
	h1huI7ZodZtr2Cd6FBgo2zI+qLBuuTNJxmmw8dhna5Gz5O0aHBtJeEfZlMTWiKDC
	VlZOQ7E4x24c0z+7ommuj1QNwbCCzBC24ywnhXdOnnLHTwFmv3isTlNTnj/B3U7B
	BoH68VFXR7GSOqXmlLk/YUc0Ntq2AzMw0p3+cr4/Bngo/lUFxIUjws7Wyg+jMvNE
	JV+1iqr7oxzlyOgIUqLJBxspqrXJMJKzzBm4g4NBsctRbQz/DfBYTdEbBR8L/489
	qckT2GuBlU04g40Mvl0vFrx3Cqg/vVg3GjmzmGHsaDrWb97g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdhb7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 17:09:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6d0014d416so929509a12.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761844151; x=1762448951; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pV0A1g/A4D3sZXswjBbm/Yb1RvRv+HhWS69DFFGbS/Q=;
        b=L7n8e60011OS7LrdIqc4XOtaxyUmlaUyo66TmtkFmxogL7NmF3ZkBhN8Ki55XhJgOR
         K0ELrKZqopHdaItASV/WgXQ3fruEkGLK3HA93rULqrLVc1TiaxhgHq5liwz5D1RGYXUo
         lkmAB9ZG8Jg+Z5gGEyXzaxBjo9wq0qqay4dTIL0tn7ASdxGqjjYAyIyOrKAt8cAG8V2c
         PtbXHWn3w6ukJSRw8UWeHSxh1JaBQ9COvxV947zJucbLvSthLAfK0GYx+ZytU4V1lA2L
         dDOC/IT5StMUZLWrc4eDy0HIhPNjK0Gy3eGOVyLWjhCIm5f3tyYvZ1Iygb+5FS+ay9Ob
         9iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844151; x=1762448951;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV0A1g/A4D3sZXswjBbm/Yb1RvRv+HhWS69DFFGbS/Q=;
        b=U38pokDRGQiLZxBzxF4oTEApJi5AiB2nX0C2+r8+4GODaqVLeGng8xcGzmraj+iZOV
         lHPKPs2VpqjgV58gqlh6yyvrafr49kR2nYiqwFFJyUEY0yzDcOAXAJxBleRsxbFjaJl2
         ENwBGxzafwnbz9lJDYANVL3sLc95tVQFEULAnBlBgR5vQTj4o+qnkWUsv19bptNlUVaf
         z1yJeGy27c6MJJ1+s7ViBTc1BNpiZnXPIoH7b3AyWGtTRJKpEK7CfDE0HXu/cvOS7GVO
         1zuZUVsyx+Z14CyN3kigncxXuVSTSGxGDWzqq5VdA6im71sN+8+6NyQ/Yl4/450dtFff
         nFYA==
X-Forwarded-Encrypted: i=1; AJvYcCXXKftkV1TYCTFt/nFimy3aupqydQDRy+l02FpIW5X3/dxfxdN6AsYcjgX2TmXzXd4wm+aMulWfqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuXT04YTsFQvBDLeqt0vaOO9Co6uX23S1KtlbefVqf9PQrZd3
	iK7+N0KrPuxXLkdXxyl5lZiIh1QmLnu+P9Xmd3OmuI0mSJ9Xc/CFhkTaArMR6U0F3XQDiHAZiGh
	X1c6k7arSDZApTwgPgBip1wujaXHpH1eQWmH7fGk2GqoGeVe96yjQSKpJg8nXkA==
X-Gm-Gg: ASbGncvcunnRfNd9aKXdC6WosqUsXe5EGMqGvVGqDCBJrXw4B6nLUrT6ts7Vx8gAVwr
	jBbZaPQuYpgtZKPjrvrtqp31mjuY4ZpcEjODNRt4CXtCoR4I74lbSg7jbI3BeNWZ11/96z1JRIb
	FUzllNfYUrmQv16BKQbBnx+qWcv4p053wwSaCLpyjDjWE37ou4dqiPvKQ5EElDIg9BlM+Ha42pH
	NsMBRtNJqIzTRir6DWfb20Sqh2tBsjWw7TbrSZVfcU+u0kNQSmNBBbtkJHdZm39wXYlNOzBpk5q
	/M9wg3CnU0XSckhHVzM+6V1mIKA8WQTjOhCaAP3PC09ejD4RTXegIRqDJqJT49itsXFBV0Wd/ao
	HV/pgxzitP7DJBERCOU+4Jw==
X-Received: by 2002:a17:902:f651:b0:295:1277:7920 with SMTP id d9443c01a7336-2951a43ebb3mr6088775ad.28.1761844150819;
        Thu, 30 Oct 2025 10:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCt5+4I47/PW//spSrNAyC1wA4DEWUlJpdARziis74notfiDAaNW2TghCcihvgBW5XZscmbQ==
X-Received: by 2002:a17:902:f651:b0:295:1277:7920 with SMTP id d9443c01a7336-2951a43ebb3mr6088255ad.28.1761844150255;
        Thu, 30 Oct 2025 10:09:10 -0700 (PDT)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09855sm192828595ad.30.2025.10.30.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:09:09 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add interconnect support for Kaanapali SoC
Date: Thu, 30 Oct 2025 17:09:01 +0000
Message-Id: <20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2bA2kC/y2N0Q6CMAxFf4X02SUwIYK/YnzYaieNsWA3DQnh3
 62Gx5Oce+4KmZQpw7laQenDmScxOB4qwDHInRzfjMHXvquH5uQeMjuWQoqTCGFxbY8ehyam1PV
 gs1kp8fJPXq7GMWRyUYPg+As9Q7bxLiq93nZZdnvbvmO934aQAAAA
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kFdFlc9zgc2-S54z1B5cR_IVL39Y2NqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0MSBTYWx0ZWRfX3bmJvcHLUYrA
 0kk9lfyih7AVG7ECMgnJWXtNbpL8qM0ME/vzNHLqUqIKS/Has/Ux08HOLnQJ+kQXThzG12NS3KL
 eoRnEDoss49VAXuK31uAdLZWV4djShqPqRtLkA/MAYmDLqVCHK2eFi7K/hGEvNCYrfy1fGnSx1j
 paKDFSv6A7bvRmBur8mMaxr0ZQ0z2q5toGIBEp3AFZaMcrbYcm5VwviVmmm71EMsP5WuuMZUNsX
 Fv68hAv64kn6rij2Y3/3yDrMj+kM0ye8ME13CJP9/FJr+0jC4me9JHZ7Rc7SNhJD0EsDmh9wQDY
 jO4BxgvVU7aRkJlvC5xTjkTnljwrZUnWu9k48aYXGiiH5p8SSnlbAB/8VTabkwgxGJX9UCd5DdY
 yLovLGuUXn06VxW8llfEESke9Wh97A==
X-Proofpoint-ORIG-GUID: kFdFlc9zgc2-S54z1B5cR_IVL39Y2NqK
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=69039bb7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=axuxfZWt1NcpswWNhAIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300141

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

Changes since V2:
  - Removed the dependency on clock header in "qcom,kaanapali-rpmh.yaml"
    bindings file [Krzysztof]
  - Corrected the patch revision number.

Changes since V1:
  - Added b4 dependency on the clock patch [Rob]
  - Updated the Module Description to "Qualcomm Kaanapali NoC driver"
    [Dmitry]

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  125 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2153 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


