Return-Path: <linux-pm+bounces-39861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02ACD94B3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02433073928
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E133374B;
	Tue, 23 Dec 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TIXWaOby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j14AKuTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671283321D8
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493249; cv=none; b=puRDPWrJkKIBqKOH+oZBVbnZ+pRT2j2kglxGSfyvyvf6Qtuwni+Z80hnVbnA3QRf+/Af1an8sPEY+YpzyKMuxs2o1YJgbxehDZs8yl+GkvbQCOEjd7PUWZ1BDrEk4wnO0UUMssIPAb95b7h7OwtigQGwghMzwhAUzZk2uRY0/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493249; c=relaxed/simple;
	bh=rxI8y5oMiOdUIwfaS6AMKMcI2liAUjCfUWH0nx3mvRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LA4KMkBm/MpMd8YnAulCu6Ic4gZbnJDGDuCcfk5XppCILzKFo7dj6hWi30ttLShF+EtZQdRvu8vt72Lo1IvvaZeqQ/i0CiqJ77WF9qcrUJfwMuKIGl3bJ7w/Gv7gocUuxs8x9xn4b41VvZq57qG72tEfk+CO0ZeqCy0P15rnir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TIXWaOby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j14AKuTf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9pr3K1889146
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FL1ftbe5lm5
	j4ymoZCGPq7taoT2CIBDv4E1wyT+IMYo=; b=TIXWaObyLSkLHxdaxlbSyhWUjU1
	8Le1dsmx9tLs7JiMDsJkeApXnJrrJNYETc5bnAPZgFQg4rG7IlWbfpCYOf3zdMdl
	OZ3zh+/6mLSGW6UMWhut551O6vctcJ1/Wxa0Dc3KMZtsSTwdakTGFoN0yjyfoJDw
	ptTSCQ4pXKDRVNjcVV76NCQSeECRYj+1BuMNJeGd6X3E7nLg/Gx2C94MGDBNsk0i
	RqyrRP8CG1p5QhQHXYlyHL63Jm8BxkoLyUZZki5JfEtflWf2qh8C3+ffi+syNOh9
	5rcOeLb+T8P6HqBBPV+MJglJdni3K3CTjq5i5FaaGgrE8DvMeRDI50XO/ew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b770akjn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:34:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so10422287a91.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766493245; x=1767098045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL1ftbe5lm5j4ymoZCGPq7taoT2CIBDv4E1wyT+IMYo=;
        b=j14AKuTfnfJ/VBqGn+tJ/HIneSWivDpXK9YKnVL0QxeTSOAUvAeGdJ4dp/ryXeiMim
         /yR3ahR88PHh/I4dNqy7/9rC8oe++oQ8uFpoof6vAA+Ti6Uf0a5X1oANoHc6YXQDKJQm
         nGFw5IaprYxYOgXxdOXON5wqoU8Nt9x5nPg3er7G+AZyV1wVhFOGTWWzdhkcYUAbwi8x
         RFd5K1XodxMQgxSz5VU0x+/2rTKZH154x3bWvipV7R5dirFHcUATDQheIp72I91+uXyt
         6FufExnjO5h600Bv4+CtWrFVteoggrGOgwbwZO8RQYSZPLVUakNRj7POM+BYGHNsrxTh
         xR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493245; x=1767098045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FL1ftbe5lm5j4ymoZCGPq7taoT2CIBDv4E1wyT+IMYo=;
        b=G5NYyMrL/w30MxUmYv466EpptCrxNMvlnSVpVT+mXQMrVvxSUK+UKRI+tPXFXAL+92
         TkQs1GL5erH/bntbFBq1UH7x7YoXgbAT0ATVUTkBASoaPuhyDAk9L01MLjg1dYLKv5KS
         FjjUpbcENmZETX6kxE/AkhPA4K/6pi/LqM/xysj2rl/w93HEcofiSzOrIpedZcEkITkI
         Z2PKhfgwT5HX/PxMbCtg6UaV3p8P1R1mnUC4sya5YdkzamY2tldtK4teDsFNcuAfWvIa
         HbDuZaWP5EHeJCqHEw0vcT2Gqz6QRFl5paPzUd3q4homTYT82RKEvkv7UhQOf5SM4Eb2
         ePAg==
X-Forwarded-Encrypted: i=1; AJvYcCVQllZY/V8dB1dnrNz99PR86ohCp1hoLRc09tRgwV3SFWjdDLNZiU6mA01tRJtqU9uouxBQYg37AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkxF4rriEGh4cyVQC3S6hxiQI6qnFq9vNWPZMP7hFKM1EqxVr
	muAmJQOWKisx8n1JhgAoYbcL17G5QRYU8u6bQPioH06HAg+SWMkk9VNqHUPPfy7axADdVzRyTVJ
	skWzNIiHkUq1YBYTLgF6LpdZ7/wjxi8cZvwQcBpAJJV+9unI91K2NnVxEmwFxiQ==
