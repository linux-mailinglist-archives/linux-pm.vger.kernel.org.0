Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228B3DB67B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbhG3J4W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 05:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238089AbhG3J4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 05:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627638977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5T9aKZsNHuu4O9mNXsv2yVyJELRr9WATiLSbVeTTEU=;
        b=QtHoqDtzF5IM7+6hBIn6Kfsa2X/9kysdoNp20wiHkzggzFdhTG43mrewDjwfzSsELlKrTf
        vNa2D+v46Vbgxl8mwOwYNXgTMYGPmmvgvA2XlcS0CTLcTMsvcW180zYdaBhSW6JQgXraWa
        foT6VeIAIzEum/8SOJrbndhvnV4CRUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434--V0cjzQPNnq7V7cN_H7w8w-1; Fri, 30 Jul 2021 05:56:15 -0400
X-MC-Unique: -V0cjzQPNnq7V7cN_H7w8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEAA8799E0;
        Fri, 30 Jul 2021 09:56:14 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAB1E399;
        Fri, 30 Jul 2021 09:56:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 03/10] power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
Date:   Fri, 30 Jul 2021 11:56:00 +0200
Message-Id: <20210730095607.57541-4-hdegoede@redhat.com>
In-Reply-To: <20210730095607.57541-1-hdegoede@redhat.com>
References: <20210730095607.57541-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

