Return-Path: <linux-pm+bounces-35316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3CB9C801
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C7932020B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B12C08BD;
	Wed, 24 Sep 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Un/iHv9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2E2BE7B4
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755840; cv=none; b=roQ6nTZyj1HVIJFgg1Hnga6gfORNRPOwHqVwA/45rCe+8otgnhBl1zr+3Zg/YWA3pkruuLmsd2ujb6ZHLQO6xSfKQH3gLvQ4uoAqQsM+ujpkWZdujih1QsVjiXrP2nK+yv6FhvHnJy1SNa16Q7aFWjpQbt4Cfkl6duN7QU0xA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755840; c=relaxed/simple;
	bh=mE1+3CLovmhMxOumYf9eLxVXoXcka3cTkc4cvMTqs5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iT6D9U31FxgIfXIfPG5aEtxtO82Lw1jtA7w/89MT3cje4Cj7C4fA0kHcwKRJ7c17sOMa5Ld7EnHIV2SUVGHYBERxjSk9w7HzKKd6TyPbEWT6rBrMLn5r0NPn7z3t89Yy2J65qr0zqBSC0CFrE58596TdynRBXKrIoHkAIzs7BF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Un/iHv9q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD0Nfl025105
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fL1iTJl35+Y6wpcATqxUjntgyMB0y5qK/pwRJep+00g=; b=Un/iHv9qQJKOrxnK
	Yx3Dzp+WMw9TBH06ubyVHv1oSacsi1HPro/P+eDngszIuEjXfMkPbtYYA6ieWqdi
	/2fT34Rk6iKSZ4hTSR6rPmAW8s7Md/toANW+xiScNlBiN0f2DUI4ye8IU2Yzmrks
	Wef2bMDd/e8p/THLiAUKq8IRWjv2Y41xdfL4fzC4jwoK7oXvMBmqeQN+cB1lAynP
	W7my18yic9bd8txaeLu36ek6Uv8pLcMMGtV7x3eb8o6RnHJSsOI/G9LmzhQEa8sN
	VXEIw4w///M8ACEROXaABhUs1VwZhzo2LfWUu8XEpKZJxcnajJHOFUnle5ruYbCP
	9zrNYg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv161cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2699ed6d43dso3319995ad.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 16:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755836; x=1759360636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL1iTJl35+Y6wpcATqxUjntgyMB0y5qK/pwRJep+00g=;
        b=wStjZHxIOIUbwGWhQq8ObjxCfZ60vVSsxjuGqBhLXeH/FvTn041NhJZqYy7fkA5CHG
         XZOPcum1OTw6CH7gFTOXKA4rAYpCmMd+rH4Ut6PHNceSu7agpYp8sDTs+2D/zhWgzCV7
         5UuuWrKz5WZ2ngq8ygApkDn8LJMvKx5yPdm4rf1PnYbTeqaOXn52VF15WH2k+IfJaCCT
         7Xm52mXNnL/xx0ma7RMfvL289UdGRo2MWguEzTRNHrtNT2RxfN9L+hACI2sS1O/YvGpg
         Vro06IrzRv+0igdV/gYM0MkcP0FWEZFelHLZbzRsIoI6MK/Dk98gocH+/rYOW3jkDILM
         8HOw==
X-Forwarded-Encrypted: i=1; AJvYcCUbxc+Z0polVN3asNgFpU2MXTOAQ+qxcsRHuz1Zz4mC82mqc0N4hGCjESxTvmt9SZHOclg2K0e7Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcPjvICEirU/Hu3pYtlYF0AoxjA8IaMoy4ze/thmbegFniy7+
	bGxTbbYUTIi5htQecxv+2dCjbzyV5XWjvV5itfRgyLad+Hs+Xga1ONpR1KCHcwAnQe1JaNZGHDC
	aDHscIKihlrT1Q7w3wF/a5REK2Zn5k4Flv2TF/rWpvsu46+cwS3G/FRtvocIZvQ==
