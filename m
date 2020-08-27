Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB5254706
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0OgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 10:36:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgH0ODr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 10:03:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A7A8929A33C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6D88248010D; Thu, 27 Aug 2020 16:02:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1] power: supply: document current direction
Date:   Thu, 27 Aug 2020 16:02:48 +0200
Message-Id: <20200827140248.37749-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the sign for CURRENT_NOW and CURRENT_AVG is a bit
of a mess. There are basically 3 different ways battery fuel
gauges report the current:

1. uses negative values for discharging and positive values
   for charging
2. uses positive values for discharging and negative values
   for discharging (opposit of 1)
3. only uses positive values

As a result userspace currently cannot use the sign at all in
a generic way. Let's solve the issue by documenting a canonical
way for reporting the data and ensure new drivers follow this
way. Then existing drivers can be fixed on a case-by-case basis.

The 'negative value = battery discharging' has been choosen,
since there are only very few drivers doing it the other way
around.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/ABI/testing/sysfs-class-power | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 651599fb18f8..dbccb2fcd7ce 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -108,7 +108,8 @@ Description:
 		which they average readings to smooth out the reported value.
 
 		Access: Read
-		Valid values: Represented in microamps
+		Valid values: Represented in microamps. Negative values are used
+		for discharging batteries, positive values for charging batteries.
 
 What:		/sys/class/power_supply/<supply_name>/current_max
 Date:		October 2010
@@ -127,7 +128,8 @@ Description:
 		This value is not averaged/smoothed.
 
 		Access: Read
-		Valid values: Represented in microamps
+		Valid values: Represented in microamps. Negative values are used
+		for discharging batteries, positive values for charging batteries.
 
 What:		/sys/class/power_supply/<supply_name>/charge_control_limit
 Date:		Oct 2012
-- 
2.28.0

