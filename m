Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C21C8BC6
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgEGNIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 09:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEGNIV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 09:08:21 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA11F20870;
        Thu,  7 May 2020 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588856900;
        bh=iF9jX+7z7ru6HD3PxDGP0QqjiXkokdLrWTYirF4yg5o=;
        h=Date:From:To:Cc:Subject:From;
        b=N5IeqxL+pm8uG+ioRyFmDRt8nvD6Ms5+PVbFa6RD5tUdKaFlFkKlV8vD6QEgLDVkk
         CM0cW36Z2FJX85xm9lHWd8pgla8pR0nbjoKHVIyHxmlxsQg0UjH7gSA8QBLPcGlS40
         amaw0LrBuHVZAyyr2YTyFaT7VE+NwlupSVpFf6Z8=
Date:   Thu, 7 May 2020 08:12:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PM / devfreq: imx: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200507131245.GA709@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in imx_bus_init_icc().

The proper pointer to be passed as argument to PTR_ERR() is
priv->icc_pdev.

This bug was detected with the help of Coccinelle.

Fixes: 16c1d2f1b0bd ("PM / devfreq: imx: Register interconnect device")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/devfreq/imx-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 532e7954032f..4f38455ad742 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -88,8 +88,8 @@ static int imx_bus_init_icc(struct device *dev)
 			dev, icc_driver_name, -1, NULL, 0);
 	if (IS_ERR(priv->icc_pdev)) {
 		dev_err(dev, "failed to register icc provider %s: %ld\n",
-				icc_driver_name, PTR_ERR(priv->devfreq));
-		return PTR_ERR(priv->devfreq);
+				icc_driver_name, PTR_ERR(priv->icc_pdev));
+		return PTR_ERR(priv->icc_pdev);
 	}
 
 	return 0;
-- 
2.26.2

