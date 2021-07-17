Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD993CC488
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhGQQra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 12:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhGQQr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626540272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5T9aKZsNHuu4O9mNXsv2yVyJELRr9WATiLSbVeTTEU=;
        b=Zh0dx77j0Q0VKFSuac344vR3xk4i2CqKZ2RUAqf2P9iXt1oh5v7FMJW2Lrs3MfqLy9jqDd
        9glYSqpaw72IsuN0nvEz8qhO65YJNECmX92jb94mbgUE2dZtnOFKRctr5+P5h1R5esfBk9
        csBPocHd3r1sikLPhXWrQFJbTb5DAWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-IG4_J8MwM3KSYFXdANMztQ-1; Sat, 17 Jul 2021 12:44:31 -0400
X-MC-Unique: IG4_J8MwM3KSYFXdANMztQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134F81835AC2;
        Sat, 17 Jul 2021 16:44:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18ABE5DA2D;
        Sat, 17 Jul 2021 16:44:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH 03/10] power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
Date:   Sat, 17 Jul 2021 18:44:17 +0200
Message-Id: <20210717164424.274283-4-hdegoede@redhat.com>
In-Reply-To: <20210717164424.274283-1-hdegoede@redhat.com>
References: <20210717164424.274283-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

