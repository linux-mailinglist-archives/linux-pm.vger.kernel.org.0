Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C812D231E09
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgG2MG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 08:06:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35122 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2MG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 08:06:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TC6R74064809;
        Wed, 29 Jul 2020 07:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596024387;
        bh=fbW39+qHrGG+uZhbXWyqWPhVsFB1CQWoeCh0m8N3AL0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pUQz+MqB0f/8Nao6h6H3AOyxa+4LAh47LLiFcD14g0+9bIi5eWjx9OUb45i45NLe2
         w5U/sl3uxJHhXw5Q2YAjDQAq1eCnCMQrDoEe7wWzJ5FRrmguG8+pCK4dnMebpHmurK
         dGnTbXJvjLIHiv/KAihw8NNog9Cb0+wLr/F1svfI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06TC6RSL113201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 07:06:27 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 07:06:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 07:06:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TC6QTr038786;
        Wed, 29 Jul 2020 07:06:26 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 3/4] dt-bindings: power: Add BQ28z610 compatible
Date:   Wed, 29 Jul 2020 07:06:08 -0500
Message-ID: <20200729120609.22427-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729120609.22427-1-dmurphy@ti.com>
References: <20200729120609.22427-1-dmurphy@ti.com>
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
index 0aa33590ac24..82f682705f44 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -50,6 +50,7 @@ properties:
       - ti,bq27441
       - ti,bq27621
       - ti,bq27z561
+      - ti,bq28z610
 
   reg:
     maxItems: 1
-- 
2.28.0

