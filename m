Return-Path: <linux-pm+bounces-41560-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhNL0LieGkztwEAu9opvQ
	(envelope-from <linux-pm+bounces-41560-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:05:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D8975EE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2373B310A528
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6735FF47;
	Tue, 27 Jan 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MckToMAX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IVRK5LAP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863835DCEF
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529498; cv=none; b=HH+XyIqRbZnPZMXLCi5yc/tc7tSJSZGsK3Mf7Vpx7YAFvKQ61mVGQJFaWcpU2V+M9epqcNA0XKNViFfSakpfqeI94a6nL7IjT2gHM2ae1a1xXkhqK+dNM2thTCI2St25j0uV5p0sz4EQ3LUvjI548TkoA2dbEj4SBybdvvIXysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529498; c=relaxed/simple;
	bh=rT9aOvKoSdoVMoHRIYOqTjccVfZ8vSzhwbpRtBd8d4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahOxL3kg25Kr5CtZT9r6IT8P/tx6+8CA1C8Hbsd67/SOjymhS4/zklOhDmKzK4QGXlgtBSXnlycnlOfi+rHMAOBTLAW4wPrPT6H0De02Jdt4sTPhDUfzo7rAJ0ugYyOY3hU+wrUIbubDn3urWVXqjqEcxU6cIuBQ4l4PRmC2hKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MckToMAX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IVRK5LAP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60REZd3G1065833
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F+ZHp27u6SO09MSQuvFyIVk4/ZmKs1kInQ5godvccYU=; b=MckToMAXYIa8T6OI
	vGtZEhd1polk+Ow4u8Tp/ZNtsbWZNEwPLWVomCBClbTeOvc/Xv7rMaESHIve8Qzh
	6aF43VuejqjB7vU9gitmIFS1AgawiE9qtnDrtYdQrshlF2HDle19+OvV3O/2hLjC
	ekGIA6QMxPg78U2IX1xvqQTfB84AIQK4LUydKnSX0r+pRMAsmIyEyrgwK/x2Py8E
	7Rn4LJSofT9SHv2zt1r9osDXOij3YBHGZl6UKB3mjom7wRkMPtel9TyhwWJ/05Wb
	TJ0Oj/sjZ6wEUt9aGrOoZRs0D91m05rsFKArpvfQnkeQTt3mzMIFcJWXcvMmwRiP
	mkXg+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxy8x09tq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a773db3803so52606505ad.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529495; x=1770134295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+ZHp27u6SO09MSQuvFyIVk4/ZmKs1kInQ5godvccYU=;
        b=IVRK5LAPNVbMlVjqVEubldJhOXjvPmJpfSaspd2pdtJ9rQDNuHal7Ro2u2u/A+0HIu
         lxEtLIqafme/rXuZNbdrvLeqLPUESaZ2SD74rDLNl6Eq8U6UOhJ35oEiYwkErBScxtu+
         K3RVGTphp96y4ncblhD9F7+TTpNhYnQqW8tYHQ5YgEXECbGS0ony479ReIKwtZ+MF7+c
         WvyYehETgK5Cff/0028SA4InSITRyoO5C0V/ylbCPc3jS5Rc6L5FbZQ2ke4hGdbvl9fY
         FGhPwihDlbROLNgUBOcBms2JSd3GxmnPn2OOo9pA9t4Kkrv2NYLO4SxLNa9VpL5r8u6t
         6RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529495; x=1770134295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+ZHp27u6SO09MSQuvFyIVk4/ZmKs1kInQ5godvccYU=;
        b=k2OjknP0uCqaRIlwclj6WuLQIsBuM/D9XEWqvo2plEEBZj2RKEIUInn3jCzxhwnBBS
         oMrEfx3bgJXSzRP2Jtj7qO7a9SVOP7a0kJqMPm147gG2ckdtgEnAllGw3fCaBLHWhAEY
         k4dN3nCdEwbqjRod/Tvje3Cji/1EMYDwkseFJ2N8ZqGde4JVpXr8SicIQqvSHbP4z46n
         ROjkGdFp69BSz7rqZzmwn4NI6h1MfUiQuK3qYyWuf28Xfu7Kf6Rjf+1lsBV+iBpnVGqt
         mAFl0orKW03+hv9JJCH1PmBXVXMIpaXHBw0Fli+KyxJXD1T6ghjQ0BgKyY1B+JT7ohqz
         qF3A==
X-Forwarded-Encrypted: i=1; AJvYcCVe1lM0Gd8A/g6Uwy5KpGUeC0u3AwGI1KxyLFVOUKvNfv5RuMVxtRachBSuMPNqZMvmM4SaqlzbIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFXYN8J7nOsByaYx7YRKEVIvK8u43lT5wJG0AlLzBRgjNva+J
	oJQIY3W0mhg4XG3rnpugH+c+K7ZIHK8erVD2Pav4AaTCYGyRz+pOmCldiqkJioXxmcvWB1Jmiud
	qzPBhhX+I/gkTy0hjy49ZlGYmgfVfqcT2kenAeVya5OjcS4+BcwlENgX6H9o7Yg==
X-Gm-Gg: AZuq6aIjS/Xa7YQDiEUCBtKEiVixwgN7kD65Eznza3IJCC+3ck+WRyoIDc4dGJ+O4MD
	DWJTRufgEUcZHqUVsaZILThJVlMl3WCNJa25T56jyJ7QkXs5kY4kPBGQNMNJ6B6MrS4KPpBXOV1
	/3xiaXLXbSOYH/RSSS/JFRzA/ue2T6dHdAEh/HIBOKBK9rsfx9SGofG7XR7wnqakVlChg7WeIja
	blLU/y6fQ52N27VziQjRIM200Y9r4UUFHVBdgiFux6Bqnon5ys5+98lyWsDMO3DXt3QCs2cZodr
	DbMxRCD1Y1QljYsau+YncF6w9Ny6SFOkCvO+92s0yoio3tXVmzvwKjrE9cvZtxwvYhUTSNN1wJQ
	iNxQJObAnf8DEz4ue/jB6c8gpu42w8CebJEhYGZY=
X-Received: by 2002:a17:903:1206:b0:2a7:a98b:9fa7 with SMTP id d9443c01a7336-2a870d96a7dmr18054805ad.25.1769529495508;
        Tue, 27 Jan 2026 07:58:15 -0800 (PST)
X-Received: by 2002:a17:903:1206:b0:2a7:a98b:9fa7 with SMTP id d9443c01a7336-2a870d96a7dmr18054575ad.25.1769529494982;
        Tue, 27 Jan 2026 07:58:14 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:58:14 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 7/8] arm64: dts: qcom: kodiak: Enable CDSP cooling
