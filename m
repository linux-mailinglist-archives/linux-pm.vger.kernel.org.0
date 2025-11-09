Return-Path: <linux-pm+bounces-37689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA044C440DC
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD7114E5F8F
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B12FF143;
	Sun,  9 Nov 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgiUOEvV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RRCzDD2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687192FFFB1
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699175; cv=none; b=pAGcXBN30NZDQ5SmSI7gScNtLiKiqYnG3tYkZFUS4A5gPM16jgfGO/ZaPCc031Lwu1fdZnjr39cUZAvBzEob/PwbVe69XyrniziTN8g5MP14i5Qf2Y2bHIb/dOCW8xYPtaZ0k1AyxKe6HtCPNQkPQC1KnE5u5ThKEq9YGPF4350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699175; c=relaxed/simple;
	bh=c0sDk7nE0BsMGILV6gAFYqW71r5wB3+58FpK7/a/qxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRYBuCL0GQevhXOteRGLHI++EPe888n7jq5pJ2ep7JCB0bJ93xyZnglh7MMzOVCoN1tsAegGXUn3tG6rJTbC3vkW+/ZkxeLil7ftXIywHf1oXgkQfL4i401Sgj45ySn8pr1WKdHCQltxHNwXVTB3xjG+6J6aYB/9ezwVGFRXA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VgiUOEvV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RRCzDD2r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9DUU8u736629
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AukN+b68F1iRj8szvnom43KeenMjLq1Gdzm80qeFQxk=; b=VgiUOEvVyDsP0oiU
	6O6pBDoPcx6kQ/cDcQH5U4M5hCfoGn/3vBSxJGIIidIdGAuoomIaeCnJMoGBPhNc
	NIrZmhFwcW0JtpWHxQ44+Go/aCrrpxLbEJIFy22SRlqxllY9/cAGmuycF8KSYWMD
	1s8aL3nlivCdOcg227EsfW52qrCfsMHuHa5b6ZbZSfUpurDl7opwxemavruSykVb
	X40FH6Ov+Rg6c3/XWu47aU1VBpv3Ic/9ra6oVRyQNnXTVqxFRUR1QmXW6gzmbkfP
	yeSmvtl+uXIvhYii/2gu5Q+LD0GkC3au7aJCUrvM3BFQxvSN3Vr4TxhYCl0XcHmq
	TRz2wA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuej7xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:39:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso796370a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699172; x=1763303972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AukN+b68F1iRj8szvnom43KeenMjLq1Gdzm80qeFQxk=;
        b=RRCzDD2r61YkYdFAERCKNj+xiaMA7yOC1NfJbNHgtCi2Oa1NLNCTXnCM5Pv6i7yyka
         2gXdlPCHb3kHUyFNMHBiKLjVje/H3KBJuHEHG/C7Az7C0udoxtHbcDdOQ4okodKYCg6h
         VBUF6i6XArahiXPZ6VFAWH0Yb3n6aDCXoEFEKGvrKMughDtZR/tiQCcXmo4Zqaspu/jf
         sF1v7Q99mfbMPcRBQDrgwPsiBSgoIl0Ia0rJsG1bOJq8FVJ5OCiceO1aUL0IHKzDmd5h
         6Sh1kLFLx637xOIrvssUjr8vOsr9SxBsmU30GRVKbwhdyJOYyojiMfz3iHu+KyypBjsP
         75Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699172; x=1763303972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AukN+b68F1iRj8szvnom43KeenMjLq1Gdzm80qeFQxk=;
        b=RsxQSkGgxPQpbQUbHzu6/EgdBoQnxbqYXXG2dON0damOLGmgK97iGKbthUBEdKOHt1
         Uah93Zz2CvxDg72eCjwx9HoPFNonOVkXQn4fx/kqxYIcxgoS+HEQucxn11TaaNC7EhVE
         fyq/bvUXALUOH27zGBvtRyuKx9HoG87C5ZEmSv/bWhvwI6h/4RVrNtZ+fnUb6t+FOouJ
         6KlqxzAFAdFKG29NZvc+2PwepagY0fCwoUduDexd+zIA/u5TogUY6B3C78YJPixpUBBQ
         3oAW0wKtUoykw+u2Du5uRy1I2xeK/ps+sruJ2NEMKcTROz0HM1vVZ+3z3Oec9ed4+q8e
         fx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTHNGm5v5ZghH39XySTEYO1f8//JeSfr8l17eOVk53Wd99dVunjwKr9cx28jvY+ulMW2ntFqkODg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdZVc9wCfbfRGssQcWJtWbOYZEQr7cSCdQc6bm8vRW1j6+oOM
	oUI3WhEbk0rGWxCQSS4ZXWd05fz2s4zr5dWlVI5BDe0ijxzhGsNuOQX1q6EnWy6hqeFJl4LuVoF
	gRSFwzyKvQY8iXsalkEmaGYEOstnKyTcf01smUpwAIyDdzTmCGL2WL+a9Cv7//g==
