Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D363ABCAE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFQT3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 15:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhFQT3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 15:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623958027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I6Nqm7xdeaJfWL4gTGZjst7sbm5QZQUkP++M3XhFXck=;
        b=bxbIebinYhYylfBhj3i7prvBsuNCwcvdL6yN1Dn+wV3VLgBe1bdNlH+MTdNZJuAE6s3Vov
        2YgDEa/Co0UHun/y/z6lqsQWrlY1FiQ7Nzsy0U+gumZrg84DZGoexuOzK8C7ZJUzWlEHJ6
        3KS1Xr40ATubzdIaAwCLz+o0j1VjnVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-k8TIQ406NzaMt3qtAdweUw-1; Thu, 17 Jun 2021 15:27:05 -0400
X-MC-Unique: k8TIQ406NzaMt3qtAdweUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8159F101F002;
        Thu, 17 Jun 2021 19:27:04 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-79.ams2.redhat.com [10.36.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC68260864;
        Thu, 17 Jun 2021 19:27:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: axp288_fuel_gauge: Rename fuel_gauge_blacklist to no_battery_list
Date:   Thu, 17 Jun 2021 21:27:01 +0200
Message-Id: <20210617192702.77106-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As documented in the updated "Naming" chapter of
Documentation/process/coding-style.rst, usage of the work blacklist
should be avoided where possible.

Rename the list of devices which have no battery to the
axp288_no_battery_list, which also more accurately describes the
contents of the list.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 39e16ecb7638..b74c4acba25d 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -676,7 +676,7 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
  * detection reports one despite it not being there.
  * Please keep this listed sorted alphabetically.
  */
-static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
+static const struct dmi_system_id axp288_no_battery_list[] = {
 	{
 		/* ACEPC T8 Cherry Trail Z8350 mini PC */
 		.matches = {
@@ -764,7 +764,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	};
 	unsigned int val;
 
-	if (dmi_check_system(axp288_fuel_gauge_blacklist))
+	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
 
 	/*
-- 
2.31.1

