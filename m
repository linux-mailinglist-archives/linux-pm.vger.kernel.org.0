Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4719DF30
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgDCUUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34701 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDCUUf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBn1g2qz1j9;
        Fri,  3 Apr 2020 22:20:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945233; bh=K+vbcp79f0yG60D3y6nK9BE+zeYjqGJsmkCt6t37wr0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=JGRJfZ4lzhYomhDsdKkvEye2pRDfPOP3b87QiGWu2YLABh3eNOvY7jeyryavzHkmh
         QW9r1bjJj6KHmqCZ6dLXMO4pA+oXHkq1aR30xbOvSEkqs93vSli/2z6GbTbHInPpq1
         01n6rUPXVw8c7srynqBDPiI+QmXU8r+uK+9oUEy0Lf5N70dDmuvqgh/+lpAvfwmkn8
         932Flkg3TZx7IQ6PkSLNgwe3fGJsgjlMcBawZG7VCtWhHS/YuhjxbRf0BfrJDkUJsK
         btRCGsGEhAMXrcRmk3Fw3/gYSsJbDiKaPjWNOKat0TzMfPqx1fP7o+frqdxj3katMs
         utCczzYuiUVnQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:32 +0200
Message-Id: <1ebdfa76e2912c579c3c45fe86dbbedac6824167.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 05/11] power: supply: core: allow to constify property
 lists
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

