Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0C61E7D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfGHMeQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 08:34:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36979 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGHMeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 08:34:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so7624730pgi.4;
        Mon, 08 Jul 2019 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NjnqLo3iz545x+S/KElhJPXTzOJzfZJMgeETAvhK2LU=;
        b=ZOSKOH9ptz42APtzNxr/4fxHNtLoWbGY1peNF/bZjQqe6lKg5MN560m0wpvTf/9EJx
         B+TG/tCXqG7H4/QoHftgxuWTZshzZVclaaR6T+yfQeRx4F6ZIR30GzHeEBrclcl53PJX
         bKwEwHg/H6JrvHZ2gu3Sb8zxI8wyuorntaxWeQ42Q2vAYIRSTt+f38PoKJTz5bNJ4Fx5
         B2/Yze+0Q3nVnZxnS2ewedrjHHpn68RPTWghoQFznhqkA6GlZEQCIyYha0Xj0HdpNfQz
         rS6dIDFHNCVWU7gNeg9xu9GauI/5bXhQ4nef7sfUVTEvgeozM07QBiauuKiDmtDj6Uot
         WHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NjnqLo3iz545x+S/KElhJPXTzOJzfZJMgeETAvhK2LU=;
        b=XqwD8Q89fSwlVEcQVYeC9SQHWQ7AAC1ltZR3Hz+v5wV/2QNjx3njTgrAX7Cw+YI8+q
         rkxGKKysDNFYNyMGM9BlO0d7T+HeczFEWKX5yUd1aTfYTyI6qdcL1M3ZeyIHQKUsl9GX
         fDp7V5kmMwx8JtZh0TbqFK5JU0R/fF/gSx2HAFw06B8BW3xdxoUVtxkD7UiUvYjRB7eB
         5eNRszlldEaZs9B5+esTuTEQG5eHuf4PRZe2rNQ/3aiY2/MuGR46VCQAarXYmtXjenbz
         c/Em1ehsHvYTrL4WOa9x5665GQJ1W5OsS7hbEMXF79SlaTcnpmibhjq8o8PD9VtjcI4M
         2lqg==
X-Gm-Message-State: APjAAAWBUaX1uItqvSly8KAepvFzBWOliufq9IoPFjHypTvepX57Kqiq
        zgfvaCUGSsRtvUpL5wcsMgGUK9mZgL4=
X-Google-Smtp-Source: APXvYqwptuU442FRVbw38exDDtoo5AIEoLjyAxxfOmUHmqr8wOOLnRnMFNTXHshFtLuvManYWC/0ug==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr23414666pgc.90.1562589255980;
        Mon, 08 Jul 2019 05:34:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id br18sm14785970pjb.20.2019.07.08.05.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:34:15 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 13/14] thermal: rcar_gen3_thermal: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:34:09 +0800
Message-Id: <20190708123409.12219-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a56463308694..755d2b5bd2c2 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -443,9 +443,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = devm_add_action(dev, rcar_gen3_hwmon_action, zone);
+		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action, zone);
 		if (ret) {
-			rcar_gen3_hwmon_action(zone);
 			goto error_unregister;
 		}
 
-- 
2.11.0

