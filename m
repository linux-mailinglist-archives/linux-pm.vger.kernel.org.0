Return-Path: <linux-pm+bounces-32599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB29B2B8C2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E51567D81
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3D310658;
	Tue, 19 Aug 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCxSDkLu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCB3101A8
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581717; cv=none; b=vFn6sVIHvNQ5SLGbDv2Ce2Q3VVyxhXlA/ShKqZo0bZy4KJiPess5WHHStkDJ5uCJwHO6KDxFMNS3/3Z+jYSBRWn3S3Ts3ENHpLHvwvm0jHijF99m4JJRYKAF9riIu8VPUfhZaW+AJ4las/sLheD6ByYqc1LKKWi5EV3Vh69xYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581717; c=relaxed/simple;
	bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yha6kqxlPDj9lbspKdR87VI3sNSIbXJe5ZkunU0cGmz/qHPRYVTT6Rz81Y0XHe6jQ8CP/TfMLuLK/ndSWuVmTmN+TVxRJhNuuSwAv6vqD4VzIRtfyg7FWAbPQfqxmgthVheHqmjBgIoo57N73gURgzUsryNXvMkhb+KSKQN0oIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCxSDkLu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMTLWp032554
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=; b=YCxSDkLu5yz2f4Q3
	RcDI3dRVpQtdarphXwI7VUURtKhFouxoneOiEpR6SkW/U/Om50feVe2HUmcbm+nZ
	AUbOtfMWinS5JdeFxIYwfirwbeCPQ0xZMVT0tO2TwJqOn9rreFHikevzQXnCC0V/
	JT8Hnz6t18U/n+JlgPRQ0jyjUnmr3GuMSP35QNI5xoMgwc8eMfsTYE3L6qRUk0Nh
	Vv3qsJvZ/tZkFWIwDJh3Y0h+u9uHnSJ5LShHd9yhjF2P3Q9/2LnQUZZX962t0yoR
	SiIM94zAQGblgcawe1ippuoVDNQIMr0QxGBDrQv240dmXijMZc+Pc2G8+PTw5ZRP
	z6HoIQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ufcc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:35:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458194d82so50477615ad.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 22:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581707; x=1756186507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=;
        b=Z063C4J6p9UCyNu9zS7SIevn0ujRdb6LvE7+mi4upU3c4d1iCWyV5mZOvazAMHPZyF
         BeQ7AAOyv4oH2N6VtwPqRuEO8G2POGOhAcRtanITHHIPSdFiKbPHZjDqOuSAeUFWzU4z
         uM/R+c5kafse6+yKfbiB3q+i80/bFXU9A54EkxDgmUZJVQIypDSeDYPfru/hSjyiyFNv
         PIlp0bMq4wKGFTEvVogV55YAwBdK8yqzDxSyc7PZ38HwfghFSsVF3XH7tWDDqVINqms8
         wC3J3WKim1L6ciMtGg2mVQfVsXpdISqWqXZGO8bK65yS6TU77oLISdS2kJg5Wdxi4Xf1
         zSdw==
X-Gm-Message-State: AOJu0Yyn5uvulC7inUBaVwWStVnaVoWefHOKZq2igRdMh22+YzHy33oD
	6h4YbSYKaFw8yJyiAWjOZO3dDY3zOIWwpTETSvGV4GaLrt0mA5nNgY+FA6LVV59wk4PZKg28Nbi
	2G8gGXIabO/R3FRQJ2pCnDS5mcB8lF9AjO49Slk+nAVFTc6KQ1Swu2b+3RleUgQ==
X-Gm-Gg: ASbGnctXdjD6IyUfi9P85fggGGVGdtRVtlPD2jBMzPMX1u2RQ5nAr1MoFsGdKy23EEq
	Tzb+NGGjkvLUzyNeKXEHIJDbFtz56d/SUrDz652UVi/2kwuyHtMf8Q3VDVsFtcIR7bvazd8zZoV
	Nk4kzn+sWJ6ceWxzfKcVujUIAXilk1bSBgxhs2k+wVrFBX8fyh6lzMjXriD4h4U11CNfBlQNhMl
	OsC81RD/aFOn57pw7DGAzRYTgM0Y6ZKBKsrUlXCWuHktI8pdxY/vCrjjNEKIgKuV/g3nZX+k86R
	dLvviyVDHlZmgi7nU5jxRYKjjC7hB6sBEj/KK4GxtHJpOfMLy4QmY8e0d3ZIAoj56rssdFLMZew
	=
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781915ad.38.1755581706749;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3T2DWF0sM5aMCv7IQ1WuvOo+eJnBtoWO3vhU5xsD6yPrx9RP8y2lOdkUyfyrc1jBjsJmiIg==
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781465ad.38.1755581706220;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:35:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:04:43 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-opp_pcie-v3-2-f8bd7e05ce41@oss.qualcomm.com>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=3189;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
 b=JlhlQ7TUFYilxYzRYBEH44c1xz4YIwI0fcVfxHuf0FM5xfY9kBMX68LMdQPURjW1d48qfMVRb
 jBzsfMXLcBvDWMTBKEoi+XFYXQByPcCDsCWFyRQW4zGN/lvwwIpaDi7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a40d12 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zMXv2zaoiei1dToUpyPXIJFF8WlBaiEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfXzu+kTLnQCfcI
 tfoVGzZaZZ2tYeTJkD7FOwyJ6IrR60D1frGECDXoPMwv3g/kwBNRrvH0jXcn8/S5dF1jXuZHrMs
 dsfDaZtVA4G/rt8080WFAZIf4zWUbAgzxTNfoejOhjucBbwyuH4zYs7JfdVgz8XsTfZWAJQwi5u
 eKxYq8sE3K+SPBlblXo7kDQZj5xkRWICdVbCq6Qx1OuyfZJRBfEa2d7XcUujiGmbOS41/eFHwLP
 xJD+nBLNx6P96Gp/tB7kdJZseVW6INllL4hfg66I6dVDOmUnPQOJYfr6/7HpTpODXc7pDHKJYve
 tbZJVcmnLxBYWxyxlEPqCkBJ+K5Uo/vJG/PtPDFlmjip28bZD+e2pPEbttKN1ESUcVmy/s+RJl6
 7P/1BP0x
X-Proofpoint-GUID: zMXv2zaoiei1dToUpyPXIJFF8WlBaiEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

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


