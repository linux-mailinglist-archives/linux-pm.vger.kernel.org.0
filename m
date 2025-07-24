Return-Path: <linux-pm+bounces-31370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C0B107BA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F241CC459E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223C2676DE;
	Thu, 24 Jul 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MgTzmnCK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6692673B0;
	Thu, 24 Jul 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352784; cv=none; b=R9kJQ+AsXAGybHlBjvUPK+h4RE27sN69cCmDJmQfgir2jCyMy1W2HyU9WKJJiTp67Xy1BK9olNy4zZBQ2LlTKgdm+zXHb5wAgkp854kY4/m8Oyj1RfLmp79n34dKIqxHMds6U0k2NAnKwmBfNEQOyn/s7YmAGYHhkrGepq2swD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352784; c=relaxed/simple;
	bh=b2z02Tg7+vcOZeTgZw3lRIJ677lSvmqCMf5C7B6Yr0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf5Uq9UzO3gmWjsYzo61FQPA6rZUxabg+uCr62AhcGKB3TTZP4bYGjCFGZDDUyHZRxj3OUEN/L+r08pVS1kMV0UFk3KiEMU+gU9sb28UuurAFq24RNKcjaAUUwGSMyC0UxnV16ECzUzUXh15SJnGp1l/izHJxFrTUY0xczTaV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MgTzmnCK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ixkX028516;
	Thu, 24 Jul 2025 10:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF3PiaRiaIJjwDIgFh/oPpSH+ITV10Dk4Nei06/sbNo=; b=MgTzmnCKARBuAFvE
	PBKFKm0ORZOX7Qb+KeyMZSBJeEITzkoo4yF1I+EAFkKcw+0HH6Kq+Dz6QDbWQ6Zi
	86CfAv403odw8UNUzpjRpP7dwUB5iKUKc9xVuRuPkecX/ZV/8JhzOvadBRzOiwNb
	yTxnMLrUF4swTSZKNKaq5Rk4HAZpUsLRdQxjXUvdjZWnb4NV6QMDjCXeqE3Ovl7h
	ULOfNSlirZdU9rWe6PhBz9diij3z/S8BUy9hXEXTHJGHTmCtmcDhmVu/tOx+krA/
	JAXGGOR+jUmA5hsow5Vsa/Z6vAaQ2UeH+cK8GtFC4fstT0/iloj8UvhkLOTNZ4o2
	5Q3Q3A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1fpcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OAQHeT026553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 03:26:12 -0700
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
Subject: [PATCH v3 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Date: Thu, 24 Jul 2025 15:55:39 +0530
Message-ID: <20250724102540.3762358-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724102540.3762358-1-quic_varada@quicinc.com>
References: <20250724102540.3762358-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: JlUxgQfSjmWSFFsqVwEzNqFR-o-VafTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NyBTYWx0ZWRfX6iwbVPc2eBOa
 9Z6x6nDOqLX1J4QYgi1fiyACofpVj64VneSEY/WokkDPM42/Vg78PIu4kceRV3xpFiN8WE0LQFQ
 +JuZkZz5lpcY8cZGCcfQz8Iy/HaDPkCacn6oxD3Tu0Xfl+UYpRK0qlnZ8/0R8tBpt/Wy2+YC4dc
 Fs5zsbQC6zc+9Ov4H9ns5q/G3myGA7P6gOgBpnpE1Lx9bHRgEvRgB+6Kz2zQAbMiAg6OmlcStPO
 PvN9+RTeTarJj9HKtAMRkLh4qRCzR1To+ewV5bvJF0RU8XJO+kQ2+iIwq2aKyJuK5rIyLunjTN9
 39gwA0R7qlVoluMbibzLmDhozJpKT5B5HylfzuiNvtU3NSQn2oZE4INo1c8Lx64Z/Ojzqj/G6YM
 YWCkq42Y2SmJ47FnqIpP0vSjC6vFp+MbcyJ5dXecBelstrl8SwQD+I3tMKhuQmH0hswgvrgi
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68820a4a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=XqKM0RL5GMr1h_B9R8QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JlUxgQfSjmWSFFsqVwEzNqFR-o-VafTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240077

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


