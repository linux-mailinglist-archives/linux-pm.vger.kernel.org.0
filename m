Return-Path: <linux-pm+bounces-41558-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEh8IHnieGkztwEAu9opvQ
	(envelope-from <linux-pm+bounces-41558-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:06:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF309764A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAF12301E283
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CA35FF46;
	Tue, 27 Jan 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCQnY1Ov";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIKMkPAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5235DCEF
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529492; cv=none; b=Gkbi7cx8OzumT+qMGJRK+dGeJnO14fJzyhAWTi+Nre6LetvxMXKh8HIY3yR0BX6laoZ88q+54p0B4w6aSmNDCCUk6GWzgd5BJWrzxOOdB4x4WeDX+XbHHJi/a1n+gWrv46WyEn47Kx4sO2JIzwwKiZDMnD1KrNGNFQ3hdyyALRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529492; c=relaxed/simple;
	bh=75Hv2ud2YpxXHB3QLKMzr5BAhjhniJy//FaHGuH283c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLjGw6rrN3rZ+yALzcbWPeaZWVoFyEOmqSb/6PkcNg7Phl3a0bNDSGUsFot1tpNKgLio6CbKaL4KRCvR6pbjUDV/cDj/jIwsrSi97G9WTRo71KXdMlNi4zneM3a1eOu9neh7Z/zyrCGZzrLeS3uCqXWDouTuezSkZDtpJ8QxH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCQnY1Ov; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIKMkPAb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RF4LXl2378873
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7DhjQ0phVpxDU6sKo7qBxnzRhjAFpM0+5pWd1KBa2Y=; b=MCQnY1OvOIuLXyHW
	30F1Zx2EyvfiSzuyK9yi6yzsxDRmgGrUeg6sPhJRFLjJNpaRwJ6/aO3gLxz0Py5W
	lasreqt+mzqH0xREHSmMM8YlFT90TPm274Ws2/PP/IeFeQ8EOFVoLXqY/Y1CXKAM
	2xLEYUB1zgtbwG9U6PtdkPFFELV4cyifHvoHZdIfAzC+jV96V1fZUV5YPv/ezG+C
	TL+K7/KW7oqKThWseLr52/Yxasw+Gk3/RWxfnO8mC08zVlYvpl+4ebfS+yCpDKdn
	LESrxuV5nWkHUrGGAGGwqbkBQorGXTx271cXpOJjtdP9BVW0kYU2CE0Cu/5s2Vr8
	YG9Ahg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr9hcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f53036ac9so4955947b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529486; x=1770134286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7DhjQ0phVpxDU6sKo7qBxnzRhjAFpM0+5pWd1KBa2Y=;
        b=HIKMkPAbIwgMBst1s43c6hIFhPtDJnyxlsCzVR6KW5IrJKOdNQHQQdGt0A5wdzRNOY
         3131wiuB0vnfDYqGRcWIJemS3mWw2pqNTqn8QRwzc71dn9IaVf7hMuar6EljVZD8InoU
         Paa2lDtumS1bC4fwT7t+y+oiwhGbgOE8MxhafDnWcfaIXdJ/7mV0gzwEFaY0FmOJI5U8
         mTN/+bKpIDBtU55F3wEn8VQRkDftzT+vNe/Dsle7wGN3Va8sdHaPaAOf7MmLmQR9nkOI
         VbwHYRswzlXvAsqXMba36WOtyckMY3ZKlgThCqNOpBGDv9dZ0KGrYPWMp4dstGEvfIoZ
         UuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529486; x=1770134286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7DhjQ0phVpxDU6sKo7qBxnzRhjAFpM0+5pWd1KBa2Y=;
        b=lsbq/K8p0Nvl59JZ5jfUPSqPhPJn7Rzrbi1GkqTa9ikZG5ni3KUxbYu1TVoOVb7GXv
         i+PSURpi0P6dndWnSkCwPVzS9APXvjIRzow5tnSgJQW3GvrOb+QYHZzPGiIy8e79fYnO
         KYkqmkKctN2iX/xbz3hRUl7UNk7RTNarpgvhsqpmne+WMrRag04LeIK0ZAYkdoH6pljU
         4Go7KOHCppboCW2xR8t4ky1JW4PD2GbjL3gdCPk9x2syyXffkAHBydaf5gArpZmkAqGu
         rXv6dvFgFfqQTnYO+6/cdLfZIHiyGZGn16ne1l7vkDI4X2qUQ7MEdpAsnCQn9m0Lgjq8
         UbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdrmQilhwUcehhVvUUf8omT+NUP7bDd0UWd6/c7Bf1UlElJ7tMtC2/3iJyXwKfU1NAMHEauiYeNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSwtW4zbzrbVZUGEqahyFN0eF04twFg2DWMJ8EOKcy4oxzHMf
	TRyoquwMTXR4RHPzt4GqymnGMudlEQvNhvM0cJMw3IEFzAM9WgMGRfv97zhjMv/xZU6WyYCDsdR
	1a/iwpzl/ABplQP1Z8lFTnWvJmdKq4stIAJkVtO9/Ne4Fh7aqwTgZuBS/Xy3Tjw==
X-Gm-Gg: AZuq6aKhLtK1abmHxcGpSqYLNRcirEHbSM5TtfqGGLFhuxP/MrSUxIoOphPhZCMt4PA
	BuQboUS3s1ND/O33a6MMKC668O/XvGBY1xsORxJMzasfra1ML89pJlY/0YQlbVtEz+MB6hopao0
	O+r40mcfiIQd2W/Wt4DzSJgDPfL/ZQlh9xsqej0qkPuY1s3nY/rrayormUYV26iNnvjel4GSmdS
	HnT5OE43RvKwIWfI7LaTepEyetgWHfrd4beejmSKPEigRCjcXlAlOH73RI8Kvc6Vr0Or0XkgpTQ
	oEnDjzsrtom9rPOiCdHXebaYHdVRL9wLiXe1qcWF97ekvG3E6bmkNwa8vRQ2s6dF2T2TGr6k6/N
	dsPDXK4vQEllRgcOHzikuThr7xy3f39O3Fc25WTk=
X-Received: by 2002:a17:903:1a90:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a870d719ffmr25767715ad.26.1769529485855;
        Tue, 27 Jan 2026 07:58:05 -0800 (PST)
X-Received: by 2002:a17:903:1a90:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a870d719ffmr25767395ad.26.1769529485130;
        Tue, 27 Jan 2026 07:58:05 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:58:04 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 5/8] arm64: dts: qcom: lemans: Enable CDSP cooling
