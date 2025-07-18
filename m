Return-Path: <linux-pm+bounces-31068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF6B0A854
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D76F188EDB6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED912DD608;
	Fri, 18 Jul 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3OWBQ0B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A8221DA5
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855655; cv=none; b=A1vS4UKV23WxG2HAI+aWN5CVI5+pyxPO51REIkdbRs9QPOSm98D5/mNqA8gL4HnzkYoMxyq18WSZleuNjhJI6dgE2Pdfz/EGiY9XMI1U6hVtmuhQfKoyZ77OCd3EIRoE2SBZ/xKGPpWe7Zcvx52wyDCQtCXNssKz3BY1q9I/drA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855655; c=relaxed/simple;
	bh=IwxC3fpHxLFPYEQoaZS4yJMMljex/qOEtV0vlUC9pvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0SDrw29+S0ZvAgBmEfQhMv+P9FYhk+6hQ5K2S0qs+1cBDRXKvHULmRKVyOkboCeDncOqNl5GeygIFz7N/QRqOrgBmbpUPnXYGSPIUAWWit9huxtaPljT6fCiXc2GLUyBeY05/Yiku+rqPZyf0BpxFygVSNNFfptHKOT6475xH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3OWBQ0B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I969DP022149
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDxbLObSKfcdBQzl/HXRVZp/xBslvDyyovwYDO8QatA=; b=n3OWBQ0B5OhmwxoB
	lQ+mdmXYMAtj12I50g8/OLiwf82gPajXENlXdMddE8LvW+CwHVryG8z2kV9lR28o
	402WqQApieBeRXHIMoXZ16S9P8UeOPy1SlxYK1oYi0L4Mw1rLFXirunoC4ZELLV3
	VWLGTLulil4XW6LOdtetgcOMsoflsVxhOGraQjEbpIfjqKk/I5NtQgLUWj1NunNM
	9D+A+VA0v9UiCbTfGhsse86KmsJiJy2ze9JTmHSLCJuN3gfh5D0SYmFZbgl9LQbs
	2dRhDtUQUfLWxMcSzrEWcEy4dcLoatrppyzngdqFGT2BVx/Jt4K/1k61YqBZ3rQr
	N2QuTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8m2gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:20:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-478f78ff9beso20357651cf.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855652; x=1753460452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDxbLObSKfcdBQzl/HXRVZp/xBslvDyyovwYDO8QatA=;
        b=gW/J8UQ6tbw+boHXNgaL4ZzUp/xCuzGqeQyvukvxc7OlN5lBctDxdCBM/08RpvADtQ
         J/EYPZfydFKqDoqZk6e5u9EvTTHZqg8Ojz5yoJFqcr0VWtjQtrn2a4+48qwq04H9QZNr
         tEXz9T2N9lni6zwaV0vMA3C5QqUFoJsDnpuLH+pt6ezOHMWm4yEXm2eB8HACbC/uQKRA
         RLsKHK1pae5mRMVojPVkCpNxah5dwB6TdmJp96QULnA9+P9R0YveQVzdGsF6SYkBTD7n
         LsTsWsvwfVA9Gosf9rhVJa1WXCsIIwQkyfqqzskX2Cef0eQeQXz8gjoxAwrXRs3/wBj2
         D1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVgGNNMRepMnOdmmbkgvDXR0YVc49uixRU57l6sMWlkt5nTXkiMoXuXhVAj2kLEMQmzBziwHR8J7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpZMQOxhjQHo9GETDtxKjNyTM6IRTMj1HWy0olLbkUnVHkis0
	y8roHp2r10M5/kDym4pCbU9STCVbe8QbcSTfHEjURZC/GrfJIYJp9NLyXQSamCZT+LDDSVCx2Ya
	2A12IeN2hPIu4svza/mJxw4XJ3AzqA9S8bwsqOXVWF1ocdFxsIUdwD23tp6Q8gg==
