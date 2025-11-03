Return-Path: <linux-pm+bounces-37311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92527C2DA41
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 19:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74A1C4E4A5F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9C286D60;
	Mon,  3 Nov 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f67hquYf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBQaO6cs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F19239E9D
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194019; cv=none; b=jYM5W+1iyfDNF4ZTfPLQGFck/eJBf+cUZHDA/0HsBXCOD2yxTDseib3WFYrKkHyDQgPp3sGQ7QTCGlFmHMX7TED7FW+UjR+EKrvhqFhEiM8xChcr6t56iJ6avrvxEss7yMHiC1VoMYkAO1+YliM/zzKBoEl7KZr85wRRAgq6DwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194019; c=relaxed/simple;
	bh=jGSlDAGxynOHmJuhn2T1ac4wri0g8xzLXd69YnmiHTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h56nzjosvPzA7/TGv+2uOg4RnMTwDbbajVs1+NK95lBANOal+Jv20QXW5QSmPoQNnbTlSrBL1Cc6lGvO0TNvnakOPXn7i8krxjt+ZkvNgJkuahFTWt73LeFHURPreichf097jEqCU61noxWdD3Jw4+fvmrz4bniCxCPcnK/u448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f67hquYf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBQaO6cs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H42wR3667728
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 18:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BJnyRumSg0R
	XQ5jL6XQy8Cjcv8UyAXkVuVPdDNneIY8=; b=f67hquYfirQOjnGUZc05s1ufDV9
	HlYl7XMUJaF+6kadznjiT0bV+GUqeDuYNWZWbh0CTb0WRI6jk3ekqLFf3XtaMThg
	d3B3HVwfrTuDP3fBCRq9vdCcg5w24nLdKRdT2HWTIb9HmHqOAFxdGih5TALvs/Br
	YOe9FyN6/bn1royvoZ2Sl0Cxe6lARuhdGBQ6hDpsyroQId0vgNzELXNuT5NbDYH5
	oNT5xTWmSGxzogB9R1T1O3WEfqH265wJ5YVgR3iLkb5jkcz4RUh56lsLAPB0OSqY
	jXboFi0KQlPg6cNO236OEO/oGzlxx7NtNBbWhYc6FN7KGX2d+1CPExnYbmQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ffg7u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:20:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed240c3d93so46453671cf.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762194016; x=1762798816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJnyRumSg0RXQ5jL6XQy8Cjcv8UyAXkVuVPdDNneIY8=;
        b=IBQaO6cs+Sc/U9g++R/N1L4uO9gqLcljlvT1FegJW86zCe1Dl/7EJk/VUd+1njEXfE
         DmyZBhhs3+kyvTx8xBtDvoH/BlaDkdr1cScrBHdPhEQjc7ozoXd6dq4b08p5QEFYR9fj
         cNnveF0ftSuWHT7a2O1wkRw7gGjyXVFHOvEI69FlsIni9YTkbMhsornwrjdSi4qYvHfF
         1nAWx8ji7y5F4LO2hKOIyS7cNBwoTH40pYSDELb4MKatDGSmNCQilEP5K8C9KaKyVFeS
         ZDyDbLAT/MFnReD17rAtdYtmAC9z1b56NzjGgIsWHISiQmga9MER9LA0MMCLviCUgVlE
         QewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194016; x=1762798816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJnyRumSg0RXQ5jL6XQy8Cjcv8UyAXkVuVPdDNneIY8=;
        b=vce0jvYLjHlSE8tfgEU1hiH8WnX8m3TQC48+r+M3a1u0vrch7m2sl7lDCRHql5qQpm
         lxZXB1ZoqC7xzmxqGv+HAh+7h0xrcL/Hfz5KaXH+He2maQ9otrCYI4Eq5i56g4y0abkR
         CLuLeTvrhfZQWMyyqhXYa/DPdWveyxYlPW2/ZCY5u9ABtW6ZNRRq3oWgqZjOT3FrVChE
         OZBOf4NySt+ilyez2Gt1A8X8yXQ/yHP8mEwuyeWd/in3ZdcIIcZj9gKdRt8TtsytQVGX
         KzZSfCGCHyVQzL9ryWlphrVtHRwY54xYENlDylo2pGSSw1Cve8D8lvqw8HIsstbuzWG+
         1W5g==
