Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB87D4D68
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjJXKNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJXKNo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 06:13:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539E10A
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8E8gaLzGiUy3NPBb62UDzn5hgQBi33JnSHhavxe5krw=; b=FbbSGrzoS9uXacVsNKEoambHw9
        IJXSAKc7IChVfL+Z4JPMVvsuP8qkVfSkA/SNoCrbeMBW+ACoNefXcX+3n6tf/DDV/k9zQzoSwIyju
        V6xFfbDbqUUw6zf5AM4YBhXbJI4SSF2ihfNOwxXSRolvggK9O4I9g8G/BN/iWXDWXjyHhDEFuzLK7
        TocLevh9Fb1GNh5a/bN4XdxWk1hCkZE3C8OdXCB9KWrTqJsopiReRUOY93g8iQuTkfX7naDa7xLBH
        ddoet9N6GggcymStXHegp1HA0gqpZs6b+xhVkhtLdqIs7jEuq1xMyCXJPzqsNhbcLaQshf4AiKd/3
        LEwExxdA==;
Received: from [177.34.168.16] (helo=morissey..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qvEPf-006NOz-1r; Tue, 24 Oct 2023 12:13:27 +0200
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3] pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable
Date:   Tue, 24 Oct 2023 07:10:40 -0300
Message-ID: <20231024101251.6357-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
refactored the ASB control by using a general function to handle both
the enable and disable. But this patch introduced a subtle regression:
we need to check if !!(readl(base + reg) & ASB_ACK) == enable, not just
check if (readl(base + reg) & ASB_ACK) == true.

Currently, this is causing an invalid register state in V3D when
unloading and loading the driver, because `bcm2835_asb_disable()` will
return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
ASB slave for V3D.

[v2]:
    * Use the !! operator to assure the correct assertion (Stefan Wahren)

[v3]:
    * Include a changelog (Stefan Wahren)
    * Include Florian's and Stefan's Reviewed-by

Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 1a179d4e011c..d2f0233cb620 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);

-	while (readl(base + reg) & ASB_ACK) {
+	while (!!(readl(base + reg) & ASB_ACK) == enable) {
 		cpu_relax();
 		if (ktime_get_ns() - start >= 1000)
 			return -ETIMEDOUT;
--
2.41.0

