Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE534F10
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfFDRg4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 13:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfFDRg4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 13:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4F50AE03;
        Tue,  4 Jun 2019 17:36:54 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] clk: bcm2835: register Raspberry Pi's firmware clk device
Date:   Tue,  4 Jun 2019 19:32:23 +0200
Message-Id: <20190604173223.4229-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604173223.4229-1-nsaenzjulienne@suse.de>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Registers clk-raspberrypi as a platform device as part of the driver's
probe sequence.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/clk/bcm/clk-bcm2835.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ccb0319fc2e9..6f370e6bafed 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -2098,6 +2098,7 @@ static int bcm2835_mark_sdc_parent_critical(struct clk *sdc)
 
 static int bcm2835_clk_probe(struct platform_device *pdev)
 {
+	struct platform_device *rpi_fw_clk;
 	struct device *dev = &pdev->dev;
 	struct clk_hw **hws;
 	struct bcm2835_cprman *cprman;
@@ -2150,8 +2151,18 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-				      &cprman->onecell);
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				     &cprman->onecell);
+	if (ret)
+		return ret;
+
+	rpi_fw_clk = platform_device_register_data(NULL, "raspberrypi-clk", -1,
+						   NULL, 0);
+	ret = PTR_ERR_OR_ZERO(rpi_fw_clk);
+	if (ret)
+		dev_err(dev, "Failed to create platform device, %d\n", ret);
+
+	return ret;
 }
 
 static const struct of_device_id bcm2835_clk_of_match[] = {
-- 
2.21.0

