Return-Path: <linux-pm+bounces-32686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AAB2D669
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B8B162F29
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC72D979F;
	Wed, 20 Aug 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbhWL9W7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2122DC350
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678567; cv=none; b=gapamptyMiwehsPcN8xAs8LHkKB3KbRhHvnyBMJ9Z5WQL1GsxR3kjymygE9vP41JzwA8G1FunTkA5Gshn9RtL0Han3J9b1u2xdiG8JHq8cjz1ouHpmlvvichrspJKeb8JSdr8wPuDey2AqNmQnokG0+oZredEFa3dXB7X061DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678567; c=relaxed/simple;
	bh=cUKVuatuU0/Edgpdfxw3c/N86a1mg3uApCUinYHTLyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDk2sbPSiDsOTEEh9XMOQ6ooYpHoVFWm/NzCCnWQda1RP29eawfYf/omyHeu4wo/5tQz08DpFz6bGWyB/A5nA/YkUqkbqCNsC/EnwyCj89a8cb1D7xyTSh0/pCgouAkyIvMMBusmXijKgXhzzMi/m24OkSjaaH3Uf6MzoXnwoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbhWL9W7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oXpo019724
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGiuOX/3Gl5SQ8ZJEPIiy7Ut2Wjdc99qWaL4w8mdXMw=; b=XbhWL9W7mFtOw0On
	Md6vs4tmwOGE2wjJttE/D7KDSXYAqom/pH2/sflw0z1Xw8q0fpKTIyGeVNrNAGuB
	gGVzcwiBg9e8u+EzaM04/+acp6CnT6rEUvdj2UhNXc5JMwq/+e8w9HGBoCdKA9Wi
	LMoleEpWN2qfhyzt2ZsrAOld8/XjtCrt2HqvwHWTriAGrgdv5GHThgaNTeYyPkjx
	SyEw5Dyyk0aZUGlfpI8Td2RCeir2vM+pLiOxMwxik7WZ/rx2G7+F4YBYRRy3aErD
	UMlwXdnjgzVpWDP1zlKSbJadfOOaDVTz1u9EuqigEqFYv3eFeNcfKOugUQ/42Tax
	t+GQag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290ytt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806b18aso70716485ad.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678564; x=1756283364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGiuOX/3Gl5SQ8ZJEPIiy7Ut2Wjdc99qWaL4w8mdXMw=;
        b=HAm+yvd+J8k7AExbWqqx1tffpFkz7R5eaIHh+dFxB6wwR+Cj0xWRJB7HM3z2vGEvvN
         lSgv9Wygi9LBHyhp0C1jI3EpucSs+ZKCSBdM8M+9cpl6t0NF4lxbeeXKwkTePRqOHsb2
         xmwnVYuosTbNgHuVFClot2IoeSbR+4W4Ppik+9fs+Lj99rINKN4skVEAf7oMnh3z2OSg
         plwriiPMDsZlx6UMlRC8tPos+3QxaIwk+3OlO3elMMj4wZKg2C1JfB8p8YkT3b/lStYG
         p5WTmf5cPi3a+wG1q1RbgCb4HNKSo1xsQL1tOdqADD2FV0VwrCE3IVzyRo9uenxK01tT
         CjZw==
X-Gm-Message-State: AOJu0YxiBNcpGPEdb9f9cDAwJAzlKD6jUsscZe3pc8yS3LZAd5F4XhFa
	aAVnzH1XbvOOHEbbcyuLLWK+sn+66h6ijAI05EVLVhEBm+tQ8AG9KrBpC4P5Z2PhGGY+6r3Q6xJ
	XWuXLmfPxhwyKDhsXajxP+gsrXIvHEY/htPc/170H+XPiZt68aXZRgMryeUjj6A==
X-Gm-Gg: ASbGncuhyKWHrdBvBPj/7wh26gCNWZOtjtclrjOODiTV3T3JkYeWlzOTxKwsixGbCQD
	aLUjiAnH/z3cXg/kNVlYGinaXuy/1vJG94YgqK74kEJDOcdN2CtRn5+90D7uICAYYE1VA+hljEz
	ArRZXfEY/P7pjrgVnCXrT2NXdoTFEx+yFUD4L6GqQFDIRJt30xdR3TKEcTm34OlCtZ8oxDQyJa0
	X/YpzPQrTGXStigilaTcvhfmflBRAVw5DlLIv3zzi2CaBM7oP6sHPaN1F8dF9DTaQFnaTgfvS8e
	UapJ+EVqip6pW3owtIY//+NoNgH3bsq3bAN0DImWffKK4yulApbiD6ylAP00JifR2Jw7nQg9oIw
	=
X-Received: by 2002:a17:903:1aeb:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-245ef27bb12mr26602765ad.54.1755678564531;
        Wed, 20 Aug 2025 01:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJc5jlXFWnGiYoLB1WpPpHS4FuxQkro7nZwC6fQBl/f109El4o5ghE83SpvySv0MBi2OCTQ==
X-Received: by 2002:a17:903:1aeb:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-245ef27bb12mr26602405ad.54.1755678564076;
        Wed, 20 Aug 2025 01:29:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:51 +0530
Subject: [PATCH v4 5/7] arm64: dts: qcom: sm8650: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-5-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=3994;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cUKVuatuU0/Edgpdfxw3c/N86a1mg3uApCUinYHTLyY=;
 b=j5NiflaSgQGzH5k3irCGzLAmssdtB0MNKNmsAjE+zZf7QsSW5X3nxr9zNrCfcextwvlqln45K
 4cKrCm4HRKlAADynfcudFC42Oxfk7uIwFW96kSOlrvM83JUmTSEWsiE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: U6s1Vr4Nsku60aax-MhCm9z1Y7Ylg8ib
X-Proofpoint-ORIG-GUID: U6s1Vr4Nsku60aax-MhCm9z1Y7Ylg8ib
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwbLFZpj4wS/d
 9VQGIv3Oz8OGT2sWrz3TNOj8xg2ibwa1b9aWdINRW2zdXqEAxO9/KbAXMv6s0sF9gxeDdq1Vkk3
 W4AWPyNWEljuxGewIZz37V6PzTDUOO4rgq09Vjq9jS8LCg+46avtrkNWNDouX+cK+IGCXx9Y8bh
 Q28nqL4s6W0IVNcU4Eyx/HQ0lBGhsGr8E5DDzkRQ5YbGqCIXklOQ0Q2nXDpzAx/qH6rgzywic0e
 GGPbGtC7Gq6+kfxRpYTbH9/JAPk5DqBx2jsinGxXS1ZXWFnkPkLGG7kQN5QntRCpK+T2G7f1kBp
 2pBkzyACSzqe99fNffgaoGzNlXJJa8nnwPZ51vsg3MKY8yaz8kAtTdbfosI5wXIG2ZZO5Jib9CC
 ezb2uTOnOTW+HB0Sym0Z4FIAClhugg==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a58765 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 63 ++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71bbbd0c8fcc851eebc9df9ac09c31..fc05f5eee870ca67cbafab5d989e5f861d96add7 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3660,38 +3660,51 @@ pcie0_opp_table: opp-table {
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
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
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
 				};
 
 				/* GEN 3 x2 */
-				opp-16000000 {
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -3840,45 +3853,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
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


