Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5482285BA
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGUQcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 12:32:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44704 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGUQcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 12:32:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LGWCZo009455;
        Tue, 21 Jul 2020 11:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595349132;
        bh=VXQVYB3wzJZWQT9GPM/H2pXNrk9WfmlT/oWF5ORcuqY=;
        h=From:To:CC:Subject:Date;
        b=ZLISQ8gBnfpEgWRKBMAQZ99+D9fIOsDzyqQ2M7TEjzc46/TCtB7ph6PkNAiGN8s9K
         iMYkemgOMItg6Di+LqUQ32j6suxcisVJIa6zJH2Ryhy6OXgbGy2Rz4/1VZ1L3QFz+d
         umMoPS4Tz9WxPcQIm5H6FMluGRlDdS9mGyK5xv/Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LGWCKs039721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 11:32:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 11:32:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 11:32:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LGWCAt027900;
        Tue, 21 Jul 2020 11:32:12 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 1/4] dt-bindings: power: Add BQ27561 compatible
Date:   Tue, 21 Jul 2020 11:32:03 -0500
Message-ID: <20200721163206.25438-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
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

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
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
2.27.0

