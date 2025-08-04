Return-Path: <linux-pm+bounces-31851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E0B19B7A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E6A3BA882
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C922D7B6;
	Mon,  4 Aug 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMhmlB2d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240117A2EB
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288243; cv=none; b=i9tsqkQrcGO7tfZbMjMbOhh0YjeCyssMAqVlWRcaxDnEe4yUba2gE3V5RDWH8r1KKZ/vhH3Db1vsF8UXf6xRDrJy0AoZWNlDzknG0CCImQyO9Zu7bJmWv1eDmBx/Zp2Bd1r0tCm98PzwfjLoNAI95kUPrFDHyuCAkZOLizmUJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288243; c=relaxed/simple;
	bh=Ul1dVZpeOTw7qaiph5ZpTsDcTs9gmOxaff1msl2kru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNEsqX+Aoz6IsWm2iJ3mi1BBTjBMc71sjGlSU6ZrjSmqeZMCZlTOEkzj1FUslFiKnhCo9Z6CDi6svgnLoZ7bJvBVNJR2OFd5qsT5i8SejtG4H+hrj3WyU2ZX2SbkwhZ5raWc11+igK1m98N7908REJ7rVtPojVvO/no6IhZwCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMhmlB2d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573LqDYn023147
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 06:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rRAvA28iaBx
	d6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=; b=TMhmlB2d4RpZRRgxT6qcgLlR/jo
	XcnDWU8pBCeAPHCuZPZmm8Nmo0omDOLkkWsxKKD4ffauOpRG41AR8BdfHNCg4l1s
	LejBL8vCxw8gYarCR7mWjzkMjlNVdsnXEMORQFPTAkPFi9cCs5LHIyeTDkK+lxvb
	tftfuqd8GWEWYSPyXRhu04tdwZAPoja14hySckw+NrQh1HQvHt8/PQqIzCfaZVmu
	wozRckjGYGxVcT+bQRjhZvxutoGGR1nfTQRtJbAGAq4NB3iuinrlCRX6cHfRP4mE
	B6AvJCgkg9uiJtCArJozswQgNLPkHM6uNjVz7k1Hx6CNJ2kKx+m5c5Cr8ig==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwknvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 06:17:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4225ab1829so2052714a12.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 23:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288240; x=1754893040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRAvA28iaBxd6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=;
        b=CZKGiIrMjUzmk4hxTzq8dVvMerNqJ8VFdUEw3uFe3KlO1j76NOiXLVkegGRbHlZL8Z
         dx1OMLuTWAkqNkFROSvczWLiAhWHqnvojmwVvWpDJeDICB3HZXw9VoKkBJdQ05LO6EOp
         jWDK+JjF5rkJT+o0UALWPKjstmj4pOoNwGMYuOAf6vcodV0sbeXL0114Ydqrh0O5U7Dq
         t/pG79aoQFHPVc/gQMLonUNc5oEErh1tBbx6p+0aPPo5oJMU/Rl9gCOyy/JidOKvDj2x
         XVt8vk8jqUzz4cohTw8Gx1imPjKCjguRen+Y3ErphJPuQEsrslOVBL053ToWVHSJa+AS
         woyg==
X-Forwarded-Encrypted: i=1; AJvYcCU9rxvIZ1Wm+yhdZ/0zPkplLZ73/HERKSmmctxW4n3HktBoREZ0Z3mmFl3EZb843GRoqszhi8WEPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyaEH6NWj1dxBnCulz1n3VpT03o7+kCqMXC4663OTZmQ4+G+4
	KTpDzpDbbjoeAjwNUsnhO5kxRtRiUGZsKwgc8Z96Nfvubvq8JAIWlB89fGVMSwOhg0/dm3z7nIq
	oisyOOUTDntbUW5VYS3efkY+3oNh/s+dqzNa3E1oFCJiDkFIWwYy0CBX2hvmVQA==
X-Gm-Gg: ASbGnct9VAA0oINybqC4Id0K/QYPwNej0l4V+xJbdYsjGL/MRn5SFu7tMzfJEAbwyu/
	rewNKz9Odn7Ei1F6BiChmSFquY69GdqGvijSMkSfGy1XFajFlSS/l6JIa2V8ye79ndH5cGCH6cx
	Fe5wmEZrzZ+Kib+cPbC1Kx2VEzVjZXxNDnIm6QpSza9xir60AN6JpZlTrDJQD5kBMNYdwnUJIiN
	dinRG6bt6PDzWgfcpifixBFSR0UGcigB04OtPf1ZJoJLA1MrF4I4v/POnoAUlyze7Nojd9Gwddm
	fWiGK0pg/rjEiUkwVn3Ku/TECzbDmbXPVlJpNbGNT1vnhkrW8LQsmDsKobsX8ffGKCVEuLZh+qA
	JVeI=
X-Received: by 2002:a17:902:c9cd:b0:240:11cd:8502 with SMTP id d9443c01a7336-24246f6d417mr66434365ad.13.1754288239971;
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPsjILhMmkQQ5MzhT7odrk4V2L30VI99GVEotMyVKKWKnUCGcF2rjuDKjD5PhVgLM20IrGw==
X-Received: by 2002:a17:902:c9cd:b0:240:11cd:8502 with SMTP id d9443c01a7336-24246f6d417mr66434175ad.13.1754288239532;
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
Received: from a3fd830d25f9.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f08sm99786785ad.103.2025.08.03.23.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:17:19 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 1/2] dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
Date: Mon,  4 Aug 2025 06:15:35 +0000
Message-ID: <20250804061536.110-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMSBTYWx0ZWRfX/NoEyMJ+c+fQ
 yCD1c1T+aBRcyGNiCJFGF+p4EjSYwOEsI2r1TtblkSq0MlDj4X96fC8jAkUYhb+8kyjubRBn/ZX
 soVL6X7kK7K94KzVHJ/igu0jodNONWlssnZWlEOrNdAcRk/bYFse6q33UqOlegFnY88zquYzBFV
 8WkT2sLRAS/3PCCIhCpnHmeatLmiy0uVAj+C7gdr/gwXLoi0yuxfCy/QaovMDiH1OzE9IrS729/
 JAAYWpr5+495nTuBgE8+sfBfR170c/RkIrGB1Wr5nbOt2z7IpTNhlCQLX0Ez0WTenxxyR5El9vK
 QcgWezOZI3O6YGss0YPDLlJnaygCfDsfVw5kN3mEQ/xAuY9oz+xJwaSoCUzkl4mc2cCkJ2SLmOn
 cgio7s332eeAoumw45Ah9OKdG0c4Lq83JFicOuZlGMEuza5TyXGua1wpyj9mxfyeGslny6c/
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=68905071 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 6vUqgEwtwoPKFbQZHwS_VUxvRk4veXIU
X-Proofpoint-ORIG-GUID: 6vUqgEwtwoPKFbQZHwS_VUxvRk4veXIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040031

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


