Return-Path: <linux-pm+bounces-36121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C79BDC87D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E215750303B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E392FFDE6;
	Wed, 15 Oct 2025 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAndtT8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B32FE071
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503230; cv=none; b=SUQ/CLL8JZOrA3oquG2e+44DgnLRCzpx+Ix+ksGd7Z7VexQNzL9cVJTZFbUhY/ogWuzRsAlfgecwd5AOhgkVFuiqrLd9DdFHkh7CxIL0g9zoTzfCl1GyuWAaBmWKZQOvTTxybHtseiBDoyoM14DIGIy+61WSkvHIbjhLAEvCQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503230; c=relaxed/simple;
	bh=3tL+6VDoxS2hdKK3SSVcPd2aISC6JIJj78KTfRsAig0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQAI9ULFsExUCTVFppzsFsyIycNWTgT3dlS3ZgHR3H3TmYVE+jL3x0wb5tgJhrsQTPBtphcBRF4XDwSxf1ZtKAF56fVVMS0PunUppWKWB0xnYwlRB4ikPNDw3+hEBtrLofpv+n1p93UzmCWfxplandJT6mJ8pRZRGtWM7/nN+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAndtT8x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s7vT024770
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZfu7RdKZtwAuiMpDePN5OtJu7qdVHtUdaRTMDlU6TM=; b=TAndtT8xUCR4alSN
	4rrgBcTwAXs0AN5CDagPAvwdm2hZBk9jhyZkzV/EHefwTAKE1MwK8pi++myMZMi5
	M03K1V44ioslf97fYT6w9ZmWJAyyKnw1Wc4jVxcGYlELYeJGUfsj5+ZpaviiRMqr
	KT8rrmRuq035OjMDd1cu0uz1aJywbTF763RgsbNVx7gtRhtSWmNaoTNGf3Illmqv
	FsUWInOjXzqf84+mkCb+lC7533dOKRL6Y6Qkc/WWMKDgZ8of+eU1sUeUruVZFKCw
	el4ChIRiHzNafenU0hVDQrAYEvGz/HI3SUWwCB9vlAid2qfBJ9R8cP74Uuw5RCqa
	iNBy1g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0u1nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so9720027b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503227; x=1761108027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZfu7RdKZtwAuiMpDePN5OtJu7qdVHtUdaRTMDlU6TM=;
        b=USRsa+HbWVTQ4AJ45VTrhddi4zElnH8LzFDubf8Cx1t+PGy/4oKrbOhxfXEppXPeva
         IVUJZZyzwAPGSMOFD7hqiTxXyIh00nZaBqZf3wYl8/ec24UfX9iKmZ/9ZhcxPPw00/w/
         NUj8ak7bkWHczUbg0bPF4avAEqtXWEWnVl7GazfPZrsxoZ5RhXyKWN31NeDR7xYt0B8q
         x8CrtP+HsmogBdi+0p8g8jAoakiKmsnA+yUNJLYMNTSobqWREhJlG9TRUcxJ2bHRRTpF
         4bBNYIjTk7uzi8IsWyXDJ0UHjeEVrRyqHzkLeKs7TlsZjRBYL5uL1JssKSWNLg/Ky2Ym
         O5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX+NBV5xWFlSfsM+xFJB8TuOVFeq0s4RxEheympWWNZoly/WKP+MKH/3IExsbvokqLX9mRaJElynw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeafmZEn/E7SkZIAFmUTOorlc7Hzn2K3FC0qlmgslaqBkQS4sY
	lAar02fBgUmJ9aMUgVLMCXjVbcf2qspQNsjUSNfkUQXZjbtaqtzhJ4qD+1zrjM+mFXbIg3LQX0d
	NmCLojitXtGk2OMjuVzpfMTZkDGqhjoqNq/tcVbU83WLdOWWwGjnL96H85VHKLA==
X-Gm-Gg: ASbGncuDzQlo9NdQY6YOT5dtad2reysC+vDxZdJuC0v02IYhovk4PvIJXt9mg17nsFe
	Iy5iWY0rZh/daAqKMswCSL+6oxhQIgRNiVpJZtDqUhnxOsDAQXmiOhsNMOAPdpADuy4KyWHxlYL
	sGBPv+J6A52WUAraCiypAIIKhHLy/TLofH6WOmXSUsqtBRHTTuAD1tfbugfU1gvMagSOEpo1v2W
	fnH/8umvhJSxKASWWk5Z1IHfaeBkwgPaRN8AnyaUA3uZ6EptHvCg/kVneCaY6jDuV4CmZ2rqyAb
	wLbCj/bPB/QaqCNVeu2TwIHNxATpOdhr5gycMVqnRAhZMSWnUTkEpmp+zLrrxWjctSyIP3bk2eD
	4
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr198616637.8.1760503227395;
        Tue, 14 Oct 2025 21:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkDYbQIRUoxg05mXOOOW/CBEpKTEB/pAQHQYMra455pfKgAnlmRZ8yd3snqshN/4BsPPzZaQ==
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr198585637.8.1760503226668;
        Tue, 14 Oct 2025 21:40:26 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:26 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:27 +0530
Subject: [PATCH v16 12/14] arm64: dts: qcom: qcs8300-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-12-b98aedaa23ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1518;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3tL+6VDoxS2hdKK3SSVcPd2aISC6JIJj78KTfRsAig0=;
 b=s/A5Gob1an5Sgo3hNJYO3UAMrJrJ71fVPjCtysHgMuKEyh0nW4q5z+SfV1ZdY14GzQJsINdBc
 U9DG10rQtHxBubxEMRq8aw3VSj19z5jd+9mOd0pBMH3u5SxAcI5zdok
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX+DfpuBiILbTF
 1Sx+BElp5SMWb+K1Tq+DBALRVGzaLE8tOu0Xz5I2zsTKqj5QCSa1/3gUTl7/PnHVeuG/Wu/bU4A
 SuQlGy7S78h8vEd+39fd3GC+gZj9ROQ56qBlygm2vlDBlY3Y+K/MEwdgATjm68/aWUfPBLf23PI
 CgG5rMm809TnrAP44GcYfksVI/y+UwMJXFxQFRkUp0IJLIR4XeXhEaMkU+7Ip5UHWpNlIlLLlg8
 2RBLz1K9f9bBQk+R5iWZHimoPgQemcWrNdq7s4vaS89cKzAGnsoiA7J2C0Tm3GMsOPmXIRz7aGi
 jux21BWtGWnZ57L2Ary1WB1rsE0kvjX1o6fkN0xwg==
X-Proofpoint-GUID: o2HQEhx_2RBF-6ee4MaN8uBXSlLXoq6F
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef25bc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pkXgoPqwvIc8jTsVjBcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: o2HQEhx_2RBF-6ee4MaN8uBXSlLXoq6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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
index cabb3f508704bc9eb0038bd797cc547d0c8cb3ed..7ebe292f1029393b43f34e66cb15c2cf97ebf30d 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -317,6 +317,13 @@ &iris {
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
index 8d78ccac411e495592a6ff532c99e7aba087d18c..89db75aa0777b9ce90732956024b6ccbec93428d 100644
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


