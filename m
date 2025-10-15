Return-Path: <linux-pm+bounces-36123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD57BDC892
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9167850369F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8A2FFFA0;
	Wed, 15 Oct 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxs2r+8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F02FE578
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503250; cv=none; b=k2tqdM0ihQrEmyFP7lNY0+TjCS3GFypxM7bjgggpxFv15P0t8q4UFwftnVw3IuFzu962id0MstdktvIKIaXFgENYdTZpfqKjnG0ptDQArGRdlFhbCPF0z3oKvnBbiO0T+jVIfdPmb0UDBSy18mEmBhQUpvpSQsW4LYFIfWCqdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503250; c=relaxed/simple;
	bh=q1pRzkuBh9GAg1JcwXGzO3FL3XRWgrlscAgQj90ENvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/kbp28GkVufAhlfHRHIu8fv3FmUqJGQnhVezxkRmGKONOKjKeDy5wWWO1+evrqb181hAbeiVFldSo1qZ6/IgrJ+D+C6ny5NV7Qt8iT7TPsKMTfM+RTOmckzYXQka6PqKER2MNJmAK2cHMxEXi477MX/LJ4mWSoM5ce1LkqUHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxs2r+8S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sS3n016037
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBo9gZrkew51yYf4IHpWDN66o41yYqQF87bJGWuNb/k=; b=hxs2r+8SAYSKqgeT
	uAZNpqBlEcK6bBPzYZ5zcv8abNZFHrNMkkFFCSPx8K8IIyRARkIGLrTOPXAqDF/n
	qZp5bk41wfi2JAhOAerQ/gzaNeZKOMKe0+ao48SwoB8F0jVO8VGz2suDEWTaKeDP
	J83RV++aCKvWtMtJEjQgMIZcXWIZi7gOz8MkBDDA9j3XCIKlaf11bs8U3BZx49x7
	pN05oHm3WL4XOd+RN9kp3jgnEWfzcVTmVkCM8pRMt6XCy40+rjLbyh1LsBkT7xCn
	Ybb/QhPBDJIGuzlRTMgSDqZ9T2FUOMOYfSLD20UkNWEcVKsrZ3zH2EvD+AEnbMYL
	OI9xXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5k5kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so21071239a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503246; x=1761108046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBo9gZrkew51yYf4IHpWDN66o41yYqQF87bJGWuNb/k=;
        b=JJ+DBHjHy2dUxXdUi5MdMi4LJyL4YAPVgjpWCYbii0PNEC5BwEfPIP07ZgHkB1BabZ
         lPCwlVAm22Qz12kpWFgsUGH41xpvK3i3YsNza9m9nWaZzbZ5U8piY0MfGchplxlLB1vk
         Y1C84K48bq2Dw0qOLizpXEldzOibBWRZsEktmU1DsEcz5vZVcJ/6hdbzPNT0F+agR/1j
         WhlFlXTbYUhWe0dBVYVRJ+gbs5jrfgprV8IrmREuaS6HDk017+j8PdMk/ScfcmVGq0y3
         ElgZnM0yBjso3kqFZGu2Tk0Z9iMU3AIhd8wisq2HSGi08Sn62XgivHkL17DkmauseGWV
         g+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8XbucOdijkxQpl/MFZkhzNYjn1VW+lVJQad8pCYBTa9sz5sWb3sgwXcRcSwgrocZ4U/5ebh98wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhtm5gthWCwZhep5tXez/scQwpaSIN/KMeVbdURjC90feUBNr6
	f6+aqi/tyeH0lOnc9UXDwe2u1KF42Bgz8qbfKPAneqPLyU0JxcfFLU40/eqodcz0/ehbGrCQZDN
	7ouQQWJyz9bAzd/rF+IxhvjnQCW10TV+38EOMWCWhhzSAoRN1jDmftiDgJZwClQsceXactA==
X-Gm-Gg: ASbGnctI1/GF29s7/TVYwz/lMYzh864JMSVM11zz7c+a5BElDSWnBMhqo5dUG4VDHYo
	dS4AmG1kBh3pxo3aw+EP3tZ+LntHjLO1FJEHrajS2Ns6+Ls+HCe3hluicHpPVFYtYOnBCdFrvIK
	K0Xjf1fXMjKlkpt3hrRr5h1Qbirznllu3rouPbJ0sWxQ2eRrj+h50jegKo1HsaszaXgOKrQMICD
	pV98YTfWRcQ3V/piFKjPQmEKaVX7baawu39g0LfjqcSnBq4cyeBFZMVYGOP/OLREr9mouYKqTm6
	+Uqm4vMKyDxmBG6/9rz+IBc8vUpIHBgzFt/90/XujzvHdY1j3vJdiL8X+ysIAQTlt4fnH1gXwdb
	2
X-Received: by 2002:a17:90b:1c88:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-33b51386573mr36050538a91.32.1760503245569;
        Tue, 14 Oct 2025 21:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl45T5gEGBYaChkWOQqwIOqGUS/zz2WbvtwiMkJgYFYDoxb2M6+A0u7nW/BBPu6hBROJZsvA==
X-Received: by 2002:a17:90b:1c88:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-33b51386573mr36050499a91.32.1760503245015;
        Tue, 14 Oct 2025 21:40:45 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:29 +0530
Subject: [PATCH v16 14/14] arm64: dts: qcom: qcs615-ride: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-14-b98aedaa23ee@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=1528;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=st897fJ7jTPYQ5eppZ6+OrlCOSPDdAnpzJ0eoXTLNbM=;
 b=gWz6wC5KS4Z9D59qmU8+oPQ+ydpoZURhG6YTecv1VL1HdeQY4r8X5AuEshLZFDnnQNu2P7OnP
 ETCaaC08bcmCbxRY4EyrQJoana5MwZKnS0RbAX/G9ftaPPfaG17phQc
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: ZvacHtmJmB1KRHiU_EqVfm0wvDgdzms0
X-Proofpoint-ORIG-GUID: ZvacHtmJmB1KRHiU_EqVfm0wvDgdzms0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX83RfWIfIEuY8
 JJW6ToerSqV8hu+87qZ8QX7rlX60m62/tn0W3VTWEdGmHL7lXXBlaKp+gAMZ4ODGfXr+n6agPza
 bLF7P5PZG8n0hLkH3990Rv6vOERsUyu9EFsKFlBNO53sqDQu5HVTblidulQ9OwgVr+5IbR6MeUZ
 EQVWm8w2oFKYN0KmMCtfQz11kk1fo1E8Pk3L0tigqXRlbKzl/8uK+rleFq+m90EE25BJvYYIWKT
 fx9tk3wi/iFC4rF9jFwTnbUKs+HMVLsU2vHkGcJKg2mEyDacjvJToQFx+vVNG0LICi+wrkhKszl
 REB8Kdc3aQc5AEuJf8a2ICfrB5XOPDuVvXyVMrXFsVmgWaT+Y8EuNurwYaYh2rZwiCpN/wYQFY/
 +I0NZaNGCop2LfZTuAkzkIglErMOJw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef25cf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pkXgoPqwvIc8jTsVjBcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

From: Song Xue <quic_songxue@quicinc.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs615-ride as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 705ea71b07a10aea82b5789e8ab9f757683f678a..bfb504db43368fe73ff200476ff5220334872c8a 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -343,6 +343,13 @@ &pon_resin {
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
diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628a5db7ca14bea784429be5a020f9..9df5e94069f604e5393350f5d8906097d6d01209 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -416,7 +416,7 @@ opp-128000000 {
 		};
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 

-- 
2.34.1


