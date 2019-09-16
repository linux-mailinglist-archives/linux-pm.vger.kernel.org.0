Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A52B331C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfIPByd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Sep 2019 21:54:33 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:47058 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfIPByd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Sep 2019 21:54:33 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i9gDl-0004FT-D8; Mon, 16 Sep 2019 03:54:31 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.92.2)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1i9gDl-000XjM-68; Mon, 16 Sep 2019 03:54:29 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Han Nandor <nandor.han@vaisala.com>
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon, 16 Sep 2019 03:54:27 +0200
Message-Id: <20190916015427.129610-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en ro
Subject: [PATCH] power: nvmem-reboot-mode: cast away pointer type confusion
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the kernel builds with -Werror=incompatible-pointer-types, this
caused a build failure.

The warning also suggests a question about machines with variable
endianness.

Fixes: 7a78a7f7695bf9ef9cef3c06fbc5fa4573fd0eef
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/power/reset/nvmem-reboot-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index e229308d43e2..606fb7e60590 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -24,7 +24,7 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write(nvmem_rbm->cell, (char *)&magic, sizeof(magic));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.23.0

