Return-Path: <linux-pm+bounces-35955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E8BD2A7B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C11189BF23
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B530305E31;
	Mon, 13 Oct 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6BeEayn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E6305E0D
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352846; cv=none; b=daE4rY7+2CrlgW96uII0v8SLEM30F0pxubhXyVLsf7x+aiqQv/eFuw42q9Vh0weG7HrGjbt/4gnhe3tlt1iixsftB0qcIGSDS58w0KCgZJhWJ42YuK15bSjkWqMyXdzSR8eezELE5LNW4FNJpiNuuS5BgtBpz0PhQ4QhaQpj3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352846; c=relaxed/simple;
	bh=y2oEgd+ZoMp2aZIZllFCtM7ZHgenc6dnMUZhPAHCRYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCPwlKRmHXzw4odA4YbXzBirrJ1yVGgowlLgbCPauG+Hmq/s5h//TeRFqOMC2ZVODFp+fkZ5m/Ra7dLq3XdkBaU3aQFcXfstuAI7mB6rGRPpyaMRUPYCcrViI2VMSTHJ6e4fMQi2cUKIjR0yl3lSRl0e3iIFCPLE/dBtsLz3c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6BeEayn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DABYId016699
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hu12c6U1rd8Z27Ib4V1hOhlGmxZlRxn08YoMKrqBQYI=; b=E6BeEaynWXTi76uP
	C3ZLenxlwqiO95JQAXfcWyKzlScZPq+awm5ki0xpNJkWQ/H9sJHUPtlj0+AUY+Wa
	tQ8H0mBw9DbPaZfs7ItE2URoZK0Z+8ydKyq8pk91I1FX6oUgFJMJoKaCWyqBcysU
	O0zD7bJvGRPlbh1E/u5B76foCpuB2KGboJWF/gV7jw222sGE9q4p7Cqp/n9xmMcX
	ziacHrIkZyOoskr1BzdLYGVXIqvX7ywZyzwmdlj/0VT+B96zYwK6NOwIy+ygEoty
	6LB2Sw0bfnFYo/tlY7ykZ/5464SC6v2UkdzMnjclXnUfbhjAeJWJPUB00kUHbtBO
	Lg8l6w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhva5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 10:54:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so12891375a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 03:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352842; x=1760957642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu12c6U1rd8Z27Ib4V1hOhlGmxZlRxn08YoMKrqBQYI=;
        b=ofXPmUcmHCHzXqPVJKA69ZwLxfWzKYdRUAQJkMv1BpQPTUDLOQrNBZYXsLnvVTb84x
         YHP2b+RGUymJvsrlrys/g74lCc14p0xqdig+WITfkZOSuFjRmW/gRUUf/d3hKuoqbS7c
         k6AZnnb3YOdrOEGTjRekDQumafAXaLrJ+jULCg4LxRxnhuuB6xc7TM/QlkT67AOmNdAe
         XXi/6Bec6yeUgnuH+/bYtTYgiA0NOQXyxzPKgAoAXNviv6JxjkBFV/CGvxsn6DRNRuGR
         AuFvtYQUw7gEAZCI3o2EckRyJe/e/ONmRvcwOjLL9n9jm8mxTnMhE3guBezXJnrOKxgL
         1GDw==
X-Gm-Message-State: AOJu0Yz7Y4OwSQLkcwEIJma+/cUL37nhKEgbTUziyFd4PL5e17ibhCcu
	/thN3ys23xoWMmm7yInD4+T+4myrIHdadsRrNYVwuQCG1vGimcxeLZP9voQXbgRRPmQQFksIyyQ
	1sEmOqfRDRJ5tkVv5fWaU9Vx1uR6dh1pRu5rMNnGDPbPNmmHPYIU4csUzDdJygLchx1vKOQ==
X-Gm-Gg: ASbGncsJOsM20J2KzFHyy2L0acMVQwgwNlr0UGMwQ1cz+61GtaE5LhrHQDbM+gWVB43
	tch5AM6JM5vfLt6GDRsXC7G7WOVUyWZermpSH2Wd8lNG09xAx2MSE8D3fA38U3wcDA7ouksKDDj
	jv0ejwcgmALZJ13dT9C+MneDyqQlghL2Xnji4pshC+pSnLqb9Dvm+kedhAd7hohslyuppUSLNos
	olvLo1+5hDY3Sq+f5UNVlVN/uGm9FMXhbMAw0P3K+gtPNPBILbBJYoBp9cN7YmmOChiXwvQ6tPG
	dthS345xlpMs1A8s5goVjoziGXWU7yVhLdsTZ+u7Wutr33ncErZ6Bi639v+XzRV6i5u9/n+rxiE
	=
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33b51106a08mr28884080a91.8.1760352841729;
        Mon, 13 Oct 2025 03:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL67rs42FcPE7mXkIbR0fTv7qyOq2w1A0meKupktMXF+eQ28rjAxJADbVfTx018wSYf5I+FQ==
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33b51106a08mr28884036a91.8.1760352841264;
        Mon, 13 Oct 2025 03:54:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:29 +0530
Subject: [PATCH v5 2/5] arm64: dts: qcom: sm8550: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-2-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=4819;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y2oEgd+ZoMp2aZIZllFCtM7ZHgenc6dnMUZhPAHCRYc=;
 b=WXfYwVyiJVYYbOAPvvH+jgZiwIINmOHJrFhYWq18X8sh9yyNtTJf6l5wocZ+Mj9sbcb3xvIPv
 vzTV8kmZCATBS4eVgcdllk2rr50C8OsXR/k9jFBRhfid0PWBw1QhC/K
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3k/GxXV0geu0
 yCEgLm9mABo7Rq/aZbrnqueEh1p9Nq42lJMWoAcERrg0yMzyVdNBy5otMorRWlVsy+VMBO5SWJy
 XAvoENAHnbu/uKPnJTgI7VikUVMkasOQVcHMVrxSdcuNBWFULpWgIKYSClilA4+CsN3kVk6TxIp
 NoI75CzhjzriQHRNie2v5AASDUFQNwoWExtoPe9d/poBvrs8AKo+wlxR5FXPaPnn497qUJKoZSD
 hVJvqTP2q/1+0fFd6pN/XnJY6HvyVJH2HZnRoqIL58XgwTGBowLxoLMvlgCAaL+fqZIt/RmVKM3
 vDvcGLT4fJZc6rS4FfknknsWLziDBGqaDjmKdjlIIt91boTdsZibo+xAlix3NOus7QbgzWiG0vC
 BX9vQwjaBe9NQjvT0a2DlK6nVuUueA==
X-Proofpoint-ORIG-GUID: uUERiSrqT8bdj7PwoFp0ZiRkY5JnW1yi
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ecda4b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: uUERiSrqT8bdj7PwoFp0ZiRkY5JnW1yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

The existing OPP table for PCIe is shared across different link
configurations such as data rates 8GT/s x2 and 16GT/s x1. These
configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different RPMh votes which cannot be represented accurately when
sharing a single OPP.

To address this, introduce an `opp-level` to indicate the PCIe data
rate and uniquely differentiate OPP entries even when the frequency
is the same.

Although this platform does not currently suffer from this issue, the
change is introduced to support unification across platforms.

Append the opp level to name of the opp node to indicate both frequency
and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 79 ++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7724dba75db79a9e66a2c61e1ea3607bacfdf5bb..9e726f848d3ac1aa6769c5c5e336f53ce7df9046 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2027,39 +2027,52 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie0_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 */
-				opp-16000000 {
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2194,46 +2207,68 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* 16 GT/s x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
+				/* 16 GT/s x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


