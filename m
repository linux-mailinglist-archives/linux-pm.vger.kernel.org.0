Return-Path: <linux-pm+bounces-31231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383BCB0CA86
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF164E6136
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09292E4248;
	Mon, 21 Jul 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkNlFt5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF52E4240
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122589; cv=none; b=GmVPt+ZnJxAHvpHfDU2NeGBeBudoCz9haiNKc/rtEWKtcBISZ7Vg0X25YLPlMf2VHyZ5dEaaTu9IG/6IoVVlhp9pCuaCWHzE7XnxzmyzivdPjoeRv2hpyaK5SKL3+5R8fuG9vbka8+hwcZYg+k6y4zq+Xg8N3L0SSun18jKUIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122589; c=relaxed/simple;
	bh=n0wa4AEusSMKTJa2REb6Zm/CPFmojeqETl81QHufxBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjoLzj6VlO28OJDiWvqyoDbq0xutjCbCOiWtaL/k43QFQ2utSx7FxeFdMCuzJ/oZFakdSDJci0pe07kNoJidVaw6pFGoINbn7GRPTWT13s1QNp2bwjzoIEqYhqbvOiiQNUO38XhfU70phF95K0d2o8xPoPsp8aiRRtWGHbuoM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkNlFt5w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFT6G2016274
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=; b=kkNlFt5wACA3Vclf
	NGmRyORu0cJbEy9crqoWMAVRIBO3IR3LnBHeE3LVmTaviXrUvKdsbLEvohPRQYUn
	jGVLp9zVxFSftokex/1yBBeyqB4g/CiPWcplToe6KVbhTdwCRQ2lv4o2QciUI9Y9
	4eR+Xxr6fCsGk4O6UZtDyvVgulkOl1irMR+rJfjVJB7tHET/zrFUaxw55I5IIFMh
	DZGrDnwOAbiDtrvhBPMFrKwhu7D1Y0ulIw/DsV9oYFoPzUo1IEYNp9DkQwZpEpnT
	OwVfYHclC30e1pImYdP4rjIohh/Rse6IgD9EMAs+gj9Md2iZJKUREzwYjFtZjchT
	6C9x0g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rxv2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235f6b829cfso35476005ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122585; x=1753727385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiMmHpQ1bB+met8QLJcdnw+SCuV4S6OJO6VsyYvdUS8=;
        b=hZvkIgrAUPGXs3V7/nW5/eTdkRdFLz1er97ceuz3CZQu6qwCJYxI8vg6Jso4wxpPX+
         Ke9PEj+D6J7DbRoxwnGlVOUVpxaronitKw7QuyoL6h6ZvMcYa3yiEN/jWA3rmuIA1Cp2
         GunzRld9fL56MPM05IkYVXI+Xb2i3EOTRZUKFMiHNKaQD7aWXN6TF8tgSTcMsaM/zznp
         s5KvStaJEP4qwaOJZobdOVVTo5fLYGlbEIOK6sZlYcrFNc7U/PPZMz02alhf/MsJkdOm
         poU4i2CKvfhXccnJ4I74ckUy3hY1rV6g9fiNGV8UgkKSpw4CJ9fQaoeEj1Coiqb/RtCs
         9hng==
X-Forwarded-Encrypted: i=1; AJvYcCXKrNXJPU8t0AKRuu5BXKzaJge+LlNdTKX94njWhgrNxP/K158OSmuY6GfTpnftkFq3NEx5j5hIFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGHQGJk4CGS/VQ3BtcJShJKPKQ7V6uYqYOExMiEdXXgPsy2P+
	TBG7mA3kwpAslUNP3RJ5T7s4bIgGpuV3yPbrAnIcZm0QNHO9CHVP8g4GPgfmOlHAvMn9NQPbokR
	ZPqVoWfWryJvFjkA40xJrkhZybVCkDy8SHx8/t4USS62/hlhmBYtPzIEoK4beHA==
X-Gm-Gg: ASbGncsXdxNp95wvfEkdQnHzjP//fL3Mw31m5E97jeDGzfjoxkujaZDCnmNW/2alWCd
	VFxE1uVRGdX1bW8hFUmpifoGDws1+KuWMsP70cW+YCK1Fb8L1+Trm8NFTpHeXWmEk3sIOWTUGnC
	EyGFilOcfejKJLLRZnzZwOehNEx9Eiz/aZhc4W1R2JkMVo0kOAQ2cNbwysvVOZRhTXO5jv8QkI2
	Xz0cofKLzsqhY+qLR4HdvyoBzgqbFenU5qxcAsAqT3UDrI5DD8zMz0tP6J24IIEXfGyG80WHckW
	Md+pSmPGE8jdrButPO/Dg3qx67T8E82x4m2MFqXMU1XeOtblmjdbDsgGssg6h2lozhcEhuWGSMf
	5
X-Received: by 2002:a17:903:22d2:b0:234:f580:a11 with SMTP id d9443c01a7336-23e256c951amr253931865ad.19.1753122585535;
        Mon, 21 Jul 2025 11:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKesUD9aIM32P7T7wuM3eaFz432EA7KeFqHN0KCnfPzbQxwR6Z60riI80+yCNY/RoO+9fE2Q==
X-Received: by 2002:a17:903:22d2:b0:234:f580:a11 with SMTP id d9443c01a7336-23e256c951amr253931365ad.19.1753122585027;
        Mon, 21 Jul 2025 11:29:45 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:29:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:52 +0530
Subject: [PATCH v12 5/8] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-5-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/OISjQAhUBAIE37ASE5b1kssDpdL8gfQSFob68FR4qs=;
 b=Bd6Eb28aznjRUSwc+8Xgk/BIQuXk1bJ/xKoplQQ+Od6H5h3mOZK4CPnDEWLP4aZz683h/a7pJ
 mkziSxCbB/OAqiXczvWlddBGNyeSdaJelRlbiVn05DC0+K+10Ob9kho
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX8sNfNgkI8u9J
 WBFU02EHSZ3vwGKXjucxPZltyWmgSDXqW/AeES4lieOI+/gfKW+XyNXYcdNKFajlxaP32lHTzsy
 ISqJZSDf+HiEh/Y7iZ8shm3rR+84MyjK6dh6FnqR5cWPHZc+5BJFO20Bgs/M1SHEx63w6f03eY0
 8ntmwqeI+2KX2+cblyBU9rqTxxuosyQONBtr7uMhC3z4VGVZV59xNlNncezk+X0lTfcY1BQt9dA
 tlCCK3l/WyPzZkXyCpsMrTa66w80eTXiAYtlwtNLKF4G82B4MGqtGzBcret1L5pSozQQ3588yim
 oxmcVyyQexpckX4A/+kmuKyOCBY++oD/V8im/Fgicvk2UmyYaKy8tNOaJinJkl7i+FO8PPA2enb
 8kT4YlvFT7R9sK2fd757+Z0xY+m8b+E9ungvLst9UETejKDeFviADO1egDjerlXeoswMeY4k
X-Proofpoint-ORIG-GUID: ka4hf23P-vbTipICdSv7vax-rDhDyGnL
X-Proofpoint-GUID: ka4hf23P-vbTipICdSv7vax-rDhDyGnL
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e871a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

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


