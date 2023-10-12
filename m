Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770DD7C684E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378166AbjJLIAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbjJLIAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 04:00:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01190B8;
        Thu, 12 Oct 2023 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697097636; x=1728633636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8sDm0h+pCIl9iKfc4jxuflqUqRc8yd1m5/OgP1/13vY=;
  b=NhMdpW4MZMRhxLbQed+nd3kQTgk2CPHK4+Xx9+yb9bzKd4t34lVYhU4d
   FPRr8GPMkPwheq3iWeZAq3qWksp7aLeIeQTM85GbnoAJLzMQUcoJ4YQCf
   /jaipljUm/whFVMRH6boA595JGzv1NakVAoW1IPn68feH5tvw+LSa9u+V
   YktipGhROtRTPddUde0loRP2q50pjjkCsnow6ZnwX9J6JG1z52W6HyB6j
   xAXOVykqi4IvMmNFdKicn9JQ8pvAGHzJHkfjODPV775gCdyKFO7bgy5rD
   boN/6ycfmL3At3p1G0II3fFIA+86zxLLw5kpTYf7os8TKZ+17Ekgqs/0Y
   A==;
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="33422563"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2023 10:00:33 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 781CE280082;
        Thu, 12 Oct 2023 10:00:33 +0200 (CEST)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] imx6q related DT binding fixes
Date:   Thu, 12 Oct 2023 10:00:30 +0200
Message-Id: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

Hi everyone,

while working on i.MX6Q based board (arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts)
I noticed several warnings on dtbs_check.
I'm also not sure whether thse patches warrent a Fixes tag, so I only added that
for patch 3. All of these patches are independent and can be picked up
individually.

Patches already merged:
* 0268e1ae25949 ("dt-bindings: trivial-devices: Remove national,lm75")
* 57db57ae15a97 ("dt-bindings: display: fsl,imx6-hdmi: Change to 'unevaluatedProperties: false'")
  which deprecates v1 patch 3

Changes in v2:
* Fix example for imx-thermal.yaml
* Collected R-b & A-b
* Dropped v1 patch 6 for now as it is contoversial

Best regards,
Alexander

Alexander Stein (3):
  dt-bindings: imx-thermal: Add #thermal-sensor-cells property
  dt-bindings: net: microchip: Allow nvmem-cell usage
  dt-bindings: timer: add imx7d compatible

 .../devicetree/bindings/net/microchip,lan95xx.yaml         | 2 ++
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 7 +++++++
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml    | 4 +++-
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.34.1

