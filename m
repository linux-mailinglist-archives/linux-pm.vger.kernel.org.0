Return-Path: <linux-pm+bounces-20393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C713A0FDD9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 02:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0003A6552
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46A3597C;
	Tue, 14 Jan 2025 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UJ8RDgdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559E374EA;
	Tue, 14 Jan 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817222; cv=none; b=UyaXgJrlVGikmqHzp1qtAoCkUFQzJAJBrFWfE/OSVglHNdStKMG+ao0HvQZ0kUazCelfDZu8Z138ojkzOHVDRwnphSYyVw0IBsU0g192GfdDdkM9nvOHx7FyI6iVghwPc4ONLz8k+2ocYWccxkE4m7vsFQNxs3KvGii2i+mZGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817222; c=relaxed/simple;
	bh=tKlV9odr7YSRbxmArmPMLHTbJZm4DpSci6fTMfqHMYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BFvT1hFoNOtSPqrlWkx6/pSwlGzXWkne96UwfnGXnKmrStJo2vM5OIkOUUy0yTLtXawDkHqu4pp4GWJlQ5tjB7ZeJVnZ7X2Yk/0tFe/JW6exywaj6GKQZBCGyb/zfBk9VG8/fyKct91U0uP48gXOMBOwktUtCPgMagJuKuDOFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UJ8RDgdP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DMOAK0003109;
	Mon, 13 Jan 2025 20:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+Csp3qgt8w/D/J/kIv6i/fN2DGD
	RsOgJAN1P0ZZWZpY=; b=UJ8RDgdPdTjqApZGAIoa2JHXReiw16G2SLr0qlbmigb
	Yn5sNDM6uha15sJjVYif1HjsSU0BEBVx1ZP0p5EwJ75wfw7OYbA0HRoZgpIgdkY8
	T/rm4eGSBXT63iIN2obzV85ZuxR3eusgZh7+fCJqgIN4nfSmpwSWylq6vq/7gUyv
	kPcjQoGCyb8NRXBkKok0ZkU+hMfEYTvkE+W8yqNmcn8V2nYBEG/f4i4/Tv34whEh
	3bwFHRatjE07Qh1pE9c61q6ZBzLLFmC2cGNwl9A9iHRa/hmlV6hQduX6YWahW26U
	tUcR15N6cjFG2ncuLT7T48n6i3bM2Hm4jbqM+QRDdZw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 445bkhrkg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 20:13:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50E1DaY3050437
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jan 2025 20:13:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 13 Jan
 2025 20:13:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 13 Jan 2025 20:13:36 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.14])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50E1DQox013207;
	Mon, 13 Jan 2025 20:13:29 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: ltc4162l: Use GENMASK macro in bitmask operation
Date: Tue, 14 Jan 2025 09:13:18 +0800
Message-ID: <20250114011318.5784-1-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: j9udTEcDEdS8BJBDbmTa9XT-YVjq7xhh
X-Proofpoint-GUID: j9udTEcDEdS8BJBDbmTa9XT-YVjq7xhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501140006

Replace the bitmask operation BIT(6) - 1 with GENMASK(5, 0) to make the
code clearer and readable.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/power/supply/ltc4162-l-charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 24b62f000..db1a75c9b 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -410,7 +410,7 @@ static int ltc4162l_get_icharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0); /* Only the lower 5 bits */
 
 	/* The charge current servo level: (icharge_dac + 1) × 1mV/RSNSB */
 	++regval;
@@ -449,7 +449,7 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0); /* Only the lower 5 bits */
 
 	/*
 	 * charge voltage setting can be computed from
@@ -500,7 +500,7 @@ static int ltc4015_get_vcharge(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+	regval &= GENMASK(5, 0); /* Only the lower 5 bits */
 
 	/*
 	 * charge voltage setting can be computed from:
@@ -636,7 +636,7 @@ static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	regval &= BIT(6) - 1; /* Only 6 bits */
+	regval &= GENMASK(5, 0); /* Only 6 bits */
 
 	/* (iin_limit_dac + 1) × 500μV / RSNSI */
 	++regval;

base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
-- 
2.34.1


