Return-Path: <linux-pm+bounces-8504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AB8D78C3
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 00:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700BC1F2115F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9E6EB4A;
	Sun,  2 Jun 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WAHrVeKu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB5286A6;
	Sun,  2 Jun 2024 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366448; cv=none; b=rBk9DjfqoC2iWQU4RF9N1ZvvvbKW168Bf5Mp10qsz7L+m8BYICAAvxz6BI/WxpbP/oQuqJPhPMhXWqiWru60LzZqcu6nacLItqXrnqFLZUYQEZ3cbGcGgLKzi37hLRNAM+vVNd/MElOXcT2sWaC3ZMC1Q4gdeST3Ih6qG6ZRoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366448; c=relaxed/simple;
	bh=BKRhzguwuepLqpxpWf5x+zmzy7Nx6ioHCR3CVaasGKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=N4XnPKQjNqgsT7AxG2qZNQSQZdotNyPj0Hd9iWVWy4HBc1Gm2r6nj1avIk4X3H3M7zavosrvvmmdYAeFJSJyNFQzsqalRiiazsFC2/yrFYeAQuBpyQntOYLwQ9iPVJfZwok0XM53teqVphbBft1cpkaWPTk6cYE8Yyuln41R0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WAHrVeKu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452LsuCp027680;
	Sun, 2 Jun 2024 22:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LDZPqcxY+TCyn+Y7haSqqZ
	3clPN8tnlQABST1m1uKdQ=; b=WAHrVeKul+Cy72H5bCBNJtEKHm3rhvfY7VJU+Y
	8x5wdM4UTD+/iqNizeG/x6et2sfIPn7NM6tr8J6k81c4Gc43B4rjdr1igYQSRUSj
	Q7FUN0OPtNhqEd1oJNuUKkMRFfSLF0lHuNMBs7as7oGF4PspFYZBKQ0DeZnv1FGd
	ovlB6QccPfGeA0yNvmeRaT2FPHUVHSw+LuRAn+OTC7Fr9w5yHmZivab8hdVOqyPb
	WRr9at5deFZp3CAyd2C/jNoEpn1ustCg75/n9BAz3bRUWQrvGERjLo/tZgQVfbtE
	F9lKVsTJ3SnQfG5aLddEXsIdUp6D7ZOdjfPSLScChoNMrWow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bahs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 22:14:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452ME0Rd013282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 22:14:00 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 15:14:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 15:14:00 -0700
Subject: [PATCH] cpufreq: dt-platdev: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-cpufreq-dt-platdev-v1-1-63c7d91c00ba@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKfuXGYC/x3MQQ6CMBBA0auQWTtJqYrEqxgXpTOVSaDWaSEkh
 LtbXb7F/ztkVuEM92YH5VWyvGNFe2rAjy6+GIWqwRp7MZ2xOBP6tATlD1LBNLlCvGLf3c7B9Ia
 ovUJtk3KQ7f99PKsHlxkHddGPv9skcdlwdrmwwnF8Aa9xnciGAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: akIl7A0l9LAZkZ1UEfxYF76U05D_I58M
X-Proofpoint-GUID: akIl7A0l9LAZkZ1UEfxYF76U05D_I58M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406020194

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/cpufreq-dt-platdev.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index c74dd1e01e0d..cac379ba006d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -233,4 +233,5 @@ static int __init cpufreq_dt_platdev_init(void)
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
 core_initcall(cpufreq_dt_platdev_init);
+MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-cpufreq-dt-platdev-8673f080dd15


