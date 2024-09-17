Return-Path: <linux-pm+bounces-14363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40197AE4A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258CAB2E744
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0E165EE4;
	Tue, 17 Sep 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BuqWDJi2"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328E13CFB6;
	Tue, 17 Sep 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566791; cv=none; b=i3YyV7WxJ0ABjMF1/2ehyseagpGHXnozQlNVxrcKe2145D71Zhwdk8NQN1p0uBVyBufAW9RnGWL+vc2qRob5v/7OpiNXE+v/ci7/w85hTeEy+ldK3oUOXV0Pjm+4IptoiYRuujqMkTee32ZR8UrJqlr490ujcmvCuejGOfS4lqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566791; c=relaxed/simple;
	bh=2m51t4gIfYSPvCfow6feJB+exKSsXcOr1fqoOxJ8ujk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fFlFLCLJECGtUvuMCWzENuMpurDovG5scl3IX+ZM+uV4aKNVsDPLVYkWTxuMaxb2sF+zOt9g4lsaAtQSkYJu7dp5lp7A7cI9aGrnW4j1xIr4MMD/r5Ev7S1Habs2UrGe0C6/JczwBYOmz84LXx4pD6PcAA7vUq3bSB8OZReGAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BuqWDJi2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48H9r6WQ097363;
	Tue, 17 Sep 2024 04:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726566786;
	bh=I4nyURUyPPGO6OLix6jfXbgVX+R6pMWHrcbM7Qd7lJ0=;
	h=From:To:CC:Subject:Date;
	b=BuqWDJi2N1x/PMQAYsG/zQn0iVDzfBYZ5+90Ftgxrzx7yd1ADM18UryBrKOW7/2F9
	 cEyobeOJLxZCUpcGMWOIwzI+ulXy2bj4LLPXE3X5VOz9aG6DaA0UIyqhOBo+oDHcgu
	 /4EOIO/xD7QNUStlfAmkJSzgOuORw59rVmsJisY8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48H9r5WP057401
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Sep 2024 04:53:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 04:53:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 04:53:05 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [10.24.72.240])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48H9r1T6069530;
	Tue, 17 Sep 2024 04:53:02 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>,
        <nm@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v3] dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw
Date: Tue, 17 Sep 2024 15:22:52 +0530
Message-ID: <20240917095252.1292321-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

It seems like we missed migrating the complete information from the old
DT binding where we had described what the opp-supported-hw is supposed
to describe. Hence, bring back the description from the previous binding
to the current one along with a bit more context on what the values are
supposed to be.

Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Changes in v3:
- Use the items: and then provide description for both required items.
  This tries to address Rob's comments on previous revision.
- I've not use min/max Items as the 2 descriptions items implicitly
  imply that number of bitfields needed are 2.
- Link to v2: https://lore.kernel.org/all/20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com/

Changes in v2:
- Drop the patch where I updated Maintainers since it's already picked
  by Viresh.
- Add more details of how to populate the property based on device
  documents like TRM/ datasheet.
- Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com

---
 .../opp/operating-points-v2-ti-cpu.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index fd0c8d5c5f3e..700af89487d0 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -45,7 +45,22 @@ patternProperties:
       clock-latency-ns: true
       opp-hz: true
       opp-microvolt: true
-      opp-supported-hw: true
+      opp-supported-hw:
+        items:
+          - description: |
+            Which revision of the SoC the OPP is supported by.
+            This can be easily obtained from the datasheet of the
+            part being ordered/used. For eg. it will be 0x01 for SR1.0
+          - description : |
+            Which eFuse bits indicate this OPP is available.
+            The device datasheet has a table talking about Device Speed Grades.
+            If one were to sort this table and only retain the unique elements
+            of the MAXIMUM OPERATING FREQUENCY starting from the first row
+            which tells the lowest OPP, to the highest. The corresponding bits
+            need to be set based on N elements of speed grade the device supports.
+            So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
+            in the table, then BIT(0), (1) and (2) will be set, which means
+            the value shall be 0x7.
       opp-suspend: true
       turbo-mode: true
 
-- 
2.34.1


