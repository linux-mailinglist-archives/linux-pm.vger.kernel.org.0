Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDE279C10
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 21:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZTPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 15:15:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:59331 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbgIZTPU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Sep 2020 15:15:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzJC25k2Jz2KH;
        Sat, 26 Sep 2020 21:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601147134; bh=3INUmx9RND0JKy4nJpRHGKH4uognPLDDkFYP6+Ush4Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=OW4w1KqaCEwgGsbA6BvdeHm8d+WND9E5IK9grlMv2u1N0lbbEeTJ3u5RQUXI0baYF
         +/7EVkvkQguwj4K9Ptgg/rLDd7jixL0LnImXIEeKnGmixZ/bDk8bvdoUBQJwPGHaui
         u8jJUPlKUAgnRo75cQ/RP5EJOWhf3X3LY28ZVF0yxBOgidS3xpWPdzJnXipYslSa5U
         Kpbizm78taelA8KqY6nNn64K2YQcXIWMJrLILWXfpYIaHkqr9IhLzQvbIS9Sm4mHmu
         M8cZakGMSeHoGAACuuCX84GgJA1JmjQYq6+IeoawpkjGvSskdomOPzH7PJ+5xJeVx7
         hpd+VYis206Zg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 21:05:34 +0200
Message-Id: <edd68202c51088d6f5f539a7d8464fff049ff837.1601146802.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
References: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 1/2] power: bq25890: document IBAT compensation DT
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new properties for IBAT compensation feature.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: initial version
v4: renamed properties applying property-suffix
---
 Documentation/devicetree/bindings/power/supply/bq25890.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index 3b4c69a7fa70..805040c6fff9 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -33,6 +33,10 @@ Optional properties:
 - ti,thermal-regulation-threshold: integer, temperature above which the charge
     current is lowered, to avoid overheating (in degrees Celsius). If omitted,
     the default setting will be used (120 degrees);
+- ti,ibatcomp-micro-ohms: integer, value of a resistor in series with
+    the battery;
+- ti,ibatcomp-clamp-microvolt: integer, maximum charging voltage adjustment due
+    to expected voltage drop on in-series resistor;
 
 Example:
 
-- 
2.20.1

