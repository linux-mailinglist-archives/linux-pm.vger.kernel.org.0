Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86996A56DF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfIBNAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 09:00:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfIBNAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 09:00:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so12598014wrt.13
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AwtIASwzD2wQBnlL9oHyI7SdRwOZSjZruhQTBPnShKk=;
        b=miDU0KYrIicIRBE0zL4/Itl/AJs4+B1X28hNpOLsd4u82nYRjtqm5YsetSNVou587O
         l5czxqg5TxbhTwY/rJGt/3KjpM1CL8XRNByXdDn2EFouyUgw1gmHjO1Iimtg8ScndpvG
         S30aTizsZUf9047APAU/CoXzU2jSs2VINLCFj94sFgTAfYopHzz4ET6kO6nemshLc7Kh
         JGzuJFWbU9rZVojwTvg9ycy4e8W0BzPL/HHPQTw6g5beWRVk6hixc0NjM5d84FVwMheD
         PxeLQndvg7+r2ZV+QYIQ0K/rzf3LdGRg0RAxlDkXB9/JITJab4lXygSZg0vdA/JRC4al
         V8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AwtIASwzD2wQBnlL9oHyI7SdRwOZSjZruhQTBPnShKk=;
        b=bKClNVlRUvWxbBFbv0fvJW9fCR2yApup2Lz0sqjFak4UCuy9CoRt1kPz/0NTdzPn3s
         bD7bnb0xiD7+Tqyp9W9apN30zGJjdSoAzBgR4FwhC3hngvB8mjbIfiiT77jyhFjb+VYi
         +e/GXrJO3/UR34/8IironqwbQLWidHq3YfYVCyOy0cg7ac3jdbblOmgPDDgp/qLqbyey
         wtofiC6BPMC1s6DcjhZsnZRqcPaqTO5cJIRPxY8H1Posefqnt7uydSqgTyGKMrlUZVyo
         AWlcR+XQJdlwoS4v8TIFaFuYiAn/VVRQfZFV/W/2oOElQjxpQ/HDdZAGJdj3bjmyQz0u
         kNsA==
X-Gm-Message-State: APjAAAXD3BIqSs8nTVz6uiHiCJB4OIbIKHis3RFCD3HVM5LpFIRLPzEG
        sORtzGU77dUn21VzDqJ0/uxQvA==
X-Google-Smtp-Source: APXvYqyYBW8VX3THfeDjkn30HbB7ZOHfQ8B3R0dRRt05rjR3UpR45PXXZOUTymd4u25da9bAS1a1pQ==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr37562687wro.215.1567429245648;
        Mon, 02 Sep 2019 06:00:45 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m3sm12163829wmc.44.2019.09.02.06.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 06:00:45 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: gpio-restart: Fix typo when gpio reset is not found
Date:   Mon,  2 Sep 2019 15:00:40 +0200
Message-Id: <94b3d1f3ebeb6000c32a7bed6f8b9411bae9cf19.1567429238.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trivial patch which just corrects error message.

Fixes: 371bb20d6927 ("power: Add simple gpio-restart driver")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/power/reset/gpio-restart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 2880cd5ae0d2..308ca9d9d276 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -65,7 +65,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	gpio_restart->reset_gpio = devm_gpiod_get(&pdev->dev, NULL,
 			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
 	if (IS_ERR(gpio_restart->reset_gpio)) {
-		dev_err(&pdev->dev, "Could net get reset GPIO\n");
+		dev_err(&pdev->dev, "Could not get reset GPIO\n");
 		return PTR_ERR(gpio_restart->reset_gpio);
 	}
 
-- 
2.17.1

