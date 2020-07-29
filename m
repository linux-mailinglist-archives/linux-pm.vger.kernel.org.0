Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F7231E05
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgG2MGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 08:06:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2MGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 08:06:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TC6GtO070023;
        Wed, 29 Jul 2020 07:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596024376;
        bh=Wd+6o7v/z+lrPDM15r+ykQGSZTFXBwT0Ene0dRfk5WE=;
        h=From:To:CC:Subject:Date;
        b=WPNx+y5Rd4uuPyd6eZByzi/p5ohdePdGL2RCNMCh4LwZKqFPJ/i431iatHkzgogOZ
         npcEXqbb1BLXlvyIV448Q5v8isZTejzepdAimeEFg/ZmhdhR/pvh8ryaNw3qIqa6FZ
         u747IcD63rBitSRWadYkX4ymG945AuBtHqr/fJzs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06TC6Gwd117304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 07:06:16 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 07:06:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 07:06:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TC6GCA097457;
        Wed, 29 Jul 2020 07:06:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 1/4] dt-bindings: power: Add BQ27z561 compatible
Date:   Wed, 29 Jul 2020 07:06:06 -0500
Message-ID: <20200729120609.22427-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Texas Instruments bq27z561 battery monitor to the bq27xxx
binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v5 - Rebased on power-next and changed bq27561->bq27z561

 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 03d1020a2e47..0aa33590ac24 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -49,6 +49,7 @@ properties:
       - ti,bq27426
       - ti,bq27441
       - ti,bq27621
+      - ti,bq27z561
 
   reg:
     maxItems: 1
-- 
2.28.0