Date: Tue, 27 Jan 2026 21:27:19 +0530
Message-Id: <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
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
X-Proofpoint-GUID: O1AGcPXSwZQYwJjuRvYMKwr7-6TNUMJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX7uFzdl3LCEqR
 ki7PowuaSmRw100xb3wVBu8AhItbLh1lhLdIlXJGw1Ff0FWhlgcHAv4DAhchVKnRVebtNHV5HdR
 yQU0Q84zk9LEhqfQYLJ9sUa5OSBe0SBhzxfU/gBOnQD9oF9Gj76UA2fRYNxHxWxsh497WzrVkfo
 nt6ky3MIshY52PUSPr05CaND1rVvYjCwlLheCBt+JJlTszjdZ/nKCafLD1FDdkatshSkt3rSNGH
 DkWRPLeJ8Ga5irMKKKC7+uAd6iSPcEYDYYAo722FjDfI7fgU5YeaHBEf3xA3S55l0BY9cUYozD7
 enPPiPk/0Q1BxPoYxT4mn6ty61VLNiT8T7DrK9tIW1sNfQ+ae93IjrS8sWjLLv2zVkH/Y+MCn+B
 cevla6niSGz/aed0hz+JZMewWjNFgvU1PzhmAa4ihmflYvHYmx0MxtAiRU0RR7T633uxDHkBh1j
 keqvwbSBdwOtgFSrC+g==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978e08e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_rgrqTzvvZAetH2WXeAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: O1AGcPXSwZQYwJjuRvYMKwr7-6TNUMJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41558-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,0.0.0.11:email,2a0c0000:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,1.201.195.128:email];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.13:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2EF309764A
X-Rspamd-Action: no action

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in Lemans.

Set up CDSP cooling by throttling the cdsp when it reaches 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 138 ++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 808827b83553..c747dd534caa 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7281,6 +7281,15 @@ compute-cb@11 {
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
 
 		nspb_noc: interconnect@2a0c0000 {
@@ -7444,6 +7453,15 @@ compute-cb@13 {
 					};
 				};
 			};
+
+			cooling {
+				compatible = "qcom,qmi-cooling-cdsp1";
+
+				cdsp_tmd1: cdsp-tmd1 {
+					label = "cdsp_sw";
+					#cooling-cells = <2>;
+				};
+			};
 		};
 
 		remoteproc_adsp: remoteproc@30000000 {
@@ -8168,7 +8186,7 @@ nsp-0-0-0-thermal {
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8180,6 +8198,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
@@ -8188,7 +8214,7 @@ nsp-0-1-0-thermal {
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8200,6 +8226,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
@@ -8208,7 +8242,7 @@ nsp-0-2-0-thermal {
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8220,6 +8254,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-0-thermal {
@@ -8228,7 +8270,7 @@ nsp-1-0-0-thermal {
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8240,6 +8282,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_0_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-0-thermal {
@@ -8248,7 +8298,7 @@ nsp-1-1-0-thermal {
 			thermal-sensors = <&tsens2 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8260,6 +8310,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_0_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-0-thermal {
@@ -8268,7 +8326,7 @@ nsp-1-2-0-thermal {
 			thermal-sensors = <&tsens2 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8280,6 +8338,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_0_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -8422,7 +8488,7 @@ nsp-0-0-1-thermal {
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8434,6 +8500,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
@@ -8442,7 +8516,7 @@ nsp-0-1-1-thermal {
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8454,6 +8528,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
@@ -8462,7 +8544,7 @@ nsp-0-2-1-thermal {
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8474,6 +8556,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-1-thermal {
@@ -8482,7 +8572,7 @@ nsp-1-0-1-thermal {
 			thermal-sensors = <&tsens3 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8494,6 +8584,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_1_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-1-thermal {
@@ -8502,7 +8600,7 @@ nsp-1-1-1-thermal {
 			thermal-sensors = <&tsens3 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8514,6 +8612,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_1_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-1-thermal {
@@ -8522,7 +8628,7 @@ nsp-1-2-1-thermal {
 			thermal-sensors = <&tsens3 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8534,6 +8640,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_1_alert0>;
+					cooling-device = <&cdsp_tmd1
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {
-- 
2.34.1


