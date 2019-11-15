Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA5FD66B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 07:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKOGZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 01:25:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37857 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfKOGZ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 01:25:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so3933310plb.4;
        Thu, 14 Nov 2019 22:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWSFthaD6WQUpptuakDsFyGfoN+3DaezgL6+fYz/Ahc=;
        b=surtFdZ6zev7u3GpypYS2mChQSvez3bS0pyRfpr0JfAThjv1WU5p0mZ9tfK5pvXCLD
         xCX/zk8n+XK3BQOsjfd+hE1wpQpfFJ+lOZzDnINijaahKraSSjOD+jrPujRtt7T3tIHr
         Q5pcmZsObJYz1F5yRoAkJ6MG9NM7KZ9hYzfxzOhUOrufjedpvuQimZE63+HEdWPPQWfx
         zwZxjATZZForCjopS6WxX7HLFEeJtZQs8NQROfwp8fqa9ZXdVAtqZ/HaEpoKi3pc995g
         +LrVj9lOLH7RnIsXLttMBNA5d7p7G/BU/cAtXayQNKPRmQXt/mUyMAKRgCJg/8cehpBO
         BgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWSFthaD6WQUpptuakDsFyGfoN+3DaezgL6+fYz/Ahc=;
        b=oL5ZsSUWD4ZEqe6cvcJEUIlQPqrZ7Li1JghBYqGAe/OzpPRj3Q2P7EaGykiX36B9di
         dGWD+/C/mD5n+xYEZePOkivZQTYTPcRUEM8IMGiXY7ey8BEwbxk48JrD9lgPA/M7jjyr
         Rd1G9QF1Ue4xSwEnWKO2IaGlXcDxpvNrwF5nYzyhzC/SKlrFvhHncKVBJ60vGm2S8gAo
         QqIl4bXTNlU9kqVl0ffS35b3NEVfAJjD/8y8xtfgmrT2Kyv6VI44i1RgpCyZG0FFDqdG
         aCVGBQv5cXhjSognbjVm7T9tP9e3UUTybXalPxXryx+CgBkd4jW/G+fhetoKtME5U0iW
         8kyg==
X-Gm-Message-State: APjAAAXKUqYsQQQPSItuZlcQ8QxbCznR6clQoatsWUyJbp8rZe7/EDGU
        CoFNYi2qgtHNA6SeYUlosVg=
X-Google-Smtp-Source: APXvYqyUtDRGP8aPtEUpVOiMEJ3XpXw98JSoFyR7XZp1dXU0TZoIdIwfRWpWprrKDJqFByr7GZINAQ==
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr16943033pjw.84.1573799124691;
        Thu, 14 Nov 2019 22:25:24 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id x12sm8682608pfm.130.2019.11.14.22.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 22:25:24 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] power: supply: pda_power: add missed usb_unregister_notifier
Date:   Fri, 15 Nov 2019 14:25:15 +0800
Message-Id: <20191115062515.7087-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver forgets to unregister the notifier in remove.
Add the call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/power/supply/pda_power.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/pda_power.c b/drivers/power/supply/pda_power.c
index 3ae5707d39fa..03a37fd6be27 100644
--- a/drivers/power/supply/pda_power.c
+++ b/drivers/power/supply/pda_power.c
@@ -429,6 +429,10 @@ static int pda_power_probe(struct platform_device *pdev)
 
 static int pda_power_remove(struct platform_device *pdev)
 {
+#if IS_ENABLED(CONFIG_USB_PHY)
+	if (!IS_ERR_OR_NULL(transceiver) && pdata->use_otg_notifier)
+		usb_unregister_notifier(transceiver, &otg_nb);
+#endif
 	if (pdata->is_usb_online && usb_irq)
 		free_irq(usb_irq->start, pda_psy_usb);
 	if (pdata->is_ac_online && ac_irq)
-- 
2.24.0

