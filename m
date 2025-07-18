Return-Path: <linux-pm+bounces-31069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A831FB0A85C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28B55A363B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73172BD00C;
	Fri, 18 Jul 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HddTm0sh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8F1DE2B4
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855715; cv=none; b=Lq1R2afmddMdB0p97aoNY+AYknB8J/d4y15YTQ3bfTVBWxGiadQTeLUrBQvM8qY4WbVqIGPJ2kYK6LOsYP092A0EQftitw+CNvSysNtMJ8QxfnZ1W4S33p7VamzgvaAu1qiUkGUzP0l8DUokLmKeR7feUZ/aW+K+NFS4fzDT/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855715; c=relaxed/simple;
	bh=qbZsoJ4WpXYeEtPSlbOZ2i4uthnkxzqWJFYyR6RgjZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNNaHrf9qkBg3k3Zy9Lb/m1HAS1J9dLlYKVfZRhBmXImSGwq87ihw0N2jvWmg/zKFqZn7B7FkQV7HuXiR8ZOxxM65l6L+u3LUqhZhS04OrlJcoHnBuPj/oHqyOELvasdBkbGQ8Ap0n4TPoFlOHMIkgXUBJ/qni6weom5Rxtl+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HddTm0sh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEdoYF020802
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x3jBTC4AynQ+yZKDFlQILcBO8zD5iMJ+Pqbi43VQy84=; b=HddTm0shYPQdh07y
	H1wHzpgPVDXBKe268xQ1R3/d2mQoUi+p78iYcBinNl7bdD1w7V0OAaZ+Lo+6PmLz
	rJpo3F0OSEEQVpHeGjAGNbJZPScHfSZQncRzbrfYj/bOW+5fvvggfhzB9+G3EgVy
	HO30MvyE+TumG19ORBp1OzdWGXyWyvgPL3iaX63W1b20QSWWMF8XH3r9tQZqfeR1
	8Gm56P1YcNuMreHMsPpbNzCtpfKiDfQxR+vM+NQdmJHcL9iPocSfADv6gBqgOdqr
	u8fk47Gm6pC4zvhmcrJdCMA3lWYlJFHfP81fghCj8+aHLBBeZWbesI4ICKxxAX65
	vbXqWA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpqamy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:21:53 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2d9e7fbff93so2359545fac.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855712; x=1753460512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3jBTC4AynQ+yZKDFlQILcBO8zD5iMJ+Pqbi43VQy84=;
        b=Lk0DDuz4xOgxEGaWmyJHyxTifX415CpxcNBbR4S4NmP9fp5cXMHn0hDFf5iYWw1B2Z
         IxUqZ2NZxV85ak2giILEP/SLm2Z/iFxpq9x7OAqG1BqoMqpgkuZJpxUurbWC+ipg3ORn
         +4HlwxmsYzCjylvKrWO1dofNd1/TL2QodEKNYrAPc03SlcLunJwxxq0j00q40lRvZlU8
         Am/9oEmcr4+Yi/teLQYAsMO91ZTgWJ1DKuied4DClKGxK9gb1gV3KUCvMNNstWqRsCSk
         aG/z+be8AqdBweXhu7WuvHYOorRuexpQ/u3I3hW3viOe7yBGuL2kvbGnXw70LWwi8Sqz
         Mhzg==
X-Forwarded-Encrypted: i=1; AJvYcCUn+ZrV1bTFCb8+BRBGdh2/SzpAKnLnlK8XBT5lA6ffAbW9C8ZjlOZ88PDQQY09JQEXb9E5+w1GFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRVlon3e521hk6Q1hAL0WuyMdVVkzgY9uI/hfctoUCK/Ardw6
	63KnmVVARe7Ml+PoVciPqi/YXIlusqOwM+zuxbDewnrxTDn5EGByAnxO/aQ4MfW2jlELtkZu8gQ
	geQbFiOKtOKiPjs2BWB3XvUd1Ahy7zA7F3l5112fDI8VMk5ok7MicVx7MnjDy4w==
X-Gm-Gg: ASbGncvKGj7TnmzXGJS8cSPA962xyb7tAzBwiADxlWKqqmrOava0ijM9RsAuwkWhGfI
	u080+gDSgmVmGTTxTPPy1KakAj0YbXlU4q99KH8NANfMGKYPgthyCE7IgX/glPubn5yWx/hiRYd
	WwLZcRqnFsIfJpgsdPRDiMlSw/J1wnk4Nv5no7oiH3HzeYj78gUSE+2NpOOalJPA7MvxE0/UuOm
	xwXDc4upphZY+3oftwn1hahXDhb9n/VSSPxccBeK2jcCcOZWalCSrarejedDHneRRUZIq2TTcW8
	76TrseL6/EbAtwEPJ3UNERsQXS0pIw5pjZAMCDsk1ruYjwQBixBT0xqREbwMPwkvXrdEeTy7NkK
	/VPmBL/AIJC+bFgRPTItG4/bzOmlZabJbjUrjSuo8me3L1gMk4nmQ
X-Received: by 2002:a05:620a:3d12:b0:7e3:4413:e491 with SMTP id af79cd13be357-7e34413e869mr1399588785a.61.1752855229365;
        Fri, 18 Jul 2025 09:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1122fPka/53dNADi6RlnmEas+Pvvg3ROQ+ycEnr8z5NvdDUj9fS6sYKgHvTRJw+APk0QlKw==
X-Received: by 2002:a05:620a:3d12:b0:7e3:4413:e491 with SMTP id af79cd13be357-7e34413e869mr1399583185a.61.1752855228615;
        Fri, 18 Jul 2025 09:13:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:40 +0300
