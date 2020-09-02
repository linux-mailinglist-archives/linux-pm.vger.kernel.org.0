Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EECC25B2E8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIBRYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 13:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgIBRYn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 13:24:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93D5208B3;
        Wed,  2 Sep 2020 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599067483;
        bh=G1e1N+vAOi4kbFZHzVHU/3lyBf8Cc2vYI1vHSa5+dfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkFXRPZcRtdhnx3I4RzJ5mXvfWyt2AwSCas4j3NWbXuF6Gaa8MXGEE/TY+0qIlahp
         pqzByt8G5nNO+m+HMW/OPyXw9Mtr7cHBguWhhQNE4UCtA3BqJDVSTMZn8FTKaBrk/E
         h9ROmV91G5kF8Em10AJZKGKXC5REQ4krX+ve9Sds=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] interconnect: imx: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 19:24:33 +0200
Message-Id: <20200902172433.1138-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902172433.1138-1-krzk@kernel.org>
References: <20200902172433.1138-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/imx/imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index ac420f86008e..b364d339f797 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -184,10 +184,8 @@ static int imx_icc_register_nodes(struct icc_provider *provider,
 
 		node = imx_icc_node_add(provider, node_desc);
 		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			if (ret != -EPROBE_DEFER)
-				dev_err(provider->dev, "failed to add %s: %d\n",
-					node_desc->name, ret);
+			ret = dev_err_probe(provider->dev, PTR_ERR(node),
+					    "failed to add %s\n", node_desc->name);
 			goto err;
 		}
 		provider_data->nodes[node->id] = node;
-- 
2.17.1

