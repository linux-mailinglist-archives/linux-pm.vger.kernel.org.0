Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8A1AF4B9
	for <lists+linux-pm@lfdr.de>; Sat, 18 Apr 2020 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgDRUUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Apr 2020 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728698AbgDRUUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2020 16:20:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7737C061A0F
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2020 13:20:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so6505289wmj.1
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2020 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DA6yBoXY+uQ7OvzNupz4RHEdNy+qYgWPz1xYRJqEZ6I=;
        b=UQK4QjGxrmWelU+MLuQeUjFn2OzPv+DvGUIA4CctUWYY20J07vC8woV+n898Ip8bGj
         ff/clSs0hSPyyTF1iuPQe2PnnH4gwPM/X/C2NvE1InHik1JTrvG6cu01XFdTEYZkTUoK
         poRETuZHCqGim+qfpizzCanmmitY6GFKjz1cHbAfGGhCQ34XhHF3s6mvwkpDZgfEC+C0
         YrttGN6fkMs0r7rtB9YtvAIULfFfHVj0QUV1MT4xCxzyiDwbMZYS1nb7oVlPoBfgD9Gq
         L8l0DAlk3uwxUuUSPum0eb8RbDlh+HciaRm2xBPuWKYRV6qnLjLS4AS8pn/nbuylhObR
         rBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DA6yBoXY+uQ7OvzNupz4RHEdNy+qYgWPz1xYRJqEZ6I=;
        b=sg1ZVstwgQ+rng0yfxKtNsBvb3VJGWC9kuKkpaMw5bIm7BYuNXYlIPgbt2dI4Ap3iC
         z7En3Em8C351Qd0l4fouXye6ruGI6C4WmRgyLBcO2z134C3sdjZdHncLfSDHtmEyJ1Lf
         yuUAxBRsMObEVmvnZTclmSSE7L/NezJsPR890s67mWpXGudQtBQrAKw7gGRzgJ3varYP
         kr2HwRecVkSGfNlMhqLHc4WYbsu7Jeurxu6Drm6VJT2Ig2+oo/A1l1DakM/JxTRBgVBv
         c4eG/KYHUPjdyu1vEyZ27hr4mseVqylL40yzM1si7X1ZBn3smh+pJamLih+5bIFZK5hz
         9GhQ==
X-Gm-Message-State: AGi0PuZQgm+8JwWn5tXhO8sPpj/vehnB3iKXaE8gv8c9V6jFevNVZ8O6
        iAsgKNtcXTgQlIf1YZtoRlJp+Q==
X-Google-Smtp-Source: APiQypIoygjdgN0YddFiw7+SWOuvRq1yqRkPYjSUJq8RFWl2gXtMDF6/o5J5QB0yLRwBfrmtkNAzQw==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr9049757wmi.182.1587241252563;
        Sat, 18 Apr 2020 13:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:52 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [PATCHv3 46/50] power: Use show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:40 +0100
Message-Id: <20200418201944.482088-47-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fdd508a78ffd..fc0108e65592 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -519,7 +519,7 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	struct dpm_watchdog *wd = from_timer(wd, t, timer);
 
 	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack(wd->tsk, NULL);
+	show_stack_loglvl(wd->tsk, NULL, KERN_EMERG);
 	panic("%s %s: unrecoverable failure\n",
 		dev_driver_string(wd->dev), dev_name(wd->dev));
 }
-- 
2.26.0

