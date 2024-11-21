Return-Path: <linux-pm+bounces-17875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536939D51B8
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4622B221EF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D8E1B5808;
	Thu, 21 Nov 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kBu9bAdf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF610A3E;
	Thu, 21 Nov 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210083; cv=none; b=jAecohOapAAug1j0tLzdrrUOE6cBTcJQXj07l22BI9KPsfbgTB084QGyFcEjN0ToRDmiqqWo+/+l+Ealw8QxJLK+85a+1eWAxhnaBb1ZwXXD9ETVShLhwNn4omkJ4jVyq5beKKnVIIZGj5wnzwKEhSevaKEPPhQ4RnBO4ukunW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210083; c=relaxed/simple;
	bh=CeEJClo5Z/NtuX0n68qqkqchg0lGopZGBLg2yU4rPps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1eA4NBiFr1MQDx99vyFNCk94d7yzYhsQI9dy99oCIOM4zTtf+VjJnR9GlmWhXIuvxg/upVR13+140BtwZ43KWuPWbCaX6eu80otobPyO9m/l3k4akoCoxUBpLHuIPUvIO9KZcQwKZrwwtSd7EQ2/s4MRfHYqjNFh7GYIJ/7Ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kBu9bAdf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL9tYto026218;
	Thu, 21 Nov 2024 17:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N8U1/ZzihtIK6IWiNh06Q/
	XYTz9DAnqy/GDTGkzugts=; b=kBu9bAdfB9CyKcfEeAco/dQIF9jcjc0M7CcVB9
	eexIUzB8CwckKbNelHs+n5PAzQAPqHOoiVOL4N1DxkgSVGmQ0SqOArsUbRDHUMCr
	x6orDcMTqCZq/u+FDWyJqF1ytDGeKn7I6UvJp7oLO9EGKaapU+yBjfCEzZidP3kz
	6XvFBQVBWuI2e7fsno0ZWz7h/KaqfOPYv/XoSyQmnvs01EOmUm4pjKcAN8oX1a87
	f+RWg8+GP49vQQh79AkQMOlBx9Et4pl29pt9akDQJDDA0I1Ybg/Z0baOssFoe4cB
	b9MRN3U6h+gohbC9q4zuLHcZwdU8q0NDPEJWvkZomg1zW+Cw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ebycfc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:27:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALHRwOW022154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:27:58 GMT
Received: from a629a2d9ebad.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 09:27:54 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Drop QPIC related interconnect and BCM nodes on
Date: Thu, 21 Nov 2024 17:27:35 +0000
Message-ID: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iaQVliiSMNgyrg30drhFUkPcQQYj4e4b
X-Proofpoint-ORIG-GUID: iaQVliiSMNgyrg30drhFUkPcQQYj4e4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=834
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210132

QPIC scaling is managed by clock framework on SDX75 SoC, hence dropping
the QPIC related interconnect and BCM nodes from topology to avoid the
risk of overriding the votes placed on QPIC resource by clock framework.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: qcom: drop QPIC_CORE IDs
  interconnect: qcom: sdx75: Drop QP0 related interconnect and BCM nodes

 drivers/interconnect/qcom/sdx75.c             |  25 ----
 drivers/interconnect/qcom/sdx75.h             | 118 +++++++++---------
 include/dt-bindings/interconnect/qcom,sdx75.h |   6 +-
 3 files changed, 60 insertions(+), 89 deletions(-)

-- 
2.39.2


