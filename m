Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA0777B24
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHJOpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjHJOpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 10:45:05 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C5E53;
        Thu, 10 Aug 2023 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1691678703; x=1723214703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EnU6mxwtuGf6jhekfVBSmSdeikIRp30Gtkant+ryK4=;
  b=qze2me8oat+B3vk8Cowj0/UVAMddIXf9iYdDBgt9oC0AcKbO/oo3Fn46
   ldXddWo3I5pSkYF6ALuG4sHk45SvCFRFRYqnGcZ/xrMSz7PmM5ukpA1DD
   tFiJJa8ogmLpeldKVjSDyZ7/cvSEINsJG30E33Ld46a0ONMjVbNnVf/8/
   nGWGsYOyW902XIORmIuS7EW7YsiyWw2C9WJCZd+2BMzbR8vEmvQJNtWpn
   MQH+1sMGUwc4VuEeZ6enyvg5XxtSYSOwHz8qErZV62b2WwkJyOBghQQnw
   cAKVVBIP9D+RWT12liAEudYlFTMBBvJYferDoQAB4Lj1LrZAiRlF6gcwy
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="32396724"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Aug 2023 16:44:59 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F0E5828008E;
        Thu, 10 Aug 2023 16:44:58 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: timer: add imx7d compatible
Date:   Thu, 10 Aug 2023 16:44:50 +0200
Message-Id: <20230810144451.1459985-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
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
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index dbe1267af06a..c5d3be8c1d68 100644
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

