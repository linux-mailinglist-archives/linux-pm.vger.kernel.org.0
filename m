Return-Path: <linux-pm+bounces-37315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12156C2DA5E
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82388344272
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCA2877F2;
	Mon,  3 Nov 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYkFtK6/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QoiXP7rD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E928D836
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194029; cv=none; b=Kv4NyHj/T5SeLz7TSygAC0TbrgWy0oaxBfkDNeswWxJwWB7LQ771RtuqC0dDhcY2hjv9G9L40je1YHn01d3hyJHY6fvJ4TRKpyzSlrEZW+LlV2IFn8vdjGZMWP1grKO1vIJ+rkk54OLxoDOqgAhwtH0c0wrNMCi463I/mA/33KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194029; c=relaxed/simple;
	bh=rlRxbzyh8yyj6CJU18HLY7UiR6zS/35hHQYL0zGGwVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gumNDbR2bI3MvyZfqh4fHw7XkXJkQK0+vATvphjxyR8yHEuiLGWEWx9aukEbJkSs0ePOdoop26hOrPZPPC3WpzJxto8D4N9qVgNsjK+slFwjUXsn910Z1A006htpxXVsogjiAJL1UrrtutItNIf8u9neegxuUDkEuPfkO1XfRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYkFtK6/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QoiXP7rD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3Gg28f3684447
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 18:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6KePe1VaAb4
	Rb0Kny+upVC22Zpbyddm9VODeMGdiXKw=; b=hYkFtK6/NXYyoNw76imw4aHAbpz
	quRkgm1aakICLsXCvgAMgnmmDGqzqncQbSaOPzCSdvayjIiE9qxnMgR2TcEw6Fo9
	uTpVHRJwe08Ro4P2FWHuE7EjXrPnEDvaT4krKg/VR6SHPgnAmb+t5fqRjP3Twejd
	JVRuXazw0WShtdB66AdcdRObSkuTuQ53jSKt/v+jfM9FTu5giVufggy3uP8jeqyf
	mqt20sIEoC7aztZXKHD98Ps3sLeyuMN7HrG+3pItBSVp3yT+4MPmZaHE/Xw0dMda
	UGr/3BBAnVwF0lNRUzpeBguTy7zSIpUbq4uJD+/wLH1EwTGAuT1ut4ySMcQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6tnrha3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:20:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a387d01bso209147291cf.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762194025; x=1762798825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KePe1VaAb4Rb0Kny+upVC22Zpbyddm9VODeMGdiXKw=;
        b=QoiXP7rDKXz24ckCxNY1unWlrcite+49/LpgehyD2OrdlrQnK6Y3MipChN+3QNFOHc
         OALymGOnI5P7HD8mnXalDmyeOMNzmMk2jRXlHNOYVx6Cvdy4OAJt3bNxA1MEKRdE66c/
         9Tfr+Vt656pC0Og+q6jp5mko/TII5Qf79mOxEvR+Bjlm+D1WFqXSzDrn56bCMinRFVEK
         GBhHZFZNnP4Aha1kWhzpEuVOkPaujfnymlV10AsoceTIeRrSy7yGQuXxLKGAbIxVrzFZ
         5Vi4GPOSlAjWvWrI2CPeI++Eg4PVKg3ggObv001cYhTHybisGjieyUhP0lsLp5+bBLde
         p+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194025; x=1762798825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KePe1VaAb4Rb0Kny+upVC22Zpbyddm9VODeMGdiXKw=;
        b=r+eORa8xYC/zBXV+qXsgmL5PEUhdNd9u4CY5CQCSPiqJvw5DHvNSWk7GLUDdMuHvAz
         a1GHBM96MsFTmVuMFb6Y+6Nm/yAP/LhqjJBhERokJpGlDmzDem55Ne4U2dSnc4zaY1rh
         dT2V+3F3axiDsbL8OMTpI3cgumnCZCojniyiiiBGpiZjM2lqp/3LaCkd/mITNHdAXemK
         +aYBss7MGZNsMLAvIyF/8K98oPWkRZkLHKNBxm0/eDbIy86Hv9cjSGt2/152yuVSYDoQ
         Ci1soTZiP2DtyUTlttmetcYr6NAU2JISWAX5GeWRBteew98O9bRgedx6vqeS6T5HDF4c
         tK9A==
X-Forwarded-Encrypted: i=1; AJvYcCUX0g5m7d9ylxmRP7w66lzwgbEL+1cxunEz16FxcyRpFOzSL4D14M4UTxZm/8YZnohK24Pth/hdxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjTPWukFubGI2ITvaPQwm3KncPrrPPYhWMLYVdYa3NGg9YMVR
	fE2ytOc9vxTdMt8qSc27YG3Mcr8KH5jOhvoCR2IUwBhf0/Vmguhpg7IT2mDa+U/wEhjjSsRe2G6
	XMUZGB9RhMbsZXMs7V2z4pxBOdDRHj3irrtkU8LftoxglMF71hw+fNolVc9IgbRh1LRvv0pOM
