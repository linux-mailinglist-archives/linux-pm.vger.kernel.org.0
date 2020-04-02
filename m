Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44919C50E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbgDBO5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:57:07 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:3035 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388959AbgDBO5G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:06 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR412vyCz1vh;
        Thu,  2 Apr 2020 16:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839425; bh=i8rERO1eokJ5ICLdJIYDblCyT0yVXlWido55eTwKoeY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bOrdNKXwbQuvjtEwzOMjxh0RSTpzizqKnnXdKOboiZPCo+8VSHl+JYAaRmMZX54GY
         sdVHQ5NxR1zeOAp0RcZpBkMqIxmQgL/TKJLE7NLO5Ru3VOrPtVmvG3lm8a4M4jTAUU
         CISJyqhtx0wwSfSJy/AE+TwWcSYH9ggrI2QzvfSnOdrW+Z2K755IB8ge6GiQFa+RI5
         5Oq9XXGVEhZmGsPiopSUYu+lArNfrxNXt/E/7fkA08hkslM+c9ZwRoEY7Yjw7ScLN6
         Ru5iwN+ZddsnW9jSqfBjHVq6bm0nMsoKjNl/MeM2TNNW/LkE134HAc/rOVnKN1o+wf
         fip2CCMfR0V3A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:04 +0200
Message-Id: <77267299aa987aa31abe26da0a353418a49d9619.1585837575.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 7/7] power: supply: core: document measurement points
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

