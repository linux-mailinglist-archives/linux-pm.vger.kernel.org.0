Return-Path: <linux-pm+bounces-17044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93319BDBA7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 02:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63284284C3F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8418C335;
	Wed,  6 Nov 2024 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bTk/8t2I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B11188920;
	Wed,  6 Nov 2024 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858177; cv=none; b=FIzG2Ng/U4BD7QxupN5X4M0fnloRaNkPmGh4alTM6ZkSQtwG2zCkS6O1DKcBvRlStf9I8FhNZkLmmCXYeHvlU48bunuTOxeZEdhtGx1Dr+BS7MDJOuJsacA5tCvphrBd5EmJztYpS4c8+Sphiaah3xoB1L4PDoOEfmWaNYKCQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858177; c=relaxed/simple;
	bh=NY+92kEJeKk4xiF2xOu7DDHnYOW5B0nb0P250FfBKVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y06Yzow04laFfIZFoUsJ8sj+rue0FIH0Rc20JCy2liEPlVw5BFHanNFPGzI7yQK6FFz2g/16tuOYQvqSrBVIZfF/IUK55sNt9IMZa1icTa/DjyI8J5Jsx1EQD0U3HtA194hjUyffF3d5uv3Jts8/QsjYuuRdNT2uc2bi5hjVmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bTk/8t2I; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A61CxcG019658;
	Tue, 5 Nov 2024 20:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=yyZbhqM+BRbGbWL7ZHz88qtD/dv
	9fCntA6Pa9Zb5XCY=; b=bTk/8t2IPHIEt28A4+dsvNjbb/Mc1AM3tFidd3UfIlt
	pZo3PASAEZGllKabfUiSpqZaJ/yjuLCUNFZ3f+MuY7eIqbeH4/A9IAkyOUL/ElD5
	KuQLgnHlKsNy9z9RQvCCRu5yrjzfnIdLma97Wi4JoGHBYLrvg3STGmfHEF2Q+pHh
	npQBqp/U1Isb/ADPE2eCd0+l0Gwep++TFWvHnrLOf5qQR5I461MuO3qq/M/Rbgsl
	f06WO7H/3GS6IXg5s6Anx6INmEh8Z/i+ntcuwrqqI8EuGmkuddnVHpEfoJL4eUm3
	Z7fbyn006MFuZKetiFiyuHt5YAvCPHckqlSMYnOZw6Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42qbq3500p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 20:55:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A61tueA040545
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 20:55:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 5 Nov 2024
 20:55:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 5 Nov 2024 20:55:56 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.23])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A61tgLX006618;
	Tue, 5 Nov 2024 20:55:45 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Wed, 6 Nov 2024 09:55:36 +0800
Message-ID: <20241106015537.6189-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ka07_7V91-UYgq43v0tLUeyKgB7BIqFz
X-Proofpoint-GUID: ka07_7V91-UYgq43v0tLUeyKgB7BIqFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060014

LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

- Add compatible entries for ltc4162-f/s and ltc4015
- Include datasheets for new devices

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V1 -> V2: Modified commit message describing differences between
          variants/devices.

 .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 29d536541..9b546150d 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -17,12 +17,18 @@ description: |
   panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
 
   Specifications about the charger can be found at:
+    https://www.analog.com/en/products/ltc4162-l.html
+    https://www.analog.com/en/products/ltc4162-f.html
     https://www.analog.com/en/products/ltc4162-s.html
+    https://www.analog.com/en/products/ltc4015.html
 
 properties:
   compatible:
     enum:
       - lltc,ltc4162-l
+      - lltc,ltc4162-f
+      - lltc,ltc4162-s
+      - lltc,ltc4015
 
   reg:
     maxItems: 1

base-commit: 83bce34420eaf91506957703bf9a31d8581ed6cb
-- 
2.34.1


