Return-Path: <linux-pm+bounces-35317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65243B9C80D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136D217800F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7392C21E8;
	Wed, 24 Sep 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gDQjWe/e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BF2C0286
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755841; cv=none; b=OEBu6arnIwUip1Gd0jC8zJc0+5BtpjR4kb4gDUpWrQ4yFhBICb2SfJdXBu75XKx0+07Uh1ew2/3zduhiNqhYd1UjdIxxrIISTv/HhSbp4Kva2RDZsYxkLXqL5hs6EuWeRQbUJOfxA/xRBDqfkcGEvCsB4V/mBhNCSh8MZOFYiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755841; c=relaxed/simple;
	bh=Gof4pKeTlVAfV4FxLQb9dzAHN3tcbZ7WLBE3vor4mPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWDUzmsmoXs9lvlQHXGXj1UKt8fdaL3ZCc9iH+vquApqnY7lNlOvS4u+n+DerKwBax0BXj57u2xDXm/lvD0LORiolH7h3ztqPgK1ON0i5G8yGY5V+KKlnoiJUo6AdX/bdXU3sX/DyTMuDPd5XMk2s8Z1YlB9b990gUdS786P0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gDQjWe/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODCtJm002152
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CCS9tU60/YFF8M8i7W5MAb37OoGC+vKy4CyRgEo2uag=; b=gDQjWe/eLiBGFUie
	qmYpRs+ivyfrr25ymn7T/pAptNSqRGV4rQkoXLs4q4rrrDXjQg9EYzDxWEuZfS/X
	iHja9Dy2JOarjNjoS++xYZ2LNOulh3i+EpRBphppasu2wIjmBZLeVuUFMEcdK8w2
	C07Zw8OHxylFDU57GdTmKbsVDyQugTf7bDFi+T278LDR9UKjBCk8v0sIE1ZEI5fz
	bUldHw6/S1c078WmyUyz4FXWzbSLD4VL+5zoKAHly23vpxvjyIGznPUz0RT/o7F/
	ux5/3EnEpQRYsITduDkk4D8awiOW1LPDks8I18JSLWDygO8KJmFQa9G9zv772EfO
	dLxt/A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p0yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55118e2d01so212110a12.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 16:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755837; x=1759360637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCS9tU60/YFF8M8i7W5MAb37OoGC+vKy4CyRgEo2uag=;
        b=wzWCJ4LMyWUCLLvLggZlTz/Sl+FX5puvFkxoDaN+vyj314eFw9B2zm0pqXEBLX0K+D
         jkOit9UsqMPV4vh1DIkXTLWB5LEr05RxGPpdEYmgQ+2lLifo+Nc3i1HIN47vT0yfIbDk
         XQLhzU+buQfb5yG7PXaQW0RL+FIclzLie2DrMo+DGkGt8tRQq1zZg6OEw2O4mALiTMDB
         n4msDrqjH6z7cIvsJJxLgEphnQi7cznTJiBDiREVOtMHhIoUcEM+j6zdMzZlzrMGyQCU
         +A7evRtCvjt2q1tJjYsF6LsYrlBF31HW35Qf6X9Eb3d8VaKZZoEV7VRP68mPj4tNTcv1
         4DaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwrrljHUnFNvV3nL5Sj2EfsXQqBUoDEU8BoOy4HN+rKknJlxE19fK1bsSEWKRhZNR67SetyIYyDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSq2zTNFOa36Eg2STZ5CHrnPfnIrkwLyU1jQvaovOqVs/FQJN
	VxMds4m9qAY5tXoF8fL169iTwmnDcERnCOJz1pcALbe+18vBsNuo7bE9HN3YkfKi3UgWVkzO4Gu
	14hAOi8m3caTzKSmjct+Sx1k6udflr679jM0izeY4JRI0DAdFLoQ0cvAck24Hiw==
