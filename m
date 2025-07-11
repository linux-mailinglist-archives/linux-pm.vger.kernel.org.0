Return-Path: <linux-pm+bounces-30675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0FB019BA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF105A01C9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5A286439;
	Fri, 11 Jul 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/iFu/mx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74D286401
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229565; cv=none; b=jMo9Y//gC5s7R2YUODZgbOcAeP8scVupoZQfEnMKgk6yVXBBXbWnrLicUlzogxCNmpiONhHvqmWm/CvbDqG61QIZ3Xlu8TV+14inufgIfATc9s9ByiIDSbn/5SAcJyG7Ujg2jR+EosaCm/aELDeeQUToMe54bhxiOO0R/YVKG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229565; c=relaxed/simple;
	bh=fgdTM4ITM88GWY3Neg4ZqJewXaeotsx4jj7fF3ssm5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6apEN+R66Zb95BGY6F++5iC7xVYBGdPIZrkaAyk0Wmfayqx9CtWXJkzkQdeWtVleGh6PtzGHPCpLlnLwH9PeWjqWmIgyFnydDJdyvccXvx/Yy0JgyNAHfpCUY8JyGWccTTgFIq90qGVErAIIxIBx87DFZc3t5YybxX0iPqhSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/iFu/mx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X9jd003861
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xj/5EZbPPiA
	iEjVwB/H1Xk1YvlvBGlniJy+i6YLozd4=; b=Q/iFu/mxM1ajpel2wQ64IpkZxNx
	jSxtLyCb7zGMcgIkvMNPEd8c6UtCHQsfbQ2MtXX6uqSHlAwMUdi8BeKhqr1LVB5H
	ZZg3o1VWzHSX42Fmd2v6pN5OQ0sTN+3KXGVGXZTW3rdEOOJ9UrDyagLj8y2POa7X
	78x5MqvoAheB7Bu26AVYbkk/7Ktf00P5RrMS/HeA7lcxQ1ndrAjywsvI7zVMTNaJ
	U4s2+U4ulkmyWer/HfXTvkXeSS7pfLdqqqaMn4bRyszSf9sTawfqeGpiUk5ULs6L
	MWSaVccElpgL+Z/67PUierycwuT6np0GIrqZZJHt0wF+sgyJb4I7/fEXmvw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp0a4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:26:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23507382e64so20732355ad.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 03:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229562; x=1752834362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj/5EZbPPiAiEjVwB/H1Xk1YvlvBGlniJy+i6YLozd4=;
        b=JBav+Rqi9KNY/S0xDujImfAhu/aRUJ3QrEDBWFkLV+zB9+draUwWjesIFPoGqU0ovg
         TlQHFNZdqnjuGAeFjNTO3zgQiU2gW7WkaEJYpu7JiLcAg/ufclaFDeZMBKa6hTTBrGAs
         Ym3Lj+WpUpeAWvx9KvYINdq55TCMuF5ltZY1LMI24tocObMtxCpW6LuH7CllLV/RVEYe
         2SoyK+50aKUypeOZkyc3cOg77EU7U0Li6BNGUGrlD6sp4lzW/ohtPtNKHHZyoFy4lXo4
         GeDbDrfYZWKegPVPDHB5mKhCvOyvv/HrY4cd7euPVpBwv/h+qNvPP6u6mCAPneuJ9o1t
         zy+w==
X-Forwarded-Encrypted: i=1; AJvYcCVVjb833RoB4ju+C6Hp+fR6IR37v2CEU9hL1clGjk1+BCTmaY9Lc9yaepH1H6Eak2elRsrG0/+PyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwISZ6bP+O7DbRfd4GFOi0GMATkLhIF5hGNHfpbeuUxFrHC/RbH
	SJcENTQL4czbtqyN64VcK+J+z6MGuMYkKMtyaxFK504hnCe5pxBWkZLqkcJ7749Fwp2P5w/n0kd
	T1lMkOY5wNo/e2Wp6g2FhfdOKnIdNi1zZcqYzA7BudXbFs+ZS7ZRmQTIC9FZCnQ==
