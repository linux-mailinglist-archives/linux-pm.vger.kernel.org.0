Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02AA19DF33
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgDCUVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:21:00 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:29625 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgDCUUj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBs588rz2CH;
        Fri,  3 Apr 2020 22:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945237; bh=i8rERO1eokJ5ICLdJIYDblCyT0yVXlWido55eTwKoeY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=oSDYnQkDQXGyzQSHchOxSC8Y7ZsUUKssppn6e/zSVApzK0dJVUe3gTarwksErAVFw
         Woi/UY0Y7+G86AiNopTq8Z7CURxjTqyTRs61hclmEAVHACRi966NYflqr1Jd8EVZGp
         bt0I5KHwRzxOHjohgPNvsVOdBDFhwC9fRNX9jKYc1nFuGSLcUXskbXpmVGyfmVTAN6
         7jGgavW1lEJaMv6gW4tdUT3qTWGP2BCgls5AwNwQVxeTKNwecxuv7rEnedFNyVTz8V
         gVhmi3BJ6sq2Nv2g3VS2mE+zkWH2KpXn5DVugOsjqsGGAdV/fxMYBtLrOqA9c5foQ/
         /hNzTwmDu+Q/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:37 +0200
Message-Id: <8a68a586e2a3e51fd5a2a3d017844c8f77b0a794.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 11/11] power: supply: core: document measurement points
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

Document used prefixes for input/output/storage voltages and currents.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/power/power_supply_class.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index 7b8c42f8b1de..c41b25aaa755 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -28,6 +28,12 @@ indication (including whether to use it at all) are fully controllable by
 user and/or specific machine defaults, per design principles of LED
 framework).
 
+There are three defined points of measurement for the benefit of mobile and
+UPS-like power supplies: INPUT (external power source), OUTPUT (power output
+from the module), and unmarked (power flowing to/from a storage element,
+eg. battery). Battery is viewed as a power source, so current flowing to
+the battery (charging it) is shown negative.
+
 
 Attributes/properties
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.20.1

