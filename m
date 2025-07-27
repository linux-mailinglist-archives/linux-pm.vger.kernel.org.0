Return-Path: <linux-pm+bounces-31441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7273B1308F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D101784A6
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797422156C;
	Sun, 27 Jul 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LnRUUNJG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABD2264BF
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633568; cv=none; b=reEiZtwjA/r9ZME2CPwDAo3rp+Odys80EmRD//3edecKtwU9ivlnR7dAseGq3mIrouydgtdizbStl5p+0hXvzg+atOEEVtFvKaovAESr2JJ6kQ3RpvhRBr6Vnw/yBO+XN3lr9/ydlF10HVfgw/TR0urd7wJQakRSnYOrr1iXJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633568; c=relaxed/simple;
	bh=n0wa4AEusSMKTJa2REb6Zm/CPFmojeqETl81QHufxBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxBnyAAY5AT98BEwKFuHQ1mCFIxvtbu3zCLCHiFcNdnK5d9mHu7tL0AMSD/DbHWt2pmyZhPb80CZJwS+u26J5/ruGuOiuoIyG6FOsbfK16w9QlN2Ymmbb29xQTNlhjnTmSZk+SW73CuobHiehSmlvq/Lpn7ym+A/yGSuVUrK890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LnRUUNJG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REoemn010918
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=; b=LnRUUNJGXUIhPCL1
	JnvGQKD2L6Lbi2jzEYnYkIfcAFZkQ8b4XBogLRdUTJgh7+AeZwmfupFsATieWcyC
	+4FLiCJJOrQlECVglxl32h2h3SlMtG2Uye2YMhDwWU0o1wuSQRjkNtPAh7ExSUAg
	huNpNknEJJ7U4FAeNWcO0Wakusb/uHCLl5XpFdKd30lL5V7dscr5baxdyQL2lELq
	N3EmJrem0eFuht6RRvJ/aL6sehCOvK7JECySyPfowe7EHRrbAte+SiVg/W76J5nn
	OYIMhmkUssp+Z6hlJF7czQPJQx7cqwDWurZc5IhV76VQnZxGbk5TPuiBP255VIAf
	IADivg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbktb85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:26:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23824a9bc29so61275025ad.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 09:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633564; x=1754238364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=;
        b=cHkPCA54L+IjS6Ep5Nyl5mPkbXOa/7ii1MB0rRfEa3DlapUyTJHdbtUvV/JMKmsszV
         /GmjjhUEa7G86INADKbck8t7QsNPFMkwIKIjPvKMBaPdhL6CUIK9ugQVC7LLLXwYnxp7
         rwH6C6vy04qV3HajnkpHgurBZmPFj58vFHQwR4LaQ2eAPu9JYg2XePTcxGkQyCVKvWGU
         XYV7lqI/mwMLotFlHrqiDowfG0aRdw9MAouUHsahdr1kuGmPTyQ/qKcmVn7teQrHh+Vk
         SvixC1tlvinC5n9sF/KAseSv4/7r73yAbSup11Lo3KNl9GLCWPl3kvOXq2dZmMU3f7eX
         RvDA==
X-Forwarded-Encrypted: i=1; AJvYcCUI+r+TkvI1J5Ra1nLK1yMoZ1Q617RgxCQAMybYKn/uVTn9SzrXTwdXEC026SF3D/dDuwAAehXPOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwguxwUCqRt1ZOAoCkm6Xy5ZNfJmb7oGmbrsjq6ivcJvwo4WOwZ
	DdVuNP/VoGn2/jK7Y7nlCFUHEMkWnGyTcKxS0uTZ67PwQ+8cHPYlJhgc7GThoNYKz0TkUnF8A6Q
	sETmcw4NbVkFfvad0gdrKn1ilJLMjafUyKV6M/ENpYTTa0Z7vkgTZpzTi8jhlNA==
X-Gm-Gg: ASbGncvawdP9//sqiD8Bpf69CqGg9wIWv13Dv2iXLJpLyMKqIFiBWH5U8FGMu6uLRk6
	hFLc2jl369Ts/Kglbb9aqy+IEpvirbMDTqKiObEXpnoUNPjoOYR0hrRrsSSjuXS+YlCmGK1HNS9
	WoZWMXHtphxniM3U6S4jjgQoz8cJZ5K6c+GGt8UDlSEwnES9BFaO08Y47R1Kr7WBlK/Ny4wc/SQ
	jomTLOVtuwMrCzyiVzlGXM3aGB4f9Tu7MDpfqcKm8l2mGyE4QoetoNv09ShNHXYWhgiBn0p0sBE
	llKcu417fRusfbmg8EXUhM0qS2z/oWPerCsVXqAfZpeioDxEXr5hWWAYgFZ28lG3d31dhbBSu2u
	y
X-Received: by 2002:a17:902:ceca:b0:240:2bb6:d4ae with SMTP id d9443c01a7336-2402bb6de62mr9628125ad.30.1753633564181;
        Sun, 27 Jul 2025 09:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcv2kVK/ZF8/3NjRyqdhDR2HpvnWClMUSrwh0p1UvaDUQJSXqzTIkgTv+rF7qNzXfsSV+sgw==
X-Received: by 2002:a17:902:ceca:b0:240:2bb6:d4ae with SMTP id d9443c01a7336-2402bb6de62mr9627755ad.30.1753633563720;
        Sun, 27 Jul 2025 09:26:03 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:26:03 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:51 +0530
Subject: [PATCH v13 08/10] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-8-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/OISjQAhUBAIE37ASE5b1kssDpdL8gfQSFob68FR4qs=;
 b=/j9LuLfgeFti1wex62JLiS+dW57tWBQjp0c2zfR2CnLi8HYpUl4wkARBVtzMP3Jg2HbR5Td81
 AGDjWH7b1EqBbUwIaroGDhq9zWeYEc/3o7sejilFBpLNay/t6KxhLuP
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6886531d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NiBTYWx0ZWRfXwAdWSHZnnt5P
 CBtjihk+MgY3MCSxDp2G1+xBjHPetqaluUdblQTqNSGwFdLn2CB6l1U6IgwzPEbN1wu/FLGBUeO
 LgWU8Cuk9mhxQTszH8gg4KjWIIpSVEom39SGbQ4eACWhv0Pu+LAUFOrGM1WKJv7KjuldsMxG0q6
 yvptI6lqjx2QkuFwZ1Fqfe0irqJp507Z4M6yWfMKb3GkpOyH+2zGQlsu7KjzF2uNeIw2c62nIW3
 kDl1U5cCWzkqyexM5xTvh62+jliF/N3lNdOw7WwXfvc4PLjc5OVDSFvrV532fpJHH9n/WQ5yBug
 mBA4Q2CXfuWyVH3jTj+6zWQjw7/Fca9a3mmzWOZDODDCkLKCdlngtAtZjtQ9wgXJjIkCW7OS/6P
 1fRPiSE+itPClDtJO2iFsKvkKQQazWjA6Lp/QT/h0DZcN9Y/+m8/MNnt8lRj/GYEEMwTHtC8
X-Proofpoint-ORIG-GUID: 8YP0Piy-1RgB167tZsVFyFS7Cr3scGon
X-Proofpoint-GUID: 8YP0Piy-1RgB167tZsVFyFS7Cr3scGon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270146

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
index 7a155ef6492e176390faa3f2dbe419f5cfa62f0d..d25dbdde7dcee9fa3f1bd48a38baeae0f063023c 100644
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
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..e6a99ef50b9b9ade9d2a71a14fcde429f8076dd5 100644
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


