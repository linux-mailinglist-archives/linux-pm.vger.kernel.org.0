Return-Path: <linux-pm+bounces-16830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448519B7BAC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E61F1C2105C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F619E96B;
	Thu, 31 Oct 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RhdAtFeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007D1C6B8;
	Thu, 31 Oct 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381302; cv=none; b=hi8Ba4RLM3Vf3NpnIBZHi4CYxUytM1Lq3XJ1Fl2qH44RjCveuxoguCYEOs2OwpnG1Wfx33sLbT9DO/FvVLcSebhqgj9drJonkBz8zj0zvB0vYYudVEqYetWxRIakHDnV7RM/3cFKoj3KHyBVE196ot0p21LpiQUl2L8Tu5kd5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381302; c=relaxed/simple;
	bh=J6N9Po5+94CgcZgqS9AgYA8qumoxWEU/9knF94jO/34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmaZX1Vw4zWOBovQkLelT8JRxVK1RiFllJ/uXKr4LnoHaZ3zJe7Q0oHW+PB6351J9q/w9upkARbaLEo1tIy7et4Gg8nRSiXhDuz9McN/BaBqa42OkmphU0kxJ3+ipfvUK5LaUUe0o62lVvyh3d5FASZE0FmO1nMpl+2LQ2AKAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RhdAtFeG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8AOrG030172;
	Thu, 31 Oct 2024 13:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wokNxyM6Gy0OMdkl4cgjg1wawN2GOERfsU9/vs2RYxk=; b=RhdAtFeGN6VfcyRn
	x+Fw/EbG5l2XVbLTm+AVYLA9lyG/KhhekTtCmi5Fq+UovtAXul9hNZxRHdpKHJFg
	5ScvJnvEUOwfyzA6tMREMSuPrqDOwU4P5iLFF4cqZhK9rDwOX6pun70HBhxlSFxh
	Shao6rtWrcb9Tt9tt0qaMNlmKpyX/iv7zYAU+75FJukB5oYFKI70eje+ZtY/lI5K
	1avRC+7SmQIJ8+ECzK879BTcT/wI019SSSvfZFksz7F600c3YlPZjqEskT92dpVm
	4SZSOW8FW+S4707O38D0hfFkmnIKveBDBs9gWkJuXfrvjrI7DSKiBfNNjFUB2NqD
	aKRGDQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grguqthg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VDS7r4005444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:07 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 31 Oct 2024 06:28:03 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V7 1/2] cpufreq: scmi: Fix cleanup path when boost enablement fails
Date: Thu, 31 Oct 2024 18:57:44 +0530
Message-ID: <20241031132745.3765612-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031132745.3765612-1-quic_sibis@quicinc.com>
References: <20241031132745.3765612-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wvDBv4j9u__dF9q_XhbqOgxoXw5p9R_N
X-Proofpoint-GUID: wvDBv4j9u__dF9q_XhbqOgxoXw5p9R_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=926 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410310102

Include free_cpufreq_table in the cleanup path when boost enablement fails.

cc: stable@vger.kernel.org
Fixes: a8e949d41c72 ("cpufreq: scmi: Enable boost support")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 5892c73e129d..07d6f9a9b7c8 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -287,7 +287,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		ret = cpufreq_enable_boost_support();
 		if (ret) {
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
-			goto out_free_opp;
+			goto out_free_table;
 		} else {
 			scmi_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 			scmi_cpufreq_driver.boost_enabled = true;
@@ -296,6 +296,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	return 0;
 
+out_free_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_opp:
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
-- 
2.34.1


