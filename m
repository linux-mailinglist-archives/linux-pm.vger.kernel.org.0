Return-Path: <linux-pm+bounces-31327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C61B0F0D9
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A3189DEDF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52E2E425D;
	Wed, 23 Jul 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TY5fxCbd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DF2DE71E;
	Wed, 23 Jul 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268937; cv=none; b=dHpSc7KlyqUU9LWPONV70ZcmpVt52X9iGrkw/ZVcDZb6NOHF3bZTvtAE1oGDbSwJ+seFe1YC4n55b+Z05YMf2foTpATGN+qzDAPXOCTDOcY+ZtZ3Ru7tl98ZKQNppTpzRNf8leRb5VUEpy0hcTBgKCqaUTnTbDStGZudNavif7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268937; c=relaxed/simple;
	bh=b2z02Tg7+vcOZeTgZw3lRIJ677lSvmqCMf5C7B6Yr0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfUJiWU/60T+iBlzmwrdjSONAOOZxHNFccyMoyiXMYVXNOQnR7gOzOE9Xsbmxp3zj/QfYQwpn9uBxT1iM7vNuXuk0Fwb8fsp0MeO8HGXcyhicXe93XfipXgPn208MIwGRxuqSIfLDJkbtf9fyl3DZuURoVaF74s4UHjnIgmu4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TY5fxCbd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N90Nbm030756;
	Wed, 23 Jul 2025 11:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF3PiaRiaIJjwDIgFh/oPpSH+ITV10Dk4Nei06/sbNo=; b=TY5fxCbd2hP7gbyp
	uyJs8tgmq/44bZ+6aq895A2osrfV7ooUmt6JH1bqmoqtx+0bfA5Wh0Q3tSVc96xo
	T/mdOx436Z42AAoa+LQeW6qHhxiJ0TcVsez0EX95iVVA05g8XJ8YaZW1vEKd6m5m
	Kc1BSogFnzERWHUsNrHDz3yauHJdZYLqvVQ8pEu2c8LVzMWnFGYKhRpRFSgGCEI/
	EN2+p5lZpCqcrrPf+nBVPn8HOAKNoXchZd3nLlsRPXvZo+83dJMbP2t29LW80m/5
	yKpOdxVgJvwGvy7ug1Q3g/iYp49OGSFVxheJrzPkWvNbWCYyrpXUy9L1guBcBKwy
	2lxrSQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w39qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56NB8pDg030833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:51 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Jul 2025 04:08:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
Subject: [PATCH v2 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Date: Wed, 23 Jul 2025 16:38:14 +0530
Message-ID: <20250723110815.2865403-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723110815.2865403-1-quic_varada@quicinc.com>
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=6880c2c3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=XqKM0RL5GMr1h_B9R8QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jJ54FnbuT4TfRJc7KPbJhTRvd-ZXjIJZ
X-Proofpoint-ORIG-GUID: jJ54FnbuT4TfRJc7KPbJhTRvd-ZXjIJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfXyXqICZlR9hIH
 nnklFTQSLwJ6qnvmJoEQCkliTYy6qJ8DvNZLVTt7kblhJaM7p7M+ZGyCMENQRvwu8iMq9tBI732
 24p6cupzdQw4dI0vD/eXUw7ibnXWBMkanOTfK/F6FV5VWN27LdG4I4Xr1IZ6xHue7ke7yjjIjDe
 8FkikoutTKQFm67cO/sIzH8orU4+/K8sXrLGj5tTLxwEyKR4NlBZgEsh/gwvniJpgsRxLKoRTaD
 WX61+nY6WfRl1JQa4hH7hDhTjvAGiX/aRuCZGqGCnHN0HgGjjeCQ9BJzsqITrO4Eu7I1NmetIGk
 nRe3QIFziEC67qmJY3F4pqsTviIBWgOTA3A7g0v03MEyLItW3cGkWlMRNdiTIra9rKWO16bRgfu
 OfgPCVJoycRMHiX534Yu8etm6TouGLDiHwNzzJ0y5NRYbe5CnozCVPd32hRJ4YRWVhBfbfjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230094

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[ Changed '!=' based check to '==' based check ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add Reviewed-by: Konrad
    Change speed bin check to == instead of !=
--
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