X-Gm-Gg: ASbGncuAOEqLpCJgYB4c4yr+Fs/RWbWLCxKyVeS9SCgqCssBl0eVPxvXL4gBYgEzjEQ
	pj2CWbq0xwfB2TOZzIUz0RFMmOxSl9OQmeVI9mRLFvWr/mG+IQJDZhKZ7d0XUVAS2QrmORSOsfK
	CqlSqcaWwQJnGnouvIat5t2Z2uCpgZIBm/j9aaeDwwgZECmJc+lDMQg5ELJbwm3OUTDkpLlGRFw
	DIGTA+7nG67AXt8opkO/DI4oh1xl/C8t7HIiffiwHBSSuk3JytqEvCrz3KurR+cXXAfBjSWmSrQ
	c7Jk33zg2PQRX//oX3YIhK6Ee6jJzSMs0dUVT1HauYqvC5UaIpqFsuQ13hTHQZdt0xcFDurLkNw
	BFG3M7wGdF72HG2NZwYCbqrbDKQJXWa8dSP43vpD1fs6cvgN87ZkX
X-Received: by 2002:a05:620a:4690:b0:7e3:4416:1033 with SMTP id af79cd13be357-7e356b2ceebmr453842385a.60.1752855231110;
        Fri, 18 Jul 2025 09:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENmojVPRULhryYzYcjKAupjpRcli1UOb7Y9P15EYANIEcwieDAArApyc6GdRKsYu170ABl+Q==
X-Received: by 2002:a05:620a:4690:b0:7e3:4416:1033 with SMTP id af79cd13be357-7e356b2ceebmr453810085a.60.1752855227144;
        Fri, 18 Jul 2025 09:13:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:39 +0300
Subject: [PATCH 1/8] dt-bindings: power: qcom-rpmpd: split RPMh domains
 definitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13688;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IwxC3fpHxLFPYEQoaZS4yJMMljex/qOEtV0vlUC9pvc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3qE/IIpouo3rTZyCInPRVbbxuttOTY5iXq
 leHAsUz3riJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1RdgB/0ZkP60RomiSf+x/lJdLDp0LsqE8pBA9G4IpWyWsuCWazwfbBFZsNPfLZo/rCelfw3phUG
 ++lgsgFoaKmmgHGxuX2YZkTTC4hqt4XVYC0eWZPZqRBwlwhwBUQ6FKrppEqUUf4hVh3NyToHq6I
 RSfKa54nUCL1Ij/FU1YJhiOxyZv9cS61mZPfbP4RdZ1p5tq1wFPtYhEIf6718YIHEGLUpfSyv6N
 u5ZbIBFya6UaGE7krKSn2kAddk9NThFtKtiWpZN6MG+iTEfiTCyQZlOMiKyXik8+WwFw9RVspIL
 Ntyp7+GmY5JXs8MF8ydA9C5D1wN9uzbaLoLN9cJy4Gys+8aV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOCBTYWx0ZWRfXzua5KWL2K81S
 6xDBbAQFAYlsvxgmrpSyNu34naO+dk1Rfq9o+6H7l9t5+DNZc0RqdoiixvCCN+di+uO9ipvFRam
 gb+f19q1WSeyWQBFt3J3qc9Mdjc8sPKvwFlSXXhuwKrTVpaprkvX01g/bOzhwYIyC8YVrEcUn2p
 eV4BtMWVskXk+K9ZRLumQ8VMj3vKZM37mVhEhoRRoTIwmerR0UR0rilkmTFfqnqZBi7ITnWH1QS
 5DDuK+FBn4U06GtSz86ktTMeJZzMD/hxo5zKY15CEP9jXOzFqg4NTuqsRRulSPTwnNMkYrrHt6R
 nwyNLOQUAEMP7gC6Huce6bUmlSehBSmjambDDSVQ4wf+RnYFxbNAz6VAdkWmkGherAVeuNYxagu
 ug0X/6uQmOeO/dGpIji+ADKhpn5Y+DFfUEQQ+biTDg4zKIk4RI89TMVYxswxe1eovBkYv0dj
X-Proofpoint-ORIG-GUID: Aci7UL080CFLUWdYF47fcRa-9-u7Q8XJ
X-Proofpoint-GUID: Aci7UL080CFLUWdYF47fcRa-9-u7Q8XJ
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687a7464 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LdBTWnh5yz5cCWo1om8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=893 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180128

Historically both RPM and RPMh domain definitions were a part of the
same, qcom-rpmpd.h header. Now as we have a separate header for RPMh
definitions, qcom,rpmhpd.h, move all RPMh power domain definitions to
that header.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 233 ++++++++++++++++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h  | 228 +------------------------------
 2 files changed, 234 insertions(+), 227 deletions(-)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index e54ffa3614515ca19e7ef93d33c22645c13a128b..73cceb88953f705106486b7e111b3ffc39c85664 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -29,4 +29,237 @@
 #define RPMHPD_NSP2             19
 #define RPMHPD_GMXC		20
 
