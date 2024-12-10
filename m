Return-Path: <linux-pm+bounces-18886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31709EA87D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 07:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C49816A185
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D02322ACF7;
	Tue, 10 Dec 2024 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gQwDSobN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7122ACF0;
	Tue, 10 Dec 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810749; cv=none; b=bavnIqSPxmIgFqTUxDkpu70RwkhU3u5OMJYLXPY87Te7V13TclESNlJuvTWgT3MzCItLwjI5+a/cdyyIaBHTUNQO3sQGgMhLVQuTzMWp5NbWBTErYxj4BGTB+D31Lep/t38qbfKZDwRx9dlYRHmhBjlx3Huht1W+5RNXWGGNRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810749; c=relaxed/simple;
	bh=lYaaF6/Nbje1jbs9RzZeIcP3YuUKlidMuSupDhem9yY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euueTn+gQmsFlEUKCTumgZ0X9xIRz9DoeGVyhoW8zTTuSv7hk93R0Dd6kiDDyovSvbErJ2VVZiTjYxu/8BVae9pRTY8WLP+DuPmaeGt8zw7H42ki5xP87N1BlVl3M3nzCQfpfcbOWYNAFkXAU5CrUCCI7d5XnRvkvPZkvurZ+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gQwDSobN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA3VN1p004059;
	Tue, 10 Dec 2024 01:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=j+/DCYUotuoy59RhEa5Db2Zezd9
	cN/SGzppFf3IZ36o=; b=gQwDSobNgKlWD3LpVgLBUzDN0KVf9a39TA57syy7D1z
	DM74wuxpZ9+f1IlRjv4bU5usJJlzEfCg/GgB8QCO6FExaCD3RMrwr5FMBsSR4QMJ
	mPQRbaJ+18gnXve/5UygakE684pRogoR36N4PQumm1fQGu3gj4DMMj2ral2qwoBL
	YO1wz6g8S8E37ounXk+6nKM5RDpQ8BEhkjUv0wnpo6jpcyGa9VSmRfoBiZ4IJTEd
	s7bRjbXQ2Y0CVZSKa4e3YnwloQjLe2HhsoIlnLoHYX7+BsymxXY4O1ooqvPHgIc/
	8vQN+20vkTagFqyZW+ieAIIvhY2W9lWRGXcGETR40bg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43e61xtuhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 01:05:40 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BA65Uls025072
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 01:05:30 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 10 Dec 2024 01:05:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 10 Dec 2024 01:05:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 10 Dec 2024 01:05:30 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.29])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BA65HxA004636;
	Tue, 10 Dec 2024 01:05:20 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
Date: Tue, 10 Dec 2024 14:05:05 +0800
Message-ID: <20241210060506.10295-1-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: SBHUNhZZYp1Wjf9ujDBq6_t-DZhNCVvZ
X-Proofpoint-GUID: SBHUNhZZYp1Wjf9ujDBq6_t-DZhNCVvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100045

Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
They share a common set of registers. The only differences lie in the
resolution value of the scaling factor for battery voltage and battery
current measurement, input voltage, and input current for different
battery chemistries. The differences also include the calculation of
setting and getting the actual voltage applied to the charge voltage,
as well as getting the die temperature.

This add compatible entries for ltc4162-f/s and ltc4015 and include
datasheets for new devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V4 -> V5: Add Acked-by tag from Krzysztof Kozlowski.
V3 -> V4: Arranged the compatible entries in alphabetical order.
V2 -> V3: Described differences in the programming model between variants/devices.
V1 -> V2: Modified commit message describing differences between
          variants/devices.

 .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 29d536541152..06595a953659 100644
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
+      - lltc,ltc4015
+      - lltc,ltc4162-f
       - lltc,ltc4162-l
+      - lltc,ltc4162-s
 
   reg:
     maxItems: 1

base-commit: 94ba531bf9cb3c4ef725ffc37b8ed09006533f25
-- 
2.34.1


