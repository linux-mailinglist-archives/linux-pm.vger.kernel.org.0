Return-Path: <linux-pm+bounces-29969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2041AF0F59
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDF1C26D0A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0623D29E;
	Wed,  2 Jul 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FehmnoY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDD233D9E;
	Wed,  2 Jul 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447614; cv=none; b=oHXlJfnRgx6v/f+tf7+y8tgo8GkXulIqMxd2gU9PhtprG4kIVgzWbfJpndGeOpC7CYuSraNlxakqHmLdhtiPJV+wNIp+emnQbyjDNBDenNKv0i/D78ida4olC/K0f/TX92ysx98LhlC1m3tFNZLWjfFs+JnV5PlZxhJE/T0lHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447614; c=relaxed/simple;
	bh=mhAUJwLGyWJWM5SoEqiWDX1ozKMiVyu7+WEYBedEpWw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Qqu9ztbgzHjGZ4e9s42uOslnN2pv/DQHGLh4DtyOB3o/Ad6xqsonDBOBqFdwvNMkTiaI3vree/y2cRgBzs+GLtfRyvlbX7uUaN+vjUfW8rPsVCEmxUHCDPg9xiiAR6SP0jz/cHvEfeifY9TZ20AtekWp9ityk1DH1Swq2kiaCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FehmnoY1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5625Bn8e024756;
	Wed, 2 Jul 2025 09:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dGErFcn2bbUfPM6EYCa3He
	g6EeeHal565bae2oygEyc=; b=FehmnoY1d7PyHiOmPU4x2GMQhblSfJUZU+fFZs
	4wDEroZ+1NgZNSKy6GYxW3+46slGyFcjWueiHTTiyZiS21wNMAvbfUxNobO4jkBT
	T5slpbeBxyZ7X+8jV3XvUD+hArWmRfZvgi3Jxr6Kz5/V8Osecg/7sFIWdQogPGEF
	o3IVLA1W+F+mD0wok1PigrqBQFCK3unshMiBwgzXq0TLci33SzZi/2VHRLBFZ0k7
	aCoXneBdT7+ehA89Wo3yUxeOMcoXwH2pvnoeSu8lFsHN+C5xAxhPWoMYzskpObQ1
	Yp/nyWK2Gjw0gfP6mtm9+Mf56tLlWNI1NKj6a8MiBdHj3QOg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9m07p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 09:13:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5629DR0U012657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 09:13:27 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 02:13:23 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v5 0/3] Add support for clock controllers and CPU scaling
 for QCS615
Date: Wed, 2 Jul 2025 14:43:08 +0530
Message-ID: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACT4ZGgC/32QTW7EIAyFrxKxrisgQH5UVb1HNQtwnA5qCDOQi
 VqNcveSzGZWlbx5lt/nZ99ZpuQps766s0Srzz7OReiXiuHZzl8EfiiaSS41N1LDFbMRGkIAvNx
 gWGBV4IzrHDZDTdqw4rwkGv3PQf08PXSi663Al0eTBcrZHvC+ejvYDZdP7FVwwCniN2CclxSni
 VIuXQEcOpTCkCiT1n0UKvoZXzGG9321s5mKJwS/9JW0JK21o5NCaTWqphVY86ZWne5wlLK2TrW
 GRraHPPu8xPR7fGJVR8p/jy61Z7Fty1HX2vDnLOy0bdsfYsPA6l0BAAA=
