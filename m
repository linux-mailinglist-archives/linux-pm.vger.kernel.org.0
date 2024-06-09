Return-Path: <linux-pm+bounces-8820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A664901465
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 06:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72721C20D53
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 04:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612479F2;
	Sun,  9 Jun 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9mLrtrI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18784C79;
	Sun,  9 Jun 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717905795; cv=none; b=sGS6J8Yem/vRxB+Qo9jNb+BuZq4hz7z7MMa0oYgHeN/BCCfE1qE2nEFa8BEVr2kcrd5aXauiPOUj2RRC2Xp4UkZtDdMyeP2wx4fdQn/Y5N6yUWQuBZe1O057DJlIDKrUlHfdtf2ReBmBNmy9HepzunTeMWY3mjotYsyHTWtEqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717905795; c=relaxed/simple;
	bh=+G8rylvToyZMf6Ef92YfIsfhhHIEvlNHkuznkdJlNRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=K7Pjjyk8QWekaSFWPN1MqA6qtkbqzCUl8/fdLvJsoRSqIRSZ2JM0zwq0Or3aufaT02n90DtyJAEhDXyUoNPSE6HdqUUa4AC1yYzCdDR2bT8P2FW/KDkdxkijqCLDHfP7+Kr6RD1zpzNzmQad+LDEbhqMqNBmLtsSv79UsU6/6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9mLrtrI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4593H8lv021006;
	Sun, 9 Jun 2024 04:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YX5GA6YJcJC4DY/xZbHKJk
	4i8DEHF1YttbfbK+g7ZuA=; b=k9mLrtrIShOS7ep8I3+mP/r+UQjfiX9JQstqA+
	O/a4kWI0Zvouj0nh5v5SCUeSJw3m0N0zej9fIImLuRbXZUoVAPse8DaYU44NXVGQ
	xK4+MJb6i757ot0Sf8lktDU20KB8nzHS7J5+u77JKEedbCwOs/UVvToJPp+IO/Hk
	p3Vq9sRVl5E9+NCVOkGY0+QFJD0x3jkazLPOe+bOot7QdSLpFPskwl41/Hkuh3h+
	J3JFOHjGzu8/816tBTwkcvMBp4lzh6rqMp1LoGVukcODwzF46zRg4AZcgBPBr0DE
	tZ21DRXR29cEdg0CUEpE+8vjM6zBhWA4mv2/kCRDgBd9vhmg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yme8rsenf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 04:03:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45942xeH000782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 04:02:59 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 8 Jun 2024
 21:02:58 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 8 Jun 2024 21:02:54 -0700
Subject: [PATCH] power: reset: piix4: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240608-md-drivers-power-reset-v1-1-08dbc1a546a2@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG0pZWYC/x3MTQqDMBBA4avIrDuQSoihVyld5GesAzXKjLWCe
 Hdjl9/ivR2UhEnh0ewgtLLyVCrutwbSEMqbkHM1tKa1xhmPY8YsvJIoztOPBIWUFrTex94523X
 JQY1noZ63//j5qo5BCaOEkoZr9+Hy3XAMupDAcZx0zAE6hwAAAA==
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BQcEm8OiJQWmplj-PuWlqaQqsHZQc3WN
X-Proofpoint-GUID: BQcEm8OiJQWmplj-PuWlqaQqsHZQc3WN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090029

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/power/reset/piix4-poweroff.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/power/reset/piix4-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
index 7f308292d7e3..e6822c021000 100644
--- a/drivers/power/reset/piix4-poweroff.c
+++ b/drivers/power/reset/piix4-poweroff.c
@@ -106,4 +106,5 @@ static struct pci_driver piix4_poweroff_driver = {
 
 module_pci_driver(piix4_poweroff_driver);
 MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
+MODULE_DESCRIPTION("Intel PIIX4 power-off driver");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-power-reset-488bf66477c6


