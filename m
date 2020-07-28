Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457A230C16
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgG1OL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 10:11:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgG1OL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 10:11:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SEBP5f112980;
        Tue, 28 Jul 2020 09:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595945485;
        bh=gh4EtzX5Dz3uIry+K7fUw1sjey0K57y22u9kC6AyAjE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=la+GJoINXV7K4ABET04SIqys6ORJaisPL+KtfQIC/oCd4hr2BnihfUSkOSJRZujn8
         4RoIQ6C817aRgSK4Fdr+7hZl3QYHTlevRvHrJvshZHTDeJpxpHq8nJZ8uFMouWqDOJ
         E8ZqX2hVii2Lrb9h2fvqFeTJoWGSeD3TILG9DXF4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SEBPSP092727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 09:11:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 09:11:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 09:11:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SEBPEx115838;
        Tue, 28 Jul 2020 09:11:25 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 3/4] dt-bindings: power: Add BQ28z610 compatible
Date:   Tue, 28 Jul 2020 09:11:12 -0500
Message-ID: <20200728141113.31518-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728141113.31518-1-dmurphy@ti.com>
References: <20200728141113.31518-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Texas Instruments bq28z610 battery monitor to the bq27xxx
binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 51cb1f685dcf..d74c99c21604 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -50,6 +50,7 @@ properties:
       - ti,bq27441
       - ti,bq27621
       - ti,bq27561
+      - ti,bq28z610
 
   reg:
     maxItems: 1
-- 
2.27.0

