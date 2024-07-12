Return-Path: <linux-pm+bounces-11023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D192F526
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 07:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65E81F2293C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09518052;
	Fri, 12 Jul 2024 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kCzmUtZP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BE17C69;
	Fri, 12 Jul 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763359; cv=none; b=NPuzHS+QmTB77x9KOuSa/oLMD8+wGL7XQCt5AFzdyM3B+rwGtR3vBOxQe9YDs35r39te4TK7EdON+RB3fVCZd+oPNS7bYn93vB/uJeXTeMzpNhABUPHHhysmymnTjh5/PTxG3q2W3rchuyGiV+tfbrGRM/WST9k5DF0pnw3ZyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763359; c=relaxed/simple;
	bh=Ak0qz/c9ESyeq1z8EPaQqN1CgpVF1/tahFyr/nPxsd8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qZHh6g+IkvHb+jzlRR38eOySUdmxw1ekYJhAaUEgIenbcnlFrnwhS1q3iaJtK6CLlzvBYIDKoTB+KFgGtTrW6gE+CbFx3S+guBDS0YX0RiBwGg9aDIpwx/6f1dmrPo9OVOqtYG25h9i+v0VmGhm0Xzr7Fq+JjnDOqplXIadSH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kCzmUtZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C3w4vL027395;
	Fri, 12 Jul 2024 05:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=jaaJBA/aIW1R
	6eI4zxncIJ2GAqDHScgn1aYxhdZKKx8=; b=kCzmUtZPAkphRAi/YJ260uA16j+T
	p4gHx+6rugAg5qJXtIse/LbELT9ODZTzePetGWeSRUMlSMDg6/bzr3PryERNK6dO
	SL7AY35Xbbstv0u3wx9Ltfz5TgJA5j7axFuzhT/sIl58quTtYIT5SVfLYsRVL3Zz
	TooJlBtExkXVgnF0vuwFEwW19dGVMK5L5QQxUMQJc76vErVcy6zPWt9362xAbvNg
	qAc75V9DdYPCp8pGICo5lpnVHbeiHB/YkMHTwv2L/gD34T9huoOo/q1OCQGV45m3
	zyhoSb7agWpm6Em23S6WKHX1l2JDDTCj12vRCVLjcjjbH+y2XKHJCHnzig==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ajbqscq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 05:49:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C5mwjT019976;
	Fri, 12 Jul 2024 05:48:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 407g4fvapa-1;
	Fri, 12 Jul 2024 05:48:58 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46C5mwm0019970;
	Fri, 12 Jul 2024 05:48:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46C5mw9D019968;
	Fri, 12 Jul 2024 05:48:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 4757A1287; Fri, 12 Jul 2024 11:18:57 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] add device managed version of dev_pm_domain_attach|detach_list()
Date: Fri, 12 Jul 2024 11:18:29 +0530
Message-Id: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IQWEImiKySIVenZ9fa4Z6WgZe1IzLmuV
X-Proofpoint-ORIG-GUID: IQWEImiKySIVenZ9fa4Z6WgZe1IzLmuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120037
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These patches add the devres-enabled version of dev_pm_domain_attach|detach_list
in pm domain framework and use the same APIs in venus driver.
If any client drivers use devm_pm_domain_attach_list() to attach the PM domains,
devm_pm_domain_detach_list() will be invoked implicitly during remove phase.

Dikshita Agarwal (2):
  PM: domains: add device managed version of
    dev_pm_domain_attach|detach_list()
  media: venus: use device managed APIs for power domains

 drivers/base/power/common.c                    | 41 ++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/pm_helpers.c |  5 +---
 include/linux/pm_domain.h                      |  4 +++
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.7.4


