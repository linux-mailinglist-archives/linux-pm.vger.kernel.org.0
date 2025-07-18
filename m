Return-Path: <linux-pm+bounces-31066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15CB0A83A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB735A33E4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A82E6D21;
	Fri, 18 Jul 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQTN3Eu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A92E62AE
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855243; cv=none; b=I9Y+skLQmjj51hlx93WY0SMqobIKJ/cj6bVXnsfdoDtIQPKzB7S5sIB0otekGF3pdxp1hqfAxFs1IaGMayB48fA7mXI5XOay3/HLYOAefXzAL3J1TxvaufTjVp/fsjW3CfTa8Ob4SFFeLtqxTjcCb8DA7EjJcDJMAV+It3n7OcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855243; c=relaxed/simple;
	bh=gmfr46OFYmUccWZSBc7IaVgajR2Vt394m5Ncm1zzRZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXTxII1YXtGK3H9URJN07VbvfZ4YHvugYkMTAQYnXr3NKDoLIJW8XWPBCdXR1GYeErfqiBxfXvZ7MFXNY30Ta7PBzgyMgrp+sil+fP+7135IhJdjCnaGICvD5DgoCP83BScUy/8GPhU5jj//PvRvKpYC05fLLQDFNgUnPdNVb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LQTN3Eu4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IF1RgA022444
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GyGX0yCNyB/fJpepU8CmcL0R5Xf5NuixqQQS52Ar6fE=; b=LQTN3Eu4FoyTKj3e
	pR5PMtaGCqha8gKjJVV/Gwwk9cnsGI5dLZPpSDaQPLi0Vhoh3lHiVZd6uhKybHOu
	qT7iVSelDoOi9gUzEgfLH8liFZFv2tyZGrDA7G0sorhDVM5u5ea2I8mfXcj40/42
	0eaLlMFGev+oyslpBUESeUV9n4JtQL3N8+1CmTUoJnbjKioDo0Pldl3w+RPyvLOU
	Kt211uds2/+zEvs+4LpjTv2nMgcu/ilWVoWkcx4vkcjly6Xo2NHDX8uanHvAZkLE
	Wl/asb6LFk0Uk8XkTBX5mB31VX/id5rJBwfP0gFlU96fnXs9yDuVtRC3EURfJsbB
	Jc5WBQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyc7hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:14:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7ceb5b5140eso372684285a.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855240; x=1753460040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyGX0yCNyB/fJpepU8CmcL0R5Xf5NuixqQQS52Ar6fE=;
        b=BWQTyTLQ4fXXBbO3juTydVBgA8K4/S11neJNZhfh38D+SNLr+qVcWLTu6lcab4ltct
         IzBc1Gf1gS7c+8tLzWoqhgThXVsPdmKcvWQN5BWYLpmXRG6wUi/oz3l9bg9yYS4uzkg7
         zO6N3fgWm/v0lq4/S3zmV5MFBNVSRX96erTVVukbpFqxdyR4cfuJr2lUFK40KCDxXNlV
         5thk1wReLjwrVR7+GZyIGATxgQB7rza07X5k2iNr4lwO0XGmlP2respQ1Og8azmHr9hW
         mlaoM7OXRKBqWmVkyA3U72tm3n8vV+rC/KQ9PXN5f83466gNx/l6IulgySINoZQq7M75
         ajOA==
X-Forwarded-Encrypted: i=1; AJvYcCWcEushcJhLxWvJor0R38ysV25f8Ly5ENDyF3DIU5Pydvx8Fp+uocKJUu0ChJHXuVthr2V4NPp6fA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BsvQRFyyKJ+nWkerZ2ldEsFJxLfRP9oCbMwPl8NHbfT3ecD4
	DeDuPsLLlW2A5JvkRIcKI2ithEU2RiNgWwtb81KrdBd3aQHX7+uR23gjIxclPC3w7cL+w4cNlFP
	Z8KlrjlNIrN3wAlJ6mtO8tZU9lkMkEYvUqLDyu8fP6HRoPeEHvdfHaX0yDe7/fQ==
X-Gm-Gg: ASbGncv3JhiCyB1qaPNFoVqAvdGbml4mEvXswr7BA1kM13D8nSA0tMITpJtdRchK8Bz
	eWXr5fWnEQg68VJiWTBLGcB0V9sF4+/Q+sTmEOhbUyqeEYktnvaHG8W81DRGHtW9g3knlCdErea
	R0R2yFRFW+bwzXaAl8dYR3Ukd19ay7yVifE+38ZcfkK1IeKh6wrF3DDzmI6P4phQnjwqDOT7r0N
	fs/ZC77In6CNY3dbsvb+iFRa5KN0Wi2lUISTr3tTCy5ZezpsRo8N2rwOFEcfeFwCgSWhfOz8vgK
	0FFO71rgr3HKxAaqQY4HG7PIFj8tOpVBvRhQDbwdl+0SbEW50bcIDk6CCzRoyztntJW04BnkbYf
	PSXDMUVF3hws5h0yI4gvfdfwMrYKj3ThHINoo6P2N6UnrzLNreVa4
X-Received: by 2002:a05:620a:4111:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7e342b9c9d9mr1695739985a.58.1752855239583;
        Fri, 18 Jul 2025 09:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF5+LPdchdvDPtfa1f7zPMhgf1TwpIBYaXASh9HQnX2GtnD+tloD0jFjFD+zpI1ErW5YaIgg==
X-Received: by 2002:a05:620a:4111:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7e342b9c9d9mr1695731985a.58.1752855238785;
        Fri, 18 Jul 2025 09:13:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:46 +0300
