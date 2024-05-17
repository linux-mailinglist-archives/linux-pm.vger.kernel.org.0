Return-Path: <linux-pm+bounces-7924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2E8C8126
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 09:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2C1F21107
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755514AB0;
	Fri, 17 May 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DsR8dTEH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E814A9F;
	Fri, 17 May 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929366; cv=none; b=K+YK0adrXvX4RL9xWyMLnuiL4GkbyMp8ZsfBB4kXBjtb8xwo9f7opmNioPH280K9saHsMQJ2qa1cji1blE2V86W4dX5qo2fKEmV+2HjefSw3PTcox7xFapO82rglqP/AZZb7MKZ/ZpyyltIsNrLa0T7ys5icL4xZJBS2lHmdWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929366; c=relaxed/simple;
	bh=yfF8T0qSQyJNeBh2GE62uu/f4rsUpxn6cGIf7Wi5s6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuYa11GCwDPbqFWvHeUnJH60ZnOPZuwpT2J8C+Z4RhXpMgwjiZTAW30u/H37MyglNSlJdi7SrhbXGWKWsK8/Q2edtO3upQhoRvkarSj70maLqi6GlawgOSsBmY4aP3C+tn0b2Vorl42qUCJrJyym/ucuM65DB5hmdWyACuqP484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DsR8dTEH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GKMq0H020849;
	Fri, 17 May 2024 07:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=EdfTodF
	m2OFLJ/9JBCUXk4QT9oTn5vS52O0Pgs8Cyqg=; b=DsR8dTEHmUYrF3uGJq2W0+S
	e5NBd8hJWGy1UX7GxkEKX6ORcTAaTodP4A3UtQZv0ESKxqyYJP0mTB+HcJ07yfHN
	u9FUn1ghijsNsa8ebplg/7Hu1qVefE2Wnwdm680lEnjVb8zbDJOkWh7YVX0kLpMO
	QB0ZQ+j5noNKLKnwLu1ozH4fcE4HiU0hIjbDNo6tyF80djukRQPKsvQnPCbemZzC
	e3BetdMIaWPE81ml+tZ4AN39rmCwyiSW/lD/iw+IRMKAb8Qh8Yw9ikC6HxFWxMaQ
	hsjAPHb3houB46xYhAB+OUmd7YDs45+r+Kd19qP8gs7gl2T0pgo3AMRWHS7SMOg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kw082p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 07:02:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44H72M09007517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 07:02:22 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 May 2024 00:02:18 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Cristian Marussi" <cristian.marussi@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vivek Aknurwar <quic_viveka@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Fri, 17 May 2024 12:31:57 +0530
Message-ID: <20240517070157.19553-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VtqDQfNAvGcP8u5ca1Ejpm2-7TMNedd7
X-Proofpoint-ORIG-GUID: VtqDQfNAvGcP8u5ca1Ejpm2-7TMNedd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=831 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170054

Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
can lead to overflow if the multiplied result is greater than
UINT_MAX, since type of target_freq is unsigned int. Avoid this
overflow by assigning target_freq to u64 variable for converting
it to HZ.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3b4f6bfb2f4c..42be87aebe6f 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -63,9 +63,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
+	u64 freq = target_freq;
 
-	if (!perf_ops->freq_set(ph, priv->domain_id,
-				target_freq * 1000, true))
+	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
 		return target_freq;
 
 	return 0;
-- 
2.43.0


