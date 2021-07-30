Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937253DB67D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 11:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhG3J4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 05:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238089AbhG3J4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 05:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627638978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/EFlUrUSiyyZvkPQyfsgFi/ehTLeTbTLNoYuwZk90U=;
        b=JTJYptp2/sW+IxdRsyOLWvkSFPhXPBvwbBGuyD90rwsX83B+ZhqRJ+lHchW+NrQETpaj/X
        FFOcEQNhkhuUkzOEke+24+E9GRUeL6yC+p6uzO3ZzYYDi03JzqkAwu50qzFqCE1/hfWJz5
        h4c2nf27h9U6lPSaV2CIt+wJCCZ68l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-4IhZhNJTOlmnjnLUZ71fEQ-1; Fri, 30 Jul 2021 05:56:17 -0400
X-MC-Unique: 4IhZhNJTOlmnjnLUZ71fEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA032801AE7;
        Fri, 30 Jul 2021 09:56:15 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECCEE399;
        Fri, 30 Jul 2021 09:56:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 04/10] power: supply: axp288_fuel_gauge: Report register-address on readb / writeb errors
Date:   Fri, 30 Jul 2021 11:56:01 +0200
Message-Id: <20210730095607.57541-5-hdegoede@redhat.com>
In-Reply-To: <20210730095607.57541-1-hdegoede@redhat.com>
References: <20210730095607.57541-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

