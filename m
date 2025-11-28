Return-Path: <linux-pm+bounces-38889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CDC92643
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 857AE4E5CFC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88C32ED40;
	Fri, 28 Nov 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3P8P2oh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClUN+unc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B532F76E
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342122; cv=none; b=sWt4Dl3YcyWO554BQMjUCyLvhRK8FStRbBDHpSrxEd92jQFR8gFmklouAsTTfDo3ok5FBSI4wGw9d2UYFpCRJp8Bd20eTxooRLvOEfnb62/wkREhw2i9N1P5UyAS7Tk4O+Sm/wH+kNhyGrbPXmiBrm21+LqMaVZsLYSjCqa3xGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342122; c=relaxed/simple;
	bh=UU33rsjB6cwkxiQZjs9flKSwaQBjR62L8vGfNNoDXYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Wu+06E7rUY7KS6sfXK6pmPNiSArJEKEe48wKcY6W3SraIFynwN2pFqv/rCFlxM0zFGG6+aMeAOGCXh97oRTX91nt2/WYAE8OilCISkkCcjpIHvIHYrnse+lBy6FV0WzrZA88r3BRVeWt/DRKhGYlF3PLYBeU7j49NkMCziRwbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3P8P2oh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClUN+unc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ASEbOak225813
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=poPZ6JaN1QNodsl/vhNAHQ1cQ2m75xykuLF0QgSfxXw=; b=m3
	P8P2ohFmef2Ja/2/+q2JtZ17oPf1GLNl6AP+1MiloBWs/7PLA6tOonf3L2Qxb2Q+
	dt1ZN5LVqBemcqo8yoDx+gS/H14NdSGrdizQh1I+koTHNnqb5smt93IuhY1bdnyi
	BxpTWQ+xC7xyAphoxOR7Ht6M3oiPzPa8bAuhJ/AcR0Q+4o/g+/ZjHc6SdaEUstip
	UQQtl4cDJLnLX4Qw2MjSHdWG2Gg8l2LuyHs9VLpViN6TVuHskGkHxRK6e4UiSJll
	32dTdZvI+36savujiuWiOg176qrNiEl2+Jm/XoaGJ74EyyMOrIzWii+yYgd0RN4f
	8+QzpG0G/WOQJG0lat6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqdnr822e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:02:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29b760316a8so21854365ad.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764342119; x=1764946919; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=poPZ6JaN1QNodsl/vhNAHQ1cQ2m75xykuLF0QgSfxXw=;
        b=ClUN+uncCWDLkXeA04XmJfDkEkujYxacsuqEZqGIq3aQcr2i+/aggwPZZ3dqqc/gaw
         mkfI6m/cFMmJTF01sQA2CtGHjsZMKybWtVLimbxypp+fPRkrSAroI+MTxU9nVxluHoeH
         OHPJ8J3oMtEaHwY+OmdhYAL4J3rmTJ6aFLeC32d7YqOPTWKkQGAr9yJ5zmcLTzU0Zvx6
         HSZ6WWR41AK//dLT94japhGnEiJn52kRqYhwqE7vMHf3B3uIq5lIB+ce3ZTWrK9b4u22
         OIt+sj1O9eiQDToDln0gLLWsgNXNsR5ObkEfe5C2t27KDIWPuJWKt0uI5yAbd5vc2x3J
         OyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342119; x=1764946919;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poPZ6JaN1QNodsl/vhNAHQ1cQ2m75xykuLF0QgSfxXw=;
        b=aPxTfGxSgHPN6c8x1t/bE8vXNv1twJ1jJARKye37tZ7V6BeuFrFNP1+JEmOHAXEI6E
         b2T4BAxhXBG6ruEhHZ1Px0k+vDfu/YMpPdZeF7ks5PYOZdpS1XGH8h5vetF5I3Rn1VVd
         SR/oWg3/frspg3Op9Sx1NRHEpFv1Hda4KZSfDA7198wI8HXEQ75MRTT/U3HwmoC8YTdi
         KaGPR0PGTw3QJn0r5+ycnt2EI1L7E66T4vBrPrnpfzdgX9XjR0b8w0WVTSzJ60p26ZFc
         J9VIAEKCi6zv2FWvm+EB4jl/Yk5Eur3/HNntA/+OITpxYHBhNYtXRpz1S0CaTiuB7O21
         MpLw==
