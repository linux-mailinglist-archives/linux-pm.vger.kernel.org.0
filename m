Return-Path: <linux-pm+bounces-13654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA696CE55
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B857C1F24328
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D815624C;
	Thu,  5 Sep 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oj8Fx0C1"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712F149013;
	Thu,  5 Sep 2024 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513295; cv=none; b=ECj7exbqQqEYIEhtZP+m4Qk7P5EmZI84BvIh4j5to7BwcYxxGTOKOrY381fm9uO07X7RAteXJrV3hcKccMNscleSrM5CnPXuBb74obTVz4zubmbfkdfVWhCROEErtD6S38Ysu/qBSPBTTv1ygQR8g/K04e7ZkiPwKFK/jKzAtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513295; c=relaxed/simple;
	bh=aG+evR3+/5qIXwTAJgFCZS/zyQH8AV2X8iY2rmN/CA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HMCkZM8VsDrdd8OEd2AiqZCx9S7cb3JDFuo3Ju/OFEzoThddkS/lmYUnJhNYI22t9fwRdnPqN9y8jtu55fDOFbuOsLc6h2HrSNJ1qn4GGypg5gCiFhIzWWHEn4lKGYnjjTWnns0Tj5kHNtKm98IefCEj82T2/XhkSg1Dm71Kt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oj8Fx0C1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4855Em5a109414;
	Thu, 5 Sep 2024 00:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725513288;
	bh=T/EmD+I0Gk0axmSOCLnZzBv2wRZ3H10IZiSBl3yeiWs=;
	h=From:Date:Subject:To:CC;
	b=oj8Fx0C1GDa1Y8zWdBZ5mWWRgOI5i6/PD4vxLq2R7SlF2FsCxvwqEXmBM2xVQBsTK
	 vmigXpGm6y7QW0/Gycnzr/tdk/7sFKBMKJvqK3qFgqZ6oM/zsDa33O6BgYGAdQwZZq
	 PfUEhRa92J0TlbesPF50shuhZ3f3vuDIaJveTkl4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4855EmNH037404;
	Thu, 5 Sep 2024 00:14:48 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 00:14:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 00:14:48 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.68] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4855EiKw040071;
	Thu, 5 Sep 2024 00:14:45 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 5 Sep 2024 10:44:32 +0530
Subject: [PATCH v2] dt-bindings: opp: operating-points-v2-ti-cpu: Describe
 opp-supported-hw
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com>
X-B4-Tracking: v=1; b=H4sIADc+2WYC/4WNSw7CIBRFt9K8sc8ApT9H7sN0YAu0byAQIETTs
 HexG3B4TnLPPSDqQDrCrTkg6EyRnK0gLg2s+9NuGklVBsGEZBNrcZHovEeVcCGryG5o6I1Du/a
 jmIaOKwF164Ou+uw+5so7xeTC57zJ/Gf/FTNHhmbQfOxl16vJ3BNdV/eCuZTyBQJ9Fue3AAAA
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725513284; l=2568;
 i=d-gole@ti.com; s=20240902; h=from:subject:message-id;
 bh=aG+evR3+/5qIXwTAJgFCZS/zyQH8AV2X8iY2rmN/CA0=;
 b=LkCqPjg3unfYAuZU/6ZBUvp8D3NacezwVDYTn8T2pqvDNKDcGULhOtIu5JR0sep0MtqgTLcV7
 gwDhndcGsuiAgsehtB9pFBwuS7uip3ZeTwZ5DU5hPywWM1DrZAlQ9ni
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=yOC9jqVaW3GN10oty8eZJ20dN4jcpE8JVoaODDmyZvA=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

It seems like we missed migrating the complete information from the old
DT binding where we had described what the opp-supported-hw is supposed
to describe. Hence, bring back the description from the previous binding
to the current one along with a bit more context on what the values are
supposed to be.

Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Changes in v2:
- Drop the patch where I updated Maintainers since it's already picked
  by Viresh.
- Add more details of how to populate the property based on device
  documents like TRM/ datasheet.
- Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com
---
 .../bindings/opp/operating-points-v2-ti-cpu.yaml         | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index 02d1d2c17129..fd260b20c59c 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -45,7 +45,21 @@ patternProperties:
       clock-latency-ns: true
       opp-hz: true
       opp-microvolt: true
-      opp-supported-hw: true
+      opp-supported-hw:
+        description: |
+          Two bitfields indicating:
+            1. Which revision of the SoC the OPP is supported by.
+            This can be easily obtained from the datasheet of the
+            part being ordered/used. For eg. it will be 0x01 for SR1.0
+            2. Which eFuse bits indicate this OPP is available.
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
 

---
base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
change-id: 20240903-b4-opp-dt-binding-fix-73c6829751d2

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