X-Gm-Gg: ASbGncsGBE5c5+yjQy02wZgCwf0DKPnBPltTmHZhPqMYOzSuGPBAkSUCoPk9RL5N3Up
	Ns9qm36WvmJlyTHJFNjk26kHNttISkX1Atfd7vciDSDIzJGVZk6t3PWo3CHqKignTWpvvHFjttF
	GgHXpxcpphOk0rHWkboLBFxk1E/MT/Q0V/QkGMo2arDy+r/tM2Fn2yCVFZmSdx2p52vLy7yuNyU
	TYZx+CK4STgypcu6Mcfwt7AGgQXeUAfesd69ka6ZoyL6puK+H4MJkrZGg5O78K3WwB7EtbsedT1
	qTd2TKuI4Ov05r/wZ2HG9SDRAAPuBYoz4kMFzQ2ZCcbBAdC14ZycJTCL/LkMKImlQuzbm4JdYij
	hxdcOhabk1H5h6xQ=
X-Received: by 2002:a17:903:3bad:b0:250:1c22:e78 with SMTP id d9443c01a7336-27ed4a09192mr16009645ad.1.1758755837289;
        Wed, 24 Sep 2025 16:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8RNAE0dK78ZIUhrtpS8noaRXHuZuj/3uciNFcs6W93z8jq8mpZU26oSG9p/RkrT9v/zQzXA==
X-Received: by 2002:a17:903:3bad:b0:250:1c22:e78 with SMTP id d9443c01a7336-27ed4a09192mr16009385ad.1.1758755836839;
        Wed, 24 Sep 2025 16:17:16 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm3892125ad.108.2025.09.24.16.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:17:16 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:08 -0700
Subject: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add RPMh power domain support
 for Kaanapali
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755831; l=2289;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=J/5I59el++Ih5Gq5braSoVsViqw3EJxsHP0Nl/fg2GQ=;
 b=KyHs9h7fzlCc93gEReqzSlaeEsjVk5rIp9T89Kpw6/LXxia2noXXaLRBdJ5ZgU0yAmhcNcHAe
 gFgv4IwnmAIATyjXhI4aI4xfpRDz4x2NdiF1d8eibluUMVzgq/OJltv
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: mrBoMiqINQi07R2qpFWi2wXhyVbNWTBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX7jm4DAg0gy9R
 AMwyoQuUlkLFLopFKr0/FhZh3TFEfpcKB8RMQk1KZbEOwCU/OoGVMyvCCWMsDsNcQwucHevA3PE
 wb9I28KkRLODa1E4pFvJn2SKt3lA6kcs0mJTZarO5LRWiwtLg4LDIpkHx5fWmLG03LxDEu9DfGt
 yXqkd2JBUACmE3wIqdiNVEYLLdwsFbhErJzyvOF60h2tiW10HolMPV/vo3HJfBtXxHsq/Ia4dI5
 Tiaijngs09ci402EGVkosRWuhmvkAC/Xl69lW0V+/lWz7ROtajwpa1GmSSU5Lj8WIYX6ssgVWlu
 5yMzXgb6QksKrA/6LZ65qCkesDJW3heFqHgqslxJntTjQG8QKfhaKIWvWwB4WMIeCsw4shEEivC
 H/609lOq
X-Proofpoint-ORIG-GUID: mrBoMiqINQi07R2qpFWi2wXhyVbNWTBr
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d47bfe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Xp9dVAycJPogQ6Zm-Q8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add the RPMh power domains present in Kaanapali SoCs. Also increase the
maximum allowed number of levels for ARC resources from 16 to 32, as
needed starting on the Kaanapali SoC where the ARC vote registers have been
expanded from 4 to 5 bits.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 4faa8a256186..a8b37037c6fe 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -19,7 +19,7 @@
 
 #define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
 
-#define RPMH_ARC_MAX_LEVELS	16
+#define RPMH_ARC_MAX_LEVELS	32
 
 /**
  * struct rpmhpd - top level RPMh power domain resource data structure
@@ -595,6 +595,31 @@ static const struct rpmhpd_desc sm8750_desc = {
 	.num_pds = ARRAY_SIZE(sm8750_rpmhpds),
 };
 
+/* KAANAPALI RPMH powerdomains */
+static struct rpmhpd *kaanapali_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+};
+
+static const struct rpmhpd_desc kaanapali_desc = {
+	.rpmhpds = kaanapali_rpmhpds,
+	.num_pds = ARRAY_SIZE(kaanapali_rpmhpds),
+};
+
 /* QDU1000/QRU1000 RPMH powerdomains */
 static struct rpmhpd *qdu1000_rpmhpds[] = {
 	[QDU1000_CX] = &cx,
@@ -767,6 +792,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
+	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
 	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },

-- 
2.25.1


