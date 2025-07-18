Return-Path: <linux-pm+bounces-31065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078EB0A838
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F314B5A337B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4362E62A1;
	Fri, 18 Jul 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odUf99go"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A232E6D18
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855238; cv=none; b=ix3Ud+m/aLe0yjCqAM8t0bxxQJBNsmf+hm9VYpFR7sLmW0l0pGKvmy5c/3rERLLDQpCKTP9iZxlBb7pmapeSQnfi77iyatpFd1i6YVvmnuQAzCDpuFNFx2CaP/AELgmpyohWCngC6KfV5dd397AnFTZkxc2AwGZ3EQdffjkjfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855238; c=relaxed/simple;
	bh=hKwIxLX6Tkq5ssXYijoQYUEhL4IdWqUldpJvuIWYf1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djYLEC16MirMKzgZpqJeHjWSMW3owrdbEb9FoX03zFG3ru52le0p2t0p2OksqRIYfGCh4W++Cixn0uOdkUvKhx0vlWY6nNPJ6f5zrTQT2cyD91tIO9LTVpHMBNGfhkaq+H0UfI0vviS9d7MtI8CcwV4CJ2rdC2NnF9k6qxRi2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odUf99go; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9vVpV015968
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bC86cQsWTQOgqMpG7vO8FaEN+Csh7UDonwPSnCbi+A=; b=odUf99go/JP/kCuV
	dDKnf240HKqwNgfq9OmBBOjUqazvW75E5X4uYiwv6GaO8+PKa3pj8csWZwiXETWz
	i+0FDTokvPYFYvEhdgR4xpYGqbzBO+G5E2pSoSxKhBHiRfmoL5XWhdDEWw4JUgRQ
	/ud24bNu6pYMJ3QnS/2dOeTuOikNsffmUG+erWVNGA8oRd8dwNu9DuVVaP0R31tC
	nxMcTXxXdZjaHEz9AbFDYamjACIXLws9w9kLPRvEtv70shYf9FwK4jvjyGqSdThP
	uElXPEQjCQ0Xutc2rW4nabKI626LWVSN6aMC7/QJse2oo48I0xfQSVfnbdkQYzlx
	nbnXjw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc43tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e2e237fb4eso388257585a.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855235; x=1753460035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bC86cQsWTQOgqMpG7vO8FaEN+Csh7UDonwPSnCbi+A=;
        b=bKIOZbM9AUQnRHvU4kzilj8jrZuWSnYt1Ys9pb0+l5g89asrhDQ+LdAoOz3mTwtpP6
         UW/zZC1qOePpVIOYSbG7D3L7ZVn9+tjx+UXn7SqfMzWxngDQQJ7dYI1wTcTIk+NvV+fr
         t8F1CxJtI+VwwkBQ3zzyyMzvxpg534EUjevj7Elj5xpFxd/jNLMszFoeV6WBPfLG/yCH
         UPFOriXrMiS+aD9S2GHzGSvxNSqbiK4iCfcQbEPpkR8hzn/svOzNduSFRCKuDcjhV9Hx
         8qO/Yb28arK8x91J/RHuaOiwH86tiwyrJr4tw/xsp2RoZqMLXDHhOBorNMuT7R3fOoLj
         qwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLp9nND98Wzg4yASS5m67TTDG/sUSXmyPZomE6+YLdrDe1CBVJGaGGMdCQGdfjiZWBrMVCYxnpng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/Xopj769VAe/+zFLHPVhjy5Bc/EA7l5QFE8ozPpVQcE9FBBW
	nL2YzFVzWTkk/MlptQYOv1esRdYtqI0Ob6K2ZVjQVChA5ZUdi1Kr1BIszmcZq3Rqse610fwhVc+
	JDqNpElB8eJf8NIXIAibfwJj0W9DDUMESiuktNNIRNqk9HwnruWCBAKlr/wshKQ==
