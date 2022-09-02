Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BE5AB7E6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiIBSAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiIBSAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 14:00:51 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F97E3408;
        Fri,  2 Sep 2022 11:00:50 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 9CF33147FC;
        Fri,  2 Sep 2022 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662141649; bh=uAtmIH/m8gFPWqDADpZ8qu9osFiSkCwmcrNQPhD1y08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOqBc//z2490XMQk2RRyankA6PAsf3bKXPUukHPIoUkcQe+QrfhqkO3nSRtrwTtI0
         siTeamNOGQq+F/fLFBIbMdOgs9sNb/TY9rNQ3L2Qw3qzLgC15gDRmTJbcq2t9BiHY8
         2jPDhG70EamOpj5a/qf65ND/TcCZ9oeXzKTOj81cY9Mz/QrXUuFH2F/KDMoa0pC4Sr
         i5OoEYbt91oGycaTGldrBTBBAmoa89uXb1E62Mq5hw5EjhfVTbeWAdRzBsxFV9jJ22
         GOeNUmnUWyDxlF7gy7VCF2QLDuDoRGkAuHiRHl4VrvLMqo6voctqVgd7RUGzHgw8CC
         yQwpuqwy+dj2g==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 3/3] docs: ABI: charge_control_end_threshold may not support all values
Date:   Fri,  2 Sep 2022 20:00:37 +0200
Message-Id: <20220902180037.1728546-4-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902180037.1728546-1-lkml@vorpal.se>
References: <20220902180037.1728546-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some laptops (for example Toshiba Satellite Z830) only supports some fixed
values. Allow for this and document the expected behaviour in such cases.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
2.37.3