X-Gm-Gg: ASbGncv/JpSTBcHKqucWi8/WeOEghrbkWD5ltPrtBBdknbyCBGNf+sKUmKfsi4ZsZlv
	nsdc9l+XiVLS/FksZCKuZxvyqd9Ob0Ml+96zSWQ12kd+Ou4RHvgzQjtrz1mUloRTa4o3YLeUFyD
	zvEqh6ujaAZ8Q4/VNY407t7ll+6UwuRMRd1rFWgft0a05EEXwqwo7sMb1z2nc/tAoi/GICCNVd2
	IoHStOMn2NXlj2dC/3y1CjhSJaZ6A7z8vGsQcrWCwlQDslbOmqP67LhZ7+yuwuJSZbCX7KfYwbr
	CymIWjwPC6AHJQmPqy5O5Nf9JD4AfTgOco7du1hHIgjJ9awF6U1HoDzB9uatUfkfSqmIbg0I/QO
	SAlw=
X-Received: by 2002:a17:903:22c1:b0:234:f4da:7ecf with SMTP id d9443c01a7336-23dee1888e9mr31559595ad.8.1752229562207;
        Fri, 11 Jul 2025 03:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9gNVwJIyP5KQDtwpzbz8gmKpf4Cj0OJhjLdP0IHV71VQm8NLRGpE1x9Fmy1PpHQKgLA1V1A==
X-Received: by 2002:a17:903:22c1:b0:234:f4da:7ecf with SMTP id d9443c01a7336-23dee1888e9mr31559315ad.8.1752229561795;
        Fri, 11 Jul 2025 03:26:01 -0700 (PDT)
Received: from a10065738a1d.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436839bsm42861375ad.253.2025.07.11.03.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:26:01 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 2/3] arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node
Date: Fri, 11 Jul 2025 10:25:39 +0000
Message-ID: <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MyBTYWx0ZWRfX1ngiO9pFgpKz
 EAIlWicl6WSLciRJHCiwfI+8M24bHq8SNNeH3boxbJQRRDraKXV1bpyLNjMA6173K4PVnfL3Lj3
 0c/rHCeeSs1NBRUZ6kJFM9UHyby0cVBzp73B/9YFOWOauHdnHJxvQbUxG7OMQ7jsxO4kerPmfLT
 pTJ8Y/9v43Zai6vE2Sn4j2A2GuoyzwCIMoIsWZsxy/qZVLs9GLREuxT/Jc8buD05bzCrqLPZpDb
 bxaVUyLC9m9M3zZARYOFthae/ds1IiNnN0RULSZdjAt55P+6m8u0/bXyMMCVnvDIhW1yAFRApFA
 CU3No375tDdLTMNHYYxt6sxG1/TBAazukJ/NYqmTxIljgy0YlWA4Nz5P5AIUN3+CEbjk5/PgPFe
 AbnMSdE5Kjczo7mptYzuVu1BNtvVBbQDclqTfhapWrqXzjfaXq8IDMsGnZQe2SJwZ7w9M1pu
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6870e6bb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=U8kZZDKKErrUKwT9OYMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 7mfE7p5jCeOwc5eoP5q4OKcGqoZE6jev
X-Proofpoint-GUID: 7mfE7p5jCeOwc5eoP5q4OKcGqoZE6jev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110073

Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.
As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
compatible as fallback for QCS8300 EPSS device node.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 7ada029c32c1..d6a58e228091 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -5433,6 +5434,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		epss_l3_cl0: interconnect@18590000 {
+			compatible = "qcom,qcs8300-epss-l3", "qcom,sa8775p-epss-l3",
+				     "qcom,epss-l3";
+			reg = <0x0 0x18590000 0x0 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@18591000 {
 			compatible = "qcom,qcs8300-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0x0 0x18591000 0x0 0x1000>,
@@ -5455,6 +5465,15 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 		};
 
+		epss_l3_cl1: interconnect@18592000 {
+			compatible = "qcom,qcs8300-epss-l3", "qcom,sa8775p-epss-l3",
+				     "qcom,epss-l3";
+			reg = <0x0 0x18592000 0x0 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		remoteproc_gpdsp: remoteproc@20c00000 {
 			compatible = "qcom,qcs8300-gpdsp-pas", "qcom,sa8775p-gpdsp0-pas";
 			reg = <0x0 0x20c00000 0x0 0x10000>;
-- 
2.43.0


