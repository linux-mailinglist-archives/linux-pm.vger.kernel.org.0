Return-Path: <linux-pm+bounces-39425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992BCB47E4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 02:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E2D3059379
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE57F279324;
	Thu, 11 Dec 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/9Mp5br";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iyz+GhcQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F4275870
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417990; cv=none; b=KFaehdYW9jJu0LAjaC9VeopisSLzysaDA1Gxg14YVrb+jxpXfQait4bKZs5Hd4z+2wxO+Y50FH8OkHd+57qkIew/WtAuFrlDUeBTq0KdxDGgVMiiOrDGktlC7yFFzQ9DmOkE4tskWdG52xJ7sgqmk6l5GTCupl2efjGzY2vo2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417990; c=relaxed/simple;
	bh=9ckmh5P9uACZhbQ1z1bDXFTsaJgOxZAy4PuFVHTfrOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1PRd7wJ5/AlSgpJNV3UEmdFz/y3CYvw6cWDnOW7VTXyZEIi9RD0atxmJBhNpu4Wrr7bwMu5rKqfeNTSNyiPoqX0ZHUjCyHCtXlWiNEWQrP2LkzEt7hXNUUl4+TQhR43puN8GRZfmqmmSw5GUKDNanztdIAkwUanBOv2ND2MLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/9Mp5br; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iyz+GhcQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BALP62P3728172
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4E4K+yjTc09JdGkW+wirjJghAAmmJGypkhf/dbHy9r4=; b=n/9Mp5br+ei3ZP2L
	M3cOxW/YwKbJ7jh26iGwbgtoMHuTWA8kZ44VpmyYK3YXPAfYD06xo2JahfexkyEA
	e0sKbjbkOPLqh7FbecfIEn7Ep+zhBcQzKLs7d5AXKJacxY/d0SfhWh8F93EroiyK
	4CUa/W5CM3UR/LNoObop7v0x2J2J440yUCuv43s54qDeSZG8wnxVeZhbViKtzMxH
	+ToSEXgeepr2Dkd7PiTstNfANFSTVocoYD63MQ7zRWl0e9q3qrXlkGySl6OUJXtI
	CXpRpMvKlH+M76ewgqUn88JBDhmwTg5hM9qZlYJHXiMxr2UzuUcSlEM4/O+GagzC
	UWOpZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayg0prqh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 01:53:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b6963d1624so140321985a.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 17:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765417986; x=1766022786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4E4K+yjTc09JdGkW+wirjJghAAmmJGypkhf/dbHy9r4=;
        b=Iyz+GhcQNPqen7A0PVMDc8jEfnPYehXtIOGfJC9RmEq7mpoksnxau000Dp/6AiEpGX
         /t08N+wOS/q6CUc2xaeAro9aJE+BTRcwHXmNsBQpji0lKRi4LYYOEcRcJIqCjcCF6pP5
         3HJ5VQB9yvngy7R8nzFxb02NciqWNh1+nPa1NvAttO72GukahUf0QdoEDolK8zmRoEgz
         tQk5ixxN6ssKSF6aC6FOjfoCBNLtS2BT0bqRd6FTebc56njRvHXVykcM4ALlhW2Cd3yk
         AIp4FT6+jk5A6/m8NbhZzbT05nZ+FmWuu0hvr1jQ0C/5vExZqV3oRq5dvNIvgKi98kOh
         m60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765417986; x=1766022786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4E4K+yjTc09JdGkW+wirjJghAAmmJGypkhf/dbHy9r4=;
        b=Nj3XTTSd4wysOtM/QMqFm53yqd9cz3n/qh96jnvGoKJyw7s8JA1ubqwRHuZqYWfBmo
         LPXLaxQ+ZbtkwWqMqAxX4zAP9QDg8sa+6bIQQXb8idTOWZim0DDKNcutycb/Ke5k08/0
         apsaHKuVpgBYCQL1vaqCzZN5e69lceJnFQyCRmJvIV/SGcTswi6oUyY1YZ5V/hyUpuoo
         PETkHI1XE1jaPDejiMagMlHjtNoat/wAUZ9lF/ti4XvXmE2PW4g0CFZbbUv8qx4wWr2H
         Gw0aPjWQMHDZStfnX15a/Kw80eG2mhnw5yI0Wb6Cn8eowISlbD3Gu2agA/Ku8kARfA2D
         togw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0aCi8OnhQ7ZX3F4xkzERDYOxVwfN6BOi+e6imZaVmhC67p+eu5B6tN3OBeh8p0DpHMH49i5MRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/sa3CnhMMVxHOfP7QTuFLMrlwXm5ROgpY+ShjTWJnAWORTdP
	b018a1QsLCQs+Ze7mETSZgyQl3qPn+ZTDKZWDcc+QLkrOX4lT6bsJAmx/mobpYcVDLgBz2rm+6/
	5rqsOP1ljTZp7aluXIu6Yk5ZuM4YVpwITR5pyRZ0kBDWUGmkWtO9s2Co6doXw6g==