X-Gm-Gg: ASbGncuGqed7jOWveelHSs7t6+LTcv9c7NiQALKgLbTG6lTpATO2FzustcSCsyK/LRX
	0lbyZct6k5AnCZ1LP+5pbyLxGoZkdQzqGZCEWwsDvGdvBCnwNAGQXgEUprnZrY9s0gkGhEWESm2
	8BteTemQi6sbK1tQ/3ZgFtGsEJfP3Y2yYKwosr9yRqqtOTz2LqM06Rn3BdZYNWDLT5U/+9mhKuu
	4JFX8n4+M4c/nY6zm4RhY9tx4myo+JnjFtzVFQVG4qdSv4jYXXLcYuQraZSzOsQK+XjXCehCO7b
	0g07G1vCFWv1CjIVhaS2VsqOLgi0udgNpkcdNnVDvYUhnfeyXWUfkAyJnr/NYyAanIsoy166iTS
	1JHtTl/S5Pzfpd7I2JR10wxTovES3n9omKkutmtaqqiuLG6OHaZc3
X-Received: by 2002:ae9:e302:0:b0:7e3:2db6:1163 with SMTP id af79cd13be357-7e34d9d2706mr818143185a.43.1752855231506;
        Fri, 18 Jul 2025 09:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/xfyE4EqYZs5SJKoG8l9Wmr7yLZMHsyXm0BSNJgn7dGYympaLxySGid05XcsqJ+9QPL8dQ==
X-Received: by 2002:ae9:e302:0:b0:7e3:2db6:1163 with SMTP id af79cd13be357-7e34d9d2706mr818138485a.43.1752855230952;
        Fri, 18 Jul 2025 09:13:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:41 +0300
Subject: [PATCH 3/8] dt-bindings: power: qcom-rpmpd: add generic bindings
 for RPM power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-3-eedca108e540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5883;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hKwIxLX6Tkq5ssXYijoQYUEhL4IdWqUldpJvuIWYf1I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3c1qXB/balMU/jlQcdeziArEdBNc7sKEd3
 ef4fwJs6OKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1SkJB/0WeBKjARPPuXb1n5taQMhySYAUcfJX1gsRiO3aUC1ORivBGXl2bytDlYboU1K56NYeWO4
 /khQR9GtaaZJ2TqnHrpnqA6Dxegz+/T/hwUFiSbXthk5YD5Br2JNJFkDvEJ9sSlEIHpyOKtnm+I
 ehbjPIgKY17hLhIxW7/MbhYrl964elgrZn0ue1Fk5HLan1wthQJt2fXyKChkQs/vk0BSWPweCBz
 z1DC5N7U37sxpfozs3+tYb0jsOYRWaBG9/K+9LDelcJEgjD6+pf5w+U26qORa0ShOgYGuguAzVS
 Fw+fqhrBAPr30ShCCGpSRD35A8Pp1LSqNF1p3u6lpUCgrqpl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a72c4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AzVmNdOAsp2gS-V4oEsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: IO4drOO2yNl0qBTP03Xue2CIbySZx0Ys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNSBTYWx0ZWRfXzHmIXOJYlLnR
 A/5BxLB6GgW3i+exdaU5uvdQgrYp1/T47sVKJ+dovIihciQqKYjSl3y7cVNtKlhWsg7VTbGbtzc
 wPz3cY4gXs5kQpSRstp31AHqZYcqh/UQ1df+LwH57NtjNWvW5ZzF+LKhC81jWfTwEZBJSf5ghNS
 kZXBMiPDClwvBgao188bDIjmxaUITCRjmYtXpwKM7x+ZlbtVSzGX9XLP6x9PVI+SAHbBDcXbB2I
 H0Kl6KsTjAo/WL6BjoW1mYCgerhQf72DHXxId2LBbOgGRDTF0TvZKMHINgFklm0imDYGpzuIjQo
 Zn8S24egRw6fciKVIT2KgGnIgC3EvUzH+cxeW7/c/ZxCaXQscC+Sl+WW2w6vNnqv29Qe/mZKr0Z
 aRE53CWblQoj+1ft6G7c6a3dFk1u6wfaLhohkzjdf/AzbQH+4E5IBneVwcM6j0QdDt7mdZ1H
X-Proofpoint-GUID: IO4drOO2yNl0qBTP03Xue2CIbySZx0Ys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=937 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180125

