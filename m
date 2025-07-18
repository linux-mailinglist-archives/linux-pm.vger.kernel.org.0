Return-Path: <linux-pm+bounces-31072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6BB0A891
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9E71C47057
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6829B782;
	Fri, 18 Jul 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lw8xueDA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10B1ACEDD
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856653; cv=none; b=X7dH2e29gdmhtrAIKi/bgTg45sJ903olCinOOTCKiKyiHh8fcuoeEbORr2c2qAOsgaK9ymvxgQdfpXPAM2qgkITtCxYMtMCBwXfme7ngkWimA/tLzxj4oLljAMhAQ3xjQ4cmP8pcZH0Et6tztLx4+qsmPJ6aKGwGsjOd5n+3xUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856653; c=relaxed/simple;
	bh=+xxLOwS3MGx2kqnHazzxF1Z9hjd0cdKHphI3OkVanZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+hdqCDU6ckP25Zg9huMjH7Mc4VMsor10K/r6BSF9+ugI1p8fEoGK7npn0bbPUEEoiOkaMA8xZV2AvNxY6O4NM/wzTrD6lNd1cHtR7sGxJ2bBxbPCVEsZ3RipJ9GYKBkpo0dNU7TKf19AkGuulTCzjh7hD/fgl9W1eOqkn7C2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lw8xueDA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGPM6a025200
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	upe+/+ZNiN4rEM8lxNMtjuLncvLHFDi7Ix698gnE0ac=; b=Lw8xueDAzFq+c2mT
	ba/DSmcA+bFywa2eaZ4Z+8tmEq2IFrw7/IdjgwHxh++QTDetfUJHkKckdlUe494s
	uH+nx8sx+e/8k0wWPNVQFrz7EWQSnOVboYeVokMdyCtDfVsOxkFB6iMQn1/qx9p2
	vMxIxBuiC3MD1x7szYq/fr3pAWhpGwWlKNo4h9GrTt09rR34OKDPyV33zOiPUZFx
	uvr4CD+HaP1rLId4EBL9SfVVbxCl7vSxmqHGTjqMqomMd7Fu/8QWQlIJ5bNDrxdC
	u0+ZsQPAVO8uddGf4/wjLQ5Q9QD8uPEq3AKOOXUu/JJgEQBUvZo4o+/3QFVONXAu
	QYmqwA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqgfbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:37:30 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-615a76ac603so1126085eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856649; x=1753461449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upe+/+ZNiN4rEM8lxNMtjuLncvLHFDi7Ix698gnE0ac=;
        b=RQoMT6Y83fckEwK0h/btntDQh7OnhmhWab6pQnuiOlGPlwyr9IRdlcI/rnswlN90I4
         Ub8ABs0xwdyancuXTE5686Jv3Vi3Afs8jgE41oWijK6quqdHZdDCdrZShVF/RQgkt/Ez
         ZCkTLhLTpTm5vxZN0vIpxFTL6IzWAPNJwtx73IUnG4V1dN4zjxV/PgKuNpWtKi5r7yIA
         PfLJQywcbkk1S4D7YQ8VlS+U8Y877EsqaQXJVrygSxkyO62PzCIMFFlsBHXYzX8wTFZ0
         jM+4ZU+0r2wUTb5sjAfpxxxML2Cq01Q/rjQo+afsHQqnz5f9TkpibRzRoABkhHGgCuih
         h9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hRE7DmyDce6C1uExc668Ml1LzIjSXhp3KGH7IcyRhd1yPmAbm/5ISRjqbKXqtrHWDOe0Ajx3FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtGua2jffKSFEo1h1Hbw3KZ9fYAR6dcHKWfCGyOPYRaQ/zizD
	Gn7J4YJp8qvFob3577FMs6Ikdr7wt7vOkNPDkfk9kFOgw1a1Wos8EJeJYOHqPvlH9Wb0OgvVq9W
	vaUS3WocmBEouA/JsbWy+gcIfY7jPTqGF2/jzc0mPQW7LJhif/EPVKVDAVFUt1exQiKbruA==
X-Gm-Gg: ASbGncvBeLSH2aZSQt71PxOOfyc2M7Q3UhRO87r2CWlgTXR9GJFFyTQfLjBbRy4ukn3
	xiIM66MKGEJl1NY7hDw88PIw8H0T9opyX1dOqrGovYbyVq+jg0cQAJIyQKPWrZfSIFdGg/dc2Ai
	xBBgzjacv+sLVgFmGrv/Zrv6Nb85VVgVb1wYyeeuTKjp0wIrolK4UB7scStW7POiEoxATZuTZ7G
	ROW3p7pVasHJPdNOD2PxK/mBMnisD50ZgoAW+Q+Tkrf06AtBV6SAJo5ZyM/vknDCBVKql0GYLko
	O5NHWsPxhALKMQL6wWhBCx0r8kBEtUKdHcky7UE2mFxbBICT1Y1gaYH6P1ugFY3jyMDZLYTkPHJ
	GMiX4ezrGKfkvYuUD7MENBJvMnAeBLRP8GYZLIjbCXjFYNGAmpS45
