Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9E2D57FF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 11:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgLJKLq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 05:11:46 -0500
Received: from comms.puri.sm ([159.203.221.185]:40408 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbgLJKLb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 05:11:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6BA19E1217;
        Thu, 10 Dec 2020 02:09:55 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ORuYWibJJf1l; Thu, 10 Dec 2020 02:09:54 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 5/6] interconnect: imx8mq: Use icc_sync_state
Date:   Thu, 10 Dec 2020 11:09:05 +0100
Message-Id: <20201210100906.18205-6-martin.kepplinger@puri.sm>
In-Reply-To: <20201210100906.18205-1-martin.kepplinger@puri.sm>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the icc_sync_state callback to notify the framework when consumers
are probed and the bandwidth doesn't have to be kept at maximum anymore.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Suggested-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/imx/imx8mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index ba43a15aefec..d7768d3c6d8a 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interconnect-provider.h>
 #include <dt-bindings/interconnect/imx8mq.h>
 
 #include "imx.h"
@@ -94,6 +95,7 @@ static struct platform_driver imx8mq_icc_driver = {
 	.remove = imx8mq_icc_remove,
 	.driver = {
 		.name = "imx8mq-interconnect",
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.20.1

