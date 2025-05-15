Return-Path: <linux-pm+bounces-27169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A117CAB7C7F
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 05:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C3F4E03EF
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 03:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACA2580C9;
	Thu, 15 May 2025 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JTltlSE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5051F9F51;
	Thu, 15 May 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747281217; cv=none; b=W406WhZturXOlxydvZS1A8PkPy3U9vnyfalS+sKDu/UcSwHmAheKQRLrcN0FUKwyn15Sy84ORU2Tt+/7GcSr+jXAJSFzxMtKJBfTzazsVlhVpDSmPByW4/ovuU0fJjIF9E/FeTyBSbyVx6cnf5hRKUTn7Aa6GeyYjPU/q+v0qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747281217; c=relaxed/simple;
	bh=RrCsXGlfR6WBV2rK91RSqdDpza2Aa7/EZMJ1DyqoeL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftLi9KpBf/N4XgY7sr4rAIg55ALm4AZYaTYyt+OTfJH1IqCSUOPXvJBrurAKnOzYNCW44v7RTzzr4zaiHW5OZZu9SXlFZIBuKJf5Yzr5I38OF0TL5kvBxcH3vcdHoif5ADt8TjTxXSggBd5ftdJMy+IWqXxze53ngCKAgHlUB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JTltlSE/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJShBo025487;
	Thu, 15 May 2025 03:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ld1RKsEAsCuP+g+udkbXYb
	bm/MEVYhIXmCt3JvtkAJs=; b=JTltlSE/m/GU8VubJQHNL5VpfbhZ9IItUEwPgZ
	j7btoHDx7/eaBElr0QHj8oLHgW615GBCAdCioXfbEoj5RDv4Cl9dw/l/gIsgbR5c
	BcTsh/3Uzc4nXtvrGDjH5vRKjSnjGa0KYt0ODv1vRE/KrmRfffTqKlhyL2tu2UFK
	UUuFr1hk9q5j1x5vV+ZZ+OMoJan1rg4WgIZyuqs4yxjlp3UurjKQ1+6S/girQh1J
	sYbPxG106AeewX6ntkRmhfHuNFZJYdaQys/i8MUKmD8wZu4HR4maPTGXAbBk/L2R
	Ff8rJwYDjwXMo+KjkA+lKABZ1WeX+rx9M9J4iuX/CuEJfzxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew4r9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:53:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F3rKhl022563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:53:20 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 20:53:19 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan
	<peng.fan@oss.nxp.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>, Peng Fan
	<peng.fan@nxp.com>
Subject: [PATCH v4] cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs
Date: Wed, 14 May 2025 20:53:12 -0700
Message-ID: <20250515035312.3119884-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yjlb2BcRSXE2d12PWi3S-o4z144rqt9c
X-Proofpoint-ORIG-GUID: yjlb2BcRSXE2d12PWi3S-o4z144rqt9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzNSBTYWx0ZWRfX3d+YX/SkQPtZ
 sDzIbmDn5ESYV09P5qjbSYRZqE0N+htiGom5mmCtjO8QB6Y6dhnBivS510pCHik8AyQU2m/aru9
 DaxTj7DUWUIGcmss76/u0vnLfFl90Vh1MKg7NHDiDCUIuRn6pWTE6xwRFsi0CVNT8Y7eQjNwXOU
 aVCdKpfTBCECZHCzHtRUkE//TTx5bZgsViefFutdK1NLM6P+3r6DH5vGCh+fFsE+ZWg+1Cbz1mh
 poVBt/ZCYOzDcBw7UpOv7mkxQvAuMUY44vrUhYB7Qmta0L5S8+1SPhAvvSom65Rt/NuXNNYQwZf
 lDQbnInaQ2CJl2469QghrUEYeuaM47ADFyoRjp1dhX1s8DuxJSZF1tIiHh/hdO3/roL46TUgCCh
 SCQYhFEl/IjkK0HqazBWHxwGFn/9dCLAynluwZo0TkQulWYajrtoZTe2/DUPalnj4Hv45YCS
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68256531 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=8AirrxEcAAAA:8 a=7CQSdrXTAAAA:8 a=Yfdy9-sE--kubaARhR4A:9
 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150035

Currently, all SCMI devices with performance domains attempt to register
a cpufreq driver, even if their performance domains aren't used to
control the CPUs. The cpufreq framework only supports registering a
single driver, so only the first device will succeed. And if that device
isn't used for the CPUs, then cpufreq will scale the wrong domains.

To avoid this, return early from scmi_cpufreq_probe() if the probing
SCMI device isn't referenced by the CPU device phandles.

This keeps the existing assumption that all CPUs are controlled by a
single SCMI device.

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
---
Changes in v4:
- Call of_node_put() after of_parse_handle().
- Collect Reviewed-bys and Tested-bys.
- Link to v3: https://lore.kernel.org/all/20250428144728.871404-1-quic_mdtipton@quicinc.com/

Changes in v3:
- Use dev_of_node(dev) instead of dev->of_node.
- Sanity check scmi_np.
- Pick up Reviewed-by from Peng.
- Link to v2: https://lore.kernel.org/all/20250421195206.3736128-1-quic_mdtipton@quicinc.com/

Changes in v2:
- Return -ENODEV instead of 0 for irrelevant devices.
- Link to v1: https://lore.kernel.org/all/20250411212941.1275572-1-quic_mdtipton@quicinc.com/

 drivers/cpufreq/scmi-cpufreq.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 944e899eb1be..ef078426bfd5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -393,6 +393,40 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.set_boost	= cpufreq_boost_set_sw,
 };
 
+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
+{
+	struct device_node *scmi_np = dev_of_node(scmi_dev);
+	struct device_node *cpu_np, *np;
+	struct device *cpu_dev;
+	int cpu, idx;
+
+	if (!scmi_np)
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		cpu_np = dev_of_node(cpu_dev);
+
+		np = of_parse_phandle(cpu_np, "clocks", 0);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+
+		idx = of_property_match_string(cpu_np, "power-domain-names", "perf");
+		np = of_parse_phandle(cpu_np, "power-domains", idx);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+	}
+
+	return false;
+}
+
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -401,7 +435,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	handle = sdev->handle;
 
-	if (!handle)
+	if (!handle || !scmi_dev_used_by_cpus(dev))
 		return -ENODEV;
 
 	scmi_cpufreq_driver.driver_data = sdev;
-- 
2.34.1


