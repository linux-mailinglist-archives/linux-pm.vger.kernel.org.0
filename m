Return-Path: <linux-pm+bounces-41559-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KR4EBPieGkztwEAu9opvQ
	(envelope-from <linux-pm+bounces-41559-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:04:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BB975A5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64929302BE94
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2935F8B7;
	Tue, 27 Jan 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9l0BtHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tybqx73X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662F35FF47
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529495; cv=none; b=cS4UkEnYizUAnCD8yu/gG13z54NAYpjnTr/HPb5hIbgaEQr2mW2N7MGFoGyTVdJU8aoR9+wNrf5KsYk5nXFNQibwYrAAHd1/shu2a651XbmHYD12aC3kvWoRV2rvMIs0ZJid6IDAfNQZ0xnN3c54xdtlMBAXV5MRU9eAE05mQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529495; c=relaxed/simple;
	bh=imtITUMdGl12JmD9BqLF6obXBs2hrUtdLo4cmRhOnEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihgiF/hRgNdjRoPbcVhfu6lpCkBtpfEtfIW3FLkalu6KYyCxXYf0x78V64n6M2UJbcHzZjjKj45csMOl4PIl+H8a2zOXLIckpxzthk+ww+NOXbEZBwhmUEwh/aUA9xN0F33NKwmuGvP8NAOFgTDOvop/+BY586Cmzv0cBEUrhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9l0BtHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tybqx73X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RFIeRf2379239
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jK9v27e9BZ+Wwf8D2qBSh4rJOfb5MBzZq76RGHeZTQ4=; b=k9l0BtHs9jmTcDc9
	RLFbrXAwEEHxBkgqN7JkKr057KYnbVGev1dqezGf09ldL140BX4Ajiga5aHObGA2
	2lQ5Y3tDSOigOOFxrqLwj1v2X7J5vazuA2eWvLjEJX69inV6CLKduy2fUl9nzuRt
	hFoF8N+R1qEiIr8pGVfdvrZYT/+1Z6J8C/Hopoxc56/r3FjV5ilckkiT+qES3lKl
	4hluLEbtNjTgsU3RbKxC7riUSF3AUgusba/cel56sGGF6QmSq1jrLgBzxsIKnRdF
	27mR/Dvg8OiHh1S4YzO182pypC/bb1mTqmqhlUykIEZLXCo5GzFwD9yRwEYXM/3B
	RHx1Nw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr9hd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso6209725a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529491; x=1770134291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9v27e9BZ+Wwf8D2qBSh4rJOfb5MBzZq76RGHeZTQ4=;
        b=Tybqx73X4TXD0DlHGhIM+XBzdxmDrH0BxfN/y6aWbAuRkY4T4nodEgG/ywCgL/rdWF
         bXwUEaQc+iahHaQZ0mDlzKKk1bZxHQGxXDcc+7O38DRVO/eG0ye1ub8L8qxNq2T7G+I9
         ioZ4gh8Cc8eM1zbuSOHpiaSApWP4cRszIcdxX2jRy/GcMTkPVI1iWdDAs3sQo6xcDxvD
         WhdmNAP81hxreGDjK8UxjrBVWtxuZRjEj2ovFRQv6ceuJCnZXBoaafJGTTcfFZS5bM6I
         WqgTcmO2is6f+V2H5aUVgPvD0mcHKUTV76eBghEtCbso1o87dcRjDV4kYhbWDh9YlF7l
         p8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529491; x=1770134291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jK9v27e9BZ+Wwf8D2qBSh4rJOfb5MBzZq76RGHeZTQ4=;
        b=TbxjHBrzBTQl5tvlu83MIcSFsXPceqjdQwdrwegCRkENkv575AvslzS/WaThn8Jb56
         z8KHgx0NXFCmJFQU8MxBH/2B9L82CI2CE/A8GJN6sUsPljScvQS8FBH+6vAfZOhjGN8H
         wlAuRajWiQap1hKplRsUeJ7+Eau203xBBPcLYPa73Tnf2fV0cOAQlrDgqzF4mNo2rA7D
         J7sNn8/GkaYeAoQRT9TbeJlbiru7RfoJ6lY09so6m16U0DLFfysKCy/8Y4HhiMTi/MZp
         0mmHWas5sPRXysf0R+IAApcCJW9jr6yXbVIxfrd2OhgFhLsAnvocIshwrowU0li/DaN1
         MlqA==
X-Forwarded-Encrypted: i=1; AJvYcCV4GW8w9u9bdimfBbxRH8cNANYBZEbV4F3rcKj4N67rRaUXiJVraIYqLa3NJfzG1X2RofpXpqbrKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztQeuchrB8+hIRXcO61SIR5jHKAcvo36NhSD1oLGp6Q1rD+D+n
	rnV4O8dTPzJjDKUITW9UO2Po0Ium3Is6AiJeWCINW2BrxbMwow4j5T/OAtNnp7Y3RZk8CQVy+7E
	Pn/towgmyM0J5XtU11rUVQSUQ7B5YDA9TOZ8AKgDYt4F78FKdO9o9mI8/u8jDFGv7ZLia9Q==
X-Gm-Gg: AZuq6aLPoopjsH3SHnJrbAQRwWj6Dp+zmX1mBav6+w7Fp5QkZzFvuv5XMl1xVouUpkC
	vV0pNHuf1XSHBKAKHhFkhyPSIN913+bg3ThHQPB4NrtqwON1FQG9+h/+X98HNcdNRKyNvEpwFaQ
	m7/pVpvxZfVap1GI+oc3hHcFRbcuPetc0YcksyQCXYQ57qL9+Ve6cj12BlQZ0ArLq+pbYGg4KLc
	20kv21iSynl1VXvQCMyl8aNXsPtTrlhJVI1ksGNlX5LvGacs4a9W6641HbhtjURlIdbNhywpiKf
	7hTXERKJGSrgQt7LIyvnJucl4Itp8c1MlL8oDnbmjdP1GIIALqOQXWY5Y9yRHnTFVUQB5yboXrS
	cBo2ZN8gVzCdnU0++f43vTFcgCSlvHC/sCswY8S8=
X-Received: by 2002:a17:902:d490:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a87133729cmr17254655ad.22.1769529490793;
        Tue, 27 Jan 2026 07:58:10 -0800 (PST)
X-Received: by 2002:a17:902:d490:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a87133729cmr17254425ad.22.1769529490171;
        Tue, 27 Jan 2026 07:58:10 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:58:09 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 6/8] arm64: dts: qcom: talos: Enable CDSP cooling
