Return-Path: <linux-pm+bounces-31064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F4B0A83C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD51C40FCE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9372E6D15;
	Fri, 18 Jul 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFlfwSoq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C42E612C
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855236; cv=none; b=cZmosNrzgat3EwX9j4tSps2qMWthKo0epMlmBOXHlpf++HhbE+dQOAUT9DRZErLF+3BBwGFvRq4NZ8gCbulbO8XEnwuf10QuBZrmIzGrgKSAtVlUDbB1S4xl7Oo0lBJjj1aOoZhgGEo3RDDkQVsTjPoQo24x81jCnAHstcloKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855236; c=relaxed/simple;
	bh=PQ8nep6+2CkJ/XSkB12+zBFIYToc6uVoayIbLHk7IAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hd+ha/wQQoF+QM+suAH0BSiwDsgb71VY9TCppjFtOG3AdspJ4FG5WPaA7v9ncfzDL+j3RIlH76SnMDjTtDrL2BR4Gj2uxX/tSudoL/LDmUxXv4TBXm4Rorfe6ZgRxxpA0ziMMu8oiSlzKqdpAAZiXhzrhFRyr2rUP3RQDSROxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFlfwSoq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8SlsV000554
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ToUWdrHOvvzd4l32npkLp+sN31SJLS2F6Ly2KepaknI=; b=lFlfwSoqDHT1TY1N
	VPEpLTcEsQtxZCs2qakOqXo/4ZER0prB+NxDrImd7sC0xU/hVDdjShNNnum9zcZF
	aCjaC7xXWvkJjnSfUsOXACWK5cQXFNYND76q5nMK9ieBfDWg5XtNeZxR+P6OD44s
	SRMWUo8dEoVnvsi43HyEEUc8J1Ccq7tPcMBrkLYHlX0igLWdG7bKGGL4Frd5RChC
	/FsjUWLnUUdAZGwtJ+fCIUMolrgs6dvm5GF1Iv486KHKKMdGhKo1OTxVsKLxI2Xu
	DMf+QX1ky0LEAaeFCfPWgobHuGjZxTN3EdCS89zTcL0TsMtyTp0J4RIdmJkajngb
	f178SA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dry8xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e350826d99so297895685a.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855233; x=1753460033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToUWdrHOvvzd4l32npkLp+sN31SJLS2F6Ly2KepaknI=;
        b=C8CTb/LTIDyPYE7KWoebuolxOdiGEexIESed3MYx3yHG9t3wzlY6i14YzRjvPKSZu+
         Taow+zBrw1HOaYvgzSasRBEbntmj6t0DiXP15pSmhHabj6y0p/U1KUvT1C0tCWavlOIc
         T/TFxpnL2NR+OIjH3ZGLTktPv7X0oIJW6Gdn7SI8my4wVJbZb9r01M7ffGK5JUwfl/Fq
         WBgHWf9rbfpbsK0z3d1clcBkPUKkGjAox35rCDi8g8dUwLWT0vq16vaSSNR7mcoyLxQK
         Dv7li8p74m1Uj3C+vozsRi7QgrSDZyMBOx2Uw0bWLbjufd+ylbgah5LqO4ugRYhBvkRg
         LAtA==
X-Forwarded-Encrypted: i=1; AJvYcCVrM/xFqDEP+FuqFiqoEka1/nnJ3l6gmuAKBegl5OQGTgGriQ4+ynZZjCmtReuS5uRE7Anr5M7iaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36YoP3TlZzsG+neQ20wh11c2VwCzVdRSfP1sFiqLNl7+kdiOj
	HjjHfjT4iVs++e4OoNLhf7M7DzbShjWOY/pbHy7NFK0izihIjvgXZdDrYHg6nVLf7q/DdpuxhKG
	ejdnI/my/Wqnjp4O0HTOB6UZDtyoWVdWKhPtaiZzijZf2poL4zUl43QOJrbdEcA==