X-Change-ID: 20250625-qcs615-mm-cpu-dt-v4-b6b9bc7d3e56
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=6864f838 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=a7MBU3iHR-4UK4nVPLsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7Sa-EcWuHgivbyF7NZ0tzl0QW1TLf6Xs
X-Proofpoint-GUID: 7Sa-EcWuHgivbyF7NZ0tzl0QW1TLf6Xs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NCBTYWx0ZWRfX59chx2AqQDrX
 09P4BHgy8BYV5xdMqsb7QYZaNatuXX68Hrq3XsFWNBsrQGZO1rNxhBJ+3Tdy70zn2lUwQft4Bom
 Q7GZXHezXlV2jbgWL3xrFMw1+WwyWmspB/RfVUUtFg1XHZGTbRsw2Zmf2URnNTpsF4apGk/ihV3
 ra6r6lyjuqZAXgsx906kUzXX7gcTLIi91MrWdjy2cAVSMEcNjvTw4HP0hcH/eAc5WZKe4qQ99W1
 0TCkSlNG9LnV9Z85w0GniGzJYEXWqg8tgl7ygKEwRUpHQ7zZxNZxhFvTHIiXpHhEFxxYmJUlRHz
 Tr1sLvYmpzLoAEJL3ctbx2i1GVgcJbVD2tzUQnjo3LdVGp5RccyXxK6XXZNmaUgD0HoxlDKL+qY
 2Ins7as3wOLnyCc3KIDBPbIUgvodmUruQakw+iKKi5l+ODZd8qWgj+I0YASveJi5DHywTCMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020074

Add the video, camera, display and gpu clock controller nodes and the
cpufreq-hw node to support cpu scaling.

Clock Dependency:
https://lore.kernel.org/all/20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com

Changes in v5:
- Update the documentation for CPUFREQ-HW for QCS615.
- Update the device tree node for cpufreq-hw to point to the new compatible.
- Link to v4: https://lore.kernel.org/r/20250625-qcs615-mm-cpu-dt-v4-v4-0-9ca880c53560@quicinc.com

Changes in v4:
- Fix the typo(removal of "") from cpufreq-hw node
- Link to v3: https://lore.kernel.org/r/20250612-qcs615-mm-cpu-dt-v3-v3-0-721d5db70342@quicinc.com

Changes in v3:
- Move the cpufreq-hw node under /soc {}
- Add the RB-tag on (v2) from [Konrad]

Changes in v2:
- pad address field to 8 digits [Dmitry]
- Replace cpu/CPU in commit [Dmitry]
- Update the binding to use SC7180 compatible, as QCS615 uses the same
  hardware version.
- Link to v1: https://lore.kernel.org/r/20241108-qcs615-mm-dt-nodes-v1-0-b2669cac0624@quicinc.com

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
Taniya Das (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615 compatible
      arm64: dts: qcom: qcs615: Add clock nodes for multimedia clock
      arm64: dts: qcom: qcs615: Add CPU scaling clock node

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  2 +
 arch/arm64/boot/dts/qcom/qcs615.dtsi               | 80 ++++++++++++++++++++++
 2 files changed, 82 insertions(+)
---
base-commit: 2ae2aaafb21454f4781c30734959cf223ab486ef
change-id: 20250625-qcs615-mm-cpu-dt-v4-b6b9bc7d3e56
prerequisite-message-id: <20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com>
prerequisite-patch-id: 9879d98848e0c7b1a5d898d657c8318738c44ac2
prerequisite-patch-id: 6414e91724ba90fe820c3d2bb5caa720c99cf3be
prerequisite-patch-id: e4e24f3dc507891b70936c9587ee1416f1a53e6f
prerequisite-patch-id: 23062409b23977940c958bf22a215ae5dc45e93a
prerequisite-patch-id: c35335d37fdf9a7f665f1c6d79d34b091d45e291
prerequisite-patch-id: 9a0caaaa8d25634dd0db5edffbc939eb7e734c6c
prerequisite-patch-id: 0b08c5ea612ac291dd829f5e7e63c499cd2812f7
prerequisite-patch-id: 2327271def3656283d53dadb2ce9f8cd561249d1
prerequisite-patch-id: c97840c551e081b0b9bf6c0e77b551935454f62d
prerequisite-patch-id: 71f0eb0fb98c3177dcbe6736c120cba4efef0c33

Best regards,
-- 
Taniya Das <quic_tdas@quicinc.com>