Some of the Qualcomm RPM PD controllers use a common set of indices for
power domains. Add generic indices for Qualcomm RPM power domain
controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 121 +++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 65f7d5ecc3521cfbc45d6158bd6143ea09f47302..4371ac941f29d9657b6573f4934658f100726224 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -6,18 +6,37 @@
 
 #include <dt-bindings/power/qcom,rpmhpd.h>
 
+/* Generic RPM Power Domain Indexes */
+#define RPMPD_VDDCX		0
+#define RPMPD_VDDCX_AO		1
+/* VFC and VFL are mutually exclusive and can not be present on the same platform */
+#define RPMPD_VDDCX_VFC		2
+#define RPMPD_VDDCX_VFL		2
+#define RPMPD_VDDMX		3
+#define RPMPD_VDDMX_AO		4
+#define RPMPD_VDDMX_VFL		5
+#define RPMPD_SSCCX		6
+#define RPMPD_SSCCX_VFL		7
+#define RPMPD_SSCMX		8
+#define RPMPD_SSCMX_VFL		9
+
+/*
+ * Platform-specific power domain bindings. Don't add new entries here, use
+ * RPMPD_* above.
+ */
+
 /* MDM9607 Power Domains */
-#define MDM9607_VDDCX		0
-#define MDM9607_VDDCX_AO	1
-#define MDM9607_VDDCX_VFL	2
-#define MDM9607_VDDMX		3
-#define MDM9607_VDDMX_AO	4
-#define MDM9607_VDDMX_VFL	5
+#define MDM9607_VDDCX		RPMPD_VDDCX
+#define MDM9607_VDDCX_AO	RPMPD_VDDCX_AO
+#define MDM9607_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MDM9607_VDDMX		RPMPD_VDDMX
+#define MDM9607_VDDMX_AO	RPMPD_VDDMX_AO
+#define MDM9607_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* MSM8226 Power Domain Indexes */
-#define MSM8226_VDDCX		0
-#define MSM8226_VDDCX_AO	1
-#define MSM8226_VDDCX_VFC	2
+#define MSM8226_VDDCX		RPMPD_VDDCX
+#define MSM8226_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8226_VDDCX_VFC	RPMPD_VDDCX_VFC
 
 /* MSM8939 Power Domains */
 #define MSM8939_VDDMDCX		0
@@ -30,11 +49,11 @@
 #define MSM8939_VDDMX_AO	7
 
 /* MSM8916 Power Domain Indexes */
-#define MSM8916_VDDCX		0
-#define MSM8916_VDDCX_AO	1
-#define MSM8916_VDDCX_VFC	2
-#define MSM8916_VDDMX		3
-#define MSM8916_VDDMX_AO	4
+#define MSM8916_VDDCX		RPMPD_VDDCX
+#define MSM8916_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8916_VDDCX_VFC	RPMPD_VDDCX_VFC
+#define MSM8916_VDDMX		RPMPD_VDDMX
+#define MSM8916_VDDMX_AO	RPMPD_VDDMX_AO
 
 /* MSM8909 Power Domain Indexes */
 #define MSM8909_VDDCX		MSM8916_VDDCX
@@ -44,11 +63,11 @@
 #define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
 
 /* MSM8917 Power Domain Indexes */
-#define MSM8917_VDDCX		0
-#define MSM8917_VDDCX_AO	1
-#define MSM8917_VDDCX_VFL	2
-#define MSM8917_VDDMX		3
-#define MSM8917_VDDMX_AO	4
+#define MSM8917_VDDCX		RPMPD_VDDCX
+#define MSM8917_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8917_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8917_VDDMX		RPMPD_VDDMX
+#define MSM8917_VDDMX_AO	RPMPD_VDDMX_AO
 
 /* MSM8937 Power Domain Indexes */
 #define MSM8937_VDDCX		MSM8917_VDDCX
@@ -81,12 +100,12 @@
 #define MSM8974_VDDGFX_VFC	4
 
 /* MSM8976 Power Domain Indexes */