X-Forwarded-Encrypted: i=1; AJvYcCXxkXJxlMee1pNdPWcdCICLjcIcdfyTlFRxFqN82Pyts66FJ7mDWq89iFIaUt8t8Ha+YSxMluth3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOo+sGkFrcRfASKWbQ7QwOTKpicXf3C/qCvd5U3IAsJ2Ng2q2/
	Q5b1kWI54CBVWgBIXwRoX7kVA/nvN3acGfc7CwMFaE8+bFS1hNXiCZbq9q2gL8mBY7+RoE6ZzmO
	pWbJG41pF+AKtXV+7Rqzt/x7Uie7SXJXPO1GKj+NYVlWkrZ5QzVJZNvdDJvg36Q==
X-Gm-Gg: ASbGncts/C4k0zn7D2o+G78Xk2WADjXeTQp2qEkptQG0rYdNrxy7ERtjPMQV6GBx4ez
	KwBC58xmv9iXsNa2h7qmZ63qTcytUTCMKNJ8pqbW8ASIBGhQZAsF7W/UdkGoK50VqsXMtWdB7o8
	ZIFDu+xanW9Qlmbo1EMOR/AIRSIIFhj71AHHhj+efy2CbkQTsX1ExozHFeOLXeaYsaefZ9Y8r/G
	dbKJEJ5q3DbEs3u6ZdHrd1sc6H6oea7L+bhpbN8W8IFpMeJ2FT/69xkvzVuf+XzxSwcmjSBsMGq
	BCJ6AJOG9223fLUXOC9iQRkwXHXx8TRgzTaoDSBdBRG7bM9Rv0hwxX2qIqn3UQ8WLM/HY9TT9qt
	9g6Smv2XhI0Qqj1iuDcAKCBiIwPAgyRxaGn+MNXAOmG2uAJSmqxZnCyH2hJTLiMchQw==
X-Received: by 2002:a05:622a:5c0c:b0:4e8:b56a:992e with SMTP id d75a77b69052e-4ed31079298mr192039791cf.59.1762194015851;
        Mon, 03 Nov 2025 10:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoptK7u0v6sAyMbPtU9mrRa1NJTRPDFdDvOuaz7ftNbENmIT08/ZU8ZOsevnKESRJoGRUfcQ==
X-Received: by 2002:a05:622a:5c0c:b0:4e8:b56a:992e with SMTP id d75a77b69052e-4ed31079298mr192039201cf.59.1762194015297;
        Mon, 03 Nov 2025 10:20:15 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:8842:5746:daeb:a8f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm169096545e9.11.2025.11.03.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:20:14 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 1/5] dt-bindings: power: reset: qcom-pon: Document qcom,warm-reset
Date: Mon,  3 Nov 2025 19:20:02 +0100
Message-Id: <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=6908f261 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: SSTT_72EKGfVzUQzQLwBWAdME96wIFfu
X-Proofpoint-ORIG-GUID: SSTT_72EKGfVzUQzQLwBWAdME96wIFfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NCBTYWx0ZWRfXxUKQvCZGR2wt
 fl8ightKFIUNAaSfMKZibn3jUUCqiDfCi4CUctPV34POlwcxQG48gAlKdhmbc73dSfAcrd/LOFi
 rsYpL5peXE6gWcL89nl34O5FKRRzeT4vdzABDJszvboU7sK6yGjdsVunQEYSu9YEG2UmggwMQBz
 p/2hfD6f9Gp2wYuVIPfI2bNbu83Nnhu/Nw9mCTghFlv8d8nI/kYnjEK7K7H6CukdIr5n5RkVseP
 OGXDaz3TfF8MU/WEVqH0+VY+Y9jFAifEK4m+i5Suq6TboqU+MliBlbeAYFcM9IugDMQ9cpqOHv4
 YCdlq+CA9yaoPHRPOK7o5eD/2d58RnEQZmuQkA3z2/XmZrqnEjP19ISyUH4oBVOQXttuDMlb+FJ
 ZYcQqqJmdMwW7zI/6v8arkg1eV5qkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030164

This property can be used as a fallback mechanism when a warm reset
cannot be achieved through the standard firmware interface (SCPI).

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 979a377cb4ff..ad8691c87f4f 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -38,6 +38,13 @@ properties:
     minItems: 1
     maxItems: 2
 
+  qcom,warm-reset:
+    description: |
+      The PON (Power-On) peripheral provides support for warm reset, which can
+      be used as a fallback mechanism when a warm reset cannot be achieved
+      through the standard firmware interface.
+    type: boolean
+
   pwrkey:
     type: object
     $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
-- 
2.34.1


