Return-Path: <linux-pm+bounces-23112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F9DA483EF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FB63A4179
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766401ACEC7;
	Thu, 27 Feb 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cTodszGs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5E1AC435;
	Thu, 27 Feb 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671603; cv=none; b=a4qTizyuKbyMkypMIVSqqnXRt/lhFzGaFuY3fmWPZCVjsVWSBgd0XAja11HOUjbAYx088w9waZoJlXSO9JokJ/Dnad+s1Vv1mz5ctqvZpaTuPS8agFwyvC7eVYmFgZubI1VbI2Y0923V30Tc3iOs0iMfP163+s93YnvSKIev2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671603; c=relaxed/simple;
	bh=htf/+MeFQoqYlPYCePKHszLnbJy1d35GcY3askHeR3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttHoBMMDgMYQ38Jr/8XNTQqT9cfDw+cRCyeLzQQLvVnW9BZb1C9pkPG8mr7pW/03+X7Aqq8QmrGnsg7baHjxUJnWHHN2ceZIzhmzcYjJ6cPPotwR0ntF3Ch+edumSFbRRqYqH7eC+EiOppiDS+tOdw8fjnqEOKE0U/yPIS/nRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cTodszGs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8Z8Ss011860;
	Thu, 27 Feb 2025 15:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j2sR96LpMJHsZjO78F10G40p0fT55C9dkwLvJPHtpGw=; b=cTodszGsBaG0OYr+
	CMRdFyyNiNnwzohdy8lW87dBFT09cd0AIDefK639/FJ6WUcFJHk5LpskrNmp1lCp
	vnrWRi2OCLjfVc3yzPb8qLxRgh7aI+8QmwP5LHu7o3Qx9DJYIOv+oJBGW+XVRwT2
	34bOCmYNkl4qHZiDzYuwsGAQhp1duUH2jVJrmFRaZ+BD4zQdEpL5Uo4jjWm51GQ4
	rDmAJSMEBDP68lINoPcgFiLoSH61BRbpiHWPXTHWRXJ3e3u8pqiuhXvWTzR97rhJ
	rnQ5dyOI+bkT+L9R1EwlA3iu+7PmK1Sh1KqF45/9v6bm3PEPHnKub/LOICNrJlyM
	r2co1g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prke8a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:53:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFrHfX012405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:53:17 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:53:12 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V9 6/7] arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
Date: Thu, 27 Feb 2025 15:52:12 +0000
Message-ID: <20250227155213.404-7-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BlRp82LiH2aXbakKqbpBhytqDojj0onv
X-Proofpoint-ORIG-GUID: BlRp82LiH2aXbakKqbpBhytqDojj0onv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
SoCs. L3 instances on this SoC are same as SM8250 and SC7280 SoCs.
These SoCs use EPSS_L3_PERF register instead of REG_L3_VOTE register for
programming the perf level. This is taken care in the data associated
with the target specific compatible. Since, the HW is same in the all
SoCs with EPSS support, using the same generic compatible for all.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 3394ae2d1300..d02b4abe9e8d 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
 #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
@@ -4653,6 +4654,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		epss_l3_cl0: interconnect@18590000 {
+			compatible = "qcom,sa8775p-epss-l3",
+				     "qcom,epss-l3";
+			reg = <0x0 0x18590000 0x0 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@18591000 {
 			compatible = "qcom,sa8775p-cpufreq-epss",
 				     "qcom,cpufreq-epss";
@@ -4666,6 +4676,15 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 		};
 
+		epss_l3_cl1: interconnect@18592000 {
+			compatible = "qcom,sa8775p-epss-l3",
+				     "qcom,epss-l3";
+			reg = <0x0 0x18592000 0x0 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		remoteproc_gpdsp0: remoteproc@20c00000 {
 			compatible = "qcom,sa8775p-gpdsp0-pas";
 			reg = <0x0 0x20c00000 0x0 0x10000>;
-- 
2.43.0


