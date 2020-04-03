Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36C119DB7A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbgDCQXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:20928 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404434AbgDCQXg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xL6YPJz1vh;
        Fri,  3 Apr 2020 18:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931014; bh=i8rERO1eokJ5ICLdJIYDblCyT0yVXlWido55eTwKoeY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=SgEJc+eh3h6dv3Vbbc5pj+44ZjMlGt4B/PoNuYGnro7Qtmn87zhYFox8GjIU1PtvC
         /ugfVF2c//RAt5Ib0Orw9hIc2yDptLJXg3JchoI1HCejxzCc0Gy4/+I0wkpcv+efN1
         y1b7WBXwBeTQ3uOut7JjN/CMJeVDFHRERA727/dbcJxH5MjnuMatVYPiIVV+8S4lvB
         9lunCkm8XTJlifkQJvH7UydyWCzmUtkpx597pI5eeECrh1f+EnH0iVekZfMx1vXbPA
         rxf4A5KNjKVxrO0wqRoF6JPfn4lY6OmaTFsq3Yt/8U7FqJb296ylfMGSGdEtst7DYx
         T6L2yWs3n1ggw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:34 +0200
Message-Id: <044cccd482b77c7ebbbb8ec960eaf73a079df29e.1585929580.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 8/8] power: supply: core: document measurement points
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

