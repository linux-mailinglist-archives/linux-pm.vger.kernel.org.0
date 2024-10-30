Return-Path: <linux-pm+bounces-16736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE829B6427
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 14:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90E5281268
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2101EBFEB;
	Wed, 30 Oct 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YFyqHMYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED321EABD0;
	Wed, 30 Oct 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295138; cv=none; b=ef03it4nHa6RXbL/+9Zv2mRPO4ELEGmzq2ADY5IUuLimS2rKNWJGIUnpYEYAgCLZWHjU+aMIl+MN7EA+gBMfEmP3r58wWzPLVXGdvUxKc45PGS/42aSsgag0gNP3tdMSeIAVc9f25ZTQm+KRTiQ0D1ECh/a7PeN6uJBb6Hq94No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295138; c=relaxed/simple;
	bh=b0OnCQghW9QVElgOiB0/VJEnC3vVic8d6AT2sPgDfIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgZ8nll/kMpTgf+Ah0s0tll8vWuGV7zQnmXdNkonfAQ+x0CoD0OKeiv/R0JpPt7XnC8p+WSrW2ty/GvJO+F9ios2fEO/6w58T5iyQcCKz2r/JIPZsx+hpYRQPY+buND9s1gvmGJMjr+G9OFaZfebHKL4nx0MOHG3hsKdcLGGTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YFyqHMYq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9ZbpQ012778;
	Wed, 30 Oct 2024 13:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vyOiJymB0nnDRku/t4g1pc
	FvAC1IuzmaO9Rq+PhkWF0=; b=YFyqHMYqsy32ma3bzD6CprZA/SAH1Cmd8qLTvj
	hlb0GqfJ3ghxdn3dkRzhFCwN0XM5kpUHAieYdu+FfENrhC0jX5iX7kl853RP/IcL
	3QuvRFbtZINuiNIl4/vdqSNEdm1skMRj1RlL3BZO/M5aZCSP38SorpRfbmA7A90j
	EJQo7Bmsxgi0x/0+7Ql4AelcaTf+zVoouZLQg+D//7RGgBh1rQMKr41qsIGUAv1f
	TRfFnHoigMhMG8flqnN6rWQkoJAJruFt1WxOksUdiYCe88hz6jSHT5+ae+w3jh25
	OzrOfYWuOm5Fog7ItpZyGWQXe7SPwSoIgWAY9qtT2VFjIl5w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k6rpjf9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 13:31:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UDVwZi006387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 13:31:58 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 06:31:53 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V6 0/1] firmware: arm_scmi: Register and handle limits change notification
Date: Wed, 30 Oct 2024 19:01:32 +0530
Message-ID: <20241030133133.2932722-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: usyqeks7XHTCpeLJzJIGkPIOknqe9vir
X-Proofpoint-GUID: usyqeks7XHTCpeLJzJIGkPIOknqe9vir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=875 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410300106

This series registers for scmi limits change notifications to determine
the throttled frequency and apply HW pressure.

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

base: next-20241029

Sibi Sankar (1):
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/scmi-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.34.1