X-Gm-Gg: ASbGnctNgcozInjfjqjfVvnjC4q6YpfWsSBBD7yjw5VGbg07VdGZC0abo4NY2KyIbIM
	SttYQ85oqRKeOww6m5t2+btouwsdIp8ct83jzlHkF8m4aBDXsygYonf8X7qIgjMNDAQXj0SQqgC
	iRjtK6T40awYZeIJnY/h4Mm2MFkPHI0j5aBDugzwTph7nm9K4aV1EaFH93YFA3zCVEgTXqh7QVs
	mBcS2o31sudQ1mAK/XrWMczNs6nhlHHhPVyBMa7q7fBcIW+V3d6nlvGcaiZoGR9ZWWNcpiyB6kE
	h6HEDbKJxMYeUSx70Dmw7sWBlIJhNb4FkjJ48a8Z2RZyCwB0qjd9YJel3wPxxcEWIzAEAALPfGe
	Ds8qsDv45/WrL8Q4=
X-Received: by 2002:a17:903:19ec:b0:266:2e6b:f592 with SMTP id d9443c01a7336-27ed4a374a8mr16357835ad.25.1758755835984;
        Wed, 24 Sep 2025 16:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMT5fZm8NtIhfLw02WJm5zy2gw5isSV+jZJC2QoWnR3r1EDadpHa6RYWSYUdxzPv0//VQJJw==
X-Received: by 2002:a17:903:19ec:b0:266:2e6b:f592 with SMTP id d9443c01a7336-27ed4a374a8mr16357475ad.25.1758755835541;
        Wed, 24 Sep 2025 16:17:15 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm3892125ad.108.2025.09.24.16.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:17:15 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:07 -0700
Subject: [PATCH 2/3] dt-bindings: power: qcom,rpmpd: add new RPMH levels
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pd-v1-2-b78444125c91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755831; l=1196;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=7MsdLOhfuwnAQv9zjXruuy5kHSwIw5C2aX2uOydY54U=;
 b=9kH6KAMx5wPqYM08+ActayQIaqK6Yhb0nhOKmVwC9vY4C6sdJgxCJvnCDx8FBeuiI92p3Dvhu
 fOrb1DG0XhkARq01IVPf3oH2CnsDt8oqaMyo2MaKVLtfZdsZeY01Vra
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: HzJF4rwR7qiVayKCm9edsNm8MJGucdlc
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d47bfd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IiiVuqObk_426pyfg1cA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8ekHpyXcEP5s
 HkfBy5bcQkf9C4LeuUJlWmoTJ2pwk+Tx1WhUHJiSqmXe0y0BWMHHJuSrvI/LEZ6Lofq1oVEn5nv
 R4lWdvqOwwo0XxOAb9IyKMOUHpJ8uwTT9wgMgyvw7vB5qtpY8m9VLiRNZBdLaYC3m8vJOVIhIWP
 08lFtAoQSboyr7UXWg9VNnPnZ+bffZbhAa9EZoNmrPx1TPmrez/4mEcYarSEXcc1R6f2GOkeO7I
 TseVLMphilJpGq2euuEgreXSEPNWTtlxOwPxK/ZjKxzT8DvYZBn2MSVea1n0JiXoML9XpY1ZJ/w
 9TQKlYr+wN782oEJg6ku0CW5YetF9Fiu4Nz99DXGDYRmd3Fzunbx8Qy9LeogO2G37gQfNco9EZU
 obQnGG0o
X-Proofpoint-ORIG-GUID: HzJF4rwR7qiVayKCm9edsNm8MJGucdlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add constants for voltage levels: LOW_SVS_D2_1, LOW_SVS_D1_1 and
LOW_SVS_L0.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 73cceb88953f..50e7c886709d 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -33,11 +33,14 @@
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS		48
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2_1	51
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1_1	54
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
 #define RPMH_REGULATOR_LEVEL_LOW_SVS		64
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L0		76
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
 #define RPMH_REGULATOR_LEVEL_SVS		128

-- 
2.25.1


