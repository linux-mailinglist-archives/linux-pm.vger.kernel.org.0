Return-Path: <linux-pm+bounces-17736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C19D1EC4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 04:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F4CB22524
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26113D29A;
	Tue, 19 Nov 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="o1X66wiF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F01EA90;
	Tue, 19 Nov 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986624; cv=none; b=ryu7Gknrs94ZL/CvEpGGI8kE1twCcwZzoClb+IhZuks9BoGJcEDYW5Lv0dwZXmdE2jqZmd9ZukEVUdd639EdhERMDRrdVGqU9ndVH7eBPCSyacIIHgUz4v6z7OmAfF/TixVh+UUPJG8xYiIalc3AYoh05R6KJdM24IFlMMRuOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986624; c=relaxed/simple;
	bh=GFlGqjY/VVJjjiO67xTLvF1XwRG9gVfrJqEaFYrmed0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WeBQl6mQn/RtpxZmBekIizHgWd/CzEXZkGqLBuNKfETCObAPJgaK8OyFSluWYlrk9fxqDTt8TajA05TinOMbHnFBU+p/eKbqZtCA4lskmMv2GJFcSMDmlH+5vx3jbdw1wDRKN9raUH54CqKzm9Ni6NxN2FxzTZ1Si1GgasXIwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=o1X66wiF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ28h2O020206;
	Mon, 18 Nov 2024 22:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=B7VVwe09JJvSKovEhmCTdIJ+zaE
	ZO8DHn8K93fIRW5k=; b=o1X66wiF6CZbkcQSbsIJwqYJF42IJt9/dZ01S4T4CMz
	WRYi45n6K2Nsnud4BOyFCQ8ycdGnUmmimUWsJTNGmFOD4Q3CXqd+quEvCcoUvLMj
	Az9WFpOMyWUT8rjboX6WqUlbcvsEiDb2HHMmK3ZdXyrmI/mU7njUDHXc1IURDMAd
	Ucw5lzGEZu2klApHwuAtNHjw08/bGtNVrOPhRv2T8Z5MrX/y/idPB3UjpY1HSi9x
	hFdYVjSiJYn7Q+GrfmLpSEHm7YoM9rKIv19yd1emPhoACAjUjy2KUUSYI9P2OM15
	1QFNKHKH1I3MvoU0elQs9AVgOAcTWz7O+7EOoYBH4EA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43025m4ahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 22:23:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AJ3NXT5039435
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 22:23:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 18 Nov
 2024 22:23:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 18 Nov 2024 22:23:33 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AJ3NJqV002613;
	Mon, 18 Nov 2024 22:23:22 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
Subject: [PATCH v3 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Tue, 19 Nov 2024 11:23:03 +0800
Message-ID: <20241119032304.23588-1-kimseer.paller@analog.com>
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
X-Proofpoint-GUID: f4ZXAkHp-GSBeAoaa0DskMkFTS0gJuT-
X-Proofpoint-ORIG-GUID: f4ZXAkHp-GSBeAoaa0DskMkFTS0gJuT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190027

Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
They share a common set of registers. The only differences lie in the
resolution value of the scaling factor for battery voltage and battery
current measurement, input voltage, and input current for different
battery chemistries. The differences also include the calculation of
setting and getting the actual voltage applied to the charge voltage,
as well as getting the die temperature.

This add compatible entries for ltc4162-f/s and ltc4015 and include
datasheets for new devices.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V2 -> V3: Described differences in the programming model between variants/devices.
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

base-commit: 05d9044177c3e910921522e0209640d3b825a6ae
-- 
2.34.1


