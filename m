Return-Path: <linux-pm+bounces-16164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622C9A93A0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 01:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32031F22CBB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949F1FEFD6;
	Mon, 21 Oct 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UulntUYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F91E2840;
	Mon, 21 Oct 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551838; cv=none; b=lEFN93u6VM1S54fAinj9HDwejPFowgRUEgStSPWLoW+/ydGEg5ym3tY+oKlv16JVfVMIxbfvHDpwNIrswGY9uXQn/oJoQySVVxUZu03oHaBKW27B2Qekp3VglcidRxCNwpW83T33DtQYgYnY9mk7lc4ntdg6CqTgfw53qX4+pJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551838; c=relaxed/simple;
	bh=wD0hmRmTZUqp0PKJmH8+a/bou63wvSt5Pm+QZwl+y44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6EP2j5i+kcf0WtSzy/q70UCDt39eKDiMaETgfKEpIYHbRenL+r69L4bBvwUAYdVKB69M63Kfl9kqzT9FLsHUdISHrMV2B3MoKSyVKpHFKcOXC/v/gYJFLq3HJdqbd1Lftp5ZWJS0YUJhtucvaXLpEJPhwMhMLi/wGKV1UMJmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UulntUYq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIeYoR020550;
	Mon, 21 Oct 2024 23:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ByC03Gijfdpnx/8ym05Seg
	S4GuWvCxyuXb4cbLMvcis=; b=UulntUYqrpc2JPpvWB+Vo+2aVJRvyLdr+Mlw2b
	AUlBNjFreZpsVVVmWjm1JMiQRu3hAmun3E4lDbWG1Q7TYZ5Bp2WcG/67XVzGjyB1
	XY1qk/MoxQ7jKHPXPYj+O/KlrgeeVXldMA/37Tr/h3ZATsyHbhmYDvAYh/azb67e
	OtDVurWDQpuSXizF/wqThja3JnsPgCJ74koX9CLJamKHRK2nsCjRgh/fSHI0SNyg
	pXEqIr8Yo2lNP3m4Rh2T+H4cAYZROmmCUbo/eAMjdrxcnYIcUEpXEhtZaDxpQURk
	ulMZfbFXZf936kRPSWqWYMDvF6OKn13TZtENT8YCkscvyfgw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vxx8jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN3kpO010268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:46 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:03:46 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, Luca Weiss
	<luca@lucaweiss.eu>,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?=
	<otto.pflueger@abscue.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Abel Vesa" <abel.vesa@linaro.org>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya
 Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH 0/3] pmdomain: qcom: Introduce power domains for SM8750
Date: Mon, 21 Oct 2024 16:03:30 -0700
Message-ID: <20241021230333.2632368-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5cSEt40YkRU0LFeiLdBS9pf6tWlVLQJ2
X-Proofpoint-GUID: 5cSEt40YkRU0LFeiLdBS9pf6tWlVLQJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=756 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210163

Add power domains needed for the SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Jishnu Prakash (2):
  dt-bindings: power: Add additional RPMh levels
  pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750

Taniya Das (1):
  dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  2 ++
 3 files changed, 29 insertions(+)


base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
-- 
2.46.1


