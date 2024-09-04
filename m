Return-Path: <linux-pm+bounces-13608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A696C504
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229B51C24E75
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA41E1A1A;
	Wed,  4 Sep 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jj8ryHa4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2831E0B99;
	Wed,  4 Sep 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469971; cv=none; b=hYumHYkhygQ0/UtTma0MbqYn87eEYWGGbBKnMxImJouR+aIXxrxtHApn53f9CDCX3No6wR9eJQJPrBncFcUIb0wZFuQdd3/XIXGWbWCRKPW7xTghid8Bj1/xED7ScuOunmf+GQRT3dGWl4ID4156xYjcHZXNck7SA1pNMDJDxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469971; c=relaxed/simple;
	bh=/J9Qxo2tO20UZrHFyDBDh9ZRnc3izojgbFzm70J+krI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juXax3hwNzAyVflqUb0o6BOIyymFp6r7T8Q7yMNsuuGv7wtiPIeurihvF+yFi/wakJ8rpmu8u26DFy9jHVRIViNH17T0bBIROVOTCGcu8x2sEIO9a+XLczz55Sa2TVcAwkoPAMQaMVpL3/edm6BlBdw1p1mMfuim6RLn5oxwvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jj8ryHa4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4848I7eI010438;
	Wed, 4 Sep 2024 17:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7xmL8xmgnj65rbmd9MFRf8hYz8z2EQF05QmylSm9zo=; b=jj8ryHa4VaWaou09
	M6VJOBuJGczlbacnyn/NcnU4A4zQ6AgXwSnbqYSpaEy8PcOwKIP/fq8h26YDsqmJ
	5XGO8o9z7dS0XbY1fjXiRBaNspLs2C2OyPfa+7b7j7hwrpxRAT+oel+RMjsDPsYh
	5l+dWTwBzAJDYY208wYi+qAYysDvuBGT4wckh7y2RTujZobYE6xAdwoHtLeFrgJ3
	OlW8n+wMPtLqin9n0cHuSWvJPH/VEW9v5IVYCzU0ymsGqD7R6fdNagF8ysSrZgit
	a2w6KNwoXLHz9C/6zlkU33seAj4i1RjIT+2uPeA9aDtRkYK7otu/mKCvby2UaCkH
	HPBxIQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhmsdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:12:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HChHq029761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:12:43 GMT
Received: from 0e63825dadb5.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 10:12:40 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
Date: Wed, 4 Sep 2024 17:12:08 +0000
Message-ID: <20240904171209.29120-3-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xH0NuquHw8fZXeAPWrn-BF3L5oXNO2L2
X-Proofpoint-GUID: xH0NuquHw8fZXeAPWrn-BF3L5oXNO2L2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040131

Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
SoCs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index e8dbc8d820a6..06bf2ba556b8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
 #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
@@ -3777,6 +3778,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		epss_l3_cl0: interconnect@18590000 {
+			compatible = "qcom,sa8775p-epss-l3-cl0",
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
@@ -3790,6 +3800,15 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 		};
 
+		epss_l3_cl1: interconnect@18592000 {
+			compatible = "qcom,sa8775p-epss-l3-cl1",
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
2.39.2


