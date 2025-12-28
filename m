Return-Path: <linux-pm+bounces-39993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594CCE543C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D02F03012CED
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F7238C29;
	Sun, 28 Dec 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8l/yiIx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gpcg/MMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4C22B5AD
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942497; cv=none; b=k3lPz4EXs7YIrGpCp1P4sB4pG6ZjhRG+8bW5Hmo3D8TJ4VBxFKBB6fzpwEVzB/yMt6kwFahHmQ1SCwyxWi53Pdsy1XOu2suaQJXGyn4amtVKxVra+hHrn9be6a3Vkt6yULLWwVs55Z/AnKrVZBNbyqwE18Of0UHNtTf0gRvaqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942497; c=relaxed/simple;
	bh=zyaMjYOjFDa2SPj03vZF0IuCzZxO/R2dcgFXOkM351U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjLNbxL/G7Gb56g6Oyi+wexAwyAv+cJuJGiusHPkWb15vj3zaKLBEDWD1GBv3ydJ5ZPTMUvUETFEiekW5Sm3RiScr6YwKRJkxkX+gVw8Qw3cKpGrWJ0cKdAHAt3IMP05KXCsCTV2Ppr8ljisueJiigvFsXz36ulE7MqCi38q32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8l/yiIx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gpcg/MMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSHC8jB3239832
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=; b=a8l/yiIxD8wSmWmu
	OG2ObJKVgF+UgroKX4v02Y7ncEDaM0tiGEjV9Lqq46Hrxf8aPT1Z4ksUiEFafeJX
	LePcCHBJtpJvIqx/67DfgGgNrJm3ZQpWwlA/eJ27Jh86rm1WxjzYoU98KNA+8gDD
	aBSXrpwuHvJXSLGefbDdNBuSKZ3cia09k4c854UresA+i15YywcGq9bX+zlWmk26
	muenRQfYILP4TPuYrnmfUarBaky5bX07BeRnUlwNoaOx9nZVvdDkudT2Zu83unb0
	d5twYrv50ojqazQ1rhnXp5wvr/YqdMUBTj0SH+RakleFuFzph9eXoki3oNieAbRG
	z3QiQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr2m77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f25e494c2so96826525ad.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942495; x=1767547295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=;
        b=gpcg/MMo/GfQ/Z4/jxulTiHO3mFgKB8KBMLnRF+xa9A3Wud2JPlN2H+i8AjTrlBqsM
         Vh7NjJgkL/NgQajLSaDGWCgz4Uw6xrZJlSDwhy+3w6iJ77GHw4uuJj1Vhwt8DktJlR1q
         2QwAPOCHUrk9CNoEH6RyzTp/qW4xeMfUkc+WTLW5s+sSyTAJxoZKLjlwwCbcFbF9urhG
         s0zVWeXUUKlDKIj3DVkkn+t5Ywgz+M7qs5RdTLMG+jczaz6SJ/EeeFU7ZMl2SiebP8Yg
         dPbneJgayeWU4b2IgLr1v0IS5e0EPwcANptmKnyfqAlGJRmQHSPb3R/Q//qnbAk0x/XD
         g48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942495; x=1767547295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4yj3uTrVzY91o9UvaViQBsZAb2B7yFqWeP8MulTCY84=;
        b=olhJ5Jgb+C4sVHbn3DjFISbGz/+gK1RTvNI3xu0+oo1uQZi2IJL9kbfrNuPv+dIUXT
         qsluUzjtIbN3a+vSvyYUNAZ/hGDEWoJua0EYYnQrbBmvTGwJejd2gOEMUKr2iXKGOift
         2Yb0Z6qi6uYJIIZUzyUWRwacuiNc+5AZ+kjGsV71/F8vdTZVSTJ10DQ3LycRd0I/VfS1
         4Hm+SXF/myH8WaISq3z/yPQgmcT+iXHf1HVIwItkyZwaT2Aa+H+Y5Ws+rKqMONinnNIS
         wIefvlnxr0FPr7bvmPkJ7nyR7PPa4piiqIsnfhbUBeC3P5jSSuxzDRx/8ha/3SG+BJkw
         nBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7W8tPdPxqa6b6qSMw6ylp53qNCz2wI+3oRFM+/2gqLKqnQLzHdcQZqT4Y5sEbv6Wx60wzqkWhUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqF3mtXIb2rEzVdWD8bqCtDFWorf/250/AyJNfypt2oaZchE3Z
	xZNmJk6BLRiUCe2/mU514ZY0QD9tHLu6jRJeXfYAJ5cvJYdxQVS4gbWTVC7092ExIxxZuUCK4g4
	woiVv8tLYtPtRyVnFIkDnLtZPpuN3/AnjKSVu432EAetZHSospvqF6XSNidg8Bw==
