Return-Path: <linux-pm+bounces-31070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225AB0A867
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1255A4489
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97962E173D;
	Fri, 18 Jul 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBFccEd4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2F1C36
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855975; cv=none; b=ksn+h8CvXLuhlzi6tkkQwAH1EBNyipdgOBf0s3h5pZZvtAfqruTEk68RpDCZiKj2ZuWfbo+JdkRMu09cIEpXQi1cHR4f6hl0yBzppMtqn3YZ0RwCnAPBGHMCohKWq9PNh0txeF8eZU4ZiPoPmY1Wudx2ZawuM2ESZBuhsIrzdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855975; c=relaxed/simple;
	bh=GS8W5OKhX5k/3MQCghSpRV/kbVATVCRf5/YkEeA5moE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eX1ApJ1cz6Wmo7TdRDXyFcD9dUcFEWSqT047zBaRuiLNizmt5V4lB59ppLEQdrvZ3gJDKyO5DtbAA/TcpEWwpyeyiRvyTJmIwW0yzsc4DOQ7bwmq1TAZe5sKeJ3jE+ZxBXUFSesweSeihBqAYPIFAGYpHr+7bZJecqWVREiigXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBFccEd4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFVw7L022405
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/MegsDezoJ79tZFpGw1Q8AeYWxrjPn3HT2ydHvhFydU=; b=pBFccEd4Wx/lh3Bx
	0baDdpJrAVlSPbsVtEeTH7+PXy100+0rEt/+u1MKhY33ccl0/7NSMXBoGblR/ZPw
	S35ODjNp1M+nxORrVKJxGpY3U+LqsQtU7TPH1ICKHFPwHTszqrgU6QPX9J4COuXR
	7KVPc3CH98nvAWGAvY6lwzsGZ8gicCBIBNLLO3w0sERs/c3MEWkb7zqHIv3bosvE
	eD8qRavQ9U8Oeh5xuL3rCz0Q+95zR6o6faiMuXUR4lppSAoXZlqvdk0tgKkfBV5F
	o4rc6JSQcCOOzE9Hrq2zk33sG5KA7AsMSyQswbuLk3D4QPLtmdFUyU4XgDX/+oEj
	QX7vYQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyc8nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:26:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-702b5e87d98so40948486d6.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855972; x=1753460772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MegsDezoJ79tZFpGw1Q8AeYWxrjPn3HT2ydHvhFydU=;
        b=JdR81ZzQRkSpW6ChScDkxswsEdGkrNsiaIA8aLNBo81ep4d1hel3olnqNfvZUsTuAE
         Zf05kAedVhaT/T8wkMMR56v9v1iYpvUhGTC9j4KFv0b/IbU3orL2yp7pKCXxDH8G85xB
         WNKsd+jF0bKJPbM2uTxEt1aX5Qvu43Z6xgwEvqbyzrkqR5n2RA8Hqv13N/XOmUnyDOLC
         gvXGXSoXM9zBnuH78vBQGrIGOeSTRpKQ/f+KsKtsuybM4kRzKKMDDCRtwOlSZsMHo2TG
         Ea6QphHBni7cQaB3LhpZ0smoko/0aVVamqCq4x674MKJZgV7aCCkqddEbK6W8xh1/rvj
         r4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVI1WRFHWHoQEIRBT5FwMK6jC6De07gF2csHboplG8GYiktdH/Y+p44iZY5g25m0m0V8X/y8c100g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpNLcYdn93WwCH2PRNqLshJVG7zYzAR2rGRHKHcGnDJ1xAyKz
	6hFB5/TP9Nd0ZXRPc247/CsUNcgLALxbr+p7SNg86YMQH3uTW1SauP751UyOI2EHB0reb464ySP
	WVWdd1eE+IUWxjkH22QJs70U8SHVds2Na4kWRy0IFydnTWs0YDmpLK84g/YP7FPLq+6HHgA==
