Return-Path: <linux-pm+bounces-7979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA58C98F6
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 08:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9BE1C20B55
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3133EE;
	Mon, 20 May 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwLA4Bix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166631758B;
	Mon, 20 May 2024 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716187095; cv=none; b=Yj36n7HWbuasd6ZwDZ0PITDhhrVMMS0MbcNZfT98Gyf33BnTvi25dLuu9CbPmhcmw0xVEf+bEqCej1/vqPQ/CX8WNjUtpzTN7XzoGcGpQaAudKp4y/GonrAThZEKxxsWm4wqR8reUFw5J8s6+xJe2PCqgxCPmJ2JJcRNnHVas2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716187095; c=relaxed/simple;
	bh=MD5tXJbWDoNRNah49iylpbl+MmYztbRmSyaR6nE++WY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOULEnYcwGn7pKmaY2drJVS9EwxdcafZdhQs1uiZGlAOsVupoqjfpvL8ZIf84LU3VE37vjys9vboRYbYwHCDR6yZHlA7E/Q+KYBpUciqTAMWXt12XLQLRPGLb/3jG5+gKcuK+riDvWkgla99yoV8tiuz4Qs0l7aRqE/S4dymwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwLA4Bix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K09ti4030101;
	Mon, 20 May 2024 06:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=zUDPaX2
	UonUEkEVKLUHQEfC/OF98n/1NswENGcH/67Q=; b=jwLA4Bix9nnXLiUPl/RjxUe
	VliJ7KqPl88jaN6uieD1unLJAgjREDz2C52lUBdArxbqAB1Yjhe/McHhCttosFTB
	dgIDwaqVA0YdsExx93k/xStvLQ0IgaY2nEtWIl8UfzMuh45+iCyFkXbsockkF2Iz
	NP2z4obws4LaiYY29DOv0mJiGRAUeM1Hg2Z/JYhXVfmdYZ3eWl+/7qx3LZ/hOApW
	vLJeAsaeMffz0Twrgk9fHPJ2Y4cId8VnDZ4ByZvkJWlNRpL8RazT4OFByS1sD9LM
	14HgvABUnGZxv/dM38amSr1Ya4Gek5r+3iazgMAJa3wZf5IBTbCkVySXt9A0VOA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p2v4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 06:38:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K6c2kQ030232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 06:38:02 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 23:37:58 -0700
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
Subject: [PATCH V2] cpufreq: scmi: Avoid overflow of target_freq in fast switch
Date: Mon, 20 May 2024 12:07:32 +0530
Message-ID: <20240520063732.11220-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: Cy6sbbZukCoe8hBBmu6suj4PS1vcWjTU
X-Proofpoint-GUID: Cy6sbbZukCoe8hBBmu6suj4PS1vcWjTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=920 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200052

Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
can lead to overflow if the multiplied result is greater than
UINT_MAX, since type of target_freq is unsigned int. Avoid this
overflow by assigning target_freq to unsigned long variable for
converting it to HZ.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
Changes in V2:
  - Updated freq variable from u64 to unsigned long to keep it
    consistent with the rate parameter in scmi .freq_set() callback
  - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3b4f6bfb2f4c..b87fd127aa43 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -63,9 +63,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
+	unsigned long freq = target_freq;
 
-	if (!perf_ops->freq_set(ph, priv->domain_id,
-				target_freq * 1000, true))
+	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
 		return target_freq;
 
 	return 0;
-- 
2.43.0