X-Gm-Gg: ASbGncsO8nlbPN63a+BeExLZm1ZjBPzUKni2ce6smvu2qJFengrGnzbK1r4wMIeqYU0
	e0z7IQFQwLFuqXlhqj5FcOi9Tm9hkhwyjv3yVjgUBJJOfGkciRa0uhXu4V3mNYiT80N1dGKQ73b
	xKtU8s+P2hqSSNg2n1MD0iIYUCKOmXF8lvPpTdWuksRxf8skdiUX57knZrqPJ3ooT4HsR2MzGlD
	VMoSj1tGaZ0BP7tRXAaToSq9mDCSgQA3wsjnFQATlw2A9Xgv+qDhqHMsoBs738qj4j5iJO7+J0q
	46j94R0yu3O+qOwIM7aq+YEPBfvuPnGq8pvajtrSpiM/Y8SWTbdo2cdofHdMFtO6h/lPbCzDdxI
	6gvWNQmtztIzFD5wqsqcFO4C0yfwS9tX8Iw6bU/lLXzaaADFGDNIz
X-Received: by 2002:a05:620a:2947:b0:7e3:3d2e:1f08 with SMTP id af79cd13be357-7e34361b247mr1657433185a.45.1752855232945;
        Fri, 18 Jul 2025 09:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1YG0jt9yWFaIGUj666c/NtISkNC4WDZgTnNihtZZCDJ9bbquyIoF7UFwFofEUy4lFvuRhlg==
X-Received: by 2002:a05:620a:2947:b0:7e3:3d2e:1f08 with SMTP id af79cd13be357-7e34361b247mr1657424385a.45.1752855232184;
        Fri, 18 Jul 2025 09:13:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:42 +0300
Subject: [PATCH 4/8] pmdomain: qcom: rpmpd: switch to RPMPD_* indices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-4-eedca108e540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6484;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PQ8nep6+2CkJ/XSkB12+zBFIYToc6uVoayIbLHk7IAM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK31D+ET4JXXb3RpsdqeFLE9iRYlmTx+o5vX
 ICQ4VXeLs+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1fRAB/9veeHp8Lre9JqC3BHTf4Nu8Ske2qUokDoR2mCLk5a+g2oDWpJ43Kawe0+mF9OZ1wj4fL6
 zd9gj0ES6Z9YD6oEYng7H4tFZTDyaQLMw2D2KfDaqqDJGjM7uIH359YYbW3pHp5zSfH5ShNecAU
 VmSLQIZoS7w8+RGPEhPUKtaW5fKo8PlPX8qWmUl1mEnLIqrPZB/QAY0KivUlQLZdvDXdvAQKboE
 jWKvPZ+sH9c0hfJfnYl4uygNzrNpmrmNPI/XQ+g55mES+E9+4DZOU5BcMBoc+9kX9gZyZ36Ep4V
 IaBVJ9Xb2I5S1oIz4beNVjJNTTI8FNEUxVI27jAkBIPHcEnb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: aHtkCPnyZgOcVCmA-V5ZnJLnx39WfCSq
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a72c2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9OzbfAs58j7jRePA22kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: aHtkCPnyZgOcVCmA-V5ZnJLnx39WfCSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX/Helg+ojZ/gv
 2uDaMKmkTamyUrGcF5jhwyEv1eCJtHDwyT2fexMRQFmn8zeWx5jQgd7o25I8vMmMJKiMtBOSTq6
 yPOBTtlhELazlLLqZ5mPfrwllrPtaXDgkhXgC7let1q9ym1RlbOpftrls8vPA3fBBSkQa9/2pjI
 +0HvHjSir1BSohY7KghJ6hWNBKrDAVaJe+u6htjPKaVJ5v9q0Nke7l36XXo4ZLJc5XQ1U84aWHz
 69eNtXBG57mPw+XV1FJUXGgcB3zoVCFc26cbR6FYtc6f/zaAGJLiTdVQ40JtVUyzjuzIqHU00YL
 Y5REkb8AETSofzMNTJO36wxXMIBXXeaf3A5JN2b5Rue/fTb3VMNK/CUsAgmUMUif/Ev9dSG1r7J
 PlluR45FNtR081tNvgi/i0V6YaN/lu+3aai4ersRgOM/fw6jfM6xbv2NKzgGIJjPSy15kZeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=970 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180126

