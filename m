Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702269CBA3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Feb 2023 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjBTNKd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Feb 2023 08:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBTNKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2023 08:10:30 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4521BADE
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 05:10:22 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id AE14D1C0007;
        Mon, 20 Feb 2023 13:10:19 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ABI: testing: sysfs-class-power: Document absence of "present" property
Date:   Mon, 20 Feb 2023 14:10:18 +0100
Message-Id: <20230220131018.1708991-1-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document how the absence of the "present" property in the sysfs
power_supply class should be handled.

Link: https://gitlab.freedesktop.org/upower/upower/-/merge_requests/173
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 Documentation/ABI/testing/sysfs-class-power | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index e434fc523291..7c81f0a25a48 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -437,7 +437,8 @@ What:		/sys/class/power_supply/<supply_name>/present
 Date:		May 2007
 Contact:	linux-pm@vger.kernel.org
 Description:
-		Reports whether a battery is present or not in the system.
+		Reports whether a battery is present or not in the system. If the
+		property does not exist, the battery is considered to be present.
 
 		Access: Read
 
-- 
2.39.1

