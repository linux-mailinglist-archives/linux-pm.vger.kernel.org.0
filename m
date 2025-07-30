Return-Path: <linux-pm+bounces-31581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C29B15A53
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A913178101
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24BA293C62;
	Wed, 30 Jul 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C484Bokv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72EA285CBB;
	Wed, 30 Jul 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863254; cv=none; b=Z75D2soxgPsApg8Q1KD9Mg5GG7Lvqdee+gLdWNrKEj8aykzU9qQzF6b/yJ6nu1uGD3axth58cR22tryriDnGNr9AilSdrQao7Mnejm3Hx4B9G8yNiG5L8F7OCjsIbAa02SbIZnTkiVViNS8fBs/qj0RKI14VE9Tw1SP3jBknwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863254; c=relaxed/simple;
	bh=b2z02Tg7+vcOZeTgZw3lRIJ677lSvmqCMf5C7B6Yr0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc58C/PhOdpXgMZERx11G+HYDpXDP4AXKBGQsOjDVwfXfnrZ2jNXO5ZPiX2eCsjn3Z0aGVJEjUeCE1gxnC1rC7w+gUnCU5iHUfTL1AqHj880EMfVK/Bsv0OYN24Ec53obhowBgSuv3CGmfq6dI84rQoGc4/zoMJEMih3rmgBfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C484Bokv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5sVTN018832;
	Wed, 30 Jul 2025 08:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF3PiaRiaIJjwDIgFh/oPpSH+ITV10Dk4Nei06/sbNo=; b=C484BokvFynRs4/+
	KY3ZAMBIVuBTEyZCskXivoI3uqagyZmwmn+bZswu0OLC/gHIW1/uKjpIe52f4LJN
	nBPE36TgmeLx87vW3uHOskC4DAsiM/lIdWR5bt00W7xwrcpl4tX0wlbZLxwAJeyU
	L6DcWa7g7U/BWxRv7ZHpGaFpa3PrECh+HjWNbF8qKvvGA8wpBIzjG5hi6MxlFvkT
	wNlD0FPyu7PZHrvl5gcopOIB9FH4I4qlQnRmpaoqz0bJ6pprFKcDpzD7bHV8FBPA
	md58qeaHCjNs+1yiPV/BK5Q2vdfr8YFEcnP3GntRz4qO9cPFSAl5sGeHLH4zp+2M
	cHz8FQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q8633qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:14:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56U8E8oJ012231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:14:08 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 01:14:02 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Date: Wed, 30 Jul 2025 13:43:15 +0530
Message-ID: <20250730081316.547796-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730081316.547796-1-quic_varada@quicinc.com>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NSBTYWx0ZWRfXzdDJ7TjoK+HP
 fDtf7JkWzEO2dkXuU6mhAaVXIKZbKMOBB9lVyDWeCL4y6AF7tjRyHQ0zhAWiHsw+8Eef1i4v7Qd
 0uTTJkkED627r1VHOuw0yNeegez1ZfQ3eBCHClz/sV2Fhkwi3e6gcDSz6gIstI4UP20cYk00NiH
 KroIEBbkJRftBIl/uRQ00vW0dC15++TmzrxuhAKfwm5Asd1yYqHPkfu9PZACSFaH8SfURFCsPCl
 XaEUlz8ew5ALL6JCvndK8g5c1l4iZ5FPnijtweOsno+VJNMQP7h9N+DygoBizCoxviApk/0rf/S
 x22ZzhJ18VQw38wMKkzHbTwhE+x9KE1bcNlUTs+5qyDnJbgVnlsxtzxy08gpRSqS5OBSOY73/H0
 E+LzBqJvsYreOZgS05+9kJAvLYPI818iUSdLp4tkFXz1aNvp7c1ogABMCLU7S2gmcxVgBbTE
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6889d450 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=XqKM0RL5GMr1h_B9R8QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rKUnw3MKCLtNIiZXOikmtaEfVvauy3JM
X-Proofpoint-GUID: rKUnw3MKCLtNIiZXOikmtaEfVvauy3JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300055

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


