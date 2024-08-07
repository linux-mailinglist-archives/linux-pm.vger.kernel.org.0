Return-Path: <linux-pm+bounces-11959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424A94A177
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4781F245FF
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B41C57A5;
	Wed,  7 Aug 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CUte1tFx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DC18D63E;
	Wed,  7 Aug 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014968; cv=none; b=USyEdZ3LXO8DLVX0RG5oaES4sbTxC9RIHB12JDGqoPFzejcqI3lBpQ1aoPJBFT4gPK7rfk1iuT+pcUIW44evNIIO5WdZ1gpgPdGVQgyOoBtx8zgweagH6e1WRBrZv6nn3PxL+WaXb204VJ4if5FuLCTIAqEOowC5vTgT0c9ILi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014968; c=relaxed/simple;
	bh=NBfH45aAyJov9Fo0wjzwYgBYJDo76ugS3csrwrc9KE4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fq1Jvlv7IVZl9WZOXVEQGCj5U5yx1xVP/r1ZsXKmd3hhf+2p4XsRNpSxMn3p1ugZAfKlN6gQ8AKjsDZLrogPltgAIxDYEqdQ+1wrA8B2TwvdqF5x0ZU+5Qjw8Cp22wdPCZ3eYMq9RN0DtK4RLevgDvGf224bxhWS4+jni8z2Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CUte1tFx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476NWfwN026608;
	Wed, 7 Aug 2024 07:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=5Q/fjpQUkJO6
	SMg+Zfkf40MtqsgxWKC83vj3+BThq4o=; b=CUte1tFxymm/IuUzMJ8SMc8e4a4q
	cEIihFy9y8igK2e+LWMo1ILEZWarFsOKG5e6/U+Uc6W5Rpf+phRLDJYDY2IfjZ+j
	hYiaC6SQafxI4aSQCOrhu7QifmJ6t4RquiqPE6Fe5Z3kzzRDTgzUoh1W9eDDW4nc
	KaDhEDmHANeEMjwKnoQzCShWAS6R8LSCUKolwQwJR6Zr0LtDtfZ/6L+x+/DKcfBW
	n1GbyAoKXcA3Bg30GGZ89t7TTWAdhbFrRUWt+/nvvXN1H+VkNGMohT6wxehcixYg
	C+nhFoxLbhKh/PuSyjonoNu+vdLUmIOevWh2Si47ScXuZ5IEecg+SzMc9Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40u4cpmrs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 07:15:57 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 4777DP9i026468;
	Wed, 7 Aug 2024 07:15:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40sdmkv99n-1;
	Wed, 07 Aug 2024 07:15:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4777FsC5030008;
	Wed, 7 Aug 2024 07:15:54 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4777FrP2030005;
	Wed, 07 Aug 2024 07:15:54 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id BFA6125A4; Wed,  7 Aug 2024 12:45:52 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 0/2] add device managed version of dev_pm_domain_attach|detach_list()
Date: Wed,  7 Aug 2024 12:45:45 +0530
Message-Id: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HXAEf9fTbeahv8a9aApFU4tkXSkxBLJJ
X-Proofpoint-GUID: HXAEf9fTbeahv8a9aApFU4tkXSkxBLJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_04,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408070048
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These patches add the devres-enabled version of
dev_pm_domain_attach|detach_list in pm domain framework and
use the same APIs in venus driver.

If any client drivers use devm_pm_domain_attach_list() to
attach the PM domains, devm_pm_domain_detach_list() will be
invoked implicitly during remove phase.

Changes since v1:
 - fixed the warnings reported by kernel test robot.
 - added stub functions for !CONFIG_PM case.
 - removed un-necessasry type casting.
 - fixed the issue with remove sequence.

Dikshita Agarwal (2):
  PM: domains: add device managed version of
    dev_pm_domain_attach|detach_list()
  media: venus: use device managed APIs for power domains

 drivers/base/power/common.c                    | 44 ++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/pm_helpers.c |  5 +--
 include/linux/pm_domain.h                      | 13 ++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.7.4