+/* RPMh Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_TURBO_L4		452
+#define RPMH_REGULATOR_LEVEL_TURBO_L5		456
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO	464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
+
+/*
+ * Platform-specific power domain bindings. Don't add new entries here, use
+ * RPMHPD_* above.
+ */
+
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
+/* SDM670 Power Domain Indexes */
+#define SDM670_MX	0
+#define SDM670_MX_AO	1
+#define SDM670_CX	2
+#define SDM670_CX_AO	3
+#define SDM670_LMX	4
+#define SDM670_LCX	5
+#define SDM670_GFX	6
+#define SDM670_MSS	7
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDX55 Power Domain Indexes */
+#define SDX55_MSS	0
+#define SDX55_MX	1
+#define SDX55_CX	2
+
+/* SDX65 Power Domain Indexes */
+#define SDX65_MSS	0
+#define SDX65_MX	1
+#define SDX65_MX_AO	2
+#define SDX65_CX	3
+#define SDX65_CX_AO	4
+#define SDX65_MXC	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6350_CX	0
+#define SM6350_GFX	1
+#define SM6350_LCX	2
+#define SM6350_LMX	3
+#define SM6350_MSS	4
+#define SM6350_MX	5
+
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
+/* SA8155P is a special case, kept for backwards compatibility */
+#define SA8155P_CX	SM8150_CX
+#define SA8155P_CX_AO	SM8150_CX_AO
+#define SA8155P_EBI	SM8150_EBI
+#define SA8155P_GFX	SM8150_GFX
+#define SA8155P_MSS	SM8150_MSS
+#define SA8155P_MX	SM8150_MX
+#define SA8155P_MX_AO	SM8150_MX_AO
+
+/* SM8250 Power Domain Indexes */
+#define SM8250_CX	0
+#define SM8250_CX_AO	1
+#define SM8250_EBI	2
+#define SM8250_GFX	3
+#define SM8250_LCX	4
+#define SM8250_LMX	5
+#define SM8250_MMCX	6
+#define SM8250_MMCX_AO	7
+#define SM8250_MX	8
+#define SM8250_MX_AO	9
+
+/* SM8350 Power Domain Indexes */
+#define SM8350_CX	0
+#define SM8350_CX_AO	1
+#define SM8350_EBI	2
+#define SM8350_GFX	3
+#define SM8350_LCX	4
+#define SM8350_LMX	5
+#define SM8350_MMCX	6
+#define SM8350_MMCX_AO	7
+#define SM8350_MX	8
+#define SM8350_MX_AO	9
+#define SM8350_MXC	10
+#define SM8350_MXC_AO	11
+#define SM8350_MSS	12
+
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
+/* SM8550 Power Domain Indexes */
+#define SM8550_CX	0
+#define SM8550_CX_AO	1
+#define SM8550_EBI	2
+#define SM8550_GFX	3
+#define SM8550_LCX	4
+#define SM8550_LMX	5
+#define SM8550_MMCX	6
+#define SM8550_MMCX_AO	7
+#define SM8550_MX	8
+#define SM8550_MX_AO	9
+#define SM8550_MXC	10
+#define SM8550_MXC_AO	11
+#define SM8550_MSS	12
+#define SM8550_NSP	13
+
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
+/* SC7180 Power Domain Indexes */
+#define SC7180_CX	0
+#define SC7180_CX_AO	1
+#define SC7180_GFX	2
+#define SC7180_MX	3
+#define SC7180_MX_AO	4
+#define SC7180_LMX	5
+#define SC7180_LCX	6
+#define SC7180_MSS	7
+
+/* SC7280 Power Domain Indexes */
+#define SC7280_CX	0
+#define SC7280_CX_AO	1
+#define SC7280_EBI	2
+#define SC7280_GFX	3
+#define SC7280_MX	4
+#define SC7280_MX_AO	5
+#define SC7280_LMX	6
+#define SC7280_LCX	7
+#define SC7280_MSS	8
+
+/* SC8180X Power Domain Indexes */
+#define SC8180X_CX	0
+#define SC8180X_CX_AO	1
+#define SC8180X_EBI	2
+#define SC8180X_GFX	3
+#define SC8180X_LCX	4
+#define SC8180X_LMX	5
+#define SC8180X_MMCX	6
+#define SC8180X_MMCX_AO	7
+#define SC8180X_MSS	8
+#define SC8180X_MX	9
+#define SC8180X_MX_AO	10
+
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
 #endif
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index f15bcee7c9283e74dc8e6f9b6b6f73c0ced009e4..d303b3b37f18e0ff63929f3fe197151c5a3d3364 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,66 +4,7 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
-/* SA8775P Power Domain Indexes */
-#define SA8775P_CX	0
-#define SA8775P_CX_AO	1
-#define SA8775P_DDR	2
-#define SA8775P_EBI	3
-#define SA8775P_GFX	4
-#define SA8775P_LCX	5
-#define SA8775P_LMX	6
-#define SA8775P_MMCX	7
-#define SA8775P_MMCX_AO	8
-#define SA8775P_MSS	9
-#define SA8775P_MX	10
-#define SA8775P_MX_AO	11
-#define SA8775P_MXC	12
-#define SA8775P_MXC_AO	13
-#define SA8775P_NSP0	14
-#define SA8775P_NSP1	15
-#define SA8775P_XO	16
-
-/* SDM670 Power Domain Indexes */
-#define SDM670_MX	0
-#define SDM670_MX_AO	1
-#define SDM670_CX	2
-#define SDM670_CX_AO	3
-#define SDM670_LMX	4
-#define SDM670_LCX	5
-#define SDM670_GFX	6
-#define SDM670_MSS	7
-
-/* SDM845 Power Domain Indexes */
-#define SDM845_EBI	0
-#define SDM845_MX	1
-#define SDM845_MX_AO	2
-#define SDM845_CX	3
-#define SDM845_CX_AO	4
-#define SDM845_LMX	5
-#define SDM845_LCX	6
-#define SDM845_GFX	7
-#define SDM845_MSS	8
-
-/* SDX55 Power Domain Indexes */
-#define SDX55_MSS	0
-#define SDX55_MX	1
-#define SDX55_CX	2
-
-/* SDX65 Power Domain Indexes */
-#define SDX65_MSS	0
-#define SDX65_MX	1
-#define SDX65_MX_AO	2
-#define SDX65_CX	3
-#define SDX65_CX_AO	4
-#define SDX65_MXC	5
-
-/* SM6350 Power Domain Indexes */
-#define SM6350_CX	0
-#define SM6350_GFX	1
-#define SM6350_LCX	2
-#define SM6350_LMX	3
-#define SM6350_MSS	4
-#define SM6350_MX	5
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 /* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0
@@ -77,173 +18,6 @@
 #define SM6375_VDD_LPI_CX	8
 #define SM6375_VDD_LPI_MX	9
 
-/* SM8150 Power Domain Indexes */
-#define SM8150_MSS	0
-#define SM8150_EBI	1
-#define SM8150_LMX	2
-#define SM8150_LCX	3
-#define SM8150_GFX	4
-#define SM8150_MX	5
-#define SM8150_MX_AO	6
-#define SM8150_CX	7
-#define SM8150_CX_AO	8
-#define SM8150_MMCX	9
-#define SM8150_MMCX_AO	10
-
-/* SA8155P is a special case, kept for backwards compatibility */
-#define SA8155P_CX	SM8150_CX
-#define SA8155P_CX_AO	SM8150_CX_AO
-#define SA8155P_EBI	SM8150_EBI
-#define SA8155P_GFX	SM8150_GFX
-#define SA8155P_MSS	SM8150_MSS
-#define SA8155P_MX	SM8150_MX
-#define SA8155P_MX_AO	SM8150_MX_AO
-
-/* SM8250 Power Domain Indexes */
-#define SM8250_CX	0
-#define SM8250_CX_AO	1
-#define SM8250_EBI	2
-#define SM8250_GFX	3
-#define SM8250_LCX	4
-#define SM8250_LMX	5
-#define SM8250_MMCX	6
-#define SM8250_MMCX_AO	7
-#define SM8250_MX	8
-#define SM8250_MX_AO	9
-
-/* SM8350 Power Domain Indexes */
-#define SM8350_CX	0
-#define SM8350_CX_AO	1
-#define SM8350_EBI	2
-#define SM8350_GFX	3
-#define SM8350_LCX	4
-#define SM8350_LMX	5
-#define SM8350_MMCX	6
-#define SM8350_MMCX_AO	7
-#define SM8350_MX	8
-#define SM8350_MX_AO	9
-#define SM8350_MXC	10
-#define SM8350_MXC_AO	11
-#define SM8350_MSS	12
-
-/* SM8450 Power Domain Indexes */
-#define SM8450_CX	0
-#define SM8450_CX_AO	1
-#define SM8450_EBI	2
-#define SM8450_GFX	3
-#define SM8450_LCX	4
-#define SM8450_LMX	5
-#define SM8450_MMCX	6
-#define SM8450_MMCX_AO	7
-#define SM8450_MX	8
-#define SM8450_MX_AO	9
-#define SM8450_MXC	10
-#define SM8450_MXC_AO	11
-#define SM8450_MSS	12
-
-/* SM8550 Power Domain Indexes */
-#define SM8550_CX	0
-#define SM8550_CX_AO	1
-#define SM8550_EBI	2
-#define SM8550_GFX	3
-#define SM8550_LCX	4
-#define SM8550_LMX	5
-#define SM8550_MMCX	6
-#define SM8550_MMCX_AO	7
-#define SM8550_MX	8
-#define SM8550_MX_AO	9
-#define SM8550_MXC	10
-#define SM8550_MXC_AO	11
-#define SM8550_MSS	12
-#define SM8550_NSP	13
-
-/* QDU1000/QRU1000 Power Domain Indexes */
-#define QDU1000_EBI	0
-#define QDU1000_MSS	1
-#define QDU1000_CX	2
-#define QDU1000_MX	3
-
-/* SC7180 Power Domain Indexes */
-#define SC7180_CX	0
-#define SC7180_CX_AO	1
-#define SC7180_GFX	2
-#define SC7180_MX	3
-#define SC7180_MX_AO	4
-#define SC7180_LMX	5
-#define SC7180_LCX	6
-#define SC7180_MSS	7
-
-/* SC7280 Power Domain Indexes */
-#define SC7280_CX	0
-#define SC7280_CX_AO	1
-#define SC7280_EBI	2
-#define SC7280_GFX	3
-#define SC7280_MX	4
-#define SC7280_MX_AO	5
-#define SC7280_LMX	6
-#define SC7280_LCX	7
-#define SC7280_MSS	8
-
-/* SC8180X Power Domain Indexes */
-#define SC8180X_CX	0
-#define SC8180X_CX_AO	1
-#define SC8180X_EBI	2
-#define SC8180X_GFX	3
-#define SC8180X_LCX	4
-#define SC8180X_LMX	5
-#define SC8180X_MMCX	6
-#define SC8180X_MMCX_AO	7
-#define SC8180X_MSS	8
-#define SC8180X_MX	9
-#define SC8180X_MX_AO	10
-
-/* SC8280XP Power Domain Indexes */
-#define SC8280XP_CX		0
-#define SC8280XP_CX_AO		1
-#define SC8280XP_DDR		2
-#define SC8280XP_EBI		3
-#define SC8280XP_GFX		4
-#define SC8280XP_LCX		5
-#define SC8280XP_LMX		6
-#define SC8280XP_MMCX		7
-#define SC8280XP_MMCX_AO	8
-#define SC8280XP_MSS		9
-#define SC8280XP_MX		10
-#define SC8280XP_MXC		12
-#define SC8280XP_MX_AO		11
-#define SC8280XP_NSP		13
-#define SC8280XP_QPHY		14
-#define SC8280XP_XO		15
-
-/* SDM845 Power Domain performance levels */
-#define RPMH_REGULATOR_LEVEL_RETENTION		16
-#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
-#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
-#define RPMH_REGULATOR_LEVEL_SVS		128
-#define RPMH_REGULATOR_LEVEL_SVS_L0		144
-#define RPMH_REGULATOR_LEVEL_SVS_L1		192
-#define RPMH_REGULATOR_LEVEL_SVS_L2		224
-#define RPMH_REGULATOR_LEVEL_NOM		256
-#define RPMH_REGULATOR_LEVEL_NOM_L0		288
-#define RPMH_REGULATOR_LEVEL_NOM_L1		320
-#define RPMH_REGULATOR_LEVEL_NOM_L2		336
-#define RPMH_REGULATOR_LEVEL_TURBO		384
-#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
-#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
-#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
-#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
-#define RPMH_REGULATOR_LEVEL_TURBO_L4		452
-#define RPMH_REGULATOR_LEVEL_TURBO_L5		456
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
-
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0
 #define MDM9607_VDDCX_AO	1

-- 
2.39.5