Date: Tue, 27 Jan 2026 21:27:20 +0530
Message-Id: <20260127155722.2797783-7-gaurav.kohli@oss.qualcomm.com>
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
X-Proofpoint-GUID: IocoWjikTaMXmh6i9uwATS0JS5w60UW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfXyvP2yCsuX1/5
 wriVG4NMxv6i9TXiZqhtRdrZU494h9WDgZ87Hl/+eKrCSuNLHCratBrI+K+g/Yt4xkR1IE0r3Wn
 18nLjnJVWjhNtUnzzB1imPX9z6CCCr0bEHnVtIFxh0StEQRCSWOdA+3qhr/9WqvbHPYRrAWNvJP
 /7J6XRaCOJEsa9EoN5FNIIXClg/dO0hXMqCbhgwu+1V2LIAPZYB90f7mgfSsD6w3+X3j+p/lQxB
 55PQJkLm0SWnH1+p92dGxM5r7pObxl8zLj4McRFYLM8QGHNUCVRFjNfulw0gMz8zswhZOGdQrjA
 tGaGUOpqgAGM+52rMNEANfQ8DjAjMH85SE7iJY9K0snkwK52NUX35aZx4YAs0oAs7T6KdO6GoIo
 fFjSLyZJ2tN/oSpvj2NEbmfc2ZHWWeCD+b9ktn9mQcm0WArdHpQf6V/UWK4+VtibwIyxgrM+kFr
 tcb8oNZUkgraIKH7JUA==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978e093 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9S75qEfK-iFrpP9ttAoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: IocoWjikTaMXmh6i9uwATS0JS5w60UW8
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41559-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.6:email];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 946BB975A5
X-Rspamd-Action: no action

Unlike the CPU, the CDSP does not throttle its speed automatically when it
reaches high temperatures in Talos.

Set up CDSP cooling by throttling the CDSP when it reaches 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 75716b4a58d6..4091afd0b6e3 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -19,6 +19,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -3554,6 +3555,15 @@ compute-cb@6 {
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
 
 		pmu@90b6300 {
@@ -4845,12 +4855,26 @@ q6-hvx-thermal {
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				q6-hvx-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&q6_hvx_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		mdm-core-thermal {
-- 
2.34.1


