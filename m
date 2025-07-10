Return-Path: <linux-pm+bounces-30550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BDAFFDD9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB8618902C3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF229AB0F;
	Thu, 10 Jul 2025 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmIfAR97"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4A293B55
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139079; cv=none; b=C3wPp7rxFU36EU6Au8Vu92ZgNXYo+xtVSfBWo4SK9qm2Vi+hnckoUJgMJxCA6bhtQIc4adjCq8M7hlvkgqIUtFCejGRuDuQJkbGMwroKhlzeMktvuCIQivhhU8q4xT6fYwElFlUMqDB13nEjmLLZo4Z72qNdzZGDjYJ9l6pYgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139079; c=relaxed/simple;
	bh=SPFjUorJ1LNNt6IjkgTIiv1ZSNVUKKr2QMBxhxlfSyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQElm5h+AROezctpId1WVo/o9N4xXDLq1/Cxsm95PWmukHgwf92ohIg/AyAwUUm1Rgk4CP/w8HTN21eTqXYbH6GsL+lYzLMQUmm7JMvaD4He+C7oEX5iwZsq4PIAs2waPsusp0UUz1d49LPBGQQb6ssgl1z07z8tz3fEBMTZ50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmIfAR97; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A6HGOh024151
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ty1qg4MgFp/1KipjRpIWVF3P1K5EDIoLCixxlG+pA4=; b=dmIfAR97TkwUQ7Lx
	RnPSqBd6MFiaq/ha9POQEwKOOxDLFMXwItwBfB7t+S8E+OcVlnLQQcYZtKe0ReYA
	OF9pKO366O8724350FYgb4Kwacsi5oJVnpdxufv/kGOeJrQ0mQr74g+8Bm3AaMDb
	DwiWWhHUmMys1IfijrkU/TBXVYpziQl1l3xZj9lfbp9jxbAyP8F1qak3bAR6A8he
	KCkhN/ILC08Rrng235FTL4y0eSAnGWwX49oDBo9y6mPKd8vEXGjodyjzk9RLk0st
	t8P5q33CrixLGGswukojELhulegDKWVgY2P35xajEekZ2nwErH/5Z9g/SdOFFcXi
	k6S9nA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u0k6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so1499536a91.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 02:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139076; x=1752743876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ty1qg4MgFp/1KipjRpIWVF3P1K5EDIoLCixxlG+pA4=;
        b=VcA+FnR491MlrD1H9wXf5RSXKCn9dpNXgq+mOMws5mXGkyvfOJyzJ79tWOalXqCwqi
         yd+6hvPAkIcO2efD6FKfjvJv4khJS/mHxbipk1N0wBQN+jcJHT6Fn1gss+AtjnW3ORon
         nOvzRhGvirjDcIt9eidD1Gc7EaC5sVq98uKFr3reRLg0E/tAx93/m+MVXjJ15zeKS7xK
         luv43qeKK0QJ6cMXhEP453n3Lezcuiu9LqXG8zisYGtHR8syrdOWCu1Ak4TtUlUTZYw8
         d8zaEeG0ekDUZgJwxyR/W6EkmWb8oPoIkBcNIc0NJ4Yy/32jIBreslrdJDW78OxP2bUc
         42hg==
X-Forwarded-Encrypted: i=1; AJvYcCVP7FgiQWUhgQjiPMVooOXDTzUvoiuPQSJaJ511hLr3s4bDvtAt6kbRPSFN76pS/jbXWVS1vdDqOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5E4W+ahXAgAQNo2xmL6ca5eVaiq6d47WGUK5t9IevJPKZgOP
	PUxj6RWDFiz5dU3NkIdSMCE47JhNuhSWXS3PUTI047AriDBbWJ/K6dnIntj3jsUyMr34YIEq3Mg
	f9ON2sffgEpneFV8+zFar3idRFGJlACt2pf9Pf8ZDmgrbPENXfCyiZdNpXm8xcQ==
