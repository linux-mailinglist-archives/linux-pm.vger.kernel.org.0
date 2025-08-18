Return-Path: <linux-pm+bounces-32504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CBB29C04
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA373B78EB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAE30275B;
	Mon, 18 Aug 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjYZ7N7v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F343019D0
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505402; cv=none; b=swB+bkfukXwM1cg8Nr5l8czk0ylPziz5wRVVZGlxiTc5NZNfVqWgPSgupH6nEbsWrDh+ZgYV2vrbVMA6LginBJNKpfm6M/5Gn+7+iunkRqXylo7hCM+QLRhD4MqOw5HHt2mHKG8+B4J8fvyX2ZiPnUOo/uFTzkZg2qml2QKrf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505402; c=relaxed/simple;
	bh=/X43xNieWg9p6xglDxCtvVV/02zea64o7yV7vb+s+f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWnkIH5A9hRjpXginaSOHf6Cdej2uUXuNsLx6vqkTZvS+VPOYIVpnYiapjbAD6aA80f09oARSSLblD7v1EU0Fziko0kMgq89ki3yF7qzpomFPiahRpIvWcLo3q8wBjAhSqbEIo3ohsVsSKd1m5V+zvvbjz35j3Mnse+GhNoeCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjYZ7N7v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7dMC8031717
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjaZn4/0sl0sfWCsd1j/C7M8oP9Y3C9g5KguV1fncJ4=; b=IjYZ7N7vjZEAUgs1
	+XdfvbrDL1BuPxpWDVrkcNSGqh4g3/9HeyJXKKNqfvL2EejwYXiVd8uckDJ9yZeS
	WAnJMoy7dBAAv4qwh4+KDCPlX/9f59olE3Fij2/g3hFxtu6pK9GhIygtx+VdKcIZ
	9uhmjZG9ojQvFzLQ6X0+jmjHID9MqV/N9k2fAvTbfSzaRD9Kycz9DJuZAsd7UtLo
	+xhOYrD3XTPZKN3MIFJg9ijXw8g2DYYCvHgavY3ILuP9T2+3uEVbaRfE9fWCdPR2
	CbcNu8k/5oN9LBsq4PalGLCqN2t+pWCCzzhQ9PDVf7SbH1207ls8twK/CMSyEDA5
	Ji4z/Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ubx0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:23:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244582bc5e4so45882945ad.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 01:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505398; x=1756110198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjaZn4/0sl0sfWCsd1j/C7M8oP9Y3C9g5KguV1fncJ4=;
        b=vLL47hzSP5yv99q3KSTlaLvnH1af0ACRE30d5QoUoUen+6GYo4bBuUOmVaSanXXHxD
         VkDjVczuylPsArgZZEc2YDfFmvDHeaLURRWhyij0SCVU3MYjW52HRgz4wMlMiovWl/pb
         j7Ys4Ym/J2Mn+MJ8tWTX+hK6vU8L+X2Srbc8vjjoxwGirsmEFqb7hUdsQpiLnZjK5EsN
         vRc0LCkiJ8e9S/ftIOX7tc5yn1QYUwFBiGL7m73hmbllWNdOjb90Cwrl3NHPUM4dOBsR
         mPBG46HmtZsIWUlyl66hBK0rNv6z1co9vbwXFXeNFjtQm1/rRyLB9pRdtmcNxTzZj14X
         R/uA==
X-Gm-Message-State: AOJu0Yz00URX5I92EGPHpqwCw/lF1pfIJIVixyUmF4v2GQFXrQySNeXL
	GE5m4H2I3ian2Cz7ZYZjVimd9y0u+pIWr3Rs4MS0NZH2Hj+qr3/90g1EScCk+eYcTOA7zwQ0lee
	HyS6y/QG+c+bV8Vn0UhZwhOpvEeXf1NrEEpd5KYSkM7ZvgTT44XuPej0tgMBbaw==
X-Gm-Gg: ASbGncvYvSax7vDbRzgoTbRDqUVBY+4cawIJQjvzhFFnOARrlo2arpjQWnKGz9USAZL
	6sr4/rUEn/AlzeY0xV70eGZowYXAIvNJ7VUfJ/LV7o+YFQTcaBo3FqMptypmQNwHQIRLGVaf6kO
	8I1uPm6AUndO5n3xiN1n452qo5rFI8oKXq0d7YjWmQ9CHl7AqDbBqmymiG9JD0AodWe9sqoXZnZ
	rmySSqBGwlnWOpR5alCMvm8W2+d5aID5tVpL/2IUMiFgj+/EpeY3/AH3oqmAVZGqeT3dg6/458b
	9kI0XMGEUVFrfEOnXVZt30IeFurOfa/mOoCLIyqiTPWJ8eehZM5quYWxYTS5bXj0kn1iT9EnzsM
	=
X-Received: by 2002:a17:902:f552:b0:243:b39:285f with SMTP id d9443c01a7336-24478e3f3c0mr115899325ad.13.1755505398497;
        Mon, 18 Aug 2025 01:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjM9999RIy2fJin1SHXvFdklmTkclCch5/YsnRm8ExcVp78juvsGQ9GjFRyzBF8Qyf9n8ySQ==
X-Received: by 2002:a17:902:f552:b0:243:b39:285f with SMTP id d9443c01a7336-24478e3f3c0mr115898965ad.13.1755505398040;
        Mon, 18 Aug 2025 01:23:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm73225155ad.137.2025.08.18.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:23:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:52:54 +0530
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
In-Reply-To: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505382; l=3105;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/X43xNieWg9p6xglDxCtvVV/02zea64o7yV7vb+s+f0=;
 b=PNegfLcDn+vRgoOvgCOON5K7THth5AJ+iM7ASzt/+qoDm+LVJ/pBIFpxEapuXEegUpZg2vUVm
 53Fhsi90TCtBvoi62bR06F8U/1Y/d71u5pTsnQG8KQ7AlZ8br6qB+Io
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a2e2f7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: x8wwQCBzX2i-xvKkIAO-t1DuPdKkrW2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX/81RvD3JbQZG
 xAOejAxWQqzKJiT8qM4l1F7oy4fTUY65vbPBtn3aaljSpaXjSlzAclfnkJ8Q88T2SX0dL80Wdnv
 ZlL+FD4tFCc1cxrG7LaLIN9Bs1EQurQfk0nt2ReYekc1tPMK6BzXbhIVqw+lCf/mP22JXS9/7cK
 YEWH7kNzfEwuCCD0wleGzjLswL2uiIz8OPWM8cnqQoZowUIrVVt/hsJIXq7VA2InZDvVArflDQ2
 7K010aun3mZlJmlYG//VJSBwX7qT+ev49E+MTYNU5tpcWro0A+YUPwGgt9Avj+XD+OMDkKkq9Aw
 FPjzB0URtNJF0zdDHQqaXLD5oiiUDo7kVzFQy3zfEQD3JOYUN00CjnDswi8bLeD0wMn52BahYPi
 W75l0v1P
X-Proofpoint-GUID: x8wwQCBzX2i-xvKkIAO-t1DuPdKkrW2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate.

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


