Return-Path: <linux-pm+bounces-32444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA75B28209
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E415C5787
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D8279DA4;
	Fri, 15 Aug 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9Zqoocq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899B23D7EF
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268656; cv=none; b=CSwUbdtSQR/u6GK9nHK53eDWft1uLSKHyIcnSH98N66hIhbBBOLmcSI0hEhjfWjkxaVL24WkqW3r1ee/7qjYEslEAK3bsx7aWvdypBj5N++8YJB7TGskHHMrNl9zORhWCitGLKWa6ez5cySNWIKggl7idR7dQSBQS+9k6JGUrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268656; c=relaxed/simple;
	bh=cDK0uRnpMgSKSIzk24D2d7W3Iv7lYhf3EwNLLYWok5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBFoWPdh157zoBm1G71pIZwsrERDhLnKegj6yi2iLTZ7xY3gABgW6gftpVNKRmfOO3nhHhLwlk2Eu1C4bUu+WOed4zdCPFXb2NDkZxIoW4os6Ls963pc8SCQrt3p1qJhZmC8giPsvLp9JPChGmnYAfECpOZhnAVo+4Dog6KyrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9Zqoocq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJ6YK008761
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZI1ulbnp33sSmZzOl/WukD84JC7rm/wreXUDUVjjRA=; b=H9ZqoocqVzOu22rQ
	KmYlkKXCct4rsXUqtMwuL99d67dAemPz3Z4ECLC+DfY1v4FUHx5W1dplPUt4mS3B
	k75VEJqDi7n8KsFPDfJuTBQEXS0IcDQeXwRPZYKmp5n6ZhXSKK0GJiXn4aFJnKzI
	tveMC5u+gh9HdfHrJPWADiDLcMMfrztP11sMbhkKm3OzoBCQQeIrvbzBqqRyc+Cp
	9rY+wQPz5YNHJ4Z3K5tLalxqQEb42qrTPOCGZzhQQAWQtionjqMaxQ3GtzTXBROR
	V7HDgtcgAelaQf9acbhrZx3IQ84kN0avR0bIUAqX9utq8ADIK27dP1qLambGa8Bi
	dfoiPg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6y6be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174c65b0so3324050a12.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 07:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268653; x=1755873453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZI1ulbnp33sSmZzOl/WukD84JC7rm/wreXUDUVjjRA=;
        b=KfxLMki7pj3IQzk9DhFg3wgM5RW+q3SLInqApVlMdLrdwg1DGSwhab38VyWoy7D4m3
         45trE5fm3DSnDl07dihjg08H4o/AeFWnN165fT/4Sg9HQTX+M5Akd7V4qghfyL2YwcFF
         GMurEHzOSD8e2mlYATnoOTiLnDvV8/zumOTOlAXk4BIPJZN+NEj9OcqZFmJj6wYRNC2O
         abxlEMW3IULbllsXwrbZvthwIjS5M1EXG4W/wCAUY0SQLMmNFW2nF5SIoKuiJ6pnUBwT
         mUCiG0CZdod1O0YlieQEtY+08DkszyHb8V+9ODtomjs1D75TrberhM2jmDow3BQutPmG
         a6PA==
X-Forwarded-Encrypted: i=1; AJvYcCVfAGjsKLDkyV749ckSU/7fTEAgGF347UJhXlOPMgh2fFk/q7Z8i/Ouc82zGh0MqqY6cocK+ddmcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6XCl9aIpdw1JVM6L5I4cVQ8YAAto3TuwIgqBGP7Jw0frTh6n
	GQiJOr5HRw28L4Km+jiBSzakZmMPaaUfI8/eq/f4ltDi+sIbtJ4RRSLqJrD9nsZQrKbgN26LmwI
	KRWhisgadUasomzcna45YmkVxsu3ZaWzpdk+P/cW/gYjl+FymZwrQwBK18Wz63g==