X-Gm-Gg: ASbGncvxbb/Nf6dZ1ZsCOl/Ep92rBWbT9nsI2z1SvkXOFRC204OhdVvD/T/yrzS1Mvo
	0vXwO3NRu+nnHzTEEm6qGpBL6zBZTrqehpAmk0DO5uyNLXlQqbIF5y54I+ey+uxxxXC1Znvd9OO
	U7Ei9RrCOQAJ+TrC09QdhHp1zinjVHmYyQCqpi+SuXvxpYsF05RwbndZrELf8BPQjxL4560UQVp
	kyY4yDMfofkGX46pvnecmFRjz8GYMX/ZRUOOcLUFjHSNsWqkzGP2uujkttQKo4Tv5H9ZM10WZV5
	PaX4OInR8NRcnlckRZU3NiLMrEsWaSfY7d0TffBXyErh4UWd/WCDlqCm3BpSCuCyBx6wLtgwbCD
	LjqjO/oeGVzy3jk2xl1bI4apxixdiH45so1XgMfJSru+cLvDVIPN1gofu0YHLQY0ADA==
X-Received: by 2002:a05:622a:4c11:b0:4e8:955b:ac04 with SMTP id d75a77b69052e-4ed30deff3emr164567501cf.22.1762194024758;
        Mon, 03 Nov 2025 10:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4oxMJtz50yM90yKKKIia6FO6BqNrcEfMAMT8ylD8wZpLbSlCFYUGYTPGoQtsz0TPiz1enWA==
X-Received: by 2002:a05:622a:4c11:b0:4e8:955b:ac04 with SMTP id d75a77b69052e-4ed30deff3emr164567091cf.22.1762194024267;
        Mon, 03 Nov 2025 10:20:24 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:8842:5746:daeb:a8f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm169096545e9.11.2025.11.03.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:20:23 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: Add support for EDL reboot
Date: Mon,  3 Nov 2025 19:20:06 +0100
Message-Id: <20251103182006.1158383-6-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NCBTYWx0ZWRfX8z5iXP1f3vyi
 jlKcs7YvxAt3b2/11dGYZTW5znXWSCjJIjTGuETQyeNIp9el+u/zHSY+t4TLyPrtAzZL39/U+Yz
 MohSdZV0Vl/zB2V2nH/W6sREpEiX4SQzA9AucZgYemVTn6EgRjztTRWzLSc5pBbK142iU7NsFvj
 DFuBBYJ2804LA6XOItUMfH3MyQ/fV4QihEnX3sqFzJ7PgpJlRYlTyrwtjhNSdyAzA9xDDZltlH3
 zttj5UWFcyRI2pn7aq5rGQ7F64gqgYoMqcdBAn5l+TMvUICF47Qz0JQzU2cGiJ01ZuOSSd7+8g4
 iqrd83xLAUBwH3hlhT5isiZVy3ZIRfJiftWHG26EewlQNhp8m1IvgKeV96oQA1//SWTBrnPM0j+
 K8BkPbseB8pPsoNOJV7TELZWuGQ5tg==
X-Proofpoint-GUID: jz2LO811FddkJUbqVnGKRi1yDhApyPuO
X-Proofpoint-ORIG-GUID: jz2LO811FddkJUbqVnGKRi1yDhApyPuO
X-Authority-Analysis: v=2.4 cv=BrSQAIX5 c=1 sm=1 tr=0 ts=6908f26a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030164

EDL reboot mode can be configured via qcom-scm, enabling the platform
to enter Emergency Download Mode for recovery purposes. Additionally,
we enable PMIC-driven warm reset as the RB1 platform's PSCI interface
lacks support for warm reset.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pm4125.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
index cf8c822e80ce..5d84a3250481 100644
--- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
@@ -15,7 +15,7 @@ pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pon@800 {
+		pon: pon@800 {
 			compatible = "qcom,pm8916-pon";
 			reg = <0x800>;
 
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..70c6c929bbd3 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -322,6 +322,10 @@ &pm4125_vbus {
 	status = "okay";
 };
 
+&pon {
+	qcom,warm-reset;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -510,6 +514,11 @@ pm4125_l22: l22 {
 	};
 };
 
+&scm {
+	qcom,dload-mode = <&tcsr_regs 0x13000>;
+	mode-edl = <0x1>;
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
-- 
2.34.1


