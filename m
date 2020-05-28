Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8461E6097
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgE1MVv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 08:21:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39570 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbgE1MVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 08:21:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SCLnni027386;
        Thu, 28 May 2020 07:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590668509;
        bh=raa7ll2KDPbKQDXP7IUnunxQGOq82k8en6t+F2hiqyI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I39iTQfZIUCPHNtBJRyPVA7JH9feFAaI0ZJxJqjGeGpuskd8dAJ0VLpf06Ge9ZbO2
         +HZuO19nEpIPZWbBBhd+tXzzGRbGNZUXqrMSyHO0MLyMfB0NUAAyPX4wg8v8MgzGiA
         0x0SJPj/rRTa/FQv03uu++VQKtzQAGy9zBTvzCzM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SCLmPJ052504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 07:21:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 07:21:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 07:21:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SCLmHg002918;
        Thu, 28 May 2020 07:21:48 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 3/4] dt-bindings: power: Add BQ28z610 compatible
Date:   Thu, 28 May 2020 07:21:46 -0500
Message-ID: <20200528122147.6171-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528122147.6171-1-dmurphy@ti.com>
References: <20200528122147.6171-1-dmurphy@ti.com>
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
2.26.2