X-Gm-Gg: ASbGncs1+mDok5AMMUe3zZJ4zTYj8si8VzsUBew6ZeF81pCMYwE/wDJ9F6DCjt3PEWS
	tDyQ0NkU9/VZRh67jX4TWEFih8BUWq99vS3MRIc2ECi9ITcwBIwHbDNmOjRj57w4T1t8/N4Y5Ac
	7Gpq5T6GIzk7X2jQ8nni2uRmswLJ0mrFWp8r0zgrPVw9B3PhoCtXowEdQy0MV037Z1qPzQU5BFT
	pRTwD8LEb90YrqTPRUf+cXvEGlOw77yAkjp0dqwwUIos/Of5OXsFcPf2uKUuPqegofvojcuAoLZ
	5rxyp8XZnySfIZUcLq16mcS+mSp1v15igyJpL0EKYu+75Vo9f6d8rGR1Fpp0S7PRlDYr1162KFI
	m
X-Received: by 2002:a05:6a21:3393:b0:240:1c56:6495 with SMTP id adf61e73a8af0-240d2da1ab2mr3983845637.14.1755268653294;
        Fri, 15 Aug 2025 07:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGICSeKOM3amu5cDfHsCt6tTSoS71zRuUcFNv7sC0jlLIlPMtqsbosekt2XumDOgR42afsnSg==
X-Received: by 2002:a05:6a21:3393:b0:240:1c56:6495 with SMTP id adf61e73a8af0-240d2da1ab2mr3983814637.14.1755268652889;
        Fri, 15 Aug 2025 07:37:32 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:32 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:13 +0530
Subject: [PATCH v14 08/10] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-8-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Dajt+SLbZYuP9ZjHPqwB/7XOdBkGsUiHd4YnzMvhaQQ=;
 b=MEXYaGDuDuUFhmah2GQbSrJ4wEfwuNgDwr1BX5PcCzsPjhFaX/Ovj9lBCsR/tOhqe0QLmR7rY
 mE1K9DazWzSC7lUWsHUgB371f3yxxZgg08tvl3sOq0dw32CLkCKQbcp
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXzKf2OC3alLg5
 EtkWUHjIxbvGO+bVMv3bKY+zZvlGW8kNpnyq5JbJpRLfzx2N6TJcD3Z4TyBWwP2yn9Kc0HIk+j9
 VFJqTCaSqibphXgBxlyPCrAsjArh5BVcTXrYpTfcgMMbeT8oIJRDX5h821M7EcqbwnG+z9JWf5O
 eVxAbDzsFeiGkrCXAB1QOTPF6dV/vvrDvh+nDnxH/tzj0wbAauqHf6IGZh/+38ESTWT3pWhv+1Q
 5TMuZnc2i/NopJxfPhfnuO4CXH3OsSOSpKIJane4SlQaLprlO0KmUPdFMHtgkeSJvhjuhaEt1r0
 kPo0392++JYXyqFau4TX9mge894T/p8NFqPrMRruXxgkv/znQLlZIFd5Bab50Z+es5ccvMosllU
 cTMKzUIf
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689f462e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cyiPjhkRxR2_pAcaYZzB-Ng_oVo0ZZFW
X-Proofpoint-ORIG-GUID: cyiPjhkRxR2_pAcaYZzB-Ng_oVo0ZZFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcm6490-idp as reboot-modes.  Describe the resets: "bootloader"
will cause device to reboot and stop in the bootloader's fastboot
mode. "edl" will cause device to reboot into "emergency download
mode", which permits loading images via the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 8ed6e28b0c2977b831a1f156014eb9d6f70d0243..51d5991a5c392d2b7afcb5dd7726a01ededc199c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -654,6 +654,13 @@ &pon_resin {
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0dd6a5c91d109c78333f6b90104fa51fcf3bd64c..0db3fab9915b247d3c30d7484625fbd89a3514d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -857,7 +857,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


