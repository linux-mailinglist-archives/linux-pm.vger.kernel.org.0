Return-Path: <linux-pm+bounces-35167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC9B917AD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D895C421F1B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311330F538;
	Mon, 22 Sep 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbgjbRoI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C430F7FD
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548558; cv=none; b=jJnAsEcFll0fJ6E3zy7PwtgcyAtac+TSKlKxLQZPiVd+uytyK8jCoFudxoahMrWOz6R/ZObsfBXTIa4XgPfEJMS1z7jnFH+u7vr9plYe7Lg3+aKLQ2xBgAYta8zJbRrKSXNJ8IDB1X9tGPmVOthmLqN+3VGNyDqe3IU7dTk7TFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548558; c=relaxed/simple;
	bh=wHkUdDS5bnjeIQ7bWY0wwHjrewyVMryPfMFT2XspY7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQ6gMTSO7ffpqJvp2fOtO4ZskeCop1dpqS9nCL3XWN54rlo9x9UuumUhK7KDTVXmE0HtdOJkMooyQqFkCGDxPQ99epLNbnIJ1cA+MGAtQLQDp1mg4RFqMmoeoOslXl9yrv1M2OylUmrg382yLm+SSKZjjfiobPqlrFsHGXM43gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbgjbRoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8w3PU031200
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FYXv947f4qPhFNPoWzY/DvCzODELrD0LuRjCAh5+0k=; b=YbgjbRoIqEyI/mOL
	GKrXdXBOINtnbNJ7xeXsPg3gIBkGvUlHOisSX/O5d6fp7ZePBEsDCsOIw4iG6cFC
	ZbDHhf8QHmqPhbY0H0xetHBF5czMShLIZX3vG8r42vYjC2obgE9Ta71+vXZ0d87E
	wQHb2rbW+1am0fDiVH8tVJ8h76ljLtnYnZPNnXsH529fpgqRK8M612u8xIaYjiuh
	6ujhciW4MFKFxhbj36H6t8xPLB6wCkrya9a+NIW6DYCPsFssiThER/ySCXrFFJ9T
	FIxh8WVhcxJCUpQF1CuCZVVyeOeL0C2PhBzVSbD8abjTq94aJGJqZ5Re0Q86++7k
	I3Q2wA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cwt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:42:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so3401750a12.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548554; x=1759153354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FYXv947f4qPhFNPoWzY/DvCzODELrD0LuRjCAh5+0k=;
        b=ZJc2lo0WbyKfvse5E3HB3n5u90E25Ehmd9ie979AFktmeDksNBF/VOpmLfgUuhY+GE
         7uR3jiN6VgLvTW8GUUq1A4iuInIQO7DWNEfTE/wQKmCThnFlLpzqIdUZu20owADIjQjN
         JKd2Ix2Gvg6yHBmjsUlIswJCWhI6bUhxIZKwzedr71HGRaSiEaW5T5jkYFntrifL++AO
         EOgGZix2duih+HGo65bEm1MB98f7ezMZ7g0QpnWWNCM2p2/5b2EieYE5P2iqRN8bFudS
         TxM5pmLM+AitDYPZ4Q7HRlbJPfZDa8h02gKcBeIp0bbmFFuFKtpxjM0N762FEcSnAc0Q
         5CLA==
X-Forwarded-Encrypted: i=1; AJvYcCVGSlmMywU+6ZeYWCSrGcfzkj3kL/N0MVycs/k3TV3GZGO+dmSt+gDAcDpIf6JMZWXrAbUdqbDGpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XxvVbAfNf0a7fSqmnXS64pEbM58hm5Zsw9lXNV2s6YPqLXjc
	O5yfCapY+/T/Sm8a1jZ7zaKK6/zuxRURwt/PjtP54ZgSm459tnZZ2gMf/JhMcBN1qgL/hNArA/6
	eI/7e6kUTf92dR+Q00EKBf3ga7r08DKgVixA5SOEZJo1Q4NPP9kwJCv9B1mX8Mw==
X-Gm-Gg: ASbGnctnfQVYBqzlWW4dbPS7M6GFmp67/wucb72RJnoCCxVarnvBCPB3nGTJCFJuESB
	y7pfqDFPOgwBZ+rt8Z6lIng5J8qgWLuRAmwjloah/D1Ef4xVa+CnQlPVYhRwC5VcbfPXrWz1O8s
	lgjYs6PxkrmAE3GEs9H5lFxYWwy5qSLgTuxkMflOrAgxf0KP98KaRNVn+yKuduXFxalzHW+s7+Y
	CngNNLQzYOquiEf5Uq5FYqMQ8gzs+OcOrnFdLWOmqJMhJt9nUH8B/eft7dpbA5ApHSk8u+U+qf1
	Mj4mQS5YQYnDGzDbq9w9ebIEC1kCUMXygJumDCmyKtj2gTv9TZvcuujjbOYS+3rAjGPM22J1OR2
	K
X-Received: by 2002:a17:902:74cc:b0:265:62b6:c51a with SMTP id d9443c01a7336-2697d795331mr139723155ad.23.1758548553879;
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETbdwlhVXEjM7yM22/JEEvIiUoy202zLd+b4eWbRtUU2DHlwKHc8Op5CjIiXXHqrVv39UJmQ==
X-Received: by 2002:a17:902:74cc:b0:265:62b6:c51a with SMTP id d9443c01a7336-2697d795331mr139723005ad.23.1758548553434;
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:42:33 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:22 +0530
Subject: [PATCH v15 12/14] arm64: dts: qcom: qcs8300-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-12-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=1518;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wHkUdDS5bnjeIQ7bWY0wwHjrewyVMryPfMFT2XspY7w=;
 b=TCxpE50gt1pXJWJLnvp2Xo5vGtRfCb5g6AIRIIKP0dcKGqc/CJoCvd8l4Qh1JixBDFnugZCHt
 zRlWDkiodHmCXFvnxFbQqcB6EyEzV5K9RPrJ6BsZ68yVSoue50/SEZK
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX5KZO9Ufz6Ire
 uXmxJdqRNxzhwRr/nBWXv6xbuzjH4SSHhPbKOnQN6EnjdXL23MU5AAVf7/4xeUCJwAeoRfqqa0C
 oe76GevoCs2d9v/awHH9Nx+LuqZWG1E+52vMOcWn/mlrXFDB6mXFs6HTLmaddhOG7TOptwEgAhr
 FRfuHUom5S0HWsHF0bDi7PouOzn45qqDecwjhbKZRvMUJFwoKpM0GzcdWqNL/2/YzpX0DcEjv/p
 CPX1K/KpQKNDhdUeQSEcJrJQuRxceZDQaoQWIGTPhwCXrJU15rPFDdkgflKuuC1COTxcslTgp5w
 HeCxosTbs0t36TxIV62vMXhRuAAI3LK1fzKTjdwhejNIxKnkxC1LaM3OKIdag6VHRU1rVz89n5g
 Nctza9wX
X-Proofpoint-GUID: zoD8Bz2ffdXDD0ZBwT6HmuNGM-KLt_82
X-Proofpoint-ORIG-GUID: zoD8Bz2ffdXDD0ZBwT6HmuNGM-KLt_82
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d1524b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tC4jzodRyx6YAeo6W6AA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs8300-ride as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index f8ed510477cf2d23c6bd1bb042abe46b45ad35e4..dc36296d2c1ac7731d9e741099a2cc0115f584f0 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -309,6 +309,13 @@ &iris {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index d35bfece60d1afa5205d71c3b1b621dce49c805e..7d256c2f9a9a430d076000ddf22f8a56f074071e 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -663,7 +663,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