Subject: [PATCH 2/8] dt-bindings: power: qcom-rpmpd: sort out entries
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-2-eedca108e540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qbZsoJ4WpXYeEtPSlbOZ2i4uthnkxzqWJFYyR6RgjZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3i/jyVE0ZIoibzrTm/1+blpzp8ZkkyxXI2
 lmruymnYleJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1dOnB/0XkwyWN4V3SDZec6oX7fdy2JHxJX5yUxi76qD0OcjvKJWJJvITSPq2Q7t+y+MeO8LA9sg
 hn5CMYqiaTBJXjMuheKlOa+HWpcSULkC+kShj+tJvNoY4VT7wJyErAeDgQhnaLLiugCLMzLccNC
 6dNJYkdLUK+ec9H6iCPZwzQrZcP3fW3PwA4xWyW9CFdLyS8apwtEr86mOwWawdNrcSrU0wOG/Za
 n1YI4j2c/kG58xlATqK1bUDrkH5RpqTFWdR6OdgY274q+ufGHNQjuztmRJ/HahZOx8A/JDxCzF1
 vp9pEVyK11RiuKRQ90xAr6DFdxwAT6r/0mmTae4wrpDLtO0s
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOCBTYWx0ZWRfX5Qk3+MrFsmLy
 5ThXCuS130JVgXsputGwoBmu0GQZcTkUczJnTgieedgAQS3BWs1L98li1wM8lNyLoJ6vH74fKF8
 DGbQkBMgXYi5zVuAOCGo4IbtVmk1qrjRw8XkA8C40AEoJekI3H1wljgkky7/KHa2EsifNUyW4w+
 IRhXIToh03z8gKbUypG9V/Wmxge1Y1hlZe8yI/1iy/9T8Sz94YxipvDRw2ILmz66vENlUmBAUhc
 QgKcKO9W19nd5q1YTdy5iyTO/Lqgu54yCoghw9o62yvBbj10w0y/0H28L2MBigyVDxqyxLrTtY7
 Uc6u0YM2LsFVjFNlWlmPYg3NccJ8ImoTN1NODSELmv8OxRR1XxytMJNouwZnVbg8ScYNlcZvn4B
 qRpxmdwlHbq3/Drmfkr638AV1S6xKYeWlZDMz0epuyRaxx1nxbAWc5ygwafe1y0agsLTgrFr
X-Proofpoint-GUID: uLf7QWFfoJeabwDQrJxuIrJV9lWuABGl
X-Proofpoint-ORIG-GUID: uLf7QWFfoJeabwDQrJxuIrJV9lWuABGl
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a74a1 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lzX941RX6UCYqbaESYMA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=788 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180128

After removing RPMh PD indices, it becomes obvious that several entries
don't follow the alphabetic sorting order. Move them in order to keep
the file sorted.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index d303b3b37f18e0ff63929f3fe197151c5a3d3364..65f7d5ecc3521cfbc45d6158bd6143ea09f47302 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -6,18 +6,6 @@
 
 #include <dt-bindings/power/qcom,rpmhpd.h>
 
-/* SM6375 Power Domain Indexes */
-#define SM6375_VDDCX		0
-#define SM6375_VDDCX_AO	1
-#define SM6375_VDDCX_VFL	2
-#define SM6375_VDDMX		3
-#define SM6375_VDDMX_AO	4
-#define SM6375_VDDMX_VFL	5
-#define SM6375_VDDGX		6
-#define SM6375_VDDGX_AO	7
-#define SM6375_VDD_LPI_CX	8
-#define SM6375_VDD_LPI_MX	9
-
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0
 #define MDM9607_VDDCX_AO	1
@@ -130,6 +118,16 @@
 #define MSM8998_SSCMX		8
 #define MSM8998_SSCMX_VFL	9
 
+/* QCM2290 Power Domains */
+#define QCM2290_VDDCX		0
+#define QCM2290_VDDCX_AO	1
+#define QCM2290_VDDCX_VFL	2
+#define QCM2290_VDDMX		3
+#define QCM2290_VDDMX_AO	4
+#define QCM2290_VDDMX_VFL	5
+#define QCM2290_VDD_LPI_CX	6
+#define QCM2290_VDD_LPI_MX	7
+
 /* QCS404 Power Domains */
 #define QCS404_VDDMX		0
 #define QCS404_VDDMX_AO		1
@@ -169,15 +167,17 @@
 #define SM6125_VDDMX_AO		4
 #define SM6125_VDDMX_VFL	5
 
-/* QCM2290 Power Domains */
-#define QCM2290_VDDCX		0
-#define QCM2290_VDDCX_AO	1
-#define QCM2290_VDDCX_VFL	2
-#define QCM2290_VDDMX		3
-#define QCM2290_VDDMX_AO	4
-#define QCM2290_VDDMX_VFL	5
-#define QCM2290_VDD_LPI_CX	6
-#define QCM2290_VDD_LPI_MX	7
+/* SM6375 Power Domain Indexes */
+#define SM6375_VDDCX		0
+#define SM6375_VDDCX_AO	1
+#define SM6375_VDDCX_VFL	2
+#define SM6375_VDDMX		3
+#define SM6375_VDDMX_AO	4
+#define SM6375_VDDMX_VFL	5
+#define SM6375_VDDGX		6
+#define SM6375_VDDGX_AO	7
+#define SM6375_VDD_LPI_CX	8
+#define SM6375_VDD_LPI_MX	9
 
 /* RPM SMD Power Domain performance levels */
 #define RPM_SMD_LEVEL_RETENTION       16

-- 
2.39.5


