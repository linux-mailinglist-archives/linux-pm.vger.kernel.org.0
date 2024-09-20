Return-Path: <linux-pm+bounces-14503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080F97D04A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 05:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A361C211BB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 03:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4118C0C;
	Fri, 20 Sep 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WwrqBiMt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D223A0;
	Fri, 20 Sep 2024 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726803621; cv=none; b=g5xJr0HbUgOKoqQAaJUl6iyc6kte0OPMqO84v/6wOBYmqXBjc/0qOVRd0tPkoDRysWpszl+TBH/wf+cp/oSWRRF58FoKM3X/brlZbBjQ+g6Z/yxx5fq5euVGyEGHLj0LqYw6WTbCoraQ51dZOwq2xm7xuO+TeSmiSBhKxGWLxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726803621; c=relaxed/simple;
	bh=H+fD8RjT5mWdfCrQC6h70YEpWMFrdv0bfpBeHeixig8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=JgdtmpTi9ir441kixRdxS9MP0PP27D4i5T/0Axgoum8CbYPJG6zLX3xpup/xNMZ+VLl+Yl+iDq8RrbQJBAlI3cDxWS25PzuLHgkaKo2RL01DVH9jUWNCHkBZSbSqA+1ruFSTyOh01lAlx2obvoZ+/w1W4wSwj//XIqCAAh3aBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WwrqBiMt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ47cj004618;
	Fri, 20 Sep 2024 03:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NvjHoROa2CVwOd5E6H5WuS
	5Pd0lXb06ogNLiuzeUrWk=; b=WwrqBiMt19vcMdzKmlaq3nV6DgdXP5/JebRiJD
	Vy3gwD71Z4q5eEGEq0OKX7ctW/Qd5QOa+EsJnwIdSk8lgUSnVKMyJBr3MhKZQ4Xf
	y3Y8GLHHlsGmSj0FVWD15p0eME4zXyuak+5YHjSEFU6RicPzyUI1zlfNc8MyWk+c
	nQs16PLvwxhWy2fNIkVEc3dL7jEExuVN53v8fx9qVc4UcgK4UlidC6e3j1dZKiXD
	zHpg1LLzl3QOzTyb1oii4rvA7yS4Zm4Y608FCDjFFtmqG99J2VyfeedjGkoF3pXD
	GaqX0xoPgZkI1spBVPv6qjg4lEfCxF0qWGksfJ/qXxXYR5lQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdyndu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K3eF9b012973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 03:40:15 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 20:40:08 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: [PATCH 0/2] Add rpmhpd power domains for QCS8300
Date: Fri, 20 Sep 2024 11:39:32 +0800
Message-ID: <20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXu7GYC/x3NwQrCMAyA4VcZOVuIdZPqq4iU0kTNwbYmcwpj7
 27x+F3+fwVjFTY4DysoL2JSS8d+N0B+pHJnJ9QNHv2IJ48uEcVXtnBAjK1+WKk+kxSLpLKwRnu
 3VnV2x5E5YKYw5Ql6rSnf5Ps/Xa7b9gMoe3GmeQAAAA==
X-Change-ID: 20240920-add_qcs8300_powerdomains_driver_support-64ee80cd85c5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726803608; l=700;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=H+fD8RjT5mWdfCrQC6h70YEpWMFrdv0bfpBeHeixig8=;
 b=WUdxjXSsniLFOX0HUJTbbzPkLXIvwez36VOYmE15FT11M2KAKOWfKQ+SrL8xBRXfaBFBsdLKD
 fzre827irV+BE0ivZu/toGr2UfNA6RWvuOgLx2jFXxBpJicLDjrxWxs
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V_aiAY3uos0XpIvSp9Mz2VWd-gZ6wox8
X-Proofpoint-GUID: V_aiAY3uos0XpIvSp9Mz2VWd-gZ6wox8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=818 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200024

Document the qcom,qcs8300-rpmhpd compatible and add power domains in
rpmhpd driver to support QCS8300.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
Tingguo Cheng (2):
      dt-bindings: power: qcom,rpmpd: document qcs8300 RPMh power domains
      pmdomain: qcom: rpmhpd: Add qcs8300 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
---
base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5
change-id: 20240920-add_qcs8300_powerdomains_driver_support-64ee80cd85c5

Best regards,
-- 
Tingguo Cheng <quic_tingguoc@quicinc.com>


