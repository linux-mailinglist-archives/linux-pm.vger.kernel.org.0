Return-Path: <linux-pm+bounces-16289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB829AC7AC
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6928487D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67101A0734;
	Wed, 23 Oct 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KyB9WbWz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B219E7F9;
	Wed, 23 Oct 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678942; cv=none; b=LzCi/2ePTrrvPR/W7HtTw5XOwZxlcjomT88NUxBjxBTfvfb9UdF2aWcLWTe5Bh57S/2vlQNuQ7GdcMtwC47pzDrcQ/k1r8AkmbHrm4AdS3jplO+VRQQTOkl+3+Cp/PKIWoxpyDFp65HKw+qTrJ1vOSjG0YugLZc7WQKDkgzRwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678942; c=relaxed/simple;
	bh=cHagzq0n7lEi+SdhYlYhjyJtJRlzIYr+rY98alLTMdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EWYPS5GXRJ9lLUc5ZE7yFmIfKgMW9uCaCEJ9V8U5P98z3EA0xHsjYo0mAJdyoRSrVE2nmoAh9XuV46jLsQLuqcdy9G8/w5SVejeP6OC8Jih8wF0LZ0zTCahsvfRRLjjSnTCVSwMUVjOj9mweuaDkBA/8eKtY/n7PmO8WpK+uPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KyB9WbWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9VMth024689;
	Wed, 23 Oct 2024 10:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZDXdX6CLF3dKf7gGuv8gHZ
	gygqnDOMYgX/iRubfIEAQ=; b=KyB9WbWzkvPPEgbGm/taSbtsfaYrZDyd2MlaHw
	M7SsDmPVosVG4KC2WS2pLL/sC8g/PngSVaJYsexrVURQTPfDtn0Asn6iduItS2ab
	UMvFz6RNZK2bGiGBWXETCqvuBVAeAqsUQcomgwrC/szpYKqD4EBDMOkVUauWO4Op
	cdRHBqjxBlrvgrdLZWhimAtWyyhU7I+CPXVV/nlHApeViYcRkxwUMSDy0lSYBBw2
	FyKpgQaN6PC+aLB2OjFk7rjUEn0ZQquGaoTG1Ik9g1V7Z+Jo5TJb9F4X9FEn7G0a
	qFotX8hLWj5dvk4wBHKkClwdq+vIOsdSd1MjVelvsj8H6LyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3uhu39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NAM6TS004782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:06 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 03:22:02 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>
Subject: [PATCH V4 0/4] firmware: arm_scmi: Misc Fixes
Date: Wed, 23 Oct 2024 15:51:44 +0530
Message-ID: <20241023102148.1698910-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: akv4dzHL370LDksHldObZRgcey22N4wV
X-Proofpoint-ORIG-GUID: akv4dzHL370LDksHldObZRgcey22N4wV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230063

The series addresses the kernel warnings reported by Johan at [1] and are
are required to X1E cpufreq device tree changes [2] to land.

[1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
[2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/

The following warnings remain unadressed:
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16

They indicate that duplicate opps are reported by the SCP firmware and
they are seen during probe. They will get addressed by firmware updates. 

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

Base branch: next-20241023

Cristian Marussi (1):
  firmware: arm_scmi: Skip opp duplicates

Sibi Sankar (3):
  firmware: arm_scmi: Ensure that the message-id supports fastchannel
  pmdomain: core: Fix debugfs node creation failure
  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

 drivers/firmware/arm_scmi/driver.c    | 72 +++++++++++++++------------
 drivers/firmware/arm_scmi/perf.c      | 40 +++++++++++----
 drivers/firmware/arm_scmi/protocols.h |  2 +
 drivers/mailbox/qcom-cpucp-mbox.c     |  2 +-
 drivers/pmdomain/core.c               | 65 ++++++++++++++++++------
 include/linux/pm_domain.h             |  1 +
 6 files changed, 123 insertions(+), 59 deletions(-)

-- 
2.34.1


