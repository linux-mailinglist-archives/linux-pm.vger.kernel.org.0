Return-Path: <linux-pm+bounces-31992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E7B1C4E2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386EE18C144A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5F28B7ED;
	Wed,  6 Aug 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o3ILNQYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D8275AE7;
	Wed,  6 Aug 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479727; cv=none; b=ofI/We25bJMjl9HvXrRLRo4UIjR/qpWxKdaO2rVHtMnZXaEhY5e1rXe5Nt1JPCLjHnXC+58VO/XWTz7Yb5PtoAv4eXZNVTqK3ZzncOwE81GZZFoX6HwQt8B0jl9cHLCljDOqIy6OTrciX5bo6XxQcQYRbxMQdF4dF9UcW5yLG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479727; c=relaxed/simple;
	bh=Ztfu/dcEq6pZJ+vtoSkR99aWDu6yBZOhG1pLPhH9wP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8XYdbiFomv+B7G9F1/Z7gRP17fvSoAKW8lwxXi2UzzsgN/2L/MtL/b55PSmqf0s21DUdqdzYEL9kd6BFpZCXAbvOR6rFt0nLwE3teLhSsQzYnNISeOWjJnGCsCRIAluMdB+ZnAZThNfBZnAjEVGWsbk+EDyLxgMS/OtAcKnabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o3ILNQYb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576AMsA6017483;
	Wed, 6 Aug 2025 11:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PcQP/LVOaUjn/ZGPYjDlE6qZirGI1tSVP9hECb/DR8g=; b=o3ILNQYb0XtNnt1f
	9x8fxcyvtc6/7wUEzZlf60+hB5Q2Ly8aBokhuNcgdemST46SjxUwKrAayCD5cLj4
	qpAFOM0Q914K+zOrcrN8hGx3bzjKAI7VIjjPpsJYLlaNRtwLApU4wNBCHYzxBkTI
	0wuOWVGbSv7fgZcHM0O4TK6s7T4uuCGExnN2NDkXRw0mPQnEL6V0XvrjnSERhCUI
	gdmBU18Pv6uhxyje8e3RDMFNtfSmM+3Xzi4qutrpvPzDyTQgANGBOEagmD71xsM5
	imqeOUR+380htpc2pcoMO6L1PfPbeSFjnVaeusESTkwro/T3TGlgLysHAztZRDm6
	Ik/kyQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c58684h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:28:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 576BSeGq009651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 11:28:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 04:28:35 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Md Sadre Alam <quic_mdalam@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v6 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Date: Wed, 6 Aug 2025 16:58:06 +0530
Message-ID: <20250806112807.2726890-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806112807.2726890-1-quic_varada@quicinc.com>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: DPt-u0Qhxde5TZxe6RLeuioc317AN76U
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=68933c69 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=XqKM0RL5GMr1h_B9R8QA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DPt-u0Qhxde5TZxe6RLeuioc317AN76U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX6oIEgqif829F
 Bdf38oulGK+GMs1SOOvv8riGHdOjP1TncFqy5JHWG1B8Pp/YfXXk/c146h4X8TpBw/uQdf8/oKA
 j+Cb+5Xw19s3wKb8JpuC/nKINQuLaYsvlejh7y1omcUFc3/9Sh+F06J3L6+tIkaqxlK9txU06bQ
 tWQjMigQR+7XfFo7D8QWuNouhp5CfqesAIZvnSpYWZmy/8xZN7y/lAfJB96L/a2VDqBJd5NS8cY
 b4igGQAFLT3Hp4coUpI+HAjvwVNUGbp0LkFLsEdGGJXFCb42T8FWcDZp752lymb28fxU5gOSS4L
 rsmn+9HxY0qjbySz9sSvZNqkBurgK9o1sDbBgwj66mVJcvJY+1Asx57TrWMZzkHu4mxrqlUO5tu
 8u5vaRWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[ Changed '!=' based check to '==' based check ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Acked-by: Viresh Kumar'
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 015dd393eaba..de1769649368 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -191,6 +191,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq5332", },
+	{ .compatible = "qcom,ipq5424", },
 	{ .compatible = "qcom,ipq6018", },
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 54f8117103c8..765a5bb81829 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -200,6 +200,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ9574:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
+	case QCOM_ID_IPQ5424:
+	case QCOM_ID_IPQ5404:
+		drv->versions = (*speedbin == 0x3b) ? BIT(1) : BIT(0);
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


