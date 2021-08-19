Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45793F18D3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Aug 2021 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhHSMLr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 08:11:47 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:61572 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhHSMLr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Aug 2021 08:11:47 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3611e4a4dd56-d12e0; Thu, 19 Aug 2021 20:10:56 +0800 (CST)
X-RM-TRANSID: 2ee3611e4a4dd56-d12e0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9611e4a4cc99-acfa4;
        Thu, 19 Aug 2021 20:10:55 +0800 (CST)
X-RM-TRANSID: 2ee9611e4a4cc99-acfa4
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] power: supply: cpcap-battery: remove redundant check
Date:   Thu, 19 Aug 2021 20:11:37 +0800
Message-Id: <20210819121137.11928-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the function cpcap_battery_probe(), the check of '!match->data'
can actually never happen for the driver. First, this probe function
will only be called if there is a match with an entry from the OF
device ID table, and then all entries have .data set to a valid point.
So remove the redundant check.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/cpcap-battery.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8d62d4241..a3866826b 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1035,12 +1035,6 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (!match)
 		return -EINVAL;
 
-	if (!match->data) {
-		dev_err(&pdev->dev, "no configuration data found\n");
-
-		return -ENODEV;
-	}
-
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
-- 
2.20.1.windows.1



