Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA6C2E65
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfJAHto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 03:49:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32963 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfJAHto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 03:49:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so9112018lfc.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2019 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3J3ZlzLLxQH6KdthZTflCl0dBhfx+2NJSBcmROTOE8=;
        b=Tvhc1LvFiBSfoM3WJmjh4og/Lq7C6RhX1GQmIejRYvQDCcopSeDT5/osbewa3mcOOX
         +B9K75R8rAXtqkwTR7WnmmoieqyKk7rEvfq+1+vK5jIaBcOWmC1ltUhOnj1LdlI4fkIV
         utfE+RXm9ukZsoKeqhurJxVptb0ClJ47nigwf/njggEcosw6ndae1d2TcEIJRMkzyYEr
         Kj1Nh3vLBRlNYUWWftukzoy0Aroes5amJsAXaHrCIHOG2pF+4Wra0y5ThYJXXfx3+ra3
         eWhh2ltGVAKGYgY86mAobSPBx7pdfuZtnNZgzJ2RNEFBQMU1BZhy9kwt5xDfiD56WLq0
         tzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3J3ZlzLLxQH6KdthZTflCl0dBhfx+2NJSBcmROTOE8=;
        b=ua98c8TmV9a/zUdJuhqbLE9O7sNw5aREVf9JxkzPjEpPlVR2aFEJ7W/GbaOtMjkn0T
         0EPRX4vvytF4rQOfZA8WF9l0Hr6h90cPeAO4VEpDBg3wvQTkwEdvdJ7ybetDE+ts9OY6
         U26jDL9T5E3+1p0G1N5ifx7vh6Om06sHJ3UM9zqiScc/s3RtV7Ft0ANO8JbLgRgWYvEl
         RWEVMYrI9yD2j89wSURNniuVjEAiCuR1RBu2ZnSacbFqkWZLNWAgckP9y5fyXqY1dgNP
         L+ZyNogbQy7+Zb9cfOPOWGKA0/BUQy6EypBrnT2wDE2lzqtvAHS2L1FNLhqB3q2KjkhH
         3Y/A==
X-Gm-Message-State: APjAAAVUSPniN/wqBiP0sELAPQXilKqkp0o5x9Jn3lUe2whALHj2Hc1f
        bbocKJ3g9yc+0iR1sqc4hYk9Ee+2NKJXDw==
X-Google-Smtp-Source: APXvYqzDtOhNT7x/pbd/PN9TUcFRAUYljAMf35G85Ry2aILhBvVOrrLZ21Fb9D+ZYLrvzBjG93Cg9w==
X-Received: by 2002:a19:6549:: with SMTP id c9mr13033808lfj.99.1569916180928;
        Tue, 01 Oct 2019 00:49:40 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id i21sm3714314lfl.44.2019.10.01.00.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:49:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] thermal: db8500: demote temperature to debug print
Date:   Tue,  1 Oct 2019 09:49:30 +0200
Message-Id: <20191001074930.8637-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to print this to the console, just a
missed informational debug print.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Fixes: 6c375eccded4 ("thermal: db8500: Rewrite to be a pure OF sensor")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 372dbbaaafb8..21d4d6e6409a 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -152,8 +152,8 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
 					     next_low, next_high);
 
-		dev_info(&th->tz->device,
-			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
+		dev_dbg(&th->tz->device,
+			"PRCMU set max %ld, min %ld\n", next_high, next_low);
 	} else if (idx == num_points - 1)
 		/* So we roof out 1 degree over the max point */
 		th->interpolated_temp = db8500_thermal_points[idx] + 1;
-- 
2.21.0

