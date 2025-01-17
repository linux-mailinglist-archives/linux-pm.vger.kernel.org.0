Return-Path: <linux-pm+bounces-20591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B3A14852
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 03:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDB97A437B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 02:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07051F5602;
	Fri, 17 Jan 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g8SM3ZH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7725A658;
	Fri, 17 Jan 2025 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737081826; cv=none; b=ipzwXv1d36g8AtWQABKDL4x/JYOWV0EKlfj+Z+T9ZDuItQ+QDb/u4XqWstrI9N2jMbtp6942NihHJ87rZIvQ/P8GBoevdeFKlDbWA8OzTqI9YleFToWFsIPEHXwaxBSn4c790WxSvsCnqP8l7s0n9UNb8C0rik/ypS8/eTkB35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737081826; c=relaxed/simple;
	bh=zbZ2t1vkfbDU2ZuhfdVSCXuEXl7QJsqvc1frvFXKRQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMC40DP9FxdaKqrEPOb0kkwHMO/jx5gprZJ2fKS/JOjbUREnjNyBBr2tzhfAMB1L4iBULS1m+8pa5DSsgy77+3NzRoM16yiykPXDFhfKcG8HyO5amYqdUZ0BEj3eZGSwgUQhO+mAdzuisLeJsnskAS/bzUn/sRiK04YiWB4dLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g8SM3ZH5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H1o7vj025200;
	Thu, 16 Jan 2025 21:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DnyVNiqlQ+RSRCov/BakBMJqx01
	DaLLJIwRl1oiJMpU=; b=g8SM3ZH5y3JsKaZAJS5YUOofavNAjxHp4PuIRGQqa2V
	dE2wet/iGJGWLPEJ9f2QfPoj24VMerV23q4aXDoeFXdvbo5xUh2/0ryH8oT0moH6
	XTisZLAa6oWXBeDXtZ0hLR/0o0SDe7O69VGqWXhFx41MZD1M0mMXSN+QMAlzoufM
	PQbf9xx+WMbB57PCYLuvzpkUP8kLytZm7+tQdhWWiHUpIboaGsULQm4HzSqJWnEc
	REFq5mxrELUxhQ6dUZZ3JKAPxA/WfmTmYSRaQYIfZ5nq4AD911xsrZpz+ILOiwU7
	QldusJBMP9wbAjWFrsjz7HRpghXJdd1IFhu8VobTCQg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 447dw387p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 21:43:29 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50H2hSBV042360
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jan 2025 21:43:28 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 16 Jan 2025 21:43:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 16 Jan 2025 21:43:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 16 Jan 2025 21:43:27 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50H2hFaE024687;
	Thu, 16 Jan 2025 21:43:18 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Kim Seer
 Paller" <kimseer.paller@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2] power: supply: ltc4162l: Use GENMASK macro in bitmask operation
Date: Fri, 17 Jan 2025 10:43:07 +0800
Message-ID: <20250117024307.4119-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YP7DffjpTTIyyxN6V0Y9LhJMd2_xG3Av
X-Proofpoint-ORIG-GUID: YP7DffjpTTIyyxN6V0Y9LhJMd2_xG3Av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_11,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170019

Replace the bitmask operation BIT(6) - 1 with GENMASK(5, 0) to make the
code clearer and readable.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V1 -> V2: Removed inline comments after the bitmask operation.
	  Added Reviewed-by tag.

 drivers/power/supply/ltc4162-l-charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 24b62f000..23eb42629 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -410,7 +410,7 @@ static int ltc4162l_get_icharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0);
 
 	/* The charge current servo level: (icharge_dac + 1) × 1mV/RSNSB */
 	++regval;
@@ -449,7 +449,7 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0);
 
 	/*
 	 * charge voltage setting can be computed from
@@ -500,7 +500,7 @@ static int ltc4015_get_vcharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0);
 
 	/*
 	 * charge voltage setting can be computed from:
@@ -636,7 +636,7 @@ static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only 6 bits */
+	regval &= GENMASK(5, 0);
 
 	/* (iin_limit_dac + 1) × 500μV / RSNSI */
 	++regval;

base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
-- 
2.34.1


