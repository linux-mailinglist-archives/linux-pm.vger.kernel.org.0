Return-Path: <linux-pm+bounces-14867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3C9883A5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884971F23B3F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27718B48B;
	Fri, 27 Sep 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D20yKn0n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD918A94E;
	Fri, 27 Sep 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438406; cv=none; b=sFCf16e4u4yAxxWHwpq6eaFKEYj0k9vtyAvbvQ4wTjGZCBqy2A3OSXWCCylhEgXY91f4onC2caxs48fkaFTPcdoMlKxs/ipRf05opO83BJpNadjl+0iWBmh2/R6rRup23BOFHwWTQ2fT6fLtwXfriUMqQO/AgDHLfHdOXYUFjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438406; c=relaxed/simple;
	bh=G5dRquXqM5Ubqce76JdRcHqMplZAPXMF3V21VX6sEew=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=An+CmXPrTLkmR5WD6ZjEfRmugVaZSfRIUpB/wCMNiuWgzk0oXUj0+yh+GPWWiJQ5s0ggtBBJEN3hcJS4Gcco5v25NO2zWR+ddo4Iv5n3yYsbsSK3LUNMnqjlrnNjCwVBpBVApTpIYou+WPB5LpuVG6nh9q0nGnT2J/QNy95enCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D20yKn0n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6pHLs000908;
	Fri, 27 Sep 2024 12:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CarDBbXgWJJuBnsQuU5FLI
	6/Z8gB5bLhrJy3KId03es=; b=D20yKn0n7DpXvM4X0rnyZ8qQ426dkrwqycXNw2
	q82Sv+hdAQKJzJTLuSDWzC460sdqxeTcQyMrmCq/aj4pc+7+qv93EWOCtlQEbDVA
	slA3x2GK4nQ3lpW6tx8lwJBBCwxu+rU0IyHFP8CaRzUq9qHgyzf0yd9jilKOi9mu
	RK837Cne/1dDE/v7IduTbZj+y6veQE+aJgYDWoS3Dihfttb8eXJU60IKXU2Ogb8l
	COBEiS6O3m+eD9Nj7KtCie6KzUtlycQ0hzrO51KZ2EoO4GFmWMFGQuqpbLEB6Ld0
	2v3uGExal3pZFHkZ68rWkZVnH7GGPK4TuYAYcnRENFY1OHXA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sjs3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:00:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RBxxaj016238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 11:59:59 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 04:59:51 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: [PATCH v2 0/4] Add rpmhpd powerdomains support for QCS615/QCS8300
Date: Fri, 27 Sep 2024 19:59:12 +0800
Message-ID: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKe9mYC/4XNQQ6DIBCF4asY1qUBpEq76j0aQwjQOgsBQWkb4
 92LJq67mvyzeN+Cko1gE7pVC4o2QwLvSrBThXSv3MtiMKURI4yTK2uxMkaOOjX0sh1REyKDf9t
 o/KDAJWkiZBtlmkPwccKtNly0lDU1J6iMhmif8NnBR1e6hzT5+N39TLfvQZGD+mtkigm+NoopI
 gSnRt3HGTQ4fdZ+QN26rj+2kJ0i5wAAAA==
X-Change-ID: 20240927-add_qcs615_qcs8300_powerdomains_driver_support-7cd487126340
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <quic_tingweiz@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727438390; l=1493;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=G5dRquXqM5Ubqce76JdRcHqMplZAPXMF3V21VX6sEew=;
 b=/U1N0ljo+LoqaZ1L2EPggyyzZa1Bhp2IpVrZdU7nLvlSd1oG3K13E6QAp8sQhGo2OVZbweg/A
 0XIKA2/b8s2Bt2lnQG2JYd2X6wtcx6PpTHsxWLpIweUvKetIiqlOADL
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PNTOGV6zXA9DeLoM0djQE-qrwJsNJyqb
X-Proofpoint-ORIG-GUID: PNTOGV6zXA9DeLoM0djQE-qrwJsNJyqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270086

Document the qcom,qcs8300-rpmhpd compatible and add power domains in
rpmhpd driver to support QCS8300.
Document the qcom,qcs615-rpmhpd compatible and add power domains in
rpmhpd driver to support QCS615.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
Changes in v2:
- Rebased patchsets on next-20240927.
- Combined 2 patchsets into one to resolve merge conflicts of touching
  the same part of code.
  - Current Patchset
  |
  |->Patchset 1:https://lore.kernel.org/r/20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com
  |->Patchset 2:https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com

- Link to v1: https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com

---
Tingguo Cheng (4):
      dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh power domains
      pmdomain: qcom: rpmhpd: Add qcs8300 power domains
      dt-bindings: power: qcom,rpmpd: document qcs615 RPMh power domains
      pmdomain: qcom: rpmhpd: Add qcs615 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  2 ++
 drivers/pmdomain/qcom/rpmhpd.c                     | 36 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)
---
base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
change-id: 20240927-add_qcs615_qcs8300_powerdomains_driver_support-7cd487126340

Best regards,
-- 
Tingguo Cheng <quic_tingguoc@quicinc.com>


