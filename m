Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF91D5859
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEORya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 13:54:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38842 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEORya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 13:54:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04FHsSQ8026307;
        Fri, 15 May 2020 12:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589565268;
        bh=AWDUQu0QFnxVy5SWiLTaeBRuwXtOx2e3RIxvvbK9Sag=;
        h=From:To:CC:Subject:Date;
        b=asjNuXFn2RzhN8qrL2xtoKlv5EIsDk+Kcs9/dy0VveKAGXqBJSwG9J+UjAfr6DWkr
         00FPt2mOcFUIo08WeX/37qz27qbFQ2LyctTuC6KJNi9mPDZzMIWDQkOJIHU+pVtusg
         vCFsCMmKYjdN+Qv/FtNTMJrzK7yXHPL9C5K/jxBw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04FHsSZO035903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 12:54:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 May 2020 12:54:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 May 2020 12:54:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04FHsRwS084752;
        Fri, 15 May 2020 12:54:27 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: power: Add BQ27561 compatible
Date:   Fri, 15 May 2020 12:44:53 -0500
Message-ID: <20200515174454.21866-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Texas Instruments bq27561 battery monitor to the bq27xxx
binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
This patch has a dependency on the yaml conversion - https://lore.kernel.org/patchwork/patch/1240876/

 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 03d1020a2e47..51cb1f685dcf 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -49,6 +49,7 @@ properties:
       - ti,bq27426
       - ti,bq27441
       - ti,bq27621
+      - ti,bq27561
 
   reg:
     maxItems: 1
-- 
2.26.2

