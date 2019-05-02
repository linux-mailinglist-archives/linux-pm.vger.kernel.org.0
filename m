Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F411468
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEBHnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 03:43:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40768 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEBHnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 03:43:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so677308pgl.7;
        Thu, 02 May 2019 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IYrhwIfTl0JQcM7BO0AqF05htx4Q+e9ojsBCSN9J3zc=;
        b=ryJsTDeeevfD652/u/fn6XiAtJre9akUyz+6B9pnLylploqh0TZjLwq2BsKog2s0rH
         RrrvP/BwZEYvItcjdWgHIf/J+TPW6KxYh121NSHE3R9e03O1533E3Gvn1e45bHY4EpMu
         BRlwTr203nRJSEsgku5acRcrTM1RavY0qIuqFplN47x02oNm7M1XkVwKcPqWxGhTZjoj
         4eZNp8aNJm8Eq6PxIW6lNywLFguzq1OJq0sLkq39qDD8b78STHs6Zbq0CSvn8iiah5a1
         qtzfE5n5huNr29Bt2Ti4g6uulvDAQBdnS+upzzBuDRrcRaMHUNkO2qbtqg9HYKjw6TyO
         X5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=IYrhwIfTl0JQcM7BO0AqF05htx4Q+e9ojsBCSN9J3zc=;
        b=Uy6oLJ0JIdodpLwhiERo2KsNybm/eS/rL86Bie2sIytiqixNM3gKjUmNfHlMwZblPm
         WD8wcsOO2scZyc4HJMhUWckEsvQ04eJJTbG3rXV1Sd2YvXOyTRdWp+2C4myknW7Uk+ko
         njhRodtKPz4hJ7Zah9jScVkRuquATjWethc4fqMOEDZQUQTW4S77/LgRcJrqdzEYWNI/
         5YhplIlGc+ZmfcjkNBPMsBqN/JBwce1GrY2F55xagUOyokeNsNEGoaQ6VqA5EKmDBt/C
         Mi5zCYVUIx6nL2g8n5tDAmvDYKJrTc8PNuNAXR1XtV82PCi3jqrMF6ZrouS7o5D3vynW
         qEWA==
X-Gm-Message-State: APjAAAWBq6GvCkACuvs2bHL3Yhbw0ockEnEcsWMoyjbwXLAFoulObBve
        L+51S+aVnQBrVv7eQrLKxnk=
X-Google-Smtp-Source: APXvYqzjkbLroOAHRxtiP5QqBobFyO7j/MwXYhTOhP86hS5Law6+y7ihn8A7BYm0CGN+SaWq69KbuA==
X-Received: by 2002:a63:f503:: with SMTP id w3mr2550213pgh.60.1556783002552;
        Thu, 02 May 2019 00:43:22 -0700 (PDT)
Received: from vostro (50-0-151-188.dsl.dynamic.fusionbroadband.com. [50.0.151.188])
        by smtp.gmail.com with ESMTPSA id r197sm50938849pfc.178.2019.05.02.00.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:43:21 -0700 (PDT)
Date:   Thu, 2 May 2019 00:43:05 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nikitas.angelinas@gmail.com
Subject: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Message-ID: <20190502074305.GA6039@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to keep sysrq_poweroff_op after initialization, so mark
it with __initdata. Mark some of the function parameters with __maybe_unused
to avoid compilation warnings.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
---
 kernel/power/poweroff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 7ef6866..d507152 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -11,26 +11,27 @@
 #include <linux/workqueue.h>
 #include <linux/reboot.h>
 #include <linux/cpumask.h>
+#include <linux/compiler_attributes.h>
 
 /*
  * When the user hits Sys-Rq o to power down the machine this is the
  * callback we use.
  */
 
-static void do_poweroff(struct work_struct *dummy)
+static void do_poweroff(struct work_struct *dummy __maybe_unused)
 {
 	kernel_power_off();
 }
 
 static DECLARE_WORK(poweroff_work, do_poweroff);
 
-static void handle_poweroff(int key)
+static void handle_poweroff(int key __maybe_unused)
 {
 	/* run sysrq poweroff on boot cpu */
 	schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
 }
 
-static struct sysrq_key_op	sysrq_poweroff_op = {
+static struct sysrq_key_op sysrq_poweroff_op __initdata = {
 	.handler        = handle_poweroff,
 	.help_msg       = "poweroff(o)",
 	.action_msg     = "Power Off",
-- 
2.10.0

