Return-Path: <linux-pm+bounces-14464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C497C9E0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1C28306E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7219E7D1;
	Thu, 19 Sep 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f+jNah3f"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB119B3C0;
	Thu, 19 Sep 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751691; cv=none; b=Na9kUqFuJIIe0XGsKsQT3D/4j/pu1rRqNsc+wgZRqFIb0Xatj8TYWe+KsDq9ASVEVUuACtS0WMrVb4zAwLXC2KFe6rIIEhRDzqGq9ETVnpIHUwQqDBYlMa07v+QjvnbML0zrE9aXijzAj00hRnBbJ/CpT23yo6MjwM9740RGsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751691; c=relaxed/simple;
	bh=/xmLIZTg25Qjq5h9nsT+FMqltJMCECrFHyT6Rqa27CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jXP6sxv7TChBFA/t3d1tK52bckHSN3jRZHIzYsS3H7j/fIv4SiUEOxhD7At9u14ZEGaj0ryIocxht8ZuelsJx0yTEE5BT3zkK2tkPSSjIH+wh7ufwbiamBiVgUvP0i6jhhAHZz7Y6IP9TFpClHtmvnSQ4zpuLDQQNHUcSxlfJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f+jNah3f; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JDEcwV089621;
	Thu, 19 Sep 2024 08:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726751678;
	bh=4tCfpmlyfchADm/bZ7pZ5HVB9+FDOrdHQOSWgbMXHKs=;
	h=From:Date:Subject:To:CC;
	b=f+jNah3fSwz8RyAICCXSyZs2NEWoGB0TwRzd0MKkdnS6Dzydxq4xtepPJggAXTUIx
	 8xl+r4bWbXYolxvSwGMnvZaMR/jmYF3fgQv5pNOHeW5PH7z+IgPHBnm6Z60vhbTDgy
	 uOHuY3g0b7S4ym30MVscsMLYA6JJBaXy/kqTsiGc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JDEcmb050008
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 08:14:38 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 08:14:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 08:14:37 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JDEYxa060794;
	Thu, 19 Sep 2024 08:14:34 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 19 Sep 2024 18:43:40 +0530
Subject: [PATCH v5] dt-bindings: opp: operating-points-v2-ti-cpu: Describe
 opp-supported-hw
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>
X-B4-Tracking: v=1; b=H4sIAIMj7GYC/4WNQQ6DIBBFr2Jm3WkAQaSr3qNxUQF1FgUDxLQx3
 r3UC3T5XvLf3yH7RD7Drdkh+Y0yxVBBXRqwyzPMHslVBsGEZIa1OEqM64qu4EjBUZhxojfq1na
 9MFpxJ6Bu1+SrPruPofJCucT0OW82/rP/ihtHhpP2vO+k6pyZ7oWuNr5gOI7jC7qghGK3AAAA
X-Change-ID: 20240903-b4-opp-dt-binding-fix-73c6829751d2
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726751674; l=3557;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=/xmLIZTg25Qjq5h9nsT+FMqltJMCECrFHyT6Rqa27CI=;
 b=bzLUyEtejxYDeR3eWj51T+q/pqIA1dZiT8O1FZelEeHpzkjoh91gEWYiLXRC65SC3FDUuswTs
 35h9VoGiYK1C1VEpC/2vcYCPJaB06G0Teqe70zjiWMhTzCPxdlLrvr9
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

It seems like we missed migrating the complete information from the old
DT binding where we had described what the opp-supported-hw is supposed
to describe. Hence, bring back the description from the previous binding
to the current one along with a bit more context on what the values are
supposed to be.

Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Changes in v5:
- Fix the new lines inserted to seperate paragraphs.
- /eg./example,/
- Fix Odd line wrapping
- Link to v4: https://lore.kernel.org/all/20240918173431.GA1833339-robh@kernel.org/

Changes in v4:
- Fix dt_binding_check errors on previous revision.
- As per Rob's suggestion, used a blank line in between description
  and the paragraph.
- Reworded the description a bit.
- Link to v3: https://lore.kernel.org/all/20240917095252.1292321-1-d-gole@ti.com/

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
 .../bindings/opp/operating-points-v2-ti-cpu.yaml     | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index fd0c8d5c5f3e7eacecb74523e052c2cbb076ce20..624d1f3f1382fb9cae576c6c4919a9be875cf061 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -45,7 +45,25 @@ patternProperties:
       clock-latency-ns: true
       opp-hz: true
       opp-microvolt: true
-      opp-supported-hw: true
+      opp-supported-hw:
+        items:
+          items:
+            - description:
+                The revision of the SoC the OPP is supported by.
+                This can be easily obtained from the datasheet of the
+                part being ordered/used. For example, it will be 0x01 for SR1.0
+
+            - description:
+                The eFuse bits that indicate the particular OPP is available.
+                The device datasheet has a table talking about Device Speed Grades.
+                This table is to be sorted with only the unique elements of the
+                MAXIMUM OPERATING FREQUENCY starting from the first row which
+                tells the lowest OPP, to the highest. The corresponding bits
+                need to be set based on N elements of speed grade the device supports.
+                So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
+                in the table, then BIT(0) | (1) | (2) will be set, which means
+                the value shall be 0x7.
+
       opp-suspend: true
       turbo-mode: true
 

---
base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5
change-id: 20240903-b4-opp-dt-binding-fix-73c6829751d2

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