X-Forwarded-Encrypted: i=1; AJvYcCWDV9CQMwrt1d/jhouvy4D03j79408yYqYtpmsjLqPAAld2g8hCbAUZohDW/ajsBSsnZqw4auOPCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC34JOVaaIWB2Ba86ztIXaJ9aqmGnP4u06f1H2GgGNvxmssbg7
	dHlXD8nsjGCvwZySqyv5TmT6UWJ3tLejfB9ZhtQ2bK4HG1wNP0fLt7nt0qIMWQkijViMRZM8qPc
	U0bPnPzyPoRobk2MyZ1bd3DrE66C8qTYrMskeVD8773QHbuQrNkcwFgtu0fxRtg==
X-Gm-Gg: ASbGncsRYzYzOdNN53qS9JX6P4vCFgyWmNNgn0cVm+ud5dbaZ83Wu8rSjuOp06cfD+h
	TyjF2+PEqQ9H05o5coZSd4u92vqNm7ZmRMVw7/rBIxttNYkJUeWmQFXlriy7fpO8fklH3kUYYMJ
	quHC+hbZSMLO7yR7j9HElq+xVzxmfdxZzayqHbrc6/zHBNwt+4b46dkcQ3PXcsnpqPclGy4Sb5g
	u/zhe9pDDWSGEha3dVcSt1XP4ia2TUwWahUzIAVM9TJLqCP/1MerMYLppuzxtW/NKqkk+s05Uwa
	6WHKjVeN5y10ZuKquN0whL7Tw214g7Ip75uBceU4djnar/66xPtmJrWJFm4UErnuuSPfwOKDnX6
	a6P+pdkukM/yo6gcTKnSxcAKCTESH2+rnt5TWz6jw3/s=
X-Received: by 2002:a17:903:2349:b0:296:3f23:b909 with SMTP id d9443c01a7336-29b6c5767d4mr358754355ad.39.1764342119362;
        Fri, 28 Nov 2025 07:01:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW3/L7cLZ+hDAXvD8QfActpsccZMuajQkivaccixnsOCM/x9NoRUUj+OFFkquvpAv6OgjhJg==
X-Received: by 2002:a17:903:2349:b0:296:3f23:b909 with SMTP id d9443c01a7336-29b6c5767d4mr358753595ad.39.1764342118720;
        Fri, 28 Nov 2025 07:01:58 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7cf89sm48930635ad.99.2025.11.28.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:01:58 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS configuration
Date: Fri, 28 Nov 2025 20:31:06 +0530
Message-Id: <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDExMCBTYWx0ZWRfX25dmvBLr0wOJ
 5RDSYcKFgJSii+6OpnnGQ96c/CjxE1TXDMJTTbkTX5YJsO+m1jOslsYMmMkoc6d7R4OoUkTIoeN
 PzQKYlmLsrZ3xIVf1dAGSAl8ms7rKhDJhUCfdY/D61RZBt+6T/DA415F9Yta37MmfJnMq15M9ZW
 82KWuAX+ZaAn+dZGUMBOov4loZ7nF73QQTn9p7PuyUMVwf91vk6uCX+wPdPgzRPvUYImdrkyNas
 4GZ5H6XO1HUJuEz6B9xAUtrKk5VMGdZ/eYmI4Cufcur7fFGZH0hSbTXXGsyrPVzzV8UO3K3cvL4
 w+9vn0xSSCaLiR+RyMfOQAxZ8SfllJSLzwRedaHNP61rQ8BGC5S4+lNVvgLmvCh2RXBzwWFH4nM
 eeatm15zUcpX6BxfEdhxLJ3X9LyDAQ==
X-Authority-Analysis: v=2.4 cv=E5bAZKdl c=1 sm=1 tr=0 ts=6929b968 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=lpgrqeBui4GLTciQF88A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Gfbd7MEwHl1d9uJ0CbmKthVs-Oljf7xL
X-Proofpoint-ORIG-GUID: Gfbd7MEwHl1d9uJ0CbmKthVs-Oljf7xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280110
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add clocks which need to be enabled for configuring QoS on
qcs8300 SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a..6139511ea525 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2226,6 +2226,10 @@
 			reg = <0x0 0x016c0000 0x0 0x17080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -2233,6 +2237,7 @@
 			reg = <0x0 0x01700000 0x0 0x1a080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		pcie_anoc: interconnect@1760000 {
@@ -4560,6 +4565,7 @@
 			reg = <0x0 0x9100000 0x0 0xf7080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_DDRSS_GPU_AXI_CLK>;
 		};
 
 		llcc: system-cache-controller@9200000 {
-- 
2.17.1


