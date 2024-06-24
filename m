Return-Path: <linux-pm+bounces-9888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F149D914650
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D78280E99
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572E136E37;
	Mon, 24 Jun 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h+PiHUrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BC13774D;
	Mon, 24 Jun 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220995; cv=none; b=mWKUUnJ9QwTcGlA7Fih+A4rqP/mRxs5IS7KarVtpZyAJ+1+m4QvJaT4tLtAUae026zxgkHFt5Je14jm+nuwsr34L/XCMVvttwJH+ETrVsMZjGeXypbygFvsnzj6qGj0rLZMsz2VBBxqzvUXRO8AsLtBqpdAK3zXAcMZZlAZQlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220995; c=relaxed/simple;
	bh=8cAgcwTvBnAla3NrneIEz71Zv7i1DEghBD644/nbOXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbLmx51oFXO5KcZlI4v+kiiDaVw4Kpx7QtAyOYAcn6LEx3RrpfNaWajQXxeqkgAQbo+oWFQphoastGJIwj7FvAP71EMCpcUZqsUH9Kgbx42uR3zc77TYAYThs1jK4oldd3v7AxEo/yFbEZeYMF3z0NksYJpChusSfmTJyIcdYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h+PiHUrA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8ZB9T024767;
	Mon, 24 Jun 2024 09:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+wnsSYuLmoebBtSjmfB0yze6OSKIloZRMvRN0fi5T0s=; b=h+PiHUrAmGhcV+lI
	y8KpHRlsRFhjfmWDdl3M7LYMOzXg740dObohaRstgPPZmiV4JQXwEArgfS0uwXgQ
	Z/rFMHQdH6smuw2YL8kl76SnHuXCWlU/9hkEdYFfOBmzwGnKZGB5MIPIXAczPPNt
	pkAs7lnUec3mtWQa1VI1JXyUaLe1jIr21lbLrVMni8Zw83x8HYQML4Dv0Y2WSpT6
	7mRak2wR9uyyRD+DqGKEVyMvVLpdryNlb4d08fVFGtzm1TK4eyY9ZSCoLA5yNRYV
	sf64aXUHjUM3ehtm+K7UOzbggY1m1JW4Asnn36s95+5ma2r+LUEfvd0wrJSoLFh9
	PkKE9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshk570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:23:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9N93i028388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:23:10 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:23:04 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
Subject: [PATCH V3 4/4] arm64: dts: qcom: x1e80100: Add BWMONs
Date: Mon, 24 Jun 2024 14:52:14 +0530
Message-ID: <20240624092214.146935-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624092214.146935-1-quic_sibis@quicinc.com>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uN-ldSSdi10HSsqLl5M_G7z40Y2iVGHa
X-Proofpoint-GUID: uN-ldSSdi10HSsqLl5M_G7z40Y2iVGHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240075

Add the CPU and LLCC BWMONs on X1E80100 SoCs.

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Pickup Rb's and Tb's from the list.
* Add a comment describing which cluster each bwmon instance belongs to. [Konrad]

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 123 +++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9944c654851e..f9355f616bf5 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5299,6 +5299,129 @@ frame@1780d000 {
 			};
 		};
 
+		pmu@24091000 {
+			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x24091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
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
+					opp-peak-kBps = <3072000>;
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
+			};
+		};
+
+		/* cluster0 */
+		pmu@240b3400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b3400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <4800000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <7464000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <9600000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <14928000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <17064000>;
+				};
+			};
+		};
+
+		/* cluster2 */
+		pmu@240b5400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b5400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
+		/* cluster1 */
+		pmu@240b6400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
 		system-cache-controller@25000000 {
 			compatible = "qcom,x1e80100-llcc";
 			reg = <0 0x25000000 0 0x200000>,
-- 
2.34.1