X-Gm-Gg: ASbGncs9aeyJUTQyMjDXOhOuSEAu1sCtcOxW6sYH61CX94JeFSibLCD+F4cQqP0A00S
	bXuPRzwpAmOLLrCYU0CY+M9/juEOziVOTvzJKYmq2XYb6rM3/uo4+sqrJSX1TSeyKnr8ixMPbrh
	ApZcZVnr8iaqjzAIPGrcqUMpzvlPbycNG/qLPYyCeFoX1+PzbFKeR/T3HgSvweYChNgaGW7xES+
	NEL0r+hTCEqp9QWl5Zy5mbyN2/eFKsq6QvdISBLyDTAk/0TUDdPeD5+NWUc2RldRo93JyIcusoI
	38M99qSHs7gxX4qNNPAqFFrU92R2ypuX1vGXCqBAn9dzDOy2auU9XjguRG+/ZzIE/hO0V9qzEON
	QudqExL8zOYHVxBESjtzmTt4FaLU0GLc8Rww=
X-Received: by 2002:a17:90b:2d48:b0:33b:cbb2:31ed with SMTP id 98e67ed59e1d1-3436ca9af80mr7084196a91.0.1762699172287;
        Sun, 09 Nov 2025 06:39:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKmUKmAO/5YNNJQCK9WyTgSA7HEo4zvTBWQQYM60M955N7ymLGX8tiEKVtC08gIxpgP+mmzw==
X-Received: by 2002:a17:90b:2d48:b0:33b:cbb2:31ed with SMTP id 98e67ed59e1d1-3436ca9af80mr7084148a91.0.1762699171725;
        Sun, 09 Nov 2025 06:39:31 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:31 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:23 +0530
Subject: [PATCH v17 10/12] arm64: dts: qcom: lemans: Add PSCI SYSTEM_RESET2
 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-10-46e085bca4cc@oss.qualcomm.com>
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
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=1108;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=c0sDk7nE0BsMGILV6gAFYqW71r5wB3+58FpK7/a/qxY=;
 b=Mz+dwUU5jjgSzD6eifvT7KiJQzAbIaiZ/S841YqDDe6M8lFmUBSh7CQIbRvQr1GkfZsQfHygp
 2lejprqAIqqDTRobgFBQ8CGm51ZyS/hsWggwRnLthv1chZL9MjYDNJJ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX2IK3DKGtC5Vk
 Elw9QyXVFzgqHCKbdR9+83jxSOMSbW8OPJR42jjCWKIPuujJPHZ6OZqt1h8L0014VO8yqDIqxbr
 eJv+X2w57RURb8qnOXURw5rx//hS09mfKWTOCWLPxfut55C3g/PKkw71Om6d5zGv9yFlBBg8yrt
 ExzS+N2iKNrX+7WvJCBntweJek9N8PRCgQJVqw/iMXVYNN6BW6qO46wwQXIMCgS8txfe9kFymTq
 8nIBtBlEkjKo6v+FKB+1zMQpobq2bbcYLSc6Iao7xoreEvdamdW1yJanly7w2JmK/7chp/e3b7L
 szAnr7kp2RXfFRGwOian/SrZyhOt/VdpVYlLEKftqJRl+V+HAg8xmprdFig5AnL7uYnH5RkH4ih
 0+OlsFyt0JjygTRMTqjOaB7VOTg01A==
X-Proofpoint-GUID: EYsyrNXq9P3G62bGF59SrzzFuDZypGPj
X-Proofpoint-ORIG-GUID: EYsyrNXq9P3G62bGF59SrzzFuDZypGPj
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6910a7a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ld_RF3OM1xByVwKNVVYA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

Add support for SYSTEM_RESET2 vendor-specific resets
as reboot-modes in the psci node.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24e69a9d900f06bbb22baa2781cc3f..8b594a6535199b38ab6ca432673c4a9432c0df39 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -698,6 +698,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_apss_rsc_pc>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x10001 0x2>;
+			mode-edl = <0 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


