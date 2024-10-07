Return-Path: <linux-pm+bounces-15241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE5992426
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C190DB22A85
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2015B130;
	Mon,  7 Oct 2024 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o+w9MCZ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2C1531C1;
	Mon,  7 Oct 2024 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281268; cv=none; b=ahUA8QmlP0b1utZVGDZh0vJaDS8TB+brG6SJvD26fYCd7BUH4sriW4ROHOPPH08FEmPtWkV7iiMtvX6R4a+HxTtkVFdgP7nHzoF57zEa6Fms/LNW+Ba1KJEJfnkjSOaY7Nyw0fbU8sew7KkTd8KpE0t3z1pZWqmopCZW1pCjL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281268; c=relaxed/simple;
	bh=1zkhF5j0Yfw8wEglWFoGgfvTDXqYAccNbdeOJh5HwDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUv/OJU2yEBUAdRAEyD5Ouped8cU+dxZsp638DKHCu+Nn4cXK9NGY9ZFxdDuzpEgG6EGBRhSWeyyL/xwpanFbxBWrjIK2BhU9v/9V2y2C96/3Z1xlaUj2XnuuIAeeHyMaNdnAIiJfkgIXxrZUXOUN3Xm+grv5JOfb9+hpniTDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o+w9MCZ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974TBtD027139;
	Mon, 7 Oct 2024 06:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pqc2VP+MLjp0hUrnxVvMv5
	GmaCVOoqr7kCbfwtJ+IGg=; b=o+w9MCZ0QjFq+KWkAv+heKkLjHm/mHpXXjDbrk
	4Zzld/MSVTTDvDgqGYEa/ZVuyivLnkvEl3gP69BhgQFrBYfprljg7gAGEtUTXHga
	6B3PZ04gewxT+eAU8IczytxFWmCEzxuFz+LzsXvmtYQFspWHyhlfeWHGptOCb688
	+Fv1sf8GNkePgxZ82rJPVKEZkLp0hyHzeTmZOst8PLXfH0aW/bd/pHP4NlhVXXzv
	+UdWx8MhkVsu13LHo4ZoBnNzPfzVpcuLs+58IykfP2VxIzIXMzmVabRQ59cZtXWV
	72R+Rzg5X+z1RPkD8PqpNZW/sHuxWPEI1vBdN9Rk0m+CVOlQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xu6b4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:07:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49767KFe007798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:07:20 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 23:07:16 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>
Subject: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Date: Mon, 7 Oct 2024 11:36:38 +0530
Message-ID: <20241007060642.1978049-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: wJGfF22zYrib2cyoxMDWMUaAIZOt_JD3
X-Proofpoint-ORIG-GUID: wJGfF22zYrib2cyoxMDWMUaAIZOt_JD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070041

The series addresses the kernel warnings reported by Johan at [1] and are
are required to X1E cpufreq device tree changes [2] to land.

[1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
[2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/

The following warnings remain unadressed:
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16

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

V2:
* Include the fix for do_xfer timeout
* Include the fix debugfs node creation failure
* Include Cristian's fix for skipping opp duplication

V1:
* add missing MSG_SUPPORTS_FASTCHANNEL definition.

Base branch: next-20241004

Cristian Marussi (1):
  firmware: arm_scmi: Skip adding bad duplicates

Sibi Sankar (3):
  firmware: arm_scmi: Ensure that the message-id supports fastchannel
  pmdomain: core: Fix debugfs node creation failure
  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

 drivers/firmware/arm_scmi/driver.c    |  9 ++++++
 drivers/firmware/arm_scmi/perf.c      | 37 +++++++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 drivers/mailbox/qcom-cpucp-mbox.c     |  2 +-
 drivers/pmdomain/core.c               | 40 +++++++++++++++++----------
 include/linux/pm_domain.h             |  1 +
 6 files changed, 66 insertions(+), 25 deletions(-)

-- 
2.34.1


