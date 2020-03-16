Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0E186D9A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 15:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgCPOnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 10:43:10 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53568 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731597AbgCPOnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 10:43:10 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so8472125pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0T6eUZWJFpQZ/XJKy7vg1EXBeh3H+l+5vlhQNaC9i78=;
        b=mjrRsnE2XY7JiAQDYEYP09KWRdNgG8/PGGq2UDz/ci+puu8+/esreB2Z8AyQ+K0o2g
         GgB9pxwrVz/ebZFP2laHwIoGlW8PE+HbtGz8I3ijGVPotzy1Zc8BF3onxmPHuDj+2Igy
         ULnn8qz6/HDqAx4b0yPlmLSmByXSd/PbILvkPuPpbg5aZr6wlGTMBLVwWPyWOebqclwO
         Yb0BHwYdOWZd6lGrzzqmZJd0wBEJobHPmot+55IqkURXTTLW9ZK9Rv/oqA1jhnVI4LbW
         BcGT0E9JafnLLGBbFV3NPu9aCXy6xKt25xf7l5wzmZT93PQjDfqai3eWnwuLC5zC7KAA
         mB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0T6eUZWJFpQZ/XJKy7vg1EXBeh3H+l+5vlhQNaC9i78=;
        b=Y2BEUgXRTro/l0EJyF0cJRY1+XC9UUlfj1JmGT4yQTxTS2fbOyjH4Cxb+T39mI6PFt
         FXLXPkqBg6F57Z5Sqd3abgl1GcSb4wTujOpVK9CV9lLJTqaA3y0yk0fz+V2cOKfGhSKk
         vLAT/enp6Ez+tyoC7dcrFnhX6VkMJWtVjddfnABYZM6fBpDGAJCBSEFw8ESIkCHpBLi+
         xz6VWDQvv3z1NGAsf4tiwGenR1tbGogLicQcexMbft2jq5kXl1V9k5RK6VTADLATeTMN
         yOIWl8XDnI8OwAd7SMk9vgyrLCJcQx+ChN568blI1TFJgddY4qrKs4n90XaZfZ04xH9y
         QvVw==
X-Gm-Message-State: ANhLgQ3DqLE+KVrPCuWP3+hDRR67fCZhhMZEtUnOZa4B8sQqXiP2oF27
        LkvRYPZEKA7IZRFFcqgPZkEVmQ==
X-Google-Smtp-Source: ADFU+vsc1UcVd0oS5FFxZM0ubaWJF/60SgDQyjjcOcJyqIsml2MBURYSJQs5xxaWHDhEhaqKRmAADw==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr9747644plj.246.1584369787990;
        Mon, 16 Mar 2020 07:43:07 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:43:07 -0700 (PDT)
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
Subject: [PATCHv2 46/50] power: Use show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:12 +0000
Message-Id: <20200316143916.195608-47-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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
index 0e99a760aebd..9b8450eab02e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -515,7 +515,7 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	struct dpm_watchdog *wd = from_timer(wd, t, timer);
 
 	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack(wd->tsk, NULL);
+	show_stack_loglvl(wd->tsk, NULL, KERN_EMERG);
 	panic("%s %s: unrecoverable failure\n",
 		dev_driver_string(wd->dev), dev_name(wd->dev));
 }
-- 
2.25.1

