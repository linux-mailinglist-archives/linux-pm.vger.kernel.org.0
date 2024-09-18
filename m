Return-Path: <linux-pm+bounces-14384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3297B77A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ACD1F2188A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 05:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C2139D09;
	Wed, 18 Sep 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="meAZafJQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697228EF;
	Wed, 18 Sep 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726637652; cv=none; b=Bs5I6sezOCkxJCNKQdRASwi1z+zebzmATCuqf9xajM8eN/3gXwU/1h66bP8zM3nACWfRoZQMYsIqJj62SqLeUqciMdq3oNSMkG9kOh9UTHnLVX4qQj/TMgLRx6Jvwew85ZIc1eEhue0uJpxr9pFkP2U3KQNxrdBrpSkjwDk/CUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726637652; c=relaxed/simple;
	bh=47LcJsNhe3Q6Cp1GPETm73vBJVu68n/EDM2gQLNv2Yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q96S9oh6o6KXpcQLQ2xi2HWirAu4iuQ2115qFTWK/EPxHszkr4X+1r/6oBKXluu0ovljMQXu68xfVQomT4/ynw/lKlo3ZrB8YY44keR9kuwoOyCx9YUWLvbFCg/SieRgG9iBRn2hZXc+4MGzwnzougWEOCRbthgye5GUUEKYQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=meAZafJQ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48I5Y11O042584;
	Wed, 18 Sep 2024 00:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726637641;
	bh=bBrfxxqaMxb+JqIXSG+RpOR5aaAPDTbk6xtGPwtRVQ8=;
	h=From:To:CC:Subject:Date;
	b=meAZafJQJdpzTjlVHp4yxwzhawWNOJitk17iblvgR4GW+yWGeuf4Ha2SxFTqnd8s3
	 OLVkiwvKXa6Pww5eMPcfwFQLMvW6oKO2jNaeuRE7h/BoaSDF3iy0jwMnGKgFTD2ekV
	 WNdllBN0Y9nD9Dgl6PTCTYlTODJFIZxseWLjx2xY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48I5Y15h079059
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Sep 2024 00:34:01 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Sep 2024 00:34:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Sep 2024 00:34:01 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [10.24.72.240])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48I5XveY015656;
	Wed, 18 Sep 2024 00:33:57 -0500
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
Subject: [PATCH v4] dt-bindings: opp: operating-points-v2-ti-cpu: Describe opp-supported-hw
Date: Wed, 18 Sep 2024 11:03:17 +0530
Message-ID: <20240918053317.1390626-1-d-gole@ti.com>
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
 .../opp/operating-points-v2-ti-cpu.yaml       | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index fd0c8d5c5f3e..7c07410638db 100644
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
+
+                The revision of the SoC the OPP is supported by.
+                This can be easily obtained from the datasheet of the
+                part being ordered/used. For eg. it will be 0x01 for SR1.0
+            - description:
+
+                The eFuse bits that indicate the particular OPP is available.
+                The device datasheet has a table talking about Device Speed Grades.
+                This table is to be sorted with only the unique elements of the
+                MAXIMUM OPERATING FREQUENCY starting from the first row
+                which tells the lowest OPP, to the highest. The corresponding bits
+                need to be set based on N elements of speed grade the device supports.
+                So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
+                in the table, then BIT(0) | (1) | (2) will be set, which means
+                the value shall be 0x7.
       opp-suspend: true
       turbo-mode: true
 
-- 
2.34.1


