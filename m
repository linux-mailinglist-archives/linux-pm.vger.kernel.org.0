Return-Path: <linux-pm+bounces-36120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E339BDC86E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4EF55004B8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E93002A3;
	Wed, 15 Oct 2025 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JBW3ymbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5E2FF666
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503221; cv=none; b=WDrBAxoQ0TX4XpTtV/RUXpZ7RWktdClWJ0Bd7C7TMZWV1aCBusrgb7cxKjMUg8usq70iQOv0+Q04kbjCid0IJlkhGtehm5s5oW+AaOzBifKlE3CekmZpcIdXnZPSNmQXvxz25hcTED1v0NQJrxmxC5oB3tClqX/cjrRWvKeE/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503221; c=relaxed/simple;
	bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBwftxEZ94warw3Q0hM8zIu2cCcj169tRBJ1Qll7glq2YGERNdiH8O3iYq6ux/i/toYjFfAskEObrlaqs0gBzZx9SSgOcOZbxL2nveEmPw4PCJ108C4mMcCvrju7qymxPnQFPfzTS2F+/BHx4xJV1nvPMk0i43EJ2CHa2O3otH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JBW3ymbR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sFxA004964
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=; b=JBW3ymbRgEgRQwk4
	9rv7Ah2KbwTKe8OLqPy27Cp0xo0puRSYiInyXzZRHgaQXIwUp4kZuFgOmmXSNQDv
	fgrdEYUug1DjCytm+MVRhv7IRAOgU80iQqLoc3MBz1hXUAKWjUJMJyjhhUgL7oXa
	d/4s0t87gs0lKiXZoEDXfcpBOSiAhcEaiUII15KRlE24WuqqiDlvUevOOZ/KToVn
	/p7HV9w9OjURqZxkSF6D3F+E+6s9ciJeoxgBAbe9zfd9vdx1WH1Kv5vaw8mYjIhk
	HHEecjNtC4zd08X0okkke8BMqS2xNBo7hqW/+9732xCMhSjptXSiyh31LKY2waQv
	PWBZfg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1afbq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62cdd71290so382950a12.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503218; x=1761108018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaEbjaznfRKEBXAo6DFolWZjwipbscJpuOwEOXljFb8=;
        b=dcqX8BFVVMfwl5ipaS3xlWdeFL09dRk3sY2W/W2FTXXx17SwZdU2fthzEZa76A5OKW
         VELDrHAtsC+fSqkzwFrN7ZaGYBk/Lpw6CSyfwZD84F6zavJ75UVO2gt+0lB3X2hf0Xkz
         kurzKETtfM0nw61yZv4MuB1L3Lz3tPKtf8RrQSQr9XWqOnPsQ/+gk/QjYl3OojJiRPwP
         H7DV4zDa34dxmTIqiJ8xwJBSduOp1PVcoGfZAZpUeiUXQ9k2oSVx0FpfvwGyouKUMTKL
         ILQH98lHq/pI4GlAmmtCx6xBDeKx8qXXCRf7rHdVM+Lt+qe2xQvz4k3KOw03kDasp1Pw
         fkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrXygk8q+PHsK8WkUIYBRYaKtyX9zBKsN/T3Q+97qiSF5gxy3y327AIOWpcwaG9uRg5QQzCVncDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUfz5YZifGAc0IpTofER+TsSUxOzKBNqbxyuS1hGr5XgzOGOw
	KXa4a6wd+M+EYroAWngHmC7OpatFWwaNNfLwrt0NdfqfvioSUcJiJdZEMKo6Rnj91gvo3fJ7VGi
	3FRd4sxyqTO15geyJfFcMYhzRzSBcbwsJc0RlUXeE13PpSFUA6fcHemYM1QJcyA==
X-Gm-Gg: ASbGncvuvd8zXuKfT8meF9ZDc2HA0Uv8hDRxaqz0ICIptcFh1/sAZsK2fPqT2Nn00XT
	nGL9dEPdKpVFl1NoqtHhzseI4YAXTtFma856n0ldHPAML9uIDyflj9DNplzRb/h1OInm46gZ5I9
	MKM0pnjUY1NsIMW1n+bz14kp87WjKRchGzSGHYMXql2RMrb2KmW55NS4hWZYxGQ/XfYfBaKmeDy
	lzbk/WlkGgsN+IQbHBWHlFu7H1pGHRHca/UzZY8d1rk0MoxnsJajnYJumuhYKNGYyuZPaXpzhMl
	lL+1M3XQyWGJxT/SDwhCuyB46myTct9qgBr2i7+qa+LY/Stm/sfW+wgCCcP9jq8JP5PZxHQ3PU4
	I
X-Received: by 2002:a05:6a21:33a8:b0:327:957:f915 with SMTP id adf61e73a8af0-32da8fcd0a3mr34162524637.24.1760503218194;
        Tue, 14 Oct 2025 21:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvW707uWwbvXiG8keTQAlZReMI+HRsSwGyMxnWPsRVW43EYNt0vrSlWIfI3lMvZSsHDMDGw==
X-Received: by 2002:a05:6a21:33a8:b0:327:957:f915 with SMTP id adf61e73a8af0-32da8fcd0a3mr34162469637.24.1760503217682;
        Tue, 14 Oct 2025 21:40:17 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:17 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:26 +0530
Subject: [PATCH v16 11/14] arm64: dts: qcom: lemans-evk: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-11-b98aedaa23ee@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=994;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1jBpq+iZuKpAQm2NP3JS82veq+AIv0X5C7ExNAj56cU=;
 b=lQ4o1jBsBU47/mjmjh1XOZfhtlXeUXvjB+DysCkst3CeU5k7XwEFoJFmc2egI0sxXbtLJW/nZ
 PsyQu7Lt+Y3BbUreCtFgJMXmjQg5IohsDBovTYY2Fnxpf8sWNtEl+X8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ef25b3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JGo1Z14By4IpQyqbhUIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: gb5n7EnvfPd08RTG8M_Urc6Hg7zqeS1I
X-Proofpoint-ORIG-GUID: gb5n7EnvfPd08RTG8M_Urc6Hg7zqeS1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX/HUm4eg2YHjt
 V1aHqEHYLYLtk6dhu3agIsnR0XIpeBwBqoOV0F3J157q/e0TjqTYuC775k+z+tbCPMvdvnvangh
 PnBiEfc/Dnc7PhtK02eVT/ZF2x5Y11y7RTaShLI4H4oQFitDa0Y76GpKnUlCqnSXXnZWO5FldYq
 9FnALhxbYm08ZEN7+jbpZ6wXVNR2jElTiTC8tcVhYKZlPTjfse/WKP48GU7IdKZ9E11esp+wibG
 Zz35Femb6VQkiQlsioUTiRqCc5KkARL9JaPPqtzzwvjsFizn7d7/8t0YiS3fUVrdnKvIenfDWCY
 11F3n6rWs5r2TvQhZ/KXTPNWSNRLyyrBneLPjYuYSegDC5YKC1AYe6sZJcj/qeVn4npqCE7hPD1
 wm0bvgTl7O9hOxOt1sZccAXD5OsAYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

Add support for SYSTEM_RESET2 vendor-specific resets in
lemans-evk as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f445787a87ba4869bb426f70f14c1dc9f..09460441888a7011ff613c4fe9fa4b6872e12172 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -587,6 +587,13 @@ &pcie1_phy {
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

-- 
2.34.1


