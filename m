Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508AB3DCBD2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhHANbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231965AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5T9aKZsNHuu4O9mNXsv2yVyJELRr9WATiLSbVeTTEU=;
        b=W6gZENU9n5Hya3+rsPg0aS0xsM5D/gSW7XDgrAYZNmh9Q7AywMk/W4dq7/LWRPDDimmf2S
        +LsNUxl7hAl+Ay/67lpI9zK4hHLmUSn6hYSb/nll8UKtoRdFE+Z0SU7y/yJqU8N6WOcSWr
        R4SBPTiJF0YxlcSb5MSwOyB/9OlUcuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-JuWllfs_No-lKrG1EMA2AA-1; Sun, 01 Aug 2021 09:31:12 -0400
X-MC-Unique: JuWllfs_No-lKrG1EMA2AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAF46409B;
        Sun,  1 Aug 2021 13:31:11 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77DE60916;
        Sun,  1 Aug 2021 13:31:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 03/10] power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
Date:   Sun,  1 Aug 2021 15:30:58 +0200
Message-Id: <20210801133105.101761-4-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the IRQ mapping messages, because they are really not
interesting at all.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index d189849564db..43cc171101f1 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -537,9 +537,6 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 				pirq, info->irq[i]);
 			info->irq[i] = -1;
 			goto intr_failed;
-		} else {
-			dev_info(&info->pdev->dev, "HW IRQ %d -> VIRQ %d\n",
-				pirq, info->irq[i]);
 		}
 	}
 	return;
-- 
2.31.1

