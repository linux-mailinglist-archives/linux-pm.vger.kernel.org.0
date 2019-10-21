Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B6DF4E4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJUSLG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 14:11:06 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.72]:23426 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbfJUSLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 14:11:05 -0400
X-Greylist: delayed 1274 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2019 14:11:04 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 25381934715
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 12:49:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id MboSiaaQcBnGaMboSicNa6; Mon, 21 Oct 2019 12:49:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mnkunLEF23UbiKstBGeBSKdC/co/nIvZTCOX/NZlbww=; b=tUM3lE38Ag01bD4YI89LCWIkMh
        /iA+bY0K0sithlPdbdStN0PDu25sb/avL8AlbdrA32oPewpKZicCe4GhwAOG7fwAZEtZmCsezatIF
        bZ5nqIaQPnizANZDFU8wAyREhzMsQ9wPRBWwyOIF8NdSzpjuHWFmKV9DQEfwttUkp9HcdpeFSvgBZ
        NJi9+/i6Wyw1eOEdwaurDIFIty0dbIzxr+nkiWFzLDWo/Xlp5xaP3T+juJprPiSUdJEkNertbINah
        RRGHv/GlKgUW/Bu5z5c3i6m6wilxdZdv/W19BR6RZlIn6i6eB3PyQTA7kcbvzDpb+MAbaiTwPULqt
        WTr+a2YA==;
Received: from [187.192.22.73] (port=33626 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iMboQ-000AL9-QC; Mon, 21 Oct 2019 12:49:47 -0500
Date:   Mon, 21 Oct 2019 12:49:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: ab8500_charger: Fix inconsistent IS_ERR and
 PTR_ERR
Message-ID: <20191021174937.GA17424@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iMboQ-000AL9-QC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:33626
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in ab8500_charger_probe().

The proper pointer to be passed as argument is di->adc_main_charger_c

This bug was detected with the help of Coccinelle.

Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ff2bb4411a22..8a0f9d769690 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3393,7 +3393,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
 			return -EPROBE_DEFER;
 		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
-		return PTR_ERR(di->adc_main_charger_v);
+		return PTR_ERR(di->adc_main_charger_c);
 	}
 	di->adc_vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
 	if (IS_ERR(di->adc_vbus_v)) {
-- 
2.23.0

