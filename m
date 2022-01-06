Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBE486376
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiAFLGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238255AbiAFLGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEZz19IJXiSYRFXaaWaN3BgN60XEt8AIczfPPTNkTVc=;
        b=FQt8gQdCJODQP7nEJfdK15V+fpx5uBtwyD8vbosedsKyfpnsiMQopmuT29BduoQYn7lk0v
        7VBTV5/oCa+cPIg5q/Pk/VlUugSTC7l2jcOcvpCnDtMgYTJ+U5MkDysie9YLNOgeJwFx96
        6R7/koNNezda/UHVOYKE0tCO8iI1AhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-E9AYhI2MO0q__YaG31u1kw-1; Thu, 06 Jan 2022 06:06:46 -0500
X-MC-Unique: E9AYhI2MO0q__YaG31u1kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE0E1006AA7;
        Thu,  6 Jan 2022 11:06:45 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2B9167C99;
        Thu,  6 Jan 2022 11:06:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 6/7] power: supply: axp288_fuel_gauge: Take lock before updating the valid flag
Date:   Thu,  6 Jan 2022 12:06:07 +0100
Message-Id: <20220106110608.66231-6-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The valid flag is protected by the mutex, so code clearing it
should take the mutex before cleating the valid flag.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index f7dce029266a..53d0e82bbb3e 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -476,7 +476,9 @@ static irqreturn_t fuel_gauge_thread_handler(int irq, void *dev)
 		dev_warn(info->dev, "Spurious Interrupt!!!\n");
 	}
 
+	mutex_lock(&info->lock);
 	info->valid = 0; /* Force updating of the cached registers */
+	mutex_unlock(&info->lock);
 
 	power_supply_changed(info->bat);
 	return IRQ_HANDLED;
@@ -486,7 +488,9 @@ static void fuel_gauge_external_power_changed(struct power_supply *psy)
 {
 	struct axp288_fg_info *info = power_supply_get_drvdata(psy);
 
+	mutex_lock(&info->lock);
 	info->valid = 0; /* Force updating of the cached registers */
+	mutex_unlock(&info->lock);
 	power_supply_changed(info->bat);
 }
 
-- 
2.33.1

