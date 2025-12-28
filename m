Return-Path: <linux-pm+bounces-39992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4CCE5424
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4028F3015581
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583122A4D6;
	Sun, 28 Dec 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzoJRjUL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIZlcZxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089A22D4DC
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942493; cv=none; b=hSmC1VgChYFxOBAwQyuljL3JKWfZMXfQPqGyCa1ulzgc/MNct5+rsuW+5VuiVFCosJs0juSeTx0+a4gMBZKeDg3ZfeKs8V8+9OkIov029xaUBLbMsq2JqXmZlLdulMe0NSVpXOU1HaTnr+tdeopGG/u+7dKNkFb8GhTBl4DqP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942493; c=relaxed/simple;
	bh=Uo7klXz4CKVLIAFhyMsmgHyzo6vZoHcxyIjPIsWKeLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRQMJdVNNoi4NLL+mFAgTusbofHuJl3g2F/hA/QIFNLhiVTlYp58/3LPCPwBCH7O5ZKn07HoTMVwWSeBjPDetmS933PkPC9bTGfe125usbLScRbvOxzK3U+4nlrIConO0k0lBE8s4p9jNSBmPzKRlHnlQJwFtQQ+xej+KICKz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzoJRjUL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CIZlcZxe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS4pQwR1940873
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ppJ9L8xk1apLAmwIJtT0Qc7Ciy7FBPgdY26Q+dCWm5A=; b=EzoJRjUL8QD7E1Ae
	HKl2pINuG45uoRMGUNlAD/al3FkjgqxLl/ps3pgvOW6E+dusZO9NvAQT7Fy9nteh
	4nQayV9pkeBHCjzIZVQpsywW4KEIllG5mAyWystic3c3F756tV1FQD/dr6uB7YQ1
	t1NZAUURUOYgsChzdx6ByGKbigmuQN0j5xjsWc5fOJiRL7zNbTzYIFhWCauUwIab
	iMOixZTTd1TwkXocvpypOX+d5wGjKkKD+v4L8ROpY0OyNGUPpTuai8mjAAUMu7pU
	RZhvCG8l3TLtLleQ5GtD4utdZV1JUuaf7pX2YDW3DrnTQv3uRFbEEUPUSBZVt9oC
	pkN6cA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba87btft2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso126275945ad.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942487; x=1767547287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppJ9L8xk1apLAmwIJtT0Qc7Ciy7FBPgdY26Q+dCWm5A=;
        b=CIZlcZxe7D3AvHVYlUJiNZiKnxi22zaL0ubmiWyF7I+bXNYrJVLzDozGuT5Hd/+5PK
         zcZZ+wUizoJyMBuPPMZIM+LLi5puhg5x/uECcVP4QBFogyK4cd9AJloJdFsHHASRl8If
         /vYhTjVgR2Rz98gOqpywRqpp1c0SnJ61qut/k9WRa6ooIFHXNKLVCmrmEm66K2go5H9d
         9W98LPLjmth0aAkm5yrDnbMmlbhmVGCMQFV4Ow4Pkr0ggbrMfOjesd+91l38rovQrs+V
         9p9ktgCdPtimxrx8qm6Kb0CINNMQU6egc891tx/DqVOOppAW+E1Agqec6/pt2w3MDt9F
         E+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942487; x=1767547287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ppJ9L8xk1apLAmwIJtT0Qc7Ciy7FBPgdY26Q+dCWm5A=;
        b=OxAYW4ldVpmoBeexLSYlYeb/tEjaFVOhdQ6Q6MqCHySrQ+/yTrZQkM98PQB5vnktvE
         x2eP5/gqY/Dvuq+L5P/A9NByS51dMRVbPwVOeedg54Ij5nX4jb2N0weY+tx7VEd5uyMS
         GGEQGxnmmjc4kG7uxy0kPO9SE+YV1Zq1LxTFtBbySXBL/jKo8oX8guHVp0OIAfLaGbeO
         WIP2yGBY/4lP1iwfGsRRC46nr7QrEu0fXqM61AULgW2ZR2RUYvDNqsKvX/qY7J4q5BDh
         91VFIRMXH2RB6uipPcfAVbvdL1oFcscxNtjNC4UjIdxgeY4WVVXGYnkhQ77IKPof9MaZ
         5NZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJlUw1574OPbAnYYv18P7qzAXzm9pjdqS3gauwUwWBf3eangq4HtT920M7FW0p01/7IFkx/HM+HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wNbiDPvhehXheOz+lA4iQPtCdlbLvrCALnfWph9RTvPGOyLU
	c0sRUI5cGCdtZUuQWrxDBNPdooAto8H6QCGIDMLc/20k3yoC3ICy9EqXxig/RIan12sbw6R8TeP
	5gexIxZdtFhdoyUle6WSgQskY57UjIyPp2vG19GFfPf8txq+d+H1KiNdVZzcr/Q==