Subject: [PATCH DO NOT MERGE 8/8] dt-bindings: power: qcom,rpmhpd: drop
 duplicate defines
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-8-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gmfr46OFYmUccWZSBc7IaVgajR2Vt394m5Ncm1zzRZI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK4Ky2laV+OIQFpLhQXvV3YcdhKqF4v3szYM
 L9s+c2reICJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpyuAAKCRCLPIo+Aiko
 1TFkB/9zASb2ttqh4bUFeLr7tB6UPx+zGOKm5Ru0OqSNEZ4peWOE+CyEuXuLPlrnvrfqaSBc9Xy
 UKYbqiqaYolNJ6zGX6WYpRw5Il73+W1GbOG7remVMF0EcnsLxEWZ1NnS/mcYJ8ayu9C2ZlEdc6S
 B98tNfPuHTmNR98CKd9AceXSoztM3VTaGTKQ0OvBbdrFt+hLg/IaE/+GtrZFfTw624cGDyMH6Vj
 qzjpibaFgupAuzA1ZmtudzlnszBzvkA7/7PPVLdBmCdeNbJ5Zx1Q5VGbh3BgVD7OR7fbjiS4GfO
 BDKDeHj1ZRpF6mEaVuZg+6HydBzIFpSMy/IVMqgnrAZM9h/j
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX0prtHDCm8WdH
 D7QzPQEQhr5T4WgucBwiItK4tsJHMJOJOjXSV3BfyhQ7jBZOI6Ue7hafDReNpS1HKuYcjZf041B
 lFx5LTPeAbr+g51kzQ2bUNQt5GTJvu77GvvGo8J6j4NCLyI0t0I8vxSfn9AHmSIx/3itHBWrLhj
 yUCmj6CG9ejuO1FTfpRmw1aA8T+DKg+6qg9zmY3KUKRVwFXkFgZTd/0lxdwTdTRgntNtMoSNZvK
 rGiLi9JWgPiTzpNfkaQOxOhllAeT9d+3NLrffhyt4YFeLzUhzviN1ivdOhK49tWJQGq4WGb7TbL
 S4dPFOve7UF+tySfB2bhNDKydQmozaCX4VYWvI3H9n+dKj5LwimFh1lCPlCq1zwzclJKX8h2Lu9
 Nwdkk8SksBpfFN+DAMAbFNguLsTCtOW2ziPP2Ej7TR1Eh8ums84p0R80+bM/o8arEOMXBffr
X-Proofpoint-GUID: kzNRJo7xPBpzHCgf1Zz0Gg6Vg8m1Ok2L
X-Proofpoint-ORIG-GUID: kzNRJo7xPBpzHCgf1Zz0Gg6Vg8m1Ok2L
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a72c9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ucwj6ZyNMwC4X40j0pUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=548 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180126

In order to prevent further confusion, drop SoC-specific defines for
power domain indices for platforms which were converted to use
RPMHPD_foo indices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 58 ---------------------------------
 1 file changed, 58 deletions(-)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 73cceb88953f705106486b7e111b3ffc39c85664..ccf47b4670d905b166a9a39badc3535c8f9a05bf 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -146,64 +146,6 @@
 #define SA8155P_MX	SM8150_MX
 #define SA8155P_MX_AO	SM8150_MX_AO
 
-/* SM8250 Power Domain Indexes */
-#define SM8250_CX	0
-#define SM8250_CX_AO	1
-#define SM8250_EBI	2
-#define SM8250_GFX	3
-#define SM8250_LCX	4
-#define SM8250_LMX	5
-#define SM8250_MMCX	6
-#define SM8250_MMCX_AO	7
-#define SM8250_MX	8
-#define SM8250_MX_AO	9
-
-/* SM8350 Power Domain Indexes */
-#define SM8350_CX	0
-#define SM8350_CX_AO	1
-#define SM8350_EBI	2
-#define SM8350_GFX	3
-#define SM8350_LCX	4
-#define SM8350_LMX	5
-#define SM8350_MMCX	6
-#define SM8350_MMCX_AO	7
-#define SM8350_MX	8
-#define SM8350_MX_AO	9
-#define SM8350_MXC	10
-#define SM8350_MXC_AO	11
-#define SM8350_MSS	12
-
-/* SM8450 Power Domain Indexes */
-#define SM8450_CX	0
-#define SM8450_CX_AO	1
-#define SM8450_EBI	2
-#define SM8450_GFX	3
-#define SM8450_LCX	4
-#define SM8450_LMX	5
-#define SM8450_MMCX	6
-#define SM8450_MMCX_AO	7
-#define SM8450_MX	8
-#define SM8450_MX_AO	9
-#define SM8450_MXC	10
-#define SM8450_MXC_AO	11
-#define SM8450_MSS	12
-
-/* SM8550 Power Domain Indexes */
-#define SM8550_CX	0
-#define SM8550_CX_AO	1
-#define SM8550_EBI	2
-#define SM8550_GFX	3
-#define SM8550_LCX	4
-#define SM8550_LMX	5
-#define SM8550_MMCX	6
-#define SM8550_MMCX_AO	7
-#define SM8550_MX	8
-#define SM8550_MX_AO	9
-#define SM8550_MXC	10
-#define SM8550_MXC_AO	11
-#define SM8550_MSS	12
-#define SM8550_NSP	13
-
 /* QDU1000/QRU1000 Power Domain Indexes */
 #define QDU1000_EBI	0
 #define QDU1000_MSS	1

-- 
2.39.5


