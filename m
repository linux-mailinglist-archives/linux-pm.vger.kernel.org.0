Return-Path: <linux-pm+bounces-36117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55BBDC853
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211AF4FAADC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA562FFDFA;
	Wed, 15 Oct 2025 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKTU5L9p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FB2FBE1C
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503193; cv=none; b=edKWinD2DFkis9kUhluDN62QcRTuxJjJTBOsqS9uqVzXd8B2c5evDAEvC1ypq5dNCiQ7FJweOgsy7rznFvrbrMdW5hUnYRjP20mrvy72TjKTM9wSGcI4ne6wQbMb6+1gZokCzFZWpJK2s7rmjhT2RncE0F4FrEn8pZpsGk9p408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503193; c=relaxed/simple;
	bh=SF0ZX2cFxEwhDHiUYZmJsI1YTJ7iLEFuK/SHB+KhRCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dN+Rc9XwcAWf4B+A1N4L0dKHDqFBGbK9fuHQVCrpqjYPkWqyuFKVWnhK31ouAJmMqbeVa+9q0G6nqd5Nr5/1y8P0sLyHqOxrnLyRwotslh6XflPqKP1ohMU49h212qtClME0B3pgKLJsOfTIRIwGA/OkEN6kSP/J0ERBUdFZ+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKTU5L9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sJtS003643
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aIrqaoEgpUjH1gWqJbIHE0oWUKMM91MGVrTsMI//tac=; b=mKTU5L9pgpRzJhxe
	+Hew/+th7SmqB1lfHooMNMFvfhlMEd4BATgkfq36yxsuYzk9OtYH/f3c42kWkzRe
	rzim5UMj4qJL4ICHa22zaWxC2WGWk11iIBbrf5C+tHaNqhY9j54xBDFBi7yeK8rJ
	dPNlewCwdNeyHuv6eauzbBRTUf44kmZgihLeqtIS6cyMx9Vd8DLscKWXgzM2+58e
	DiDVjc3W2W1Dw2N+N3dhzVz+TQLmIr8A1rP9y5DcUb2yrO5MMvmyI2hnxWlnsa2O
	d6iR+gRcoInN1By7tGTMpH2D9YRa50oENZRhLKq2eufxbZU8lxNHkZ7tq8YOYM7S
	+9+MFw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd934bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso22959728a91.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503190; x=1761107990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIrqaoEgpUjH1gWqJbIHE0oWUKMM91MGVrTsMI//tac=;
        b=Is4armafcKJAXXesh2nV/NmHDnVIYsgKgZ0U/cKnv+GAQ4HC2hpruDO+OGPVj5U6gu
         I9BZ6jyyOyRnET6sJeSCkl0nYLnWBVsf5FWbanuEtfw/H0axAVoNVOjRb6hnj7f13Tr7
         0GVF0H0Iyzcf87qftubVl+Gzuc5uAKumkZBH3KxkiyU7htMmC1KvqoRihImSmM+Y5YCn
         p9Ubaslljx/U7VMsxXstxxsrmbAejYNguKtCCiWTdYKsB4pXaY9zFHOuOrJNBvMRAw36
         mXrnfsUzolRnkUUsJVs2G9EIDwzSPyEGsz4QmUKZDF5rXOqt+qECedSyEb8LOA3D8HpU
         kd5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+svZXOqvoDwT64DWvInDO8KL3rssSkB7xKaT6uAIBjdlEGDl1lqG6MGKWjMoAhFqu7Nm6dVaaTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysJCwP/bayjCi1JB0qqXKoLeL3kC9xn1jIh3O5Lr7EIDdcN2as
	6sVX5fa4y4ATAkRJyytBnp3qJFYtZdilZzJTnAEcoKaRBzcMoi0JcNa0+P1cZe543mwLcZY/4+Y
	DfGDpteDRqnF4ixBPMxi2xxaI2FkfxjpmO7X5SsHwfLlbBn1FHz7zpNlh0z319Q==
X-Gm-Gg: ASbGncuSpUXnCjQBDxhplrdLfP/ZYZOyIRaB5NTiLxPFvd6OaaAwoiEjQ/6CD4S3ofE
	V+e6PPXcnlRNlUCwRKhbxw7jhD4TvmA9BFWAOiac4eDrnfpl2vDlzCpfppMKMVFRz2W3WFwvbNn
	s/gUtT7IeNoF4Xbg61cGvj282NWsbA0uPtlsZ3NuJ0s1/ji5Op+UI7urlMY7LQbkrgDHopATs54
	9I8O+T1KCXs43SwhXGvCX5jm2Xgnt6oIj7oB7N1KTtPuT+2dJRisvLbxTrCvIq2+zYMhXIUsxc+
	0r32GZFSHNxueJJGki9xWfeHWhdTEH0WOO7qpaUuqAlN5q03Ou32XUuLWPiz9vfqZykLmHe7Mm3
	o
X-Received: by 2002:a17:90b:4d08:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33b513ced41mr35775297a91.31.1760503190386;
        Tue, 14 Oct 2025 21:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIBdMWJbuvqOxHpsoJ2SXPuntZq046aG+M0v++nDpNVZ+bCmPJYBX3N9RPRNo9pLI7vYF4g==
X-Received: by 2002:a17:90b:4d08:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33b513ced41mr35775260a91.31.1760503189905;
        Tue, 14 Oct 2025 21:39:49 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:49 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:23 +0530
Subject: [PATCH v16 08/14] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-8-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=CXhzYLss6B84Tshec6CrBMIL7abCTu6KdaOnK+fDvoE=;
 b=e/n+X2V5Goy+lb5dOox9u//usFNX2UoiNBTuRW5PuKfbENSKiL3PsZTGWMHHawy/fOhX9mK3v
 xqtcZS1WfdSCVMHq3PDL9w+vAsdRovHMMHuZtGTssOxkDmn2YtVFCmB
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: VznPrSV4hjIv8gv9vFHUjFxWxnBz7E5x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyo0jGtkPzj8N
 zZIhPVExuouGBXvQLboIwi13HtMjxfXJfSum/Nnqp2HCwzavmuRhhvgYEnxJfmXUKoOnwLppozs
 qJS6WBdNI3PoHKMOh3qGfgzPy7zS6KFbqdVrAR1qMZ/w/EiMJCtu9YfAvpyWyAtTbNjS/ERmC8U
 atWghaeeUhwxdAusB0OdTe9igV3lTQ5SefHGIabxK4p7hyabQfSlafsAS8Od8JuYgbW86MQOw9Q
 gKsyiIFFq1Z3t/Z0jZnyvWu0nAONvhrErWjJIC5SsWyqkY0QK8OSc8glXTdYu7X7XUbyuDMXdut
 bqiao05tK3imyatdvrpzRu66r955Gq4gFYaZ6b1SzrS1WcWmWRlqrZ/tDklqR9drF/ROhu6palM
 kQpgmPNnWMNtRREXbSjxd10udyWXaA==
X-Proofpoint-GUID: VznPrSV4hjIv8gv9vFHUjFxWxnBz7E5x
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ef2597 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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
index 73fce639370cd356687f14a3091848b8f422e36c..84322b74917f3a70adce5a4182adfa5d787ab11c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -695,6 +695,13 @@ &pon_resin {
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
index 4b04dea57ec8cc652e37f1d93c410404adaadd5d..211c2f223a03c63a79ddc736c18a5b79faec56a4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -858,7 +858,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


