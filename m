Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA87C6895
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377661AbjJLIAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 04:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378174AbjJLIAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 04:00:42 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96CB7;
        Thu, 12 Oct 2023 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697097640; x=1728633640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OB9KU7tWl5fQZiAdTcl0kb5n/4HFC+hHgYXJi8gGMG0=;
  b=gR9hf6RG3dBR+X3SXF8lOvmGLK8kT34ORSx/iyGQCB2080yR+NwIyKML
   Ymd4ymDCJrFEnebTJryO/LXEozP8bdNpKzSKy0NcDhNE3Tk7LUB6M2gDh
   bHWajaTAA/fZC+76/2HILds+FWiqTrRQtwZOqYJXRhx0hhWDs7yi7jx7E
   L8OkaHeI2jDP1x9ATr800ZdfIlQM24KvotRVPW9Pybf4LggvPYoacZCw3
   wMS/s5fZPxMkppi1ywX9biCQJQ3knHa3uia+o9Hp46RRrXGzyAxVAKEhf
   pgPMiAeurXPw/Q/L+rzThrXJNa1d8bo8Ph3Lxk5ppIML81SK0jBwVC/lv
   w==;
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="33422567"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2023 10:00:34 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8C98D280084;
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
Subject: [PATCH v2 3/3] dt-bindings: timer: add imx7d compatible
Date:   Thu, 12 Oct 2023 10:00:33 +0200
Message-Id: <20231012080033.2715241-4-alexander.stein@ew.tq-group.com>
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

Currently the dtbs_check for imx6ul generates warnings like this:

['fsl,imx7d-gpt', 'fsl,imx6sx-gpt'] is too long

The driver has no special handling for fsl,imx7d-gpt, so fsl,imx6sx-gpt is
used. Therefore make imx7d GPT compatible to the imx6sx one to fix the
warning.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index dbe1267af06a6..c5d3be8c1d682 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -36,7 +36,9 @@ properties:
               - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
       - items:
-          - const: fsl,imx6ul-gpt
+          - enum:
+              - fsl,imx6ul-gpt
+              - fsl,imx7d-gpt
           - const: fsl,imx6sx-gpt
 
   reg:
-- 
2.34.1

