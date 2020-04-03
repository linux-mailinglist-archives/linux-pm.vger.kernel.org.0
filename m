Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40D19DB85
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404484AbgDCQX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:25765 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgDCQXd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xH4RJBzpX;
        Fri,  3 Apr 2020 18:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931011; bh=K+vbcp79f0yG60D3y6nK9BE+zeYjqGJsmkCt6t37wr0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ha+I+lDn0IayMpv5TffKHTJ/ZweBKjNKFKzbvhL6uuaDiN0PLLEhPQ5PqoAe6SKkM
         GLT3qLFt5qr2M9gSzrzoYJxue0sCC70JZohrXbyYMq3RorKPdRgiqEGihRCYEuAKXG
         /fM3NaSPaQ7BmrIFwOY0jAUA02s/54vDjXaaDg19DklUr/K5tIdLbCCWF9p57qCR23
         nf2o3kCtspSV0mcY1zSL7SRU4xcckg0usR8z3INYfuwVy+oKb13dkokJIdfjOOenjd
         EeVZg8mGLz2lJJd1zt0vYwRLb4yRa9owxMsFVdpH1th8NnbwG+tmeCdSDTXABnCQwT
         SVo6bVokhDw3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:31 +0200
Message-Id: <edb51336ad361f8dad6d9745e47823da6a94a204.1585929579.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/8] power: supply: core: allow to constify property lists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since tables pointed to by power_supply_desc->properties and
->usb_types are not expected to change after registration, mark
the pointers accordingly

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/power_supply.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index dcd5a71e6c67..6a34df65d4d1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -223,9 +223,9 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
-	enum power_supply_usb_type *usb_types;
+	const enum power_supply_usb_type *usb_types;
 	size_t num_usb_types;
-	enum power_supply_property *properties;
+	const enum power_supply_property *properties;
 	size_t num_properties;
 
 	/*
-- 
2.20.1

