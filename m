Return-Path: <linux-pm+bounces-16829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785E9B7BA9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9858B20D85
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5219E97C;
	Thu, 31 Oct 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ShC/Oru3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C719CC0B;
	Thu, 31 Oct 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381295; cv=none; b=anzUI0M5efprru2UbkmfguKqAG5mt49WzfYbsrnGZf9UCJp+EntTQiUP/YIz01s5316EMb7cKUhYq6ZfzjgnIgYpnH9P6CR/COad4sAAK9Zm5tQoBXHlWa4KcXQ2hGwnZTroTUCsiyVh5A0WaizuoJggUiUoXGNM6Ww/pHXrT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381295; c=relaxed/simple;
	bh=qFfsnF03EgyGua0B3adfM1Dta52KKRnsCe6sPYZ3Xwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwVtdosT7mw/b+A2h8lkp8/Yrl+Ub6RspiVdfKspDjAz7M2XbsWHgklFkC3F8m5Hr4p01nCPCWowrhr98GTP4iHAEPWEaiVk7mB4YSxyRpOv+iy80NQnZpfGOfFAThWBkCMM8ZLYhcky85tWqk78E7t5H8G+qcfJ0b1dfZ4/kV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ShC/Oru3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8wa8n012693;
	Thu, 31 Oct 2024 13:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HYPyEheVCd3/44Em1ccl4A
	sWHUWbv3/V1AL6z17MpJI=; b=ShC/Oru3nCGgfjLl8XxG+5AKJtYOQebn1H1mj/
	IcniMz3v6H8gVq+Y7aQiRCc3Cay3HGR2VzGDq5iHDHSv26aDlmdutMdZstWjZdRQ
	asLNMJ4+LJm9IHe+/nR7XtZU/vp5RZvbWLW8g0QmkJbI5T3UqCGywTAAHF5P9w4/
	r+54pbqccwgjH1PN+GVTNG9c5ktgICZgMB/SPY7DqSrN0dowfh/zt8kavQwO0qo3
	66RNLEQz5PsygPXt3TIAlSGNZToC452JfWp4BodxEMHbV0T+5aa6z1d8qcj3350K
	2vADsbmdeFbBR87Ltxd7x//dE/Fn4X9CfCIV++ATnhWJ/ftQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k6rpp2s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VDS2bd011463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:02 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 31 Oct 2024 06:27:58 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V7 0/2] firmware: arm_scmi: Register and handle limits change notification
Date: Thu, 31 Oct 2024 18:57:43 +0530
Message-ID: <20241031132745.3765612-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4kRobGDffxY4F2YTXoJC1AdPEKLQ7cca
X-Proofpoint-GUID: 4kRobGDffxY4F2YTXoJC1AdPEKLQ7cca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=930 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410310102

This series registers for scmi limits change notifications to determine
the throttled frequency and apply HW pressure.

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

Sibi Sankar (2):
  cpufreq: scmi: Fix cleanup path when boost enablement fails
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/scmi-cpufreq.c | 55 +++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.34.1


