Return-Path: <linux-pm+bounces-12402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0D9563A7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4F0B21C71
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51371534FB;
	Mon, 19 Aug 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RqeJoTZQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44211CA0;
	Mon, 19 Aug 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048627; cv=none; b=bC9ckywqkjT5K69dP1D8t+UPkC/weJPI+rQ3ZzvWE50vea7g4YwhWuIhFLI5AKMgBmlLAo+xspT00qnskQFe/pecbsRvXP0NMkeObH09nX9riV0KG4PKsVXxdaMtIpIxEtP107GUzjk0KVSrx6Hc6p3nwZw7+3ngcEyXWVDimRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048627; c=relaxed/simple;
	bh=9Rpx+bkgwpWHs5ORc7x75ZDWXqWWicrNMC/U+CEOevY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iPO19mTUF2c9oaEttqf+MUKft6FXMhfkB0nrbrViTuZBEPQsQ+wYmMBPLmuPNLzhH+uS8U/rAjgKCA66p6tIpqRzL6ELLCna+qUKEEPb+y0ypK73UiKBf28ZNHqH1s9MjPrjBB5MJ5NrrXn2dZsArjj93AAFV5i6vrsf6E/4URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RqeJoTZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47INBB7Y014962;
	Mon, 19 Aug 2024 06:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=n9szHIALgJMA
	7bJHTvtGr26RNfQn4jp8/XBaU45CYds=; b=RqeJoTZQHhogJbkjfXoc1Z6xCSEP
	ohVAwCEJpg8r2w2w2QtPVsgQFL3C44eGU/xOAnCMPHLTmvahJeSaqIBGAJj3wL7A
	aG4RBzlZi8NKoQhgIqL+oSa+KB4gfKRLoTrFI/8teG0x6Z6msjfY1uGi/WsdQq6c
	WwImgvPw+00qhpJV2I0uyRegBdULMWIUV607+LQDSJTIS8vWJHSWRYfiCau70t0D
	7LcrCSq6X0k1mOodE3v47+p5fNev5/IVKoyJkhUlgrEAvgI+TVjhYz/ZoBh/Yg3d
	oZ4aAeLT/cKN4OXH6wrx/SlW3BcJ+My6x8AR2Cwe0wQJYmYG4UqFPDKs0A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412h7n3cvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 06:23:35 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J6Gjuu004480;
	Mon, 19 Aug 2024 06:23:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 412mxkapt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 06:23:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47J6NFiX009384;
	Mon, 19 Aug 2024 06:23:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 47J6NVIY009412;
	Mon, 19 Aug 2024 06:23:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 800C4359D; Mon, 19 Aug 2024 11:53:30 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
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
Subject: [PATCH v3 0/2] add device managed version of dev_pm_domain_attach|detach_list()
Date: Mon, 19 Aug 2024 11:52:44 +0530
Message-Id: <1724048566-5035-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S1x7QEFE0pmVZ_ArBlLWtxFxodJsuzf4
X-Proofpoint-GUID: S1x7QEFE0pmVZ_ArBlLWtxFxodJsuzf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190045
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

Changes since v2:
 - made devm_pm_domain_detach_list as static and no
   longer export this API.
 - added null checks for num_pds to avoid adding a 
   devres callback for the same.
 - added bryan's reviewed-by from v1.

Changes since v1:
 - fixed the warnings reported by kernel test robot.
 - added stub functions for !CONFIG_PM case.
 - removed un-necessasry type casting.
 - fixed the issue with remove sequence.

Dikshita Agarwal (2):
  PM: domains: add device managed version of
    dev_pm_domain_attach|detach_list()
  media: venus: use device managed APIs for power domains

 drivers/base/power/common.c                    | 45 ++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/pm_helpers.c |  5 +--
 include/linux/pm_domain.h                      | 11 +++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.7.4


