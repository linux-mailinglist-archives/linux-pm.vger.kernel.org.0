Return-Path: <linux-pm+bounces-37687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C0C440C1
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9BE04E607F
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F732FF179;
	Sun,  9 Nov 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PY0hDFBG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="StsmIab+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F62FF17A
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699157; cv=none; b=BV5pxdNq3KhQzBcbnJA/plHE+0p2hHdgH9qwtGwvsWiZZjVGBS2ToBS9BsHZKLzANILg5rZwNxaLXkUoRpbm/6cJI2zROSTE6iwjV8ZUOfbR2Ji9shW/TXu3lndFMJo14oGDQTHYRn+vNcFQl+WXV7q/UoD8RCR0qvL7auELHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699157; c=relaxed/simple;
	bh=UMYfdnFcEDl//CBNfVhkReoHQvijQL74vM5MXpvs8vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGOskWiTA1RQSHprvxJFC+waDhLTEYeG8GrGevdrTigaKyCZh2oIIawIK9MPl+UxnuXtRKrBEUxxs3zsUOVJhKs98kLo+1Oz2xMQOWTfNS4YDBvgRx/Yj0A5mTDGPCtUN/TfzNMxVL4mgVALOzCLBjlcswZeDp9+G5B/9f3xA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PY0hDFBG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=StsmIab+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9BEgxn096721
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xzsLq6x8zujM+mSWgjjGh8I+QpYkRNwwRETPEDP6/Q=; b=PY0hDFBGvwSC/Zwi
	eQZoP7MaJFNlvAN82OowVKLHEzV8+xZVYpiffL5WlL0Nxs2NFBYkGvGJXUpIKKUs
	6FaAtf5VqcPX2TbrYmq9U1JSvr1225VP/huhWBvQkIxjPy3GKfz1A/V9fzYR4B5J
	E78Tcc772JXXsVgdVjboP+R7uxLcJq5GmMpKdH+Ca5YfxN3wowd1cZi/WaoXS6Wg
	ZHgsiGko8Jp35Vea3xz2lvUH9xMYdC5gF+Ed2812Qh9vjBEncXHOJ7Icue4ijvUD
	7v08VXreRAwwCdi2stgO3bfRQQtOmHbTY2cUxflaZU0pPEdVh1J6uUoRwD0wKFg3
	pBEU5g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h27f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:39:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b99763210e5so2040545a12.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699154; x=1763303954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xzsLq6x8zujM+mSWgjjGh8I+QpYkRNwwRETPEDP6/Q=;
        b=StsmIab+MQbvCKmKPe7/w4w8g/z9pUxNWTbmy5Jcr7p5tfzDsau0J/Ks3XPq7J3bwi
         t00R5gFm9k7gSp4v8kGBlSHRGhfP0c+LTR6OCun2qKOkDnssXsO3WwdRNGLwrxXm3sO5
         d/Js8Xngf0VrziqntGVocxA5vQDCX+K7r92jsZyyj1t8Do4ubl1npkPYkozCAJnEFHe/
         NwuLa8kPKKqDXbnGlpPGyCaIAq+/VGD6vVjB3uS2mUYrz61uD+ePEuaPXyGhu4FJDwtk
         8IeqF8GP4B2rEdCb0fBpvgccvL0iqoYZRtrnhXRudTl6Lru3V3UPBOo5lueuQtI5PJEY
         gCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699154; x=1763303954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xzsLq6x8zujM+mSWgjjGh8I+QpYkRNwwRETPEDP6/Q=;
        b=rSrUj1u7bZ3LqnvHbYfJ9d/tm2f0wLZ6kuhVMZcHF/CV1ylZd+5SKC8mtDb9NI64Pe
         RyiEMyj5h8LSTutRq7rQKFlXiLIPCd4A5iaySQP518KuPmuDwKjAtaIQb7ixvNybg+fd
         u+vPWMJHpJ1WyLEa9kQQnnKwpD3z7YFnQefyErIjEmOSKYIVFAFwML800TOa1wLkE/8a
         jpWRY1uBrf2WuquRL8FBkDGvgZBmQFNVHfE0Hm9reXh/puOXVEXFrUuFeZ0zgg1FdicE
         x64adnateraSgCud5qcOuH8JPn8Tn5BI3DF4jLIkSD+8HPzQEnwhxgLyPP162GKJFEY8
         xYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUddlqsaMPap7dewUdNxGk+wINgqB55jt6nxEDngUTmexKD99F9IU6jpDl/8OiQoqX3Y9ujfaoItQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaWIqfXE9VcazWkLJcEOaz2EZjLRD4lAobbpKgomOjfOuTJB1
	d33yqKJXR1FUxmrUQ5TdHPF4UqqbX0tgVmtqJKyc9RXDI+0Fhu2aFAFc+2avN7nh5EWKQzRQ+C8
	aY0ZVh6e8hjTwMqgb4Zy72Ui318O8S0FfBFoUvZg83qY+zNvDeglKyFrLGxNQXA==
