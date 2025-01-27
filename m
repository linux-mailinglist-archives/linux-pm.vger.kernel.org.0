Return-Path: <linux-pm+bounces-20966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D7A1D372
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67150164E15
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13B1FE451;
	Mon, 27 Jan 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nv/ZuSmG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F531FDE3D;
	Mon, 27 Jan 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970326; cv=none; b=eOq7pZgunCCRYnsMoHQMSysQlOGGAxxsTB3d/iyNrcEeRQVcA5gnOY1aKuz06gmWNx/CGAucTljz4SaHFLerG7V9sqsRvCKBVZ3Anx0kaVJ4hQ5tSbt5/mwIdtjAj8EXjkehT6jo1LA/BWCLb+h9gw8IdBHY69jAixjxaap4SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970326; c=relaxed/simple;
	bh=7/ZZWp2L5SZ6D7LJtextD1CUtzuDfo45fkyJ0Nt7a7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHe9raSTbnkG08ptKg61CZAsYx2r4/EEsz+d6QRzznVXzeiJd2oQ9VIgAfhI6xs1SUK/XFZm8mCCIkHKBzty5vq6GrMp4RjP1NiFEiETixlVx0E8mjbrCRKgRfw0lpBeZBe7uyYq2QqaWrgvpuedSouIpvWFMWBIYdKTquMHoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nv/ZuSmG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QNPD33028181;
	Mon, 27 Jan 2025 09:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lC4md3mtshDVd7CkiXj5Kz4ObZbAlKOKCwlqbfdBWGs=; b=Nv/ZuSmGWN9CxHen
	FrDhDRKfQChnDRyGeG6sce8Db049AQnS7jBW23/Ti0nAaGFJR96YFvCx/GGwtpCt
	yURW7NnB8X1VUkuOBKRYY+zZpK8zwhFFyaxWBTFZ5MZJSbfNYlh8+9pEk6yE2nqu
	uCSQtyRo6lWutXa57wtDSe7eobshtOZf6XxJ9z0R8FX7k40BZLbaH4Zgu0EVGEf+
	WhooBjTOJsegyMvDcz2I8ea72gjkkAS7YL1VJ2aH2LMYZx59S+bUV6Cu4Tb1G1V0
	83TeSNjZj/mi+6wqTNM1vHdkGbmx73uHpSTD7OdfcHPKUTJXO9XrkZC8sUiNL3WT
	X9tvLQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dsav172d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:32:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R9W0Fw025666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:32:00 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 01:31:56 -0800
From: Sricharan R <quic_srichara@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Date: Mon, 27 Jan 2025 15:01:27 +0530
Message-ID: <20250127093128.2611247-4-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127093128.2611247-1-quic_srichara@quicinc.com>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
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
X-Proofpoint-GUID: 6-8D53h7Mq-E5XZqd_961klMer-O0JHH
X-Proofpoint-ORIG-GUID: 6-8D53h7Mq-E5XZqd_961klMer-O0JHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270076

From: Md Sadre Alam <quic_mdalam@quicinc.com>

IPQ5424 have different OPPs available for the CPU based on
SoC variant. This can be determined through use of an eFuse
register present in the silicon.

Added support for ipq5424 on nvmem driver which helps to
determine OPPs at runtime based on the eFuse register which
has the CPU frequency limits. opp-supported-hw dt binding
can be used to indicate the available OPPs for each limit.

nvmem driver also creates the "cpufreq-dt" platform_device after
passing the version matching data to the OPP framework so that the
cpufreq-dt handles the actual cpufreq implementation.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9c198bd4f7e9..4045bc3ce805 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -187,6 +187,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq5332", },
+	{ .compatible = "qcom,ipq5424", },
 	{ .compatible = "qcom,ipq6018", },
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..102f7f1b031c 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -200,6 +200,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ9574:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
+	case QCOM_ID_IPQ5424:
+	case QCOM_ID_IPQ5404:
+		drv->versions =  (*speedbin != 0x3b) ? BIT(0) : BIT(1);
+		break;
 	case QCOM_ID_MSM8996SG:
 	case QCOM_ID_APQ8096SG:
 		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
@@ -591,6 +595,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst __maybe_u
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq5332", .data = &match_data_kryo },
+	{ .compatible = "qcom,ipq5424", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq6018", .data = &match_data_ipq6018 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
-- 
2.34.1


