Return-Path: <linux-pm+bounces-31843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC3FB19AF4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3332B3B7DBF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9322541F;
	Mon,  4 Aug 2025 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyCviMyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6F21B9FC
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283989; cv=none; b=kRXBAjRN5k95kHorcRI6NhvpXMfTqWYj++SiMrIt9MbjOcBatTQWwPkLMf16XFwoRg7SVo05D+mHXVHUWbkkEyxYlJ9Tk1Iv+532ZazZhJl729YZNrXR80H3o3bCijOXu8A3R/+ns/7bqpjiJt7HSY7/xH4yBYrDz8VRthWJ78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283989; c=relaxed/simple;
	bh=Ul1dVZpeOTw7qaiph5ZpTsDcTs9gmOxaff1msl2kru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxQVI9SjHi3mIUwjaVZ7cFtMKLfF2odvwLqvAjsAfm/Icayhi35dQhrblCT6rLy0tG0wGIYNEkLKHvakzjGR0Rv8SE4qqG0pwdXnGti5EHGZq8yD1MA2KFEy9TBl8dZjoynV7we6s5pGKaC5q9BgNaxOCPoErHlnbYzG6A0hS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WyCviMyr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NoKmK029674
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 05:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rRAvA28iaBx
	d6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=; b=WyCviMyrpzJcpnJwG1Dnh468KUU
	/vrD70EZH6FbNpJl1zTo2P5Wl0kFHuqXOHwz3aKuaURfYB7cjUzrmiF6F8b7BKOi
	GmLLZrT3yNaGacOFWpDCKmM7uP+c5jM4jzDAh9jyPALubkhwPhwYjl1fO08m+kdm
	8sqYcQHZPtxD9cOobc0/yGM7Rgn5QBQbuOHQ8V4tNOKSStG6V5fXVCxLtEy++BTW
	lzd0J5eIHPkFLFpqi+0Hy7bwSEmapXkVas8RURDwu8a3ue+nuLCBKdYhP0H450MU
	dPGusjX2jcBboadQQbQsvm5JQmH6O/gJ2ZdAiH1bP33g76GHSF2U9DtGWYg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rkuk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:06:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2420cfdafcaso29605485ad.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 22:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283986; x=1754888786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRAvA28iaBxd6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=;
        b=cHYliELlnJOokGmri8baRyNkCNSbrHbdjviRZ8xV/EsJOZV55/pEDVmaQhB3+76rPC
         ZpmzbCvTceOJu1pq04NA7Plv0X89F2E7SaqYnLxHWMAbY3sRTUUeFqnptlf2MeocqJ0h
         O3mkfI6KDwqjNKZykscSwSsJu/oftcctki6dFrwSYI6MRuzVpMWGLgwSVXb4mQD8lKde
         tTu5udfrtnEsZdBWO1e6dm/EDk+jc1UfO27w8kYhhMHImOvOR2ez0KRRmBs+SbBJJv6+
         /mtrghIvVs8TkkCoX7zXr30LBwFZTw+kwuBp9nTb87xx52CR+uNBSLs93LsyZBO0PN3F
         oJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrbkb9FUjGNamXti6W3SUA3X5zxUD8X4KVZsi/ODkzP1qRGAifL/mKIYSEFQufWIOY1bRn/WmLEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAAB5jesnyHWQ439qD8mrVM0NFN51QnvSX/qpb5LwUhSrcwjd
	E4LHkuR5Pu719uhg1T/8/OFp4Zf/8tuFWEIzn92MRkAUBoyikDZPpglIeCwGQuj0rCXgR+kVRIj
	YO27QvrbhXZbW4jcGprlP1xrP2DwtM8UJapdYhjXTDYGU3P+VSXDZO467ht6ObA==
X-Gm-Gg: ASbGncsmq4R+ra9BYnxuhpa9ABbxMpNFi/MZFCIzTr5P2O0/TxeCFW63IZkNYEP/FcC
	fp8FGdnC0gtXbHItpxQ3DgEf075tLXe3i7McwiP7RruL1rmmXRcTPVGKDMACnEOwdo5VwQun2pe
	mqBaLFqAaOCT8Fu5p0f2Yx+LexVSpDZwg7QJIwpCnD/kBgcX38t9HfwajLWyugwpv9EIxQS+OWY
	jmIeONAJeWO/K5m+aP2WCWsakcqDy0SffwbqER9XoSZDVWCugWcyZ7oYrEiPfs8ODJwTE5sOdjW
	n7whtuNSFg/dbDWNtlMsdatUzjp3vDrcDfcO9JmzO9HqPSTIIn0fkhf+XdS+w4CVDu4TsrERXia
	nTeg=
X-Received: by 2002:a17:903:1a6f:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-24247356230mr131570155ad.53.1754283985538;
        Sun, 03 Aug 2025 22:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpOOQvlVH6nFPP8utCjukSMyzVv08HQLDEblBTCrRyhJpR4aqOo+5iN+aSbXqu4CeNn50Q2Q==
X-Received: by 2002:a17:903:1a6f:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-24247356230mr131569785ad.53.1754283985128;
        Sun, 03 Aug 2025 22:06:25 -0700 (PDT)
Received: from e0cec1fbb194.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm99705135ad.7.2025.08.03.22.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:06:24 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
Date: Mon,  4 Aug 2025 05:05:41 +0000
Message-ID: <20250804050542.100806-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rj_8BYuSbjGBtt8d4a_tm7732ZSk6CDV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNCBTYWx0ZWRfXzuVe2W9FNd9v
 6VRcZNsPsnqU5uCbYshISxkF5doFPn4Wj5DY9sC+aCu5vscNHRDJMtv7T71UFTsJMP7VJbbYOwt
 jQlsedQabWyrRZ2PoXZAxDdxOvaB57zfX0lRtkC2P5UtmzZ7zIRNjn3fYkAp2+eglhP7u+mLLU3
 KnznLgTvYKK9/MN4YJBAnnKj3AbAcpzMKsVZwLQltefffZ10XhyAiRo6Dyi/t3ULYHxGtxu/Zfj
 +jHBS/jtkIaiMn0AxTw54ywjYJ+oRnQJxJgDotMSJtVeW8cmZU6rQgAk4CduOamG/luhGXRzU0o
 ENZ0oU+RVjC4T+yPBxTwrz0b9zp/fGtQdA7AX+cSKp7pRqHEzVcMadYJ6fKiZxVpvkru66BQ6FX
 0N5NiP4SFk0zoVOfUa6l4/P+tmjNDnPmwArZsisT+v3Q6U1CBshuKUS2YrK0S+Kqr0eXiPO0
X-Proofpoint-GUID: rj_8BYuSbjGBtt8d4a_tm7732ZSk6CDV
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=68903fd3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040024

Add Operation State Manager (OSM) L3 interconnect provider binding for
QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
added a family-level compatible for SM8150 SoC. This shared fallback
compatible allows grouping of SoCs with similar hardware, reducing
the need to explicitly list each variant in the driver match table.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index ab5a921c3495..4b9b98fbe8f2 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -41,6 +41,11 @@ properties:
               - qcom,qcs8300-epss-l3
           - const: qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs615-osm-l3
+          - const: qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
 
   reg:
     maxItems: 1
-- 
2.43.0