X-Received: by 2002:a05:6820:308b:b0:612:c547:7984 with SMTP id 006d021491bc7-615a1ecd480mr7565415eaf.1.1752856648678;
        Fri, 18 Jul 2025 09:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiXloHUW/dJO5B/sZQcQE3qVCQt888ju18d+F/l6OyveVlh6FnxLRN/AcVdeTx/p+qx3IOwg==
X-Received: by 2002:a05:620a:4692:b0:7e3:3da8:1cfd with SMTP id af79cd13be357-7e343348060mr1756117585a.1.1752855237251;
        Fri, 18 Jul 2025 09:13:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:45 +0300
Subject: [PATCH DO NOT MERGE 7/8] dt-bindings: power: qcom-rpmpd: drop
 compatibility defines
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-7-eedca108e540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4721;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+xxLOwS3MGx2kqnHazzxF1Z9hjd0cdKHphI3OkVanZE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK4HhBlrW4LBOGjAi3YKM9tPJ00EfyW/7rmV
 BUhCPwO746JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpyuAAKCRCLPIo+Aiko
 1QysB/sHJ314jwjcgpVtgmwYMJFDToUfndEx6PnhAL9Gn45FCk5EehXwWUe95njZR42zFwX4wOy
 frgXN/cFZNIIKl1rG57nVRmNPKn3yXTRGd98AlY72IS60DkO2RV+gkpbSDUCrkdzSm3d3JvJWYe
 Aj9noA/27DhJAdmELhSkm8GUTKSz8r6TiopA2FeFK+rEffEqc7HYDw4m9h1tSYSRQlgyckx6cl2
 HoEPGbIiw5leKfldpHBBesO3XFGCAUiMDdpVBOlv/62mId2l3yOjz2p3qqeebby39nFLRfXQkdE
 +kvHuDI7xGRF02cNmnOVjGawyoMp9GQQDAopjK4TyIAoaX0H
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a784a cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Db-YKvRWyNvzAwfAYpAA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: GgBHfmPXjoe8_iB_Gz58bI0czZVyEtod
X-Proofpoint-GUID: GgBHfmPXjoe8_iB_Gz58bI0czZVyEtod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMCBTYWx0ZWRfXyZS69WVHySU7
 7RktGK+WiDe+dK7uvsH9RozdGuZ151Lfz+4FVK+uinUZras7X5NHUXrSAVcc2Wkn8HueLejYV+G
 PdW34gs745kw8gwPjMASwJX+PDylGdfIRBGbk4VAPtSWDyRCIh3IHdzkcIs7qA3nYrx7VPyNT5C
 jDw0ofM+S8b1ZSpIMYgKHEoyjisUQ7NIesMkzlHPTrPaEnA33fhqbG9fHGOijV3qOzr8Ac0P+Gz
 FoDusCEM0MRLuP4RW1b9aJp2ryNihV2/O6GRPQgKjsQbLmkH3X2wcDrLBheqWmUItiz5aKtPueE
 AH8SIqVAltAjY+d/7YKhNrKWM8LukTRAuimM+8dbNBiv+oqR4IC+njYRLp21sxdaBdKgfxmohrw
 pjigvJthBIThBPLVsJPjegYpYxwScAGehqDKdyu6nOEXVfk3OtNnI7p8OuVwo90Vbdik8lNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=810 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180130

Now as all relevant platforms were converted to RPMPD_ defines, drop
compatibility defines from the qcom-rpmpd bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 88 ----------------------------------
 1 file changed, 88 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 4371ac941f29d9657b6573f4934658f100726224..5405efa4cb77e8e6d43168889c5c83927060b780 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -25,19 +25,6 @@
  * RPMPD_* above.
  */
 
-/* MDM9607 Power Domains */
-#define MDM9607_VDDCX		RPMPD_VDDCX
-#define MDM9607_VDDCX_AO	RPMPD_VDDCX_AO
-#define MDM9607_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define MDM9607_VDDMX		RPMPD_VDDMX
-#define MDM9607_VDDMX_AO	RPMPD_VDDMX_AO
-#define MDM9607_VDDMX_VFL	RPMPD_VDDMX_VFL
-
-/* MSM8226 Power Domain Indexes */
-#define MSM8226_VDDCX		RPMPD_VDDCX
-#define MSM8226_VDDCX_AO	RPMPD_VDDCX_AO
-#define MSM8226_VDDCX_VFC	RPMPD_VDDCX_VFC
-
 /* MSM8939 Power Domains */
 #define MSM8939_VDDMDCX		0
 #define MSM8939_VDDMDCX_AO	1
@@ -48,41 +35,6 @@
 #define MSM8939_VDDMX		6
 #define MSM8939_VDDMX_AO	7
 
