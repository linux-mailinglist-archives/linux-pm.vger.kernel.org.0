Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ADF777B1F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjHJOpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHJOpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 10:45:02 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603BE211C;
        Thu, 10 Aug 2023 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1691678701; x=1723214701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fb8UNTRB4SudTf2EN/AMFPjrk80+v5okVyVyGYK1K+E=;
  b=ZHcg+EROEcVQ06X/A2F/lmabRTMAjw2nsVeUX7linf6bigLmgJ2VgMiq
   DdZqXknG+d4UVBKuWtEGfKWo+U87PcoPIlunYIHrZnhyBXTv3YuzQ3dKU
   ycWUeISLu+Dhd6cWqrRbZA++t1nAP9E9ZtnjM2fBCM40YfriHP95YwfXW
   Vsm36wdwq4Bauspgtxxc4y4hzykz3TgW/+kHhs7QtcjFwoPW3UYsskhHS
   4enOVbMRaT7q4OWrDadwKDLDFNgcIH6zaSqSQGnRcP5UDLO5RG0tzNRwC
   ljDxnl6WNmrPI7VaQRAex6bVeRowj9tFP+19b5/GRhs9bFadsFOIA7i0d
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="32396721"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Aug 2023 16:44:58 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 342FA28008E;
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
Subject: [PATCH 3/6] dt-bindings: display: imx: hdmi: Allow 'reg' and 'interrupts'
Date:   Thu, 10 Aug 2023 16:44:48 +0200
Message-Id: <20230810144451.1459985-4-alexander.stein@ew.tq-group.com>
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

Although defined in synopsys,dw-hdmi.yaml, they need to explicitly allowed
in fsl,imx6-hdmi.yaml. Fixes the warning:
arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: hdmi@120000: 'interrupts',
 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
 From schema: Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml

Fixes: b935c3a2e07b ("dt-bindings: display: imx: hdmi: Convert binding to YAML")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
index af7fe9c4d196..d6af28e86ab4 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
@@ -22,6 +22,9 @@ properties:
       - fsl,imx6dl-hdmi
       - fsl,imx6q-hdmi
 
+  reg: true
+  interrupts: true
+
   reg-io-width:
     const: 1
 
-- 
2.34.1

