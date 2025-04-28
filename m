Return-Path: <linux-pm+bounces-26325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E0A9F3CA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D9D3AC291
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292726F469;
	Mon, 28 Apr 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dwoN0zla"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EF26A0A6;
	Mon, 28 Apr 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851684; cv=none; b=QJcgPGbQeXsrdI+jozJPUA+W3XBqlpAqveLtGClREB0A6czKYR9ZWc//X4rKsidVR0HNgSSc+WY8mdgege9m2fDa1rVUDxxcgTO4oib+zyJVbtwW0bDUMmlvlItX5nrmzYe+mWsf4vu2STH81xDMv2zTWRAMH3YoKitCxhHguaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851684; c=relaxed/simple;
	bh=kuQ5RBS/v6Y1BV434gFacRwWCK5fX/TwA/KVwBQWMR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nc8hNjDxk1F1wA1YEvKMF5/RAEOM0ooLmWxzimqKTQ16SkcA6thsOr4e5C4GgDwDm6HxMbhOXyDHdR8gg5jdVb8HYVwBXxkSnltDLDfILui8EPSPlYPyd8+34ovCUSl9AeNUV5mQBFiazHw7tN5fqWRCDxu99qJneq57FzP2TTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dwoN0zla; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SADENS027055;
	Mon, 28 Apr 2025 14:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f2NMXreXM3PVotN+YOuIh9
	CVsLx7a/b/tTxSsV5l3oo=; b=dwoN0zlaeO97k3/XunMckPwwB72EHzpLgz//7h
	DrOERivFPo4oiZPOXeEAWyhRG9hrhLlKV/H4gRPwhmN67fvgw0EP7OVe0jC53wbD
	4LuhpaEMN5fNqTIcHwByHI9bVZiregF1nNeHz8cGoF9q1IeF+zWc/JMz35WlDGxT
	+/PBdCxllZmPljXXbmVrUn8+zZW/9dPljhlt13mfptmk16oxDiL1Cd2lcKZHu3WY
	eOIJS5iJH2MRdyuM/L6kqb8xe42hzFJEzK1+0J5DLX7PjES5fEiVyhj9sROtD/aw
	wyjNPRopE2v3Z1m9HRtgeKN8E1DrKygIvkfDtahDU0KQFMJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468q321gf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 14:47:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SElkPT027712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 14:47:46 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Apr 2025 07:47:45 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan
	<peng.fan@oss.nxp.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>, Peng Fan
	<peng.fan@nxp.com>
Subject: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs
Date: Mon, 28 Apr 2025 07:47:28 -0700
Message-ID: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=M7xNKzws c=1 sm=1 tr=0 ts=680f9513 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=8AirrxEcAAAA:8 a=z2bt77sjNeVQpZcblNcA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: K3-w76dxuPNYILj9uBgxADKSN0N5mjIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyMSBTYWx0ZWRfX31ICRIqjwAzc uyDtbrNxPt3Uyl8GaFw3Pb76Plhj+IAMFgeA9U5Je51HQ59TTaa8esEoVz6PXR/TmHjx1GNTHqa X3i9QW6NbAphFyb3hebWw0l/cgzvu+saYWjM79GkaJkP9VK2zw+pHinonx/0WRgeGl9ebL9FuVC
 ktHa3epY1OHt0OR+Xwqi+mXqbtIZgvaa4i7xxUfPOok4ZpN8WtkVJXc84bhpPGA9CEutojZwCob nkLKVTd4oqWPbKcA2MaR3r/8Nwo8xhXKtkCGu7rg6RImX9TrPqEOzH5NuIaD0AxfT3Y44f6/Jh/ 0ijhETY3gdqlBhJE5ag3B+QAts7MI8FfMYFB5XXw86pXm+HNiHQCFg/vNrpzIpQdG9Pc9oLUl23
 giFdI/g+LZLH2OIRv/Fsr3nOuCJ7i5g72n8Xp3HGwR7BUe0xmJW6T9k8Eowl+25r3Hcahoz8
X-Proofpoint-ORIG-GUID: K3-w76dxuPNYILj9uBgxADKSN0N5mjIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280121

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
---
Changes in v3:
- Use dev_of_node(dev) instead of dev->of_node.
- Sanity check scmi_np.
- Pick up Reviewed-by from Peng.
- Link to v2: https://lore.kernel.org/all/20250421195206.3736128-1-quic_mdtipton@quicinc.com/

Changes in v2:
- Return -ENODEV instead of 0 for irrelevant devices.
- Link to v1: https://lore.kernel.org/all/20250411212941.1275572-1-quic_mdtipton@quicinc.com/

 drivers/cpufreq/scmi-cpufreq.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 944e899eb1be..b63992de9fc7 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -393,6 +393,35 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.set_boost	= cpufreq_boost_set_sw,
 };
 
+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
+{
+	struct device_node *scmi_np = dev_of_node(scmi_dev);
+	struct device_node *np;
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
+		np = dev_of_node(cpu_dev);
+
+		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
+			return true;
+
+		idx = of_property_match_string(np, "power-domain-names", "perf");
+
+		if (of_parse_phandle(np, "power-domains", idx) == scmi_np)
+			return true;
+	}
+
+	return false;
+}
+
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -401,7 +430,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	handle = sdev->handle;
 
-	if (!handle)
+	if (!handle || !scmi_dev_used_by_cpus(dev))
 		return -ENODEV;
 
 	scmi_cpufreq_driver.driver_data = sdev;
-- 
2.34.1