X-Gm-Gg: ASbGncuSQ2LSFjPoNQmkRukpEoirkBs+jHkW6sdKEUzh95NZRakTHblXhhsUjEH+8rx
	E75vp5PmsYyA+zpZFXLk+VL6jZLUtZgkXhKpfKvdoMhwJkvkWNeu2MQiDS/Ls/Yb3WFzNcY+t7i
	/nDvytVgU3YFS8h7Tg8JP/XhbYjv7wqLLkRJ7Da2Ow2BkH6LVKlJTUVjownoYtXWIRFYHThXuyZ
	6fAGYC4MvyP5lATuuSyS0McMmAkj6i0BPrWqr7ZkIvP/upfOT53DqiQwy2XbjcD/APy9KjljV/E
	VJ4mmdPCB67lDkJgvng5B8lWFDM14xo6y52RBQFJ1ffQOkCZTmeY6w/I+hM=
X-Received: by 2002:a17:902:cf10:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23de47c3198mr27936015ad.4.1752139076506;
        Thu, 10 Jul 2025 02:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ5DuAv4hQzhi6yKoAY4RR5pKmk35nKETW7dTCDtaIHn7ZT+nH76uc5gC9jWo86sxbpSIxlw==
X-Received: by 2002:a17:902:cf10:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23de47c3198mr27935715ad.4.1752139076096;
        Thu, 10 Jul 2025 02:17:56 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:17:55 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:50 +0530
Subject: [PATCH v10 08/10] arm64: dts: qcom: sa8775p-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-8-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=1717;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wgknhYAt4nROUs/wPHMPDduf8A/Qll4soAM+xxnL6qQ=;
 b=3xptDSMJeo3n/kz2bsmlg89oPR2D+s7/G71KUw980yLr9mXAK6CEeli4EB/FEKrVloHBfPGNw
 SkdWoG5CPJdB2Plv4VSr76tB6ulp/v0kXwZhRefVTk3eBv1h3UuMEBA
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: R6aOPWIF0KgjhyEHEQwb1gfqF9pdV66C
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=686f8545 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=agHhT1tg99JF3qhwDn8A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfX4hqheJFsHGCE
 3Neqnw/a7HEosZdKV8AFaxCeHqP4a5UoUVyxDNvTovjOXqaAF5p3xmrkc42fv2UjEJby37TXpJ2
 buuMsb1xip+2mJYFN9W48UsPnj6hjYZ0w/GnCCVCRSC74sM17Cus/MWMY0np3vtP/uYiO+IFseL
 D5+F6frzhmv7ho4X+cZOIjbR9j6cI/51SKXnjNCK+IjfbYG5cP1rZaI2m0ZF4ncdEn0U2gFLEUg
 ufqx1ulqxF74+lMPXl2tSrPIMvewSUyZVBq6CU4qGQX71jfAe3na2X34gRIOjAtGRtLf9S8bnR1
 oaFXKdr+9Kd/vouFTKBuFnDq4ofTiTZxx591EMwBm1sv33ZsxlmYF2WzEO5nyVS2r7Qkyij18jr
 AKMqYBnRldoXxX3hzRXGWGUsc3qES/YkeGUsKbbsDwIRpqa2KE2tcXyUnoJ6jzUP6qPS2p4H
X-Proofpoint-GUID: R6aOPWIF0KgjhyEHEQwb1gfqF9pdV66C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100079

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

sa8775p-ride firmware supports vendor-defined SYSTEM_RESET2 types.
Describe the reset types: "bootloader" will cause device to reboot and
stop in the bootloader's fastboot mode. "edl" will cause device to
reboot into "emergency download mode", which permits loading images via
the Firehose protocol.

Co-developed-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 63b3031cfcc15fe2cce58c0fb7502b19f058b80c..44840c37c2f102e7939f64c8eaaf8a872ba5a140 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -874,6 +874,13 @@ &pmm8654au_3_gpios {
 			  "GNSS_BOOT_MODE";
 };
 
+&psci {
+	reset-types {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index fed34717460f060e6a9dfdd4e29ca4025c401b83..b1f151aff478dc268e3405ef5bdd85e67bc25cf4 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -622,7 +622,7 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


