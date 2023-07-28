Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EF766A5A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jul 2023 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjG1KZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jul 2023 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjG1KZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2023 06:25:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869444AE;
        Fri, 28 Jul 2023 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539897; x=1722075897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0QaZS3L2UJX/OqrxdZfZKqcfVOJsQ3ebCPwt06q93PU=;
  b=SZ5rl0+xa5Ce1zCDqPPbvSXvylN3+XTI5K9cD8seBmVc5E15tgzs1qX3
   swNYiv9C7+w+pwW3gpGAiUV0LdIgnxv4UE+gTjQ1OwMzlTiMttoCgJBor
   5s9J16GnZ8wEURo/V6cQ1dMWG4kc6PCoyuuIzelq5dyeylwyxkWoojG2G
   tS0HwIrE704x51bdn3nrbQlNrH1zbbOwY0GzYo9k9J9OgklME4XJUIicQ
   1qXwIXHI7DJ5clO3eE51q2wGc1UXinHlulYcdJNfxKlSFH4bdqdlh1x39
   nK98baZsNUZAYaIMBVSvSwAhEzUr+JhKQo70euMQFQ+DZilayuC0Jb3PK
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225812955"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:24:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:24:13 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:24:09 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <claudiu.beznea@microchip.com>, <sre@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 07/50] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
Date:   Fri, 28 Jul 2023 15:54:07 +0530
Message-ID: <20230728102407.265617-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add shutdown controller DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 8c58e12cdb60..0735ceb7c103 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -22,6 +22,9 @@ properties:
       - enum:
           - atmel,sama5d2-shdwc
           - microchip,sam9x60-shdwc
+      - items:
+          - const: microchip,sam9x7-shdwc
+          - const: microchip,sam9x60-shdwc
 
   reg:
     maxItems: 1
-- 
2.25.1