Use generic RPMPD_* defines for power domain instead of using
platform-specific defines for the platforms that use shared indices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmpd.c | 112 +++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 833c46944600faa641d44ebe85db17280bb927b1..f8580ec0f73785544aeb6f686438f39b477d134d 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -631,12 +631,12 @@ static struct rpmpd ssc_mx_rwsm0_vfl = {
 };
 
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&cx_s3a_lvl,
-	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
-	[MDM9607_VDDCX_VFL] =	&cx_s3a_vfl,
-	[MDM9607_VDDMX] =	&mx_l12a_lvl,
-	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
-	[MDM9607_VDDMX_VFL] =	&mx_l12a_vfl,
+	[RPMPD_VDDCX] =		&cx_s3a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s3a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s3a_vfl,
+	[RPMPD_VDDMX] =		&mx_l12a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_l12a_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_l12a_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -646,9 +646,9 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&cx_s1a_corner,
-	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8226_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -675,11 +675,11 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&cx_s1a_corner,
-	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8916_VDDCX_VFC] =	&cx_s1a_vfc,
-	[MSM8916_VDDMX] =	&mx_l3a_corner,
-	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDMX] =		&mx_l3a_corner,
+	[RPMPD_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -689,11 +689,11 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 static struct rpmpd *msm8917_rpmpds[] = {
-	[MSM8917_VDDCX] =	&cx_s2a_lvl,
-	[MSM8917_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8917_VDDCX_VFL] =	&cx_s2a_vfl,
-	[MSM8917_VDDMX] =	&mx_l3a_lvl,
-	[MSM8917_VDDMX_AO] =	&mx_l3a_lvl_ao,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s2a_vfl,
+	[RPMPD_VDDMX] =		&mx_l3a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_l3a_lvl_ao,
 };
 
 static const struct rpmpd_desc msm8917_desc = {
@@ -747,12 +747,12 @@ static const struct rpmpd_desc msm8974pro_pma8084_desc = {
 };
 
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&cx_s2a_lvl,
-	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8976_VDDCX_VFL] =	&cx_rwsc2_vfl,
-	[MSM8976_VDDMX] =	&mx_s6a_lvl,
-	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
-	[MSM8976_VDDMX_VFL] =	&mx_rwsm6_vfl,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwsc2_vfl,
+	[RPMPD_VDDMX] =		&mx_s6a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_s6a_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwsm6_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -796,16 +796,16 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
-	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[MSM8998_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[MSM8998_VDDMX] =	&mx_rwmx0_lvl,
-	[MSM8998_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[MSM8998_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[MSM8998_SSCCX] =	&ssc_cx_rwsc0_lvl,
-	[MSM8998_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
-	[MSM8998_SSCMX] =	&ssc_mx_rwsm0_lvl,
-	[MSM8998_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_SSCCX] =		&ssc_cx_rwsc0_lvl,
+	[RPMPD_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
+	[RPMPD_SSCMX] =		&ssc_mx_rwsm0_lvl,
+	[RPMPD_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -831,11 +831,11 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 static struct rpmpd *qm215_rpmpds[] = {
-	[QM215_VDDCX] =		&cx_s1a_lvl,
-	[QM215_VDDCX_AO] =	&cx_s1a_lvl_ao,
-	[QM215_VDDCX_VFL] =	&cx_s1a_vfl,
-	[QM215_VDDMX] =		&mx_l2a_lvl,
-	[QM215_VDDMX_AO] =	&mx_l2a_lvl_ao,
+	[RPMPD_VDDCX] =		&cx_s1a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s1a_vfl,
+	[RPMPD_VDDMX] =		&mx_l2a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_l2a_lvl_ao,
 };
 
 static const struct rpmpd_desc qm215_desc = {
@@ -845,16 +845,16 @@ static const struct rpmpd_desc qm215_desc = {
 };
 
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
-	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SDM660_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SDM660_VDDMX] =	&mx_rwmx0_lvl,
-	[SDM660_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SDM660_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[SDM660_SSCCX] =	&ssc_cx_rwlc0_lvl,
-	[SDM660_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
-	[SDM660_SSCMX] =	&ssc_mx_rwlm0_lvl,
-	[SDM660_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_SSCCX] =		&ssc_cx_rwlc0_lvl,
+	[RPMPD_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
+	[RPMPD_SSCMX] =		&ssc_mx_rwlm0_lvl,
+	[RPMPD_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -881,12 +881,12 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
-	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SM6125_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SM6125_VDDMX] =	&mx_rwmx0_lvl,
-	[SM6125_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SM6125_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {

-- 
2.39.5