X-Gm-Gg: ASbGncuGpGEFl4OZhTZaO4IY8RvJy3pft+bbsUEiBEGPEKvlC5NH9UWzYBCAp63LmlT
	GjZXu4L78vizCUbgbDMAShfVtE10+qQmFXJ1abRq4wjctxwZhBFHRoD7QuKJ7B9kcFLmZZQCzQt
	7hFabbEh5F6Ui3EjlQD2uqR3WM80u2YP7gSiyOW1TqHgPD5OVpapaLwGgleAKYxlibYDk/ULruK
	cZ9OsOdgXVpVtMm/d6Ks3MJYunlsVYRxg82Q746K2GT8RGM+wYxEdmlBCurz7aVQ2oX6p8h055O
	22+9F16DDLFtnuZvaN19KEFlf0q/apbBvaaNlH3ohj0YdrtV7K28Zd/L6bQ7MEoldvTQzlX1kNA
	laSzIHPCTFU/akzUOWs/z9e3ceGsQ4tWZ72xeuN09GIvZ2P0j4kzi
X-Received: by 2002:a05:6a00:a1d:b0:748:34a4:ab13 with SMTP id d2e1a72fcca58-758492e297amr10904632b3a.6.1752855562326;
        Fri, 18 Jul 2025 09:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETTxoYHaMo2UupceBlHL0TBQW5LinpfSukvtJjEUlWPT/+Pekf+q78KOdNgHFAAMem1ZIkA==
X-Received: by 2002:a05:620a:1357:b0:7e3:3e32:e620 with SMTP id af79cd13be357-7e34d9ab6c0mr981675285a.36.1752855235755;
        Fri, 18 Jul 2025 09:13:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:44 +0300
Subject: [PATCH 6/8] ARM: dts: qcom: dts: switch to RPMPD_* indices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-6-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GS8W5OKhX5k/3MQCghSpRV/kbVATVCRf5/YkEeA5moE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3f9gT0zERUZec9/hsBUQ1qPK6ZuGLIOve3
 S3naw0SXUeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1djfB/sFx/Qa/dlaCqhOszPGddW0LxXnXaDbnVtsqUwKL5xI0ckxf/GOxTrGWqrY6/FILTdFH5h
 oTXojXp6+aH0hpFTkkuE8VbllnDMSMfyL1nd5e+JfiPCrVdyDhmCh4C0CtkJlY+Hhj9algdfCIw
 VeuKF8rlqI4NqBXqaVrxfshNf9ZJQNNjMnS65dw+gk43Hi5gyHSvW84+Fq+IO9glI5JGyGxuv+o
 aj/WTob6RDLb7elEQY3tjCnqRaRjPbbjMI+JsAc8SPC2whki3e0chNnC7+ylne/j7Wg28LsE5gY
 zCWfNlRACRkqr/apeWH7J0kXYp14+E7m5d0DguYjMEq/myqE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOSBTYWx0ZWRfXxbQ3A4AtLTsj
 3NodXljC04DJCOZ1tw3W4Hgv+1/9TH4bX9aDWx3x/ANK5QSEgVODwDYhSfBWVmRvcLuw6GTtWh6
 10TdQWWAgKPqEuNzQPv0+oMZfDWJc85Fb9Cr+Gu0zG0v2Wpz9TaDdpYaVusgBHMV9iTAMyqBwjs
 4z9j3KVgl2o9DMnIAQZmwrVxeo1CLgwWXu2K5L4nd7zjUR1PtPQmNEvVfjUooejD7W/MyMt9yzW
 gOJPWM94IAirJr3Lkkzp4zBHVk8gilaPGcEq4rvZ7sdl4nStfBEesn0k0uLUFzMw/4N0s6E5JGf
 u1JE7WGT3V8/KTHYoVmD0izsmfSqbhN6m4q9yEgr/Lsxl7ZDLEngSD47gNJevSo466lhsrlszMJ
 b2Mz0DjqnTRWDP8xKhrhxGkyEYbpdh3SQW/vv0wDck5nRqigJT/LMHke+qEFciBV/pEU65VK
X-Proofpoint-GUID: T4d_Vl91IVeRiczMPxRpPwNRNBlIf13e
X-Proofpoint-ORIG-GUID: T4d_Vl91IVeRiczMPxRpPwNRNBlIf13e
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a75a5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AJhAjMZ01lUAXvDxW_0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=994 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180129

Use generic RPMPD_* defines for power domain instead of using
platform-specific defines.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 51a7a3fb36d88eeb8dbccefbab672aceb1e46428..bcf14a3b13a1b4b3455ef4069df2f3d9c5c7f9ff 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -959,7 +959,7 @@ modem: remoteproc@fc880000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
@@ -1372,7 +1372,7 @@ adsp: remoteproc@fe200000 {
 					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;

-- 
2.39.5


