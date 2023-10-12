Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92847C6880
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378175AbjJLIAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378165AbjJLIAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 04:00:42 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C8C4;
        Thu, 12 Oct 2023 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697097640; x=1728633640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yi2Z/SKqALoYJ7iRO68cYpheHieJ9Llccyg06q6p1PE=;
  b=KdjQlBIb/5lYxkJpQsZl7x1m/T9lhS1R55EwK4KtTsEIxIE9ofB6eV2e
   AO64s8mRvLPmCBqC+31HNnTug9WBB1o33N13E74wwLKUB6gZsfBWxWfh/
   uLHVYX9os2uS6+lJSsdsMQV6FXqs2tZ59ZT84WSVMSrRgE/kPiLJhWFwO
   rMaw0zvup12qcdhgOD0vcY653h5gIZ1L3En0OnWgAciUh46ILPER/zhco
   3AoAfTyQczTwNuICKmIET+cnox3m2iRL/IrWkebKlmwq6/kmuqL6IJfUU
   jl99sZgMlPY8dZaZwItAF7mA5rSvlXtvDMLX4kiKCKhMTJJQRvHqbCJXB
   g==;
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="33422566"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2023 10:00:34 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 34674280082;
        Thu, 12 Oct 2023 10:00:34 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: net: microchip: Allow nvmem-cell usage
Date:   Thu, 12 Oct 2023 10:00:32 +0200
Message-Id: <20231012080033.2715241-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
References: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MAC address can be provided by a nvmem-cell, thus allow referencing a
source for the address. Fixes the warning:
arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: ethernet@1: 'nvmem-cell-names',
 'nvmem-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
 From schema: Documentation/devicetree/bindings/net/microchip,lan95xx.yaml

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index 77c9bbf987e15..accff93d38f80 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -44,6 +44,8 @@ properties:
 
   local-mac-address: true
   mac-address: true
+  nvmem-cells: true
+  nvmem-cell-names: true
 
 required:
   - compatible
-- 
2.34.1

