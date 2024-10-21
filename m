Return-Path: <linux-pm+bounces-16165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09CD9A93A4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 01:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FA81F22BDF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF11FF038;
	Mon, 21 Oct 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bxN8JDq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AD1FB3F4;
	Mon, 21 Oct 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551838; cv=none; b=ePgtpVH1dOThNIeYwfP0zJRI1QLXF/OpWr+P2PKpxc4nXV6NvLxJFcHKaW6OR9uhLUd1mmORqzDJJUUz28TGipa4ZrprqP/ykl1wuMxWv4t1dqIoDEfZ2WAsez9/DQhyVf/5iXt4U7CcldHt9djAtVxlb3xNVDP1uFq+0gcA8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551838; c=relaxed/simple;
	bh=StCfdhZD38qkZeYYiCNP0RsnX7S1azbaOPfsk1vFnxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZGRH6vTGUFyw4sxR9ps1t7ZIUS7FG5oI2S4pVizAVjObYnG5Pjho43gLEvzUC7PcJ4tisVmIBjTAx9DpwFp8UdUxJdq4U9+dZDLrqVEqTaf19JYcGA+3qrsRKsMXAbeqIS1DAksH94xfuwmkpVpxoQ4Vy4m4oHQ+R2hjzWoGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bxN8JDq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJ6GZb021903;
	Mon, 21 Oct 2024 23:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tYPBPFwHQxR4K1T+x6Jqh0d60UXeGE2NuTnNE7slmLU=; b=bxN8JDq32pjWccMV
	h4lWfH7TGumlefF5vc6JlDJst1oGBytPvIWMnqxdHpD1qZdW9ChHANOsUAA/mrEM
	suN1oCrnkwZo4UXgb8cFOjKTEBb+bA07BVjGN7PtrAdemZctLvSrScTlahWDpeu/
	tNAu1thUKvWc4ueFkqtWSWfWsXtr3vTsrKB3xHXIcc71WnxVeiLdv4zBw9FU97yT
	oUhw8BSOM0972CTmhl0O6xVx8zNR6PNTG0zhxjzZ6bOckGK0Ba1pJzwNYgXyP35N
	8gYe6co16hCPfnwn7M1Pd/OI1grFiFf4urFNYGKJXseI6iJU4Fahc4f1xD4iVsz0
	0R1uAQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tux8vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN3mKB010675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:03:48 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:03:47 -0700
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
Subject: [PATCH 2/3] dt-bindings: power: Add additional RPMh levels
Date: Mon, 21 Oct 2024 16:03:32 -0700
Message-ID: <20241021230333.2632368-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021230333.2632368-1-quic_molvera@quicinc.com>
References: <20241021230333.2632368-1-quic_molvera@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7AyM2G8qD79CB0utHX52bW00wupey0II
X-Proofpoint-GUID: 7AyM2G8qD79CB0utHX52bW00wupey0II
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=892 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210163

From: Jishnu Prakash <quic_jprakash@quicinc.com>

Add RPMH_REGULATOR_LEVEL_LOW_SVS_D3 and RPMH_REGULATOR_LEVEL_TURBO_L4,
used by SM8750.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 608087fb9a3d..df599bf46220 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -218,6 +218,7 @@
 /* SDM845 Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
@@ -238,6 +239,7 @@
 #define RPMH_REGULATOR_LEVEL_TURBO_L1		416
 #define RPMH_REGULATOR_LEVEL_TURBO_L2		432
 #define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_TURBO_L4		452
 #define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
 #define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
 
-- 
2.46.1


