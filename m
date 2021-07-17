Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D03CC489
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhGQQra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 12:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhGQQra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626540273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/EFlUrUSiyyZvkPQyfsgFi/ehTLeTbTLNoYuwZk90U=;
        b=QpOsMpxnOx6aal4s3up5r9OO1ZtzH8S2CTdjJ2vaeFrMeh26EpM0DRpVb3nBxlQfR2zuPt
        giRbvMI6q4lCk+7PMJggABsfnmnQghSqvWalzLnopwV2N9fItyU8VAwl18nkITvgSSeRHI
        tSNyOgryyLCEuZOZkqgtV/UAArsOGWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-DvAtxTo8OyynumaBzqMWSQ-1; Sat, 17 Jul 2021 12:44:32 -0400
X-MC-Unique: DvAtxTo8OyynumaBzqMWSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F05100B3AD;
        Sat, 17 Jul 2021 16:44:31 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 596705DAA5;
        Sat, 17 Jul 2021 16:44:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH 04/10] power: supply: axp288_fuel_gauge: Report register-address on readb / writeb errors
Date:   Sat, 17 Jul 2021 18:44:18 +0200
Message-Id: <20210717164424.274283-5-hdegoede@redhat.com>
In-Reply-To: <20210717164424.274283-1-hdegoede@redhat.com>
References: <20210717164424.274283-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When fuel_gauge_reg_readb()/_writeb() fails, report which register we
were trying to read / write when the error happened.

Also reword the message a bit:
- Drop the axp288 prefix, dev_err() already prints this
- Switch from telegram / abbreviated style to a normal sentence, aligning
  the message with those from fuel_gauge_read_*bit_word()

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 43cc171101f1..796153caf5e0 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -142,7 +142,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
 	}
 
 	if (ret < 0) {
-		dev_err(&info->pdev->dev, "axp288 reg read err:%d\n", ret);
+		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
 		return ret;
 	}
 
@@ -156,7 +156,7 @@ static int fuel_gauge_reg_writeb(struct axp288_fg_info *info, int reg, u8 val)
 	ret = regmap_write(info->regmap, reg, (unsigned int)val);
 
 	if (ret < 0)
-		dev_err(&info->pdev->dev, "axp288 reg write err:%d\n", ret);
+		dev_err(&info->pdev->dev, "Error writing reg 0x%02x err: %d\n", reg, ret);
 
 	return ret;
 }
-- 
2.31.1

