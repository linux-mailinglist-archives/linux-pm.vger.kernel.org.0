Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD80697952
	for <lists+linux-pm@lfdr.de>; Wed, 15 Feb 2023 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjBOJxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Feb 2023 04:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjBOJx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2023 04:53:28 -0500
Received: from mx1.net9.ga (mx1.net9.ga [IPv6:2a04:dd00:23:4:b9:6a:78:99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDC1A975
        for <linux-pm@vger.kernel.org>; Wed, 15 Feb 2023 01:53:26 -0800 (PST)
Received: from u34 by mx1.net9.ga with local (@Mail Server)
        (envelope-from <u34@net9.ga>)
        id 1pSETS-000Cgx-Ka; Wed, 15 Feb 2023 09:53:14 +0000
Date:   Wed, 15 Feb 2023 09:53:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] kernel/power/Kconfig: typo a single letter missing
 at line 32: should have been run-time, not run-tim
In-Reply-To: <CAJZ5v0i4WthALOwWPTCW7ESyak6Bq28xWWEzgnDvmFP=WaGtaA@mail.gmail.com>
References: <E1pPlqm-0008w6-Ou@mx1.net9.ga>
 <CAJZ5v0i4WthALOwWPTCW7ESyak6Bq28xWWEzgnDvmFP=WaGtaA@mail.gmail.com>
User-Agent: s-nail v14.9.22
Message-Id: <E1pSETS-000Cgx-Ka@mx1.net9.ga>
From:   u34@net9.ga
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Feb 8, 2023 at 4:29 PM <u34@net9.ga> wrote:
> >
> > typo at line # 32: a single letter is missing: should have been run-time, not run-tim
> >
> > config SUSPEND_SKIP_SYNC
> > ..
> > --- a/kernel/power/Kconfig      2023-02-05 23:31:11.897067253 +0000
> > +++ b/kernel/power/Kconfig      2023-02-05 23:31:04.410465595 +0000
> > @@ -29,7 +29,7 @@
> >           of suspend, or they are content with invoking sync() from
> >           user-space before invoking suspend.  There's a run-time switch
> >           at '/sys/power/sync_on_suspend' to configure this behaviour.
> > -         This setting changes the default for the run-tim switch. Say Y
> > +         This setting changes the default for the run-time switch. Say Y
> >           to change the default to disable the kernel sys_sync().
> >
> >  config HIBERNATE_CALLBACKS
> >
> > --
> 
> This patch is not applicable due to the missing Signed-off-by tag.  It
> has other problems too, but this one alone is sufficient to block it.
> 
> Thanks!

from: "urdopz safk" <u34@net9.ga>
Hello,
2nd attempt to get it accepted, since reviewers had comments for the 1st  
attempt:

Typo: run-time, with the letter e. Not run-tim.

Signed-off-by: "urdopz safk" <u34@net9.ga>
---
Fix a typo at config SUSPEND_SKIP_SYNC help text. run-time, not run-tim 
without the letter e.
diff --git i/kernel/power/Kconfig w/kernel/power/Kconfig
index 60a1d3051cc7..6ee3345bae64 100644

--- i/kernel/power/Kconfig
+++ w/kernel/power/Kconfig
@@ -29,7 +29,7 @@ config SUSPEND_SKIP_SYNC
 	  of suspend, or they are content with invoking sync() from
 	  user-space before invoking suspend.  There's a run-time switch
 	  at '/sys/power/sync_on_suspend' to configure this behaviour.
-	  This setting changes the default for the run-tim switch. Say Y
+	  This setting changes the default for the run-time switch. Say Y
 	  to change the default to disable the kernel sys_sync().
 
 config HIBERNATE_CALLBACKS