Date: Tue, 27 Jan 2026 21:27:21 +0530
Message-Id: <20260127155722.2797783-8-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NK5r2g0ah4VE05aMgHMi6Bpn0-LWrzPc
X-Authority-Analysis: v=2.4 cv=OcWVzxTY c=1 sm=1 tr=0 ts=6978e098 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9N0ZlmuXsyx8K3-BwEIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: NK5r2g0ah4VE05aMgHMi6Bpn0-LWrzPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX3CfHfzcZ5swn
 9OzCWqBvIYkCburRSsPLJOLhmyRT0GytfHUeHGv/+5+WWlEb79pk25aEzMDoFCrQOaazqpM7sLl
 4MIplnTk/mW3b+6zbas4NhdrLp9D+Op9C6bKzJzathKNeaU7IR6V1+zxzMaJVzyVrHII8kCJUa2
 XWHAyK0suWQvjZuNIUzav+KLCaCY8icYJk/6MenHMJtFJIjyAjm5KRs52esKCuWhARvWXP1kqL1
 cwNHkX6k9Hx/VgVU2wP7WcDCJMqg/4WDzwda/8b29k7c055hJCnZgyGfxgEiRFoOl2sY2MLZLoT
 JrySWZdb6BLnBhxg0hlr48COy27IbKcRyibTE4661193kHLtauQkZgBUUQGqzhhBaGG/RVXryUx
 /6ALzoCp7PHle4QGJKBV3a4rQT5s9vuFYVsBy2SVnoUhUOQ7E3DhrTtxINiljCTtbBvwpBYeeRv
 AGOnBRnVgygNaGPpJ9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41560-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[a600000:email,qualcomm.com:email,qualcomm.com:dkim,0.0.0.14:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 252D8975EE
X-Rspamd-Action: no action

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in kodiak.

Set up CDSP cooling by throttling the cdsp when it reaches 100°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..3c79572bf55f 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4793,6 +4793,15 @@ compute-cb@14 {
 					};
 				};
 			};
+
+			cooling {
+				compatible = "qcom,qmi-cooling-cdsp";
+
+				cdsp_tmd0: cdsp-tmd0 {
+					label = "cdsp_sw";
+					#cooling-cells = <2>;
+				};
+			};
 		};
 
 		usb_1: usb@a600000 {
@@ -7600,12 +7609,26 @@ nspss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss0_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss0_crit: nspss0-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss0_alert1>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nspss1-thermal {
@@ -7618,12 +7641,26 @@ nspss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss1_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss1_crit: nspss1-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss1_alert1>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {
-- 
2.34.1