-/* MSM8916 Power Domain Indexes */
-#define MSM8916_VDDCX		RPMPD_VDDCX
-#define MSM8916_VDDCX_AO	RPMPD_VDDCX_AO
-#define MSM8916_VDDCX_VFC	RPMPD_VDDCX_VFC
-#define MSM8916_VDDMX		RPMPD_VDDMX
-#define MSM8916_VDDMX_AO	RPMPD_VDDMX_AO
-
-/* MSM8909 Power Domain Indexes */
-#define MSM8909_VDDCX		MSM8916_VDDCX
-#define MSM8909_VDDCX_AO	MSM8916_VDDCX_AO
-#define MSM8909_VDDCX_VFC	MSM8916_VDDCX_VFC
-#define MSM8909_VDDMX		MSM8916_VDDMX
-#define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
-
-/* MSM8917 Power Domain Indexes */
-#define MSM8917_VDDCX		RPMPD_VDDCX
-#define MSM8917_VDDCX_AO	RPMPD_VDDCX_AO
-#define MSM8917_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define MSM8917_VDDMX		RPMPD_VDDMX
-#define MSM8917_VDDMX_AO	RPMPD_VDDMX_AO
-
-/* MSM8937 Power Domain Indexes */
-#define MSM8937_VDDCX		MSM8917_VDDCX
-#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
-#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
-#define MSM8937_VDDMX		MSM8917_VDDMX
-#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
-
-/* QM215 Power Domain Indexes */
-#define QM215_VDDCX		MSM8917_VDDCX
-#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
-#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
-#define QM215_VDDMX		MSM8917_VDDMX
-#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
-
 /* MSM8953 Power Domain Indexes */
 #define MSM8953_VDDMD		0
 #define MSM8953_VDDMD_AO	1
@@ -99,14 +51,6 @@
 #define MSM8974_VDDGFX		3
 #define MSM8974_VDDGFX_VFC	4
 
-/* MSM8976 Power Domain Indexes */
-#define MSM8976_VDDCX		RPMPD_VDDCX
-#define MSM8976_VDDCX_AO	RPMPD_VDDCX_AO
-#define MSM8976_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define MSM8976_VDDMX		RPMPD_VDDMX
-#define MSM8976_VDDMX_AO	RPMPD_VDDMX_AO
-#define MSM8976_VDDMX_VFL	RPMPD_VDDMX_VFL
-
 /* MSM8994 Power Domain Indexes */
 #define MSM8994_VDDCX		0
 #define MSM8994_VDDCX_AO	1
@@ -125,18 +69,6 @@
 #define MSM8996_VDDSSCX		5
 #define MSM8996_VDDSSCX_VFC	6
 
-/* MSM8998 Power Domain Indexes */
-#define MSM8998_VDDCX		RPMPD_VDDCX
-#define MSM8998_VDDCX_AO	RPMPD_VDDCX_AO
-#define MSM8998_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define MSM8998_VDDMX		RPMPD_VDDMX
-#define MSM8998_VDDMX_AO	RPMPD_VDDMX_AO
-#define MSM8998_VDDMX_VFL	RPMPD_VDDMX_VFL
-#define MSM8998_SSCCX		RPMPD_SSCCX
-#define MSM8998_SSCCX_VFL	RPMPD_SSCCX_VFL
-#define MSM8998_SSCMX		RPMPD_SSCMX
-#define MSM8998_SSCMX_VFL	RPMPD_SSCMX_VFL
-
 /* QCM2290 Power Domains */
 #define QCM2290_VDDCX		0
 #define QCM2290_VDDCX_AO	1
@@ -156,18 +88,6 @@
 #define QCS404_LPIMX		5
 #define QCS404_LPIMX_VFL	6
 
-/* SDM660 Power Domains */
-#define SDM660_VDDCX		RPMPD_VDDCX
-#define SDM660_VDDCX_AO		RPMPD_VDDCX_AO
-#define SDM660_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define SDM660_VDDMX		RPMPD_VDDMX
-#define SDM660_VDDMX_AO		RPMPD_VDDMX_AO
-#define SDM660_VDDMX_VFL	RPMPD_VDDMX_VFL
-#define SDM660_SSCCX		RPMPD_SSCCX
-#define SDM660_SSCCX_VFL	RPMPD_SSCCX_VFL
-#define SDM660_SSCMX		RPMPD_SSCMX
-#define SDM660_SSCMX_VFL	RPMPD_SSCMX_VFL
-
 /* SM6115 Power Domains */
 #define SM6115_VDDCX		0
 #define SM6115_VDDCX_AO		1
@@ -178,14 +98,6 @@
 #define SM6115_VDD_LPI_CX	6
 #define SM6115_VDD_LPI_MX	7
 
-/* SM6125 Power Domains */
-#define SM6125_VDDCX		RPMPD_VDDCX
-#define SM6125_VDDCX_AO		RPMPD_VDDCX_AO
-#define SM6125_VDDCX_VFL	RPMPD_VDDCX_VFL
-#define SM6125_VDDMX		RPMPD_VDDMX
-#define SM6125_VDDMX_AO		RPMPD_VDDMX_AO
-#define SM6125_VDDMX_VFL	RPMPD_VDDMX_VFL
-
 /* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0
 #define SM6375_VDDCX_AO	1

-- 
2.39.5


