Return-Path: <linux-pm+bounces-23457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACEA4F2B4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 01:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062653A9BE6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2B17548;
	Wed,  5 Mar 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RqzuRCDb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149B17BA1;
	Wed,  5 Mar 2025 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134479; cv=none; b=W/veTYJf5JarCNfnzDzqDTSv5VqkPZfHEbUvIv0jtmRitnQA+TBQ2Job+Lr12rc/hgYsxF291hSV0bBPzkmWr7wLFXVOB4U/2sYgSByC0aJuMO9FYnOL0DvjWCxH/SJoFElsF6MLSoKOsYdpKuDzBgIif0EOLIsivi/Jz9oV3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134479; c=relaxed/simple;
	bh=x/VIknukD9fSBBRaVll1/APH4ZffDIGAts7O+IzGyi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qJj7yTMazOMpFmEd71Sb8U1JDtGrTsmqA46qkknq5krM1bc7D14o/Y0lU8o3++9tBcNcot9CUDsAado+i+T26WT1gFGTFUTakvgFZUHDHeQo6WdtLJGdRkXyOiK7/6ucfh0ec6tCE967DFUPtkfir6tAjVcqKGUpZVmNK/8W3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RqzuRCDb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NA9gS005776;
	Wed, 5 Mar 2025 00:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Gde7r6M8hsg4DO9rU31kG6
	3LkAxdcHyxutXtMX3cnuc=; b=RqzuRCDb5qWR39nOKwhRgQbD/5BHXNqo8eY3Pu
	bAi1RGZoL2AucbOdLq3KQOzGiPFL2pn2bSs/CfQyhs4mxLNu5C5sBekrMf0q+9qI
	XoGZFmPRHHhy8No8IZ3HOZ3awiSY0mdjF/jiGnDbRBDCXmLVSV+ciLW5PwXlPefX
	cGUu+9oi16T23bV42A39Kg3YEIEZy7WRktV4Q/V62uXcxWr9tWf4JMU+C5YaOpa9
	nazHEnHxFWA4M/g80u3HU7mI9f8YHOdXOqZLaK0xf/KEwtOTBQlYGeTWx494FwLw
	B0XCenOK8Qvh/Eg5p7A8VVO/ErrNKlLFw1wXchF978oo9W6A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6v3hrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 00:27:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5250RpJg003536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 00:27:51 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 16:27:51 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Date: Tue, 4 Mar 2025 16:27:45 -0800
Subject: [PATCH v2] arm64: dts: qcom: sm8750: Add BWMONs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250304-sm8750_bwmon_master-v2-1-ead16909397d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAICax2cC/22NwQ7CIBAFf6XZs5gFbIqe/A/TNJRSuwdAoVZNw
 7+LjUePM8mbt0KykWyCU7VCtAslCr6A2FVgJu2vltFQGASKGjk2LDnV1Nj1Txd853SabWRmOPT
 KclRojlCWt2hHem3VS1t4ojSH+N5OFv61vx6Xf3sLZ8hGVGLQUkuJ6nx/kCFv9iY4aHPOHyURY
 Vm4AAAA
X-Change-ID: 20250107-sm8750_bwmon_master-cd4b8e1080c9
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Satya
 Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shivnandan
 Kumar" <quic_kshivnan@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741134471; l=2648;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=dJ5zGKO9cyYdi4F8ivmircOfcGRI6MbvOTw8Xwp2vDM=;
 b=rQCEUfWVssQQ7SxGV33uwdgRTtWOwX5sh0jmy+hLeiXan3zgJPAerR5Q56UfCez4xHgFzMyWF
 qkueOOuHuhLBoyPoOC4L1blr7i3jZ85fhkz+AfDv/LfeCkiVyeoZUHC
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hxilbSsKKeniz5BbKWZRM5mqJZsG4YJc
X-Proofpoint-ORIG-GUID: hxilbSsKKeniz5BbKWZRM5mqJZsG4YJc
X-Authority-Analysis: v=2.4 cv=fatXy1QF c=1 sm=1 tr=0 ts=67c79a89 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=7yo25iZzBaeJ0hjbOj0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=813 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050002

From: Shivnandan Kumar <quic_kshivnan@quicinc.com>

Add the CPU BWMONs for SM8750 SoCs.

Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
Changes in v2:
- Change destination interconnect to tag active only from tag always
- Link to v1: https://lore.kernel.org/r/20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..3f2b949524708eec8247fd453b8ea9e2dea32285 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2802,6 +2802,80 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		/* cluster0 */
+		pmu@240b3400 {
+			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x240b3400 0x0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <5414400>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <6220800>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6835200>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <8371200>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <10944000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <12748800>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <14745600>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <16896000>;
+				};
+
+				opp-10 {
+					opp-peak-kBps = <19046400>;
+				};
+			};
+		};
+
+		/* cluster1 */
+		pmu@240b7400 {
+			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x240b7400 0x0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
 		timer@16800000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x16800000 0x0 0x1000>;

---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250107-sm8750_bwmon_master-cd4b8e1080c9

Best regards,
-- 
Melody Olvera <quic_molvera@quicinc.com>


