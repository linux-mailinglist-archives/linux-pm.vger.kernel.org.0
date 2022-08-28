Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113025A3F77
	for <lists+linux-pm@lfdr.de>; Sun, 28 Aug 2022 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiH1TaQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiH1TaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 15:30:13 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0A1AD9F;
        Sun, 28 Aug 2022 12:30:07 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 2B46814629;
        Sun, 28 Aug 2022 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661715006; bh=50oHs5Jy3upYQzKgNwziw+anQEXE0N+XrbhTaIqSJ+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dnx9ui/ZxK5l29hvTcd/6u6atw1eeGD45dwuez5XHwJUaUS9+naJ0H5SrexmcCCYS
         L8hac3BYWZ6xw0zUG22MinIqAP/iKdn4kLn7qxPVOXe4MOHLB4XIIAZ157plKMzeGC
         4mnV3ekP2gdCIahmaSWY/exXoFs7ZwMjwd1bi9qajDVC4t6QYKZK7zxZ/L7nY4JYXC
         SFvUoMnzdxaf5E46T6dRITZylsJHtCYYfbXYYTOF/ztVJMkLtq7ypH8BVORl1u86xb
         ofWtjjBK/SZwOW2QA5zkhKatkWx3uumlunpWPFBFwf8u9fD/Cmp0QUG1myMc+NrrMA
         ehs6Ka5A9bu8g==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 3/3] docs: ABI: charge_control_end_threshold may not support all values
Date:   Sun, 28 Aug 2022 21:29:20 +0200
Message-Id: <20220828192920.805253-4-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828192920.805253-1-lkml@vorpal.se>
References: <20220828192920.805253-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some laptops (for example Toshiba Satellite Z830) only supports some fixed
values. Allow for this and document the expected behaviour in such cases.

Wording suggested by Hans de Goede.

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
---
 Documentation/ABI/testing/sysfs-class-power | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a9ce63cfbe87..e434fc523291 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -364,7 +364,10 @@ Date:		April 2019
 Contact:	linux-pm@vger.kernel.org
 Description:
 		Represents a battery percentage level, above which charging will
-		stop.
+		stop. Not all hardware is capable of setting this to an arbitrary
+		percentage. Drivers will round written values to the nearest
+		supported value. Reading back the value will show the actual
+		threshold set by the driver.
 
 		Access: Read, Write
 
-- 
2.37.2

