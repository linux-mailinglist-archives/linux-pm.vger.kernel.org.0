Return-Path: <linux-pm+bounces-32684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ACDB2D67B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8B21883BC4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC862D94B8;
	Wed, 20 Aug 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6rkdm2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4D2DAFCF
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678557; cv=none; b=tcou3HJ3OJ5qbSkbKU7MXAAjXvOZE72JcWiyRR8XJ4VZ6+ZHeUWAZzwRsA728iV7Lwy+MzxDkrO+f1ivSxHn42qK1O47EnF6yj4Em/LwQJCSjmM9i2WqaHapTVN1PWNcAB2ytXCnCQ8GgFFpl8YR2eAG1/qr6q97xYCsWQZyKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678557; c=relaxed/simple;
	bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzmhigWnN3KrPzKCrjrgWSyeBHvWAcyZFax6vHrk8w0L8T5cXZiYfiov2Iu8CuwyT80kZGGho075vBweFK649Y7XyTUebT5C0zu4xQ8FEtXoi4g3Njkxt9eNl19HZGcpy7AxnGCepHE/O6ZW5PMpcvyHU7G7t0pL2Mwfyn02PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6rkdm2S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oioV028174
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=; b=N6rkdm2SLD4tiqge
	felAGgUHNHlk9bbtBNZuzAiwTUMzTXnBMc5eovI95FucIC9RvKeGkx3+OTL4TaIK
	YH/fta/o3yluTkpTyXUzCxsHRdSfUlMPeL61hIZ257Ed3GMf6ZWdyQxnT1niTs2E
	WnJNEmHVeDLWOAuv7O7DphELJvVReCQhMl8DdDfwOXY2tU+l5Vqs2BgQ6Jp4CDSY
	8VSs0iRUMVMgTQMWG+Pzq9swu+6lL2BRdTBzbjN3Z4HJ4ggRjtRB8JuEgNtdOV7C
	LZmORbrXONpTurUMVuZihZ9LcPk2Tmi0uyWPbUaZTkCQnELYfs8SMsKvalY+aaNS
	7YdIyA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52arxts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445803f0cfso66059635ad.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678553; x=1756283353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=;
        b=X42TyEy+L51qgDRT0RKngxKquQ+XCDhoTbniYSyU4i+8lEsfw8gQzfff9MqDTHvZ6g
         cbBonSV8Vx8YbDPPDMJuYkCJ5Ouat0H0+rzbTm0QVfJpG3S01D90iOAKNDRDwWrRc0AK
         seD5MiQDcqgKITeV/y4o5A7Eyro7DELf+eBt+95Vh1i8+IH/leUzuyp82VQ3IHzkDHMc
         Wz0xxWgrlGPLkR82PpaB1WB5LRjbxDmksnQGFNgH8C767TFqgJra/MhAm9gJG4f6Czl0
         KJnm1uR/KtmKzlndi4LA81b3HEQOkaUm+JRCmjnjgFuSr6aDvYlrTCVg41qn24nWZzag
         SYCQ==
X-Gm-Message-State: AOJu0Yx3BJ+BYy61/lZbNX18OXM2l61BqkmYae/qT174od+ionA86gyO
	9x/3bJa5T6Ap2OhBEgnu0tMvChtUdAYI5ErK+lu8aq3c3ssIktd1vQmkwHxci8C4J6y8V7NyAat
	gg3HbeJv3q+sMsn9C6Cyxwe3b/CDhJ6u8PQnTuYeXU44a1CkFvizpkJxMjysoPQ==
X-Gm-Gg: ASbGnctw68OE3M1ATT6gfCf+REsEe5fKVRbKFQTyc/u5r1FRaNFpyZFNEXEF8aJOnZQ
	MRq7XFLHMQWRWSRWWfN/8L58vJD9JHuDBYpXvWjcfN4uvquTTGH4PdGrEoXX18tv5h1hxpuC0W3
	TQ/9j+bm2tx7BFjeHqWeuFPEJcH05zTBMANEGSLGxS1b34yim0mRVRPgMfc2dA0R6c5DYUsiFqO
	XY7uVpwxEaeqD3/5SSXG7OtJ9TXbVBNp+4HfcIWPsi2PfX9PBHfRwNOp6SETs6Oh3yIgdW6IFtl
	YRQHpl/dq4hKoJM7mT+q7ppY8uuHZR2YI6Lb1DFRgohAw4fAiRBc2TOrrJLb3hC9Hh0Owg5jnSI
	=
X-Received: by 2002:a17:902:da8e:b0:236:9726:7264 with SMTP id d9443c01a7336-245ef11259cmr21816855ad.5.1755678553176;
        Wed, 20 Aug 2025 01:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH58s+l49kW9kCSGQZvGGVUFWqSm2Tm7559FEKLDrLbXRmO7pk0REh9tawRxJs0dbxdX2M4w==
X-Received: by 2002:a17:902:da8e:b0:236:9726:7264 with SMTP id d9443c01a7336-245ef11259cmr21816625ad.5.1755678552732;
        Wed, 20 Aug 2025 01:29:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:49 +0530
Subject: [PATCH v4 3/7] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-3-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=3189;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
 b=KMmLYXCx2jpkOHi6xaQPHpldFZ07RBtLf+K6gKtKbz9lBE6uK1iQtrlG7AMP4UMtkYLRWuxK8
 4KzMEreo8atBndl2xMueG3ny6n4BmAYSQJEnth69/GUc4Qp54fwwepy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyODYU+gAQXY8
 dz3TfTKBPMgY+OC3Ws19arxrZFOlWKDWDyD6MN5IlRkbT0mabHA+tyqsB47vu7LV23HXsOSFYFh
 lmBWdQ6CsobLjF7qqrVtXbm5ncdV6sTiNqQiFcc57k7G+0ubRO4M2GaEQgC1e/Eu3/+V76S84kq
 XqzHchfG7AgxtvAm8RpzBw/ppgGLvIXsKaJ8+Kjrd2eIrtAvqoUVKvv5hZfHRHltfVYVt+fDpDf
 a5DSpUoZ/93hAvqEqJx/CTxcGZmTx6S+svNXqbqZsYyS6eu9C+JXw03DI5qHlPXCHPW54YmsLaL
 xepqek6vuJ7AFkCp7/PVbMmYRyZPdO8tn42DbDEBfae6R/9ArbOCgVWBbOkMDTAxfw7ELF2F+hE
 d573dryaMrSsKnKkWfArpBQNs4nmtQ==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a5875a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: NmcTved2yHke3oirtStBppJRnENNY5dg
X-Proofpoint-GUID: NmcTved2yHke3oirtStBppJRnENNY5dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 41 +++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b915136546c7f92c7cd0b8a0d62b7e..d7f8706ca4949e253a4102474c92b393a345262f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2052,6 +2052,7 @@ opp-2500000 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
 				/* GEN 2 x1 */
@@ -2059,6 +2060,7 @@ opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
@@ -2066,6 +2068,7 @@ opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 2 x2 */
-				opp-10000000 {
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
-				opp-8000000 {
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* GEN 4 x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
 				/* GEN 4 x2 */
-				opp-32000000 {
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


