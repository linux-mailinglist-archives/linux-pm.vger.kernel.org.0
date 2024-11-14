Return-Path: <linux-pm+bounces-17525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDE9C80C6
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 03:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940801F265F3
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E01C1AB6;
	Thu, 14 Nov 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d5vD2FGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B2158DB1;
	Thu, 14 Nov 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551388; cv=none; b=OyFCwTCp5WTZJy4Y+B3MmvLaoUJwSM58kBggOrODCUDGLqBxkUEDR3h88yIekbhd3SAVv9GF4OG0UnOfqCutOj7QESMjx/RsGAsLl2flI6vrDjQ2J5ZhccWrvl9FfbSeQfwtPtoPCq/ARgKjDRgyBvaHqvT4BploKheJ+R+C3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551388; c=relaxed/simple;
	bh=+2uZXfETQBv6Bw+0CCidGP/zFprLF9Akv8+tPX3Abv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nobka65DWdZ987luNUrc/UMrUSnOIOkYgS1iqWIyU0lZWoQLKgXyQWFssHjJyn15Kr6ZfzRJaL7YLZSNiqQS7sBoEBIHWJhlDiSeJ5qf0guUfK4CLkD4xJAR3+I2D0w5qH1Axx3JJEj0ZwRwbNx58OaUVIgfrWu9dYTUmMBnBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d5vD2FGN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1ZCv025361;
	Thu, 14 Nov 2024 02:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/XFWMzXOJN0DmiAz834Zjq
	rvrr/ljxZnbS1N4jwbPsg=; b=d5vD2FGN2l+cui/Oh3IhlPj2z2YVHWGB4aYzco
	X2LKIa9mf//4/O06DA6vTgUOoM15KUmVmRq2/SN6BvTwmGKWe9gQMxUjAIpVoZz9
	EViE/tn/fiSdn655wLJClQj2ushCOZRhrVLn5YpYTeVe3473/isTrJyozr2nb/th
	jrA2NPpxyVoa2FQfCxM/tetJsINfx/JJIt/U49DVvS6bJYfkXNktHf6QdNJTYQEa
	RYVilmDXQenxuLiOER6nnHL2G1bamA4O3Btk/wlP27ZIgyUTDuhdaymIT7NPmu7V
	ZC3FQIwYwBDQb66GiSkTHFUFnNitb5yMartMYBzzNzCvo6bQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vgqqut3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 02:29:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE2TYK0031976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 02:29:34 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 18:29:30 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V8 0/1] firmware: arm_scmi: Register and handle limits change notification
Date: Thu, 14 Nov 2024 07:59:15 +0530
Message-ID: <20241114022916.644899-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 7AJqlshVTjnTHf0zBfBFHPIs_Nfqs9t5
X-Proofpoint-GUID: 7AJqlshVTjnTHf0zBfBFHPIs_Nfqs9t5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=904
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140017

This series registers for scmi limits change notifications to determine
the throttled frequency and apply HW pressure.

V8:
* Drop patch 1 since it was picked up by Viresh
* Leave policy->max update to the cpufreq_qos notifier [Vincent]
* We sanitized the range_max from V3 since we dealt with
  policy->max, now we can drop the check and policy member
  from scmi_data.

V7:
* Add a new request instead of reusing the max_freq_req [Vincent]
* Use the non-devm versions of register/unregister of event notifier
  since we have to remove them when the cpus get removed anyway.
* Add new patch to fix cleanup path on boost enablement failure.

V6:
* Unregister the notifier in the exit path to make sure
  the cpus work across suspend/resume cycles.

V5:
* Drop patch 1 and use pm_qos to update constraints. [Vincent]
* Use sdev instead of cpu_dev in dev_warn. [Christian]
* Pass sdev directly through private data. [Christian]
* Dropping Rb's for now.

V4:
* Use EXPORT_SYMBOL_GPL instead. [Trilok]
* Use a interim variable to show the khz calc. [Lukasz]
* Use driver_data to pass on the handle and scmi_dev instead of using
  global variables. Dropped Lukasz's Rb due to adding these minor
  changes.

V3:
* Sanitize range_max received from the notifier. [Pierre]
* Drop patches 1/2 from v2. [Cristian]
* Update commit message in patch 2.

V2:
* Rename opp_xlate -> freq_xlate [Viresh]
* Export cpufreq_update_pressure and use it directly [Lukasz]

base-branch: next-20241113

Sibi Sankar (1):
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/scmi-cpufreq.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
2.34.1


