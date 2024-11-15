Return-Path: <linux-pm+bounces-17612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70D9CDCD2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDF8B2228B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4E1B6CF2;
	Fri, 15 Nov 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qr2UBent"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B591B3942;
	Fri, 15 Nov 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667249; cv=none; b=S/zOiGOUk5alnxPOZa3hdx+BRWNlGkPB8kELy+U+rz90ggFND39biywowAYmWpYkknuJwG7srDf6j3fV5b8h0J/9tHjRo5OfCDFa2VK06Z201+4cs7/6wiyYs0L9Kmm+JeYUIaAz9KNa8zVGklLBMlG0gPTUVWNPHA8aSHzA5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667249; c=relaxed/simple;
	bh=sdSKaH9VU78ClbKLHSeWsMUrS5nh/IeGXJdKOndwyfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dGqWRfSvxICkoDExjzht+K+hHQOHV7LZzf53vw0ntSBTsjDHcFw87q6E/HP/yFDhEmW/wjGeE+jkqDt4840cha/GbLcf+M+06G33/4WlcITeVqxIl2H0K8dQ5euqsurQt/BHahsEFcq5vVC1YdVO59NgCwKIwqwK8QPptJgbnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qr2UBent; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8cdVv019874;
	Fri, 15 Nov 2024 10:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AWpE3/gjBEOlCTYc+Cu54q
	ThrlhZRvxVay6e057n+rA=; b=Qr2UBentEf3u5Y0DuS+TUQ8PWYNjEnHebbI3Nf
	bL+W6qVOtcwMHSGpZNOSiVX3hchzcaU4lZaV2xs/XsLG3pUnn52wj0+mz0HQ9cMJ
	no+iLi0EA796kDLAOhNOgoJ2tvI12kenwbBcMZKBj7lq3Ei6iHSsKbEXlfqFUQ3q
	gH0ErbePL29yt+F0pZV7qQeW+R0KPYTfL6QiTTYCvuASnIGUt0O4aGoTlChQpQ0+
	9yRUMLHyc4lX7SxaCZDZhw3yrmfhpvgfABEMCrOBRwUnS9SLp7SnbhorizoeaKDq
	9m1HZGcA8qPkpLr37IJOnb08Xk54JSXoFc2zHjvjNuTiV37w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v4kr3qgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAed3g014812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:39 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:40:33 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 0/7] Add TSENS support for IPQ5332, IPQ5424
Date: Fri, 15 Nov 2024 16:09:50 +0530
Message-ID: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: efcU5WldByi6W-qtspSGKh0NGkAx5mMi
X-Proofpoint-GUID: efcU5WldByi6W-qtspSGKh0NGkAx5mMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=756
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.

IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
(no RPM) hence add IPQ5424 support in this series itself.

This patch series adds the temperature sensor enablement,
calibration support for IPQ5332 and IPQ5424.

Changes in V8:
	- Fixed all review comments from Dmitry Baryshkov, Konrad Dybico
	- Detailed change logs are added to the respective patches

V7 can be found at:
https://lore.kernel.org/linux-arm-msm/20241107140550.3260859-1-quic_mmanikan@quicinc.com/

V6 can be found at:
https://lore.kernel.org/linux-arm-msm/20241104124413.2012794-1-quic_mmanikan@quicinc.com/

V5 can be found at:
https://lore.kernel.org/linux-arm-msm/20230721054619.2366510-1-quic_ipkumar@quicinc.com/

V4 can be found at:
https://lore.kernel.org/linux-arm-msm/20230719104041.126718-1-quic_ipkumar@quicinc.com/

V3 can be found at:
https://lore.kernel.org/linux-arm-msm/20230713052732.787853-1-quic_ipkumar@quicinc.com/

V2 can be found at:
https://lore.kernel.org/linux-arm-msm/20230712113539.4029941-1-quic_ipkumar@quicinc.com/


Manikanta Mylavarapu (3):
  dt-bindings: nvmem: Add compatible for IPQ5424
  arm64: dts: qcom: ipq5424: Add tsens node
  arm64: dts: qcom: ipq5424: Add thermal zone nodes

Praveenkumar I (4):
  dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
  thermal/drivers/tsens: Add TSENS enable and calibration support for V2
  arm64: dts: qcom: ipq5332: Add tsens node
  arm64: dts: qcom: ipq5332: Add thermal zone nodes

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |  18 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 135 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 201 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 176 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   8 +-
 drivers/thermal/qcom/tsens.h                  |   4 +-
 7 files changed, 541 insertions(+), 2 deletions(-)

-- 
2.34.1


