Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CBC431DD1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhJRNzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 09:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233200AbhJRNxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 09:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axZ9Ln7q8QDt70Z8kWYCwfszQULRroHPak977G8hWws=;
        b=h63CSWRzE/lx7H1H0RpzTcNz4pt/S8LWKsSAPv0NXb11v7nzHFcogyXu8pTtfqTfVfbny2
        pcOYBsxv8z4nL0IulKwjoMpIdWQUaE3Ig0QIfXjsUILswgyuBYlaJb4fwT6ukuKQwIZsjd
        LT4Z7v1BTVsEOj7f/FHu/DOiGuhtqUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-fKIb7zDaP32i9q8-jYExhA-1; Mon, 18 Oct 2021 09:51:00 -0400
X-MC-Unique: fKIb7zDaP32i9q8-jYExhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FE11006AA2;
        Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B768C22719;
        Mon, 18 Oct 2021 13:50:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] power: supply: axp288-charger: Add depends on IOSF_MBIO to Kconfig
Date:   Mon, 18 Oct 2021 15:50:51 +0200
Message-Id: <20211018135053.213310-2-hdegoede@redhat.com>
In-Reply-To: <20211018135053.213310-1-hdegoede@redhat.com>
References: <20211018135053.213310-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add "depends on IOSF_MBI" to CONFIG_AXP288_CHARGER as the changes from
commit ed229454856e ("power: supply: axp288-charger: Optimize register
reading method") use symbols which are only defined when IOSF_MBI support
is enabled.

Depending on this is ok since IOSF_MBI support should always be enabled
on devices which use the AXP288 PMIC.

Fixes: ed229454856e ("power: supply: axp288-charger: Optimize register reading method")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index fcc7534edcb2..2366b785abd9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -351,7 +351,7 @@ config AXP20X_POWER
 
 config AXP288_CHARGER
 	tristate "X-Powers AXP288 Charger"
-	depends on MFD_AXP20X && EXTCON_AXP288
+	depends on MFD_AXP20X && EXTCON_AXP288 && IOSF_MBI
 	help
 	  Say yes here to have support X-Power AXP288 power management IC (PMIC)
 	  integrated charger.
-- 
2.31.1

