Return-Path: <linux-pm+bounces-32688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFDB2D698
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3628721059
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091C42DE6E1;
	Wed, 20 Aug 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxaebifl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8D2DCF72
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678580; cv=none; b=MrzDdtkrtBbyeKKHfzF7V5uPvELR3K5KfOVNKSWWAyhaoRrHep6v055nivRpuMFB/hM6iXDC+qh65rh7Pd8bX+SUNggRyFVCWUbXGYhEqTORhtfxUgDEqoUNzG24o396AuVzQFSlx5czRvpRryLjy0WiB6x0XYz0mNNkxs8Rt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678580; c=relaxed/simple;
	bh=IkmE1jjMC4FixOnI6iCdgleDL30HMdQDrPw6ul1iKuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaE61OWoMuroD7IuMDS/3JUS0mbl8pjl1nFBInabNxTVFRUw6B4XohFpiyRjzRP7UR4D9p2eZnOA0vsxQjlDn2vz3WSRwLJE+svJRcNWbXOu2o9Bm9r3IX5Roor7UVqHIUTWsLJ8o1AAVeuwzgyFVTWg6CvqMqf6g4So+tiCue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxaebifl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ojCQ011739
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MgVazd42Ob3b+2OxT+ub/6AIeoHG7frufUrQpGpavx4=; b=gxaebiflv6+piB6O
	nkxi3Q6Eexb0QFYJ74iLHt5YdaS4ARA2WGcxRbkB4sylH456wAE89PKce3IfhcBl
	n9cufA/t1MaRyCY9XFLRdTOFwVWShj0hdHSKhJdh+m/2751mhFtREF420dH1md8F
	Suwnh2oxMLKUcKrEYYqkDkZGCAi2Bxy4aB++18oEgvPh9Jmfb3eNsRCm0bKrfoCO
	SBKNbXqvsCytP6nOqThYxI70XfIV7DzjNPjA+2+BLN27sLGxYq5pj3SSEefvlQA0
	EcCanLWY6mV0lU2iM8/0u99Z9Bw9V5ufEekSixKSLHjPg1W4rICcZ6b8Uhg9t4Co
	3PvK5w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528rypt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806dc88so156648615ad.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678576; x=1756283376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgVazd42Ob3b+2OxT+ub/6AIeoHG7frufUrQpGpavx4=;
        b=NsS7BgHwAcBzKM1ra5o4dewv3J4zNIiqhAnLsl1j7EkR+qLV2TLkCm83phdswftDRk
         fiowe8oUZbhokFDI/CluQU/sYuexAZDqdvOXze0RyDaEn0232th+SA1rNO1u1ytAC1qz
         vHT55KawkahHPAoXhb/CCDAF+d+YGDh/0sdSJc1ZRs2IifwID0hnlQlhwLUfTsCnckNR
         1KFUzxADJkJsGurluQDtWKwxk+lJyE2PrCdOU1kQiHfSWGMxkVoNC6wnYWn8AGe51m4A
         14lcjDKbLznaYjH6wYTVXUtCG7TFxTzchAhlmM8S+JNqjaPWL5YJErjjtCVogRznrAGV
         IE3g==
X-Gm-Message-State: AOJu0YxGe0NWgmFd29hueHREiW457q3xlWPLlprld0PWqSPCGohb2iCb
	E/rvMdGH0Fnbh4cMHa7eBIOSNq6Rr6HXasOzDc9nBT9XZAJw/HzG3aBm7RhwUu0SxPdCgldWaUJ
	A/2ITWCQ0SYmmx5TVy9PsOLXtmhsL0gCSROWp21AFzzNFqxY72R9G+1OoulZzaQ==
X-Gm-Gg: ASbGnctAyj4OcmEZzvWxD73kI8RtkhENCeXMp/LuJzZQU5xveolNe7rh+3UAXn5mfHY
	kKaL3SrAmxupVRUegHc7FLMLNHB7cCOLejSEaPhQ/mJE8xKjKQW8KS2HEeNPu0PAbRWDay1qVAb
	3fIWZvfD8InhX3DeipGOu+1MZnRq0Aelhdc5TR++xp+/P9JLpDSh/+rMUiUtGKpz6bfaksVfx/p
	AY74NJGZ+vgrCcO6EhsCvQBgcVPcoHbuLSEdhxewn7ObHg8jb6HQvghMpj5zjiFejmH9n4px7bd
	M2hCz0X/QeCQIlKer7ielv2XF7Sfaeb+1OjCumHU8GgZjJeDYZ5eMK4ZGWJ1yBYzRpbHJviJdPk
	=
X-Received: by 2002:a17:902:e811:b0:243:fd16:181f with SMTP id d9443c01a7336-245ef215fd2mr29489575ad.36.1755678576399;
        Wed, 20 Aug 2025 01:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiPY8BfkmagQpheekyURX0cr9AaqhseFsDNA26TuaYix4uLgKtUJ/U/jV9HEf4oUZFV9rQ3w==
X-Received: by 2002:a17:902:e811:b0:243:fd16:181f with SMTP id d9443c01a7336-245ef215fd2mr29488865ad.36.1755678575396;
        Wed, 20 Aug 2025 01:29:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:53 +0530
Subject: [PATCH v4 7/7] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=1526;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IkmE1jjMC4FixOnI6iCdgleDL30HMdQDrPw6ul1iKuE=;
 b=PKpGH+CYVvuGgKtCdEXtU++jgYZEJaPAHeVES7cN24c3hTKUpEzzt3/Th7iOTfRMFmIRRo1fa
 ENdpSsix4ALBFuePX3rfVUMY46z3LUq6gF4FLOehT7YuZ4EmlT5/79O
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a58771 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: _-PTJOdzWXHYlNIT1ySSIEp6_0in8ddr
X-Proofpoint-ORIG-GUID: _-PTJOdzWXHYlNIT1ySSIEp6_0in8ddr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwRPmY9s6PQwZ
 v/K80TSE6qeyPSw8omJcELNer+ma+hh9w528/UvXqbbEhBvmoIte0NNS/VsaGVvBEubN9akrmyK
 Y8Zyx+ohgB2jUFrh0wCn83KdJF2TZ3v5cCST3ndUlCEO7qZmPWTZ367gR1c0Vnj27rqjcTZeJPQ
 W+CWAvh/mokut/8AX6y3H2Nol+M36nTiJnCkDGREPArXE5K2BlNW/oinov+sCCquOzmgpITdmZt
 dkARiU+OMf8YxjHoqSPP3IDmrYsiJQWHdJ0T5GFdLvjtJGoj2QRMcvn/RN4cfY369uVNPZN1ARf
 ToFbWD6k5KIuZdV6KyWE24rTvnI1NnkqPKI9AFt9KitfuKAy9tL8/hufLws4iteEyIXDLgqtKHR
 x30n69DdPSKsTtZhi5Im+8sbm1z+0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

PCIe supports multiple data rates that may operate at the same clock
frequency by varying the link width. In such cases, frequency alone
is insufficient to identify the correct OPP. Use the newly introduced
dev_pm_opp_find_key_exact() API to match both frequency and
level when selecting an OPP, here level indicates PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..4f40fc7b828483419b87057c53e2f754811bdda0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1555,6 +1555,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp_key key;
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
@@ -1582,8 +1583,10 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		key.freq = freq_kbps * width;
+		key.level = speed;
+		key.bw = 0;
+		opp = dev_pm_opp_find_key_exact(pci->dev, key, true);
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