-#define MSM8976_VDDCX		0
-#define MSM8976_VDDCX_AO	1
-#define MSM8976_VDDCX_VFL	2
-#define MSM8976_VDDMX		3
-#define MSM8976_VDDMX_AO	4
-#define MSM8976_VDDMX_VFL	5
+#define MSM8976_VDDCX		RPMPD_VDDCX
+#define MSM8976_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8976_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8976_VDDMX		RPMPD_VDDMX
+#define MSM8976_VDDMX_AO	RPMPD_VDDMX_AO
+#define MSM8976_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* MSM8994 Power Domain Indexes */
 #define MSM8994_VDDCX		0
@@ -107,16 +126,16 @@
 #define MSM8996_VDDSSCX_VFC	6
 
 /* MSM8998 Power Domain Indexes */
-#define MSM8998_VDDCX		0
-#define MSM8998_VDDCX_AO	1
-#define MSM8998_VDDCX_VFL	2
-#define MSM8998_VDDMX		3
-#define MSM8998_VDDMX_AO	4
-#define MSM8998_VDDMX_VFL	5
-#define MSM8998_SSCCX		6
-#define MSM8998_SSCCX_VFL	7
-#define MSM8998_SSCMX		8
-#define MSM8998_SSCMX_VFL	9
+#define MSM8998_VDDCX		RPMPD_VDDCX
+#define MSM8998_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8998_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8998_VDDMX		RPMPD_VDDMX
+#define MSM8998_VDDMX_AO	RPMPD_VDDMX_AO
+#define MSM8998_VDDMX_VFL	RPMPD_VDDMX_VFL
+#define MSM8998_SSCCX		RPMPD_SSCCX
+#define MSM8998_SSCCX_VFL	RPMPD_SSCCX_VFL
+#define MSM8998_SSCMX		RPMPD_SSCMX
+#define MSM8998_SSCMX_VFL	RPMPD_SSCMX_VFL
 
 /* QCM2290 Power Domains */
 #define QCM2290_VDDCX		0
@@ -138,16 +157,16 @@
 #define QCS404_LPIMX_VFL	6
 
 /* SDM660 Power Domains */
-#define SDM660_VDDCX		0
-#define SDM660_VDDCX_AO		1
-#define SDM660_VDDCX_VFL	2
-#define SDM660_VDDMX		3
-#define SDM660_VDDMX_AO		4
-#define SDM660_VDDMX_VFL	5
-#define SDM660_SSCCX		6
-#define SDM660_SSCCX_VFL	7
-#define SDM660_SSCMX		8
-#define SDM660_SSCMX_VFL	9
+#define SDM660_VDDCX		RPMPD_VDDCX
+#define SDM660_VDDCX_AO		RPMPD_VDDCX_AO
+#define SDM660_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define SDM660_VDDMX		RPMPD_VDDMX
+#define SDM660_VDDMX_AO		RPMPD_VDDMX_AO
+#define SDM660_VDDMX_VFL	RPMPD_VDDMX_VFL
+#define SDM660_SSCCX		RPMPD_SSCCX
+#define SDM660_SSCCX_VFL	RPMPD_SSCCX_VFL
+#define SDM660_SSCMX		RPMPD_SSCMX
+#define SDM660_SSCMX_VFL	RPMPD_SSCMX_VFL
 
 /* SM6115 Power Domains */
 #define SM6115_VDDCX		0
@@ -160,12 +179,12 @@
 #define SM6115_VDD_LPI_MX	7
 
 /* SM6125 Power Domains */
-#define SM6125_VDDCX		0
-#define SM6125_VDDCX_AO		1
-#define SM6125_VDDCX_VFL	2
-#define SM6125_VDDMX		3
-#define SM6125_VDDMX_AO		4
-#define SM6125_VDDMX_VFL	5
+#define SM6125_VDDCX		RPMPD_VDDCX
+#define SM6125_VDDCX_AO		RPMPD_VDDCX_AO
+#define SM6125_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define SM6125_VDDMX		RPMPD_VDDMX
+#define SM6125_VDDMX_AO		RPMPD_VDDMX_AO
+#define SM6125_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0

-- 
2.39.5