X-Gm-Gg: AY/fxX70GjisXyItILAoDwGqcQczRSBGliEfl9dkswzkjKLB8gqo+7FItVNTT9m0Ww/
	YXaeAca/bddoKgDGKi0W+vr5Sfh89LCWQL4LWFt98BandtfqZNXvzo3REKvvLWfixlk6wJJhvhC
	8SVGFpe4z9OBrrlZkg/tPSVtcG+nSaBdzlFOdMO8qAU5QyLW3r0uL48x6oLOt4GrWp4eKtR2ENo
	KueIjd9iMimBm4Dgh5CaO1e8WPFjOY0fCEOAGSxA91X4QuDmnI8ojH/gn4MB9ecEikR4FvFg2KC
	ofc+XWsyYcPAHnL9dtS1XcxACUQR7GbEp2+u0iNAHMdd732LjpsZJy4cI5/1hfPbosbkY60jKQV
	mbzd+LIP9iF9RzNaEDm7xQQ8IHMkPOAz0hWET+3QqXIM+Iw==
X-Received: by 2002:a17:902:ecc5:b0:2a0:e7e0:1d31 with SMTP id d9443c01a7336-2a2caab9181mr358936155ad.11.1766942494529;
        Sun, 28 Dec 2025 09:21:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpgjZdeVDWYi2V8zEaEHh90HQVYpauaoen8x3Yi6OZShAbdcqaPn93tv2b6wfoDATyJ4jqkw==
X-Received: by 2002:a17:902:ecc5:b0:2a0:e7e0:1d31 with SMTP id d9443c01a7336-2a2caab9181mr358935935ad.11.1766942494024;
        Sun, 28 Dec 2025 09:21:34 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:33 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:26 +0530
Subject: [PATCH v19 08/10] arm64: dts: qcom: lemans: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-8-ebb956053098@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=1079;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=zyaMjYOjFDa2SPj03vZF0IuCzZxO/R2dcgFXOkM351U=;
 b=yzs7Mhx6aYbM6q9K4ZYfwCoQEqZcJxWZ1m5CokIMXSJTBj2ibqqg35xHkGkMOC1/CuEYRrvcA
 tq8KDctY5glDWUQW7rz5jhDmSgelqv/OfNehQTNYu3qfKLzm/ad7A03
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfXyTNYyyGl+BUt
 Sz3/RrE08BHCheL2g6kXD/9anjjVSl5JqYJ3HuSPiQEIgLHM13bCNdOmjTOIJz/B0qOYI5UHDPd
 Ul7RVR/9y9DQ2mGuEMTJdhwc5ss30cIHnzNaDBRyjjTZVyy+IMWfjwWLC4CJOwnlYnBFMxdT2Vl
 y4n58X9da1xkAKCH7wllFEMWMeQ41LySExN3MrpZmHYGx1M9RWyJTc3qEA7FD6Qi1JVlFVTK2JD
 PtAIz7RO4S/1rxxFxDzFaAKyLjhM4houMj4gG2lj6MnEz6W1n0N7vPhT0B/B2F+Ugzj4qjM8cDr
 DQ9XdklhHdZ2ZXCrJhAEYz1i5L2yGnu1Xayv+auEUN9CsMvsyL68dNzm3ZKPTDQILONefZQuhU4
 jKrTVzsBfMYIQNdsOojM+H8nePS2zA8NwNGDFwyEJXVtWoOVxzZFcMZGsmM9q5k5Uou2r1cTT5K
 RoWAiCghwQJMX7VnSaw==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=6951671f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ld_RF3OM1xByVwKNVVYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 41kVNuXsAUPqsLi1_d_q2bh4vTIwRH2F
X-Proofpoint-ORIG-GUID: 41kVNuXsAUPqsLi1_d_q2bh4vTIwRH2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

Add PSCI SYSTEM_RESET2 reboot-modes for lemans based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24e69a9d900f06bbb22baa2781cc3f..cc70316d6949c8a36280b85931c4adec9cd60f62 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -698,6 +698,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_apss_rsc_pc>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x80010001 0x2>;
+			mode-edl = <0x80000000 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