X-Gm-Gg: ASbGncvMTFJ7utBZxDkTLckPe8otIM32RlYSJAjZWuCsdpbJ4hPZ6vi5VA76/tkEWpB
	qu+eaNnnkohVXLkZyaA7Uzx2bKgF3J6YnTxfzM6GmSYsIoAF/262fEiZo6bfIg3oMi66bBElBic
	MF+do+0gFzP9iAr2RsFvnbi9N46y9WfS+96z88mXcNfMvBjmyTfUAezkITKiURK0FwlYr44Azbi
	2hi7GADVbiHbvHtNfZPSACtQuU2tGpAi/yKYCw75OvKd9Pg+k6KO1Bbx9UQ3JYAQSwm8ZlNNMYr
	Fd94WGwY9UgOsZmv6hryV7BO6UnoN72N8aZKsmGDAaV32AB7FxLMAzZM5mP78vSJoOnpBR6r0Vp
	eYb/eAgrRwoNSnKUhGCQ62xqWctaNQRowwpQq1G/NYX3oQT7aooGiMre1ScTvfXquet+HoOBUcC
	243BKQzEEk9Twd2coCVC3ns68=
X-Received: by 2002:a05:620a:46a8:b0:8b2:ea5a:413d with SMTP id af79cd13be357-8ba3a6680c3mr683696185a.86.1765417986007;
        Wed, 10 Dec 2025 17:53:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUTdOfhY85luSlGOTK6QICpH+E964eDVpxQn/Nc9qot8SFzvA01paLLw7VNdxXZZbD5VITjA==
X-Received: by 2002:a05:620a:46a8:b0:8b2:ea5a:413d with SMTP id af79cd13be357-8ba3a6680c3mr683694085a.86.1765417985512;
        Wed, 10 Dec 2025 17:53:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f95416sm393252e87.57.2025.12.10.17.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 17:53:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 03:52:54 +0200
Subject: [PATCH v2 3/3] dt-bindings: power: qcom-rpmpd: drop compatibility
 defines
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-rework-rpmhpd-rpmpd-v2-3-a5ec4028129f@oss.qualcomm.com>
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4718;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9ckmh5P9uACZhbQ1z1bDXFTsaJgOxZAy4PuFVHTfrOw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpOiP1P9D56YoR8WdQiNG8fnMkDkk89+7VwBVt6
 PEbRk8rvEiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaToj9QAKCRCLPIo+Aiko
 1SzPCACDJN6GqEnuxrLlLjtW/qM4ZMRsZPF0FDQKmlv+bVY/u0r5ogysf4bOR7uAtM3FS/LLzm1
 p516XiZLsKw30NYF0zaW47X1i2uI5ydVL2p6yoi+ZxdIo2Uhz6CNXyk33Kbf6qAL3ZjxNi36zpP
 mhRMVO/uFImoe3M0pElyO+f8GiWUJRTh9PyzM492LRihHQGr9xDQXGUesYbnjIRcHEMgGhA6OnZ
 X6Aoc164H0pUq0vZIqbQv7rNIlOMWwfxE+wU0GiKEu+jEoXwSWZwCoZRweWiTIOPYyibmhxiRP8
 rxvwoJo3Yg19WYRynk94TZJ6MQgF5F8TyxxcvAc8YFNCnlgL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 0gSZRLn6lye40hA4IqMp_n3e9flXdczM
X-Authority-Analysis: v=2.4 cv=b46/I9Gx c=1 sm=1 tr=0 ts=693a2403 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5zhblslti9ykmi4AA5cA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAxMSBTYWx0ZWRfX0rl2dFI6F6bC
 4ThyJJsvP8aH0BwsNnCZ/iqtkwZTpIJ9ZbVr7BTrq0mJHKKs/mAvkH8XW9JSjUKss1cIb0lrBZb
 7ew/+Vr0WV2wPTOI0xQBWFhyTx/v3LN7oetyty/DoHuKyDX8AX8Okozw0Irki9Wzvy90zU3v3t9
 Eg77XEmIQxPzpY+0PZAe0Mq2paEqlcJ/3LIqKiMSGiFNYI1ylIbqgmaib2wsRNFF8Rwbeq4X7cA
 e32ioyJRZtl3qOI8jDWxjrY0yKvhl7j89I68jOAMhx9AbCm7ootEE3IbMTKb5+kE/Zsf/8/tUhc
 aFAWe0OT9XfMrZVAP56JrX4IoND8b8wEa6We8UYbehPpWnVOa2HwBOSTiT84bDVzWhlWC9R+cPI
 DpCuLRxt6zfdFtk7nFqnVVqyfrM87w==
X-Proofpoint-GUID: 0gSZRLn6lye40hA4IqMp_n3e9flXdczM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110011

Now as all relevant platforms were converted to RPMPD_ defines, drop
compatibility defines from the qcom-rpmpd bindings.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 88 ----------------------------------
 1 file changed, 88 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 4371ac941f29..5405efa4cb77 100644
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
2.47.3


