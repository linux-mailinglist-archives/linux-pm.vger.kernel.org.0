Return-Path: <linux-pm+bounces-35096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7BB8C84A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4C8170677
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B282F2908;
	Sat, 20 Sep 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJuF/4PD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E62EB87F
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371814; cv=none; b=jduA6D0DPg8QJBaY69c4QyCOP83fSh/+qCqGmu/ui6Rbwn283vMZdouXPkPztLPoHXW/JwuspXenOGlrmMx7z0LRPf0JW9/5D+glb3PhA8W0myEvVTSYsplvzZYLhddiWlOFLfQP/pIv542c9xbkAerYWVzgpQxgKiaNq16m7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371814; c=relaxed/simple;
	bh=NlAyY6gwj3GgebzwwaWrY6Q6kn6D5Bsn1jK4HrmHOC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bDkrVGuoMZZQ/zhtCtB5fTfTZESwubtLTolNY75rAXi7sVH9Hj0M4asS3BoLS330m+CL/WVzcAhupuzdTncCyikLkeHXndy4xtjflP/0HRpaip0VwgtfCjaWHbas2EbffIlg19NaVIGEoLy1DvVAPfRHgHpOc8x5nx/n9eA1uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJuF/4PD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KAu5O9014610
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 12:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kQEsxxv9s/GhWRr7hiHaTvJE9W1ROnl+URj
	6ByZUdys=; b=VJuF/4PD18F/7WIjaN88QgYYik45597UonMuLRqhx29D+ZdW5Xv
	9u2rMCS0bi/iJYIrBQftBA+DGrMYviAN/PgsASh6O041JQ7OlWDo00Z3QjjSjHqy
	dAL6xl4C6SHiMWDFdqeazvSEUkB/G8QqQ3CrCeKmxKA32Wn4MN9RWBLI3KjjyTmY
	jlrMHgkhiStxPwpguJbQ9oX65mi7noXHNt/6vskAbwMaSpAEnVAQ1NDw5OtUqfPK
	+njqbmzuEIS1caUVDDLhI0r+SjwxO5nv8oLPpTHHJ0mFJWr5hmR1fSf1T4u1Epc/
	s6OP1tvt/ksly1O6O7tgeAkqUKeU+nm76qg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7srt4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 12:36:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77dff701fb8so1771603b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758371810; x=1758976610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQEsxxv9s/GhWRr7hiHaTvJE9W1ROnl+URj6ByZUdys=;
        b=fkQo0BOWPVZv1/6YDNLrcXN8l552thl9eYR50PSjYvIiAErTXidAcYXk4QNgIsEHce
         pkolijKxe7yPElF4Oa1m3Co/OqpCF7sq8XxHjLoMXXc/n7Yvsj/ucVWLz8FHzmXqUqmY
         iHDw3ltJJL10osGNMtSRC8JJ0GULcj4ZVPQ/DJnki0M6BEibCIllmYuFWVviC7pZDjCT
         kDf9WLlw3gcrL7LP9dnMb9l6s0wNF4+VYCOkW9WlbIzOZo/FuNzmebt/p4fe2r7B9iqL
         hU+wt6IIaOLPPjp/9HQJFH9v7pa2iy+k4i35fU1avZP/Qv5hn9a8Jbqb/QxhFh6VUGoG
         ZdCA==
X-Gm-Message-State: AOJu0YxRNh79ouhYyks1RbJsLsI0/efC8I1DAAJTVuc/a/NYy8qqeq+C
	KJSM+CLuud1GccnTuCbW/1khxKCZH/mhOU/pb2MCpa1TsfTHeK8T/Prp74xW0kCpqpRjNq7lgL3
	2sCYV08To7Jb/AYTrFE28QP3KH23uLUCLRiLc7uR5vpibtMq3/twOtfT8FuYUKA==
X-Gm-Gg: ASbGnctWqU5IMtwV40uEJ5JE+Oipi98BT00078UhB60rCjBbrXkOnKYvzn3c6p8OGrb
	k1Ub4heBKcu+bpiRerW3rnErQ6kF3nGn/bS45TqUbYGFnsjFtloFLsCsFOJ7w7InA1f7OnJVExD
	a9hjGRPyWzrHILaqPz73qnBnyc5X4Yb3dgv2v/MxjS1lfr1MXvDRG4rLeMQBHvyemc3oP9WoDVK
	E0WaW20JumyATDNURHiIOrnJMea9K8+J+u81SExCDXlrAs1xAmDk9hSbXUs+xl2aYd+Ge+j+esn
	NKEGS4cVYWtwLllwVVEnuGduZshf0AeuhTNbrlSIHkUzSOE7phaGYExfkTjKnZfe7keeV/tbxFS
	nLarc9ivscHSExgxAdbl1MGszqH5/Toq2fPRPE3HqKk2cmQR8ivH2GMLWLq4C
X-Received: by 2002:a05:6a00:1889:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-77e4d21fd65mr8295115b3a.12.1758371810337;
        Sat, 20 Sep 2025 05:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWzB5nkqqfDCZX9CuCLhkrbY8TKa9vwIXS5YrzuVH3x6awEHxf0i/Xsr/JFw/xJ+CoTCA+A==
X-Received: by 2002:a05:6a00:1889:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-77e4d21fd65mr8295094b3a.12.1758371809932;
        Sat, 20 Sep 2025 05:36:49 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1550f70asm2911274b3a.13.2025.09.20.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 05:36:49 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the Glymur temperature Sensor
Date: Sat, 20 Sep 2025 18:06:31 +0530
Message-Id: <20250920123631.281153-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX9ZiM/sdiQ08n
 1FL06C1e+2bLPlSpCKoBWlYYouKaz++p+YBCR2cwCf7F/rE09Usc6cUiIVDGdb3qTVcQ83STCCk
 2I7ezy3Pvqx1mxqwVNdcfLPsG9Ac6kqLn10fsx5DQuw3Zh/FrHDP4RCtwA0O7bKmFLtZfhSGE7M
 DDX4XrWV/frzkLKnuSJODC3X1qSnh/jZsPOsjDdekH51FWtq1sd62Ld7JXZ7egpPogIBNl09qTx
 saDsjBpgstZY8wBH76Fbq9UmrLqdMZEoIbQc5P8VPMh4LXu57aGBq8oPUAOT5G1REhsLpHMSNgc
 LMzEhWhzbmhUiyFpuvmYfVlzFqBqExhIcSV5CfVM/GH0H3zHGHGts0yZ0Y6t7NIb8mMET2wJQP3
 hkrvohXI
X-Proofpoint-ORIG-GUID: d7NRfvtGgANI1V6Y_Q5ZT5BaE7SGk7HB
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68ce9fe3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8GdNKlHnjaA04NifdkAA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: d7NRfvtGgANI1V6Y_Q5ZT5BaE7SGk7HB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>

Document the Temperature Sensor (TSENS) on Glymur Platform.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Changes in v2:
Fixed to sort entry in alphabetical order.

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f65dc829574c..78e2f6573b96 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,glymur-tsens
               - qcom,milos-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
-- 
2.34.1


