Return-Path: <linux-pm+bounces-31990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6188B1C4DA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE347624688
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433328A1CE;
	Wed,  6 Aug 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ccu1gR6r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5B25B66A;
	Wed,  6 Aug 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479717; cv=none; b=JIZaFKpYO5H5jMgb5odizRBHTly8br0P2lq6B4a15poQOi50CpOhyeqSO974uD7nOfTpGMBmUGX+0FhebR6g/jG03O9kofBs+FCWx6cmPYHRFmks34P/miyiZDTvjsEmbPg5UFJ6DurzYFML2ATGoT8wkkb/qis+twnCX2YJvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479717; c=relaxed/simple;
	bh=oaiu44qJ+xCgX9y524WCfJYwAShfvp1cYbnsRYleUQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/T6IMNQX8iOL4AwYNc7vje6Q9CvXUgZIo11eezZUseZlsQ1ldAQ1kJFv59VKqnZHf2MZ6rSBlsdymiTIAVXP3Q6CjzHm1xSuM3SaBgN4z6ZV2uF9uTbSa/QgfI1BitkxIROHiI7H3aOLtLSCnzEIyIPrF4lVFbpObGQR7HUOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ccu1gR6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765fhNs031614;
	Wed, 6 Aug 2025 11:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7nPIi4UTi5rRXxVLQziK1a
	GhMiR6sWzcqWJyxgZMFl4=; b=Ccu1gR6rDIJhlOZBiB8ZANSC/G5NSlabKJAstF
	2zS00Rb/vsIU5vnA4FGT2KDThWzjD7ONQAn0/m3egNtO4WEg15R4r2/31SdmovY9
	AT5DLHPsQZX/rNMDtiHJQz72zgfdC+qBAUcRwpe0b564Ducw+SsAnVPqfBBLnHaD
	NQjq0JMcVLm7Bj5ToTjFmlZFf2BRFPHlU2ngs8QAk0fnioC5U1GvfgybS6WjrfXI
	M90NZVZRJaV5+3yO+0Bv5xATUvbUGMjKgJY9iWxr4HRTR4kSqwXq2R6UyYXL7KIp
	JKpP1EMXFq7JZ4Gy9OBhalVYIG/7L+w9Zjtwj9ppP4Kvfr/A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybajy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:28:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 576BSOrK013704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 11:28:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 04:28:19 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v6 0/4] Enable cpufreq for IPQ5424
Date: Wed, 6 Aug 2025 16:58:03 +0530
Message-ID: <20250806112807.2726890-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX6j6Vsja/XFWg
 Z8V/yPjPjCsR5xmzJQbm7N15pu1Af1bVt2XqFhLbsVH2kwffxAo+u5ygZ1IgXqQVVOzdRZzK7D8
 am2WadJ47fOokzmQEkFpv4voVdgljIdEprJ5/Thvb2Mm7x51rFX8CmsvK2evm8DrcMi8o1i1YwU
 BSHZDFsFNQRlGF1TDoO6iXiWz7iMHdR3vvmJ6yMjjO2cbtGXKBFk+zUj4EtZakGj6BLApaw6rBt
 OBUb9f/jKPl92oouriWW3UcxRszDMGClC5Nt9Xwd3bTxueBg8mOJo3Tp2GxHKjIxQ9sqKyzXaSA
 iyzdmIkH3ZqFfWSVlM3T+JH8Y+DhfxCELqKdtG4bTMY7+JGAG09s8OrU1Ofg8ekPCmk/3wp+/ZM
 dRhLexAA
X-Proofpoint-GUID: hpCuZZ5aFXIHgkKkwtPYMjiSP3VQghFo
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=68933c59 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=hYIGFNv7twnpuLpzv7MA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hpCuZZ5aFXIHgkKkwtPYMjiSP3VQghFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

v6:	* Drop clock-names in bindings, dts and driver and use index instead
	* Fix 'opp-microvolt'

v5: https://lore.kernel.org/linux-arm-msm/20250804112041.845135-1-quic_varada@quicinc.com/
	* Remove previous maintainers from bindings file
	* Use enums instead of clock names in clock struct
	* Add '.sync_state = icc_sync_state'
	* Add opp-816000000

v4: https://lore.kernel.org/linux-arm-msm/20250730081316.547796-1-quic_varada@quicinc.com/
	* Address bindings related comments

v3: https://lore.kernel.org/linux-arm-msm/20250724102540.3762358-1-quic_varada@quicinc.com/
	* Use the qcom_cc_driver_data framework to trim down apss_ipq5424_probe

v2: https://lore.kernel.org/linux-arm-msm/20250723110815.2865403-1-quic_varada@quicinc.com/
	* Use icc-clk framework for l3 pll

v1: https://lore.kernel.org/linux-arm-msm/20250127093128.2611247-1-quic_srichara@quicinc.com/

Md Sadre Alam (1):
  cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Sricharan Ramabadhran (3):
  dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock
    controller
  clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
  arm64: dts: qcom: ipq5424: Enable cpufreq

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  55 ++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  69 +++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 264 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c


base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
-- 
2.34.1