X-Gm-Gg: AY/fxX6SRJX+kWIvCHeM5bzJI4H3V/OEPt8MvqKSduFeXQT8JC9B8XzgeG5fxunlCKl
	ZgVdvq8JU9IlsiJjtHEcIAsM4HmbxTO/BTt5nZmcHeBB0CmZoRzp+Tn7Ydj4HeMHscY2GOOWdpS
	m8BvInbRN9xaR7nvhxKjJdf/NodnRWAJxhOogcpkiQdBzsV72r/Wr5ggB6GzWqdL0DeTW/m/4nP
	3TYbU8m2P1X2v68E78C3H2leAi+EUfX2HvtADIIhA5JOQyPCqafiqJdwIrFG7qugtywVkH+290p
	bHtnLN6oLogou6+cGE3aP4vOdYT5IgFieYRCoURFivC6BPv7/RQZl995fK5cV3oIq9tiVoXCIt9
	Vzg2Lb3AR8ej+opMgUJhfBs8pxR6FtUM8FYiVJOlScp+b6g==
X-Received: by 2002:a17:902:f60e:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a2f2a3b006mr265902205ad.55.1766942487125;
        Sun, 28 Dec 2025 09:21:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJSx0CMlPpO1gbVee/NasF0jklirO9YTG+DoM9fRKyeRuAQjt6WQfhSmoqGrvLFTbitc7NEQ==
X-Received: by 2002:a17:902:f60e:b0:29f:cb81:8bd1 with SMTP id d9443c01a7336-2a2f2a3b006mr265901855ad.55.1766942486618;
        Sun, 28 Dec 2025 09:21:26 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:26 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:25 +0530
Subject: [PATCH v19 07/10] arm64: dts: qcom: qcm6490: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-7-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=2238;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Uo7klXz4CKVLIAFhyMsmgHyzo6vZoHcxyIjPIsWKeLY=;
 b=zjun3NJ8FbNcNuWN/6W2esPCepQblwL/KYhsLnapaNMIgfPaJlJOlH3y48HuSQBk1iYvQhDM+
 ar18UWmDTO+AJOzp1Ozc76c7Cd1XOxCe0UtGpGJnqzOhsYWwxlYo5Y3
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 4AUgpdGZMSxSrqKU-408RJsvI9KnvZu0
X-Proofpoint-GUID: 4AUgpdGZMSxSrqKU-408RJsvI9KnvZu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OCBTYWx0ZWRfX6ONAPkx6TkRs
 UrkUc3WAxQyFPkpmjnkIfTE5hukJO+l0bDATyVp6JqTcg5CN64hTX4Bb6FNx/TDrkmYnRR7P0U6
 pjda3ys7GMxFRTAgba85wxVEI67b0jiVaIc7l806gY0xcT3unMVRYhz2bJV7S5OSECWX8mthZE5
 cQ9nHTBjYEWbLkDfVBuHMe2x3OsT7SVqDiQ7G3DJ9WmCz+5NR/B0c3jCgA/PYnle2fKG8QQ118A
 zk8WWjvk6a84JXT2z/H309cj9p18BIu12xm+eRXuLvpJ2xzNXN5KDF7kW4wuJf3qlf0MWuB2vAm
 wt90L/SA2dQlSTOzXCxQ3GzgQzV5erIH8sOZxcsMKMtYn2XieJ6JWskk900SHc4Mt2FcTtLkqIP
 hjM/acqhNW1OiazmwAHlDRFCgq9KWYhExJ/48P6iOCMhlBEWklz82lAVzkhhu0mWW+equUxU9tq
 /PHmFpZuwnpsL+OhW+w==
X-Authority-Analysis: v=2.4 cv=do7Wylg4 c=1 sm=1 tr=0 ts=69516717 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280158

Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
for use by the psci_reboot_mode driver.
The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent and not available across
all sc7280 based boards.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800cb9927627f991e3d97174cc73c64..e319a1894901cc9c56a89cb8b8ad0acb7a18dc99 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -858,7 +858,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 089a027c57d5caed103f41f20c01fe1294b4c950..5816cc1c033c396f49fddbbcd4b09e5a633bc804 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -695,6 +695,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index f29a352b0288e9ef554ecfff59820ba39bf2cdb1..6e836e476d595b7e1b69a0859cf2f697c529cbfa 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -935,6 +935,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