X-Gm-Gg: AY/fxX6S7lSdSGFwaFAIz6pfkD/ocBJnp74oveNKyinn/hJ/r5zoV7Rzj1YRmyOmF5A
	4OqtkasQxAuwY030iqMAlckC+JlLjxr2r0SQwW6hPDKyAtup8dK1uGlzBKbEJIRyjymCxd+6wqn
	CQAbhNdGiriuDCPME0XQUPxhV3N9/FnZbnHNNiSI8Yn2amqWK1LlRzTf2XdWQGmGh6JOGPNRXLE
	thZdlPHpIgYVBn5M98JSJzCx/whZIx1RpZji1uUXNq9rZvEvF9On3sYmyJUEY+aCYOSNnUtsjH/
	UYcshFTO518qUFDHUg2caHnM6wuvTDBXjOIhC5Y2TXwRiycmk66kb8LzUcitk2dRUxXyn/a3Mc5
	5Rh7hvWxTFSqzy+y+kRSUAUZa+PS9cQmQ06Hf0OE=
X-Received: by 2002:a17:90b:2e0c:b0:341:8bda:d0ae with SMTP id 98e67ed59e1d1-34e921b7334mr11265916a91.20.1766493245305;
        Tue, 23 Dec 2025 04:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmARe1g9yVPcICt7ISPS0bRJWnT08CSFmpz4Q5i5kQ5jE9ilydr9U3/9m7HZC1Ilbfjl2WhA==
X-Received: by 2002:a17:90b:2e0c:b0:341:8bda:d0ae with SMTP id 98e67ed59e1d1-34e921b7334mr11265883a91.20.1766493244832;
        Tue, 23 Dec 2025 04:34:04 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b39dfsm12936044a91.8.2025.12.23.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:34:04 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v1 7/8] arm64: dts: qcom: Enable cdsp qmi tmd devices for kodiak
Date: Tue, 23 Dec 2025 18:02:26 +0530
Message-Id: <20251223123227.1317244-8-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwMiBTYWx0ZWRfX3APMPltRRaDw
 9h5h6yPWRtnT7tJFDD4/Q/CeqmARY+G+GRPKWVAIrQFgbYQFuD/gvK69LSwRA1wF8m1FErEQR9e
 HKClLaM5xQHiZoTt34WsEc6yEwHSGF69rnIlurrkeh/NjxoEAMJHNAhhGW8S4kSfas/+EOg4ia1
 GyKasYb0vGK456xrGJuFT35z6VhgvGIPIb4EikM3dlh0B5SMT3bW9KfEB6gB99ARxIwJdfv/8g+
 fIz7HMfOIF0XQBRFOfJaMWQ+YiJrnYQYvc985uWPFHzG45F3vILyFe/uWfDxgYnnV0tsfag2hS8
 tlewZaYiIEHCySClCSm4DqYTmjj4c9Esm51/tJUTvNIT+0OA++PzHxnciRjebio+Ydmc5YEbTlE
 xjv4lX7vIt9la+ZeD2pY1KQPP+jDMcW0ITaTb71b0zPJF04xvF6HFxw3XvdTSkzHuuVwk6K6tzp
 iYWWzp34d33vgUd4I7Q==
X-Authority-Analysis: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=694a8c3e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0nDfalMChL4Kl-YbaZgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: MeqrauVWZZFn5WSa_MsZDJ4gwR4YyW1y
X-Proofpoint-ORIG-GUID: MeqrauVWZZFn5WSa_MsZDJ4gwR4YyW1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230102

Enable cdsp cooling devices and cooling map bindings
for cdsp.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index c2ccbb67f800..03c1cef910a9 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -4780,6 +4780,14 @@ compute-cb@14 {
 					};
 				};
 			};
+
+			cooling {
+				compatible = "qcom,qmi-cooling-cdsp";
+					cdsp_sw: cdsp_sw {
+						label = "cdsp_sw";
+						#cooling-cells = <2>;
+					};
+			};
 		};
 
 		usb_1: usb@a600000 {
@@ -7587,12 +7595,26 @@ nspss0_alert0: trip-point0 {
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
+					cooling-device = <&cdsp_sw
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nspss1-thermal {
@@ -7605,12 +7627,26 @@ nspss1_alert0: trip-point0 {
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
+					cooling-device = <&cdsp_sw
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {
-- 
2.34.1


