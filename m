Return-Path: <linux-pm+bounces-7509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE18BC32C
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13C22814F0
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EA6CDCE;
	Sun,  5 May 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ByPslHNq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789E2D60A;
	Sun,  5 May 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936048; cv=none; b=o6H1mt1d0QUULQ0NTcxAcYJwYMgnQez/URORiuBpv7HVfHgIyaZnzYY6VJzrZ96gDyAWYdnL5DG+obdtnDjsPoqJDdp6dnsTbWeEAlSr4HWuqDzayD6CYdbS4jFTqyblkf2Mh7s3A6KiOYT+Rr9pNy1ocT8sDGRVkxCuJDhEdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936048; c=relaxed/simple;
	bh=szmmLD1H/yLONpMiDrT0u1oFFCwgq8o/2sETDaKXb5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jvBLd/vXMY3lYoURH7tcgaopy/D29ciz0qSI+jSmOMhWWiii7vv8ACcwt+1JsBGwz26nRcp1HBb1Wul/SXjfKb2S9EXBy5Z+x4qfJH/dCZuHxiSBV4Aj/ecDNC49XPFfP2xLQO7FeFJiUgEhCGg1AZ123tKDmvZRfGKytmIjh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ByPslHNq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 445J59tw002953;
	Sun, 5 May 2024 19:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=9Pf
	w+fy0XFrWu040MiyBr71x0qncZZp6Lk8F3FLG2fk=; b=ByPslHNq3jvHcAbZmhM
	MeF0BC0JJamxQ6iemZtflyznpzm2Ww18DLvwt3LoFRNmLJ8gTR+dzQJGwhwdJ6as
	nv/rBtBqKYu3zckBcKeLU7akJqDE8HiRynKarwUdTeiFFQ1nHgGXFyj0wXIXC3D4
	Cvs1SUEYa8HZdlDz3f11qNDhOmPrv+D7/dSxO05+4jPg0aP/g751/2GH7IsFBVVi
	dwIg7ONvsAEFbgkN6f3ePmO8yZeKbWmffr6v6YWKMCDqDBM01Vn5dhszbPtYqZ9K
	3Mv2IIORXSxK/mWuhqcVYcjGrFnJ40NzJTb6vaVuRHq4ZnNDqJxVzcANKTirlTku
	Dig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwd8722eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 May 2024 19:07:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 445J7DC7020183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 May 2024 19:07:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 5 May 2024
 12:07:13 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 5 May 2024 12:07:12 -0700
Subject: [PATCH] cpufreq: intel_pstate: fix struct cpudata::epp_cached
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240505-epp_cached-kdoc-v1-1-c03800fe0d63@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAN/YN2YC/x3MQQrCMBBG4auUWTuQtnahVxGR6eSvGcQ0TESE0
 rsbXX6L9zaqcEOlc7eR423V1tzQHzrSJPkOtthMQxiOYQoTo5SbiiZEfsRVWVTCqcc4yiLUquJ
 Y7PM/Xq7Ns1Tw7JI1/T5PqS847fsXqmNeCXoAAAA=
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown
	<lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W9ipNlg63xv7LTPfCWtzPAjHPyOMC1P2
X-Proofpoint-GUID: W9ipNlg63xv7LTPfCWtzPAjHPyOMC1P2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405050083

make C=1 currently gives the following warning:

drivers/cpufreq/intel_pstate.c:262: warning: Function parameter or struct member 'epp_cached' not described in 'cpudata'

Add the missing ":" to fix the trivial kernel-doc syntax error.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dbbf299f4219..7ddf05c9ba88 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -213,7 +213,7 @@ struct global_params {
  * @epp_policy:		Last saved policy used to set EPP/EPB
  * @epp_default:	Power on default HWP energy performance
  *			preference/bias
- * @epp_cached		Cached HWP energy-performance preference value
+ * @epp_cached:		Cached HWP energy-performance preference value
  * @hwp_req_cached:	Cached value of the last HWP Request MSR
  * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  * @last_io_update:	Last time when IO wake flag was set

---
base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
change-id: 20240505-epp_cached-kdoc-aca091e33afa