X-Gm-Gg: ASbGncuxJ+QojKxXrrWgrSboNOhhlw3I2PxOyUkel8FuRIVk4hxkNhEfNvg6DhDjTy/
	n+ZwLsvw1e2FCqm33D1/yRbHzTiP7G6Sn3UcQYV+9/9JP2W90/AuzdUllvcGXEJcxCqceJfaYMO
	rRwQvx8a8CQhmPzgA678ESG+uaCCY3JPUgJunA8IrHRCvEGRraYvAct+x52Wbp2FJ1JZLge9o0o
	4a8D6NTQSa1xcbFmkU2xqOhq2bmeG8dciqLqz6vWSrZiW1A4mhm+err4Z4ALr5x8urs3FEcZ3EY
	bPiH3N/Jji5EjBh2ApUSrFQ2YBzBanrCo1RPZJyx8YIp9XMqb260g+2rl95meb8gJ7LDL+GLSCT
	/em/PgIuKM8UKkgx79lRx7g3Hcf3eoaiIsVw=
X-Received: by 2002:a17:903:244a:b0:295:59ef:809e with SMTP id d9443c01a7336-297e564e380mr69725325ad.24.1762699154339;
        Sun, 09 Nov 2025 06:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJIVsonHu4pNwPE+f7/331weZTNenlkh2Ar1ZXefNCwpSl91W0SITTJGiPOzgc2bETvAUx0w==
X-Received: by 2002:a17:903:244a:b0:295:59ef:809e with SMTP id d9443c01a7336-297e564e380mr69724875ad.24.1762699153810;
        Sun, 09 Nov 2025 06:39:13 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:13 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:21 +0530
Subject: [PATCH v17 08/12] arm64: dts: qcom: qcm6490-idp: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-8-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=1628;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wPevfrKI7oCQBZ67FuK+Z4QMbgrqZ9zLXyhCmM5o3U8=;
 b=KRVfr1hd7m7qekk11hcXPHqyUxRtzdmozZcKhdaIrFvqaMzJOpK7PwGxYGG/pI/c4lZoafU+D
 C1C+I5ZDulcC10A5XnRAERkFZgYaryxMEbXGezaQxwhe1NO0r20BiqE
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: BmBtMwkkGhDkwbn-Q5L0ch_NZRI8UgSK
X-Proofpoint-GUID: BmBtMwkkGhDkwbn-Q5L0ch_NZRI8UgSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX4/f9FIh04e3U
 Ki82oCkEHzuVRcDcLozc6fEEPdhFlZd2NE7LJadQe193BN35UesVI+utpOO3nSlEhOrfPkq20r7
 4Lbpv4O97ijIDIhXQMvtFmj04SUYLl3MsTsiCjHvl308WE6DCQcXcGfalAnQS+clOjQ8OuN1Hty
 WI+ZZvgjoUWXrFWoUeGLb/mfkmHYfS60VtN7oZEZHaX1Zq5iUD8qOTetaNRiqIABsVtCP6uXVnE
 xrcA19G5lnwcGlUgr7KYG8jC2EZzvFiIUmgtNcLmY/wY3a1CjrQNjcIe9ygTcCiJRaDC42mtCUB
 wNliluGkXVVYWlXZWW96x3fEuaCStZHTfeA9828wAf6yGEx8qlyw5IESMHREHQ4ueLvLA/zUu7F
 BhIJxuhoTCS5I3w2kn5lIFAczqvFNA==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=6910a793 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=w06kbW2hXDg5FjFnD0gA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090129

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
index 3ef61af2ed8a87d03e82131fcd8848f0a1bc509c..5fe7a2220e1dec3b5cffdf151e09553d54e27960 100644
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


