Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4271C1917
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgEAPLW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:11:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1129 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgEAPLW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG140HCSzc6;
        Fri,  1 May 2020 17:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345880; bh=i8rERO1eokJ5ICLdJIYDblCyT0yVXlWido55eTwKoeY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=jTlDB5sacI5j59cEJIIOxrV+d0JA0Yej41oLfs5SxcJgBjnDoE3WZ4mxwhJTu1xo+
         zu4MQNH1wYoXcP8HTP6yXvXh2i7hXGZF2RNAECbKMsxzQpBgw+Kcv5gGqIQzl0BT0O
         zp6VJMWtXm30LVlxptucaSBtBf39iLI1xyjdc0wAItjFrqMOnzo2/sTGJ9+2TFrUXs
         OHcrhqORaL1fVpBD94Ew6CXOV773mwTCoxZNOd/Z9UamRCje2ZacDSHq5Jx2ccXgLI
         DagvgpRsVo2tZ+zaaSL5LbvkNONQfoesshx0S84++jVlUzLBk78jfHG7mV4ZfvLG1x
         AnTOOuAxxwhWw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:19 +0200
Message-Id: <25387c38a2454bef6ddec08ea322dd0d700f249c.1588345420.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 4/4] power: supply: core: document measurement points
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

