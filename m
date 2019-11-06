Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48E3F0CA9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 04:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfKFDJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 22:09:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38427 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfKFDJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 22:09:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so2940024pgh.5
        for <linux-pm@vger.kernel.org>; Tue, 05 Nov 2019 19:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9meDnCrlVy1TEfNYgEE4zPiyrI7Aj0wUdJgTmJwPd0=;
        b=ChIZGBOdauzWNRPMnZx4mS7Rx5rG6NTYLpSXvupVqsl+sUmP7noGaGBGMiiv/y2/Ma
         MtXYd6Baj2roRqbE6Vq6XJNznJVhMLo+2V7rdESrYmmVPxu1Vew+x9mNg0BbRFRsAtTP
         gB7hfkRq5dCyv7yVeof+dALAis+0NRgnD4civRyhjY9SA2ON+JtbvVj7G/A8wPwllzZB
         rEeomigcHVdNEBgUrhkQg1IUIyaVKXk15XMbslvyVMTP5upDAUrcnY2PQhbp6s/1e0TF
         u26VOSKxbMhfkA8cjZj7Ka4FmmwXhD1VE52xXEsj5Cv0F37K4aukNd36KzI3Kkn+WEuq
         4f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9meDnCrlVy1TEfNYgEE4zPiyrI7Aj0wUdJgTmJwPd0=;
        b=gVY/i2ccuBC2DABBWDEJvUWMkswO6vP+OqiDQ9o9P5QX56+TJKsTmQFAlFMa4+htkx
         95Qsz1nW1Tq63IW7+Nq/cOjQ4PQz2XNfm5ZqzgkCDKLs2UqDF/I3PE7EAiIL/v1rKfKI
         SWppDpvkAM2IDaQZVlUFKkvYkt7Netf6/VzUoQQo2M5+bYO879LrMMQaAO251I8X2dFY
         VJoj9pDVAT+g7iW+xgiad++c7rHaoaWSKHsHoNRAdIbU8xklzvltn3qs40FspuKU6yn+
         MCLNY+uMfFaBJOwLlJ3hPpeivHP5qKkCGGzYQCHTSM4PBRi77QEpC0z7xdkHThiDPZJz
         jpug==
X-Gm-Message-State: APjAAAUBrZLnIGle6LExMOqNOzVHpZwOmPngrFTREgESsQVFibQvexTq
        qEPn/iBHuOO3mINTY1LP+TWbAQ==
X-Google-Smtp-Source: APXvYqzhrFwpuYwd8Wlj1WmlC+ES/GKmbsEVqf2kNamEBw9yHqXZ/UGxwK3ReXng8nT7sP5aDGlQyg==
X-Received: by 2002:a17:90a:c56:: with SMTP id u22mr654373pje.24.1573009742083;
        Tue, 05 Nov 2019 19:09:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:09:01 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [PATCH 46/50] power: Use show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:37 +0000
Message-Id: <20191106030542.868541-47-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Aligning with other watchdog messages just before panic - use
KERN_EMERG.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 134a8af51511..3f39c9524c4d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -487,7 +487,7 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	struct dpm_watchdog *wd = from_timer(wd, t, timer);
 
 	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack(wd->tsk, NULL);
+	show_stack_loglvl(wd->tsk, NULL, KERN_EMERG);
 	panic("%s %s: unrecoverable failure\n",
 		dev_driver_string(wd->dev), dev_name(wd->dev));
 }
-- 
2.23.0

