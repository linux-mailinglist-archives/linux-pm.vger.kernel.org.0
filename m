Return-Path: <linux-pm+bounces-16726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206E9B6379
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01FBB22DC6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C21E9097;
	Wed, 30 Oct 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AJUJbdjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A31E9065;
	Wed, 30 Oct 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292947; cv=none; b=M+e5eQ7QqthcIAN31uUuuG5IIlTLndLXyrMLyR7WTBYdja9PulBI1Kt8N67kg47ShCR6pb0KXby9BYB+nJNM5BUVbPrJB1a+UFwXf70O6g0/MkHHflqzCmTBx1ghox2M1HOihmSH/RL8VDUfZSTmRtj2fWc9yw9SRHiKnt7ytrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292947; c=relaxed/simple;
	bh=yGAC02/OXwVAElgjrw9M1p1HsJ0jMyIz7X9crGFyAzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipR6GPzB6D9oWSCWZ0xNDnZvQWIORVGn/HfLxQ36iY0BV/b1jdHqiXGdFpOhUMScjlS2FB/f0zoP2S7KkaC/DhWg8rRvfpPjFBi2ZijEMAqPdoaaP5ya6TGxJcxb5iZG+HmrHYLJlEGvSrkM9ZcgUjXgSPHQPTUXnKXDaxsQo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AJUJbdjV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UAiItm004837;
	Wed, 30 Oct 2024 12:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wLBLPPV1MWhVilbS8xRR8J
	eUQrmYOr3BAE3UuHw7ebk=; b=AJUJbdjVvFgHPQqzVsmv6WPDmAXMYWO0Zu+A7Z
	WOsqJ78xzMyiWvSOtt2yJQRo1H6+hyTcQOV+MIefP577siOqAWK98jDryEAg75U7
	DkFmDEE3F1hqAPGreK2EAdCfeH4YzUVqBsgJ/CjTnE3/VVJMUHZPDtdliGeQXIng
	V0E9Hzz8uSahKqCTqR/93U4VGNcLVE2IgcyKCutXFdfXhTdfcCkcJ9t9PXo92ADu
	vbeVdvXXUFBmb/WBOWZJRoMmemq6CEglnlONvsxi4EkHgi2s8UxOclMbGfcXdY9T
	FjGlZcS4K3chSxzkiygJicjkI3Udv21Vfav/7luj6fAOUqHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt73xsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCtVJo012029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:31 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:26 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <johan@kernel.org>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>
Subject: [PATCH V5 0/6] firmware: arm_scmi: Misc Fixes
Date: Wed, 30 Oct 2024 18:25:06 +0530
Message-ID: <20241030125512.2884761-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OWoS-TWW7j9Csy0vkht9p_HmLYSyIhnz
X-Proofpoint-GUID: OWoS-TWW7j9Csy0vkht9p_HmLYSyIhnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300099

The series addresses the kernel warnings reported by Johan at [1] and are
are required to X1E cpufreq device tree changes to land.

[1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/

Duplicate levels:
arm-scmi arm-scmi.0.auto: Level 2976000 Power 218062 Latency 30us Ifreq 2976000 Index 10
arm-scmi arm-scmi.0.auto: Level 3206400 Power 264356 Latency 30us Ifreq 3206400 Index 11
arm-scmi arm-scmi.0.auto: Level 3417600 Power 314966 Latency 30us Ifreq 3417600 Index 12
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
arm-scmi arm-scmi.0.auto: Level 4012800 Power 528848 Latency 30us Ifreq 4012800 Index 15

^^ exist because SCP reports duplicate values for the highest sustainable
freq for perf domains 1 and 2. These are the only freqs that appear as
duplicates and will be fixed with a firmware update. FWIW the warnings
that we are addressing in this series will also get fixed by a firmware
update but they still have to land for devices already out in the wild.

V4:
* Rework debugfs node creation patch [Ulf/Dmitry]
* Reduce report level to dev_info and tag it with FW_BUG [Johan/Dmitry]
* Add cc stable and err logs to patch 1 commit message [Johan]

V3:
* Pick up R-b, T-b from the list.
* Pick up the updated patch from Cristian for skipping opps.
* Update device names only when a name collision occurs [Dmitry/Ulf]
* Drop Johan's T-b from "fix debugfs node creation failure"
* Move scmi_protocol_msg_check to the top [Sudeep]

V2:
* Include the fix for do_xfer timeout
* Include the fix debugfs node creation failure
* Include Cristian's fix for skipping opp duplication

V1:
* add missing MSG_SUPPORTS_FASTCHANNEL definition.

base: next-20241029

Cristian Marussi (1):
  firmware: arm_scmi: Skip opp duplicates

Sibi Sankar (5):
  firmware: arm_scmi: Ensure that the message-id supports fastchannel
  firmware: arm_scmi: Report duplicate opps as firmware bugs
  pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
  pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

 drivers/firmware/arm_scmi/driver.c      | 72 +++++++++++++------------
 drivers/firmware/arm_scmi/perf.c        | 44 ++++++++++-----
 drivers/firmware/arm_scmi/protocols.h   |  2 +
 drivers/mailbox/qcom-cpucp-mbox.c       |  2 +-
 drivers/pmdomain/arm/scmi_perf_domain.c |  3 +-
 drivers/pmdomain/core.c                 | 49 +++++++++++------
 include/linux/pm_domain.h               |  6 +++
 7 files changed, 116 insertions(+), 62 deletions(-)

-- 
2.34.1


