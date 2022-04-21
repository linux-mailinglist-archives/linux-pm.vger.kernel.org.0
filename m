Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0450A557
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiDUQ1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390640AbiDUQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 12:18:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8783B28A
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 09:15:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k22so7415129wrd.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiFPVEZ/890BOXHBWTr8Id5xWtU3CWG0g0Rj3LfZsEw=;
        b=I3Xk5E68FZ0l1QV2yAN+r9zykHAnVbQhzvC5rfpMlNUkdiKdYhEjy8Kl+xrFsAATRJ
         YLn7LWbwcKQ5kfNr524MjNa5Hpdcyl/S5UCC7kKiIyAsdk2p7SHvInDw/dBgbX5jpCL6
         iYNoPAWiwSdkZ/9cjlNBIm+e/g7IU743QrL3ouvOvelnXZ6aqv3Ft6kUxKLf3eM9tJAS
         z0bcUNcgTYaYhzAMIXHM+smMjjZ0a79g5mwbAxz1BhwEFcfyyHDRURdidSjV9DyY9TjI
         xOR2o1EoJXbhzaidGfjAilEbahG3OUtCfvYkUUOhE1ZXRBc/LNHfblgbFgFLA7/emle8
         2/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiFPVEZ/890BOXHBWTr8Id5xWtU3CWG0g0Rj3LfZsEw=;
        b=qTSqGmkEmwIjbDkRHSLXPbhWK66w7y224Oa8UpHXwa7B8JQ8q8uVoRZD/D3HDh/Y+X
         txi3gm6rO5kouzt6HA56AKTM8cE/oWffDHrnXlYlgnW2vpee3vjre5Ww2y5fQnh033A1
         56JiKVk7uqxT/soRAe4ZjcQiHZFnEzKsZAe8ndwkYil+pwgVkoukjMQYOi6Fz+mJ0ssH
         /2A6adkA6ZC1xYXGFdSsFmmh7Y9RbpkIWnjgiAgsl1RyemFVfCWtVHVib2KEW51gZERI
         O4SI9nsB5Kh5Dt51hSS9eJ5hgyIwCvGXVPYcN0IOicnumCAnWzX/DRtLNwU+Ep8Yw/m0
         T9Aw==
X-Gm-Message-State: AOAM531iUsVcYQOYuTHAalwLPv8xgC2h6vyq320sAallqNDXn6dBqRw5
        0fd1bFiZWzqKG7enUzCqTkye1w==
X-Google-Smtp-Source: ABdhPJwx38jxjjyoCbEDJI6s8Wwm3ARUG66bz7F/8861ht83YrP6P64Q5Ohy+DYQ6ywhuQBUZApdfQ==
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id b5-20020a5d45c5000000b0020abe8faca6mr355261wrs.493.1650557746113;
        Thu, 21 Apr 2022 09:15:46 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2865667wrf.10.2022.04.21.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:15:45 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH mptcp-next] x86/pm: fix false positive kmemleak report in msr_build_context()
Date:   Thu, 21 Apr 2022 18:15:20 +0200
Message-Id: <20220421161520.401946-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume"),
kmemleak reports this issue:

  unreferenced object 0xffff888009cedc00 (size 256):
    comm "swapper/0", pid 1, jiffies 4294693823 (age 73.764s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 48 00 00 00 00 00 00 00  ........H.......
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      msr_build_context (include/linux/slab.h:621)
      pm_check_save_msr (arch/x86/power/cpu.c:520)
      do_one_initcall (init/main.c:1298)
      kernel_init_freeable (init/main.c:1370)
      kernel_init (init/main.c:1504)
      ret_from_fork (arch/x86/entry/entry_64.S:304)

It is easy to reproduce it on my side:

  - boot the VM with a debug kernel config [1]
  - wait ~1 minute
  - start a kmemleak scan

It seems kmemleak has an issue with the array allocated in
msr_build_context() and assigned to a pointer in a static structure
(saved_context.saved_msrs->array): there is no leak then.

It looks like this is a limitation from kmemleak but that's alright,
kmemleak_no_leak() can be used to avoid complaining about that.

Please note that it looks like this issue is not new, e.g.

  https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
  https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/

But on my side, msr_build_context() is only used since:

  commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume").

Depending on their CPUs, others have probably the same issue since:

  commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume"),

hence the 'Fixes' tag here below to help with the backports. But I
understand if someone says the origin of this issue is more on
kmemleak's side. What is unclear to me is why this issue was not seen by
other people and CIs. Maybe the kernel config [1]?

[1] https://github.com/multipath-tcp/mptcp_net-next/files/8531660/kmemleak-cpu-sched-bisect.kconfig.txt

Fixes: 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/268
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 arch/x86/power/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3822666fb73d..1467c6d1a966 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/tboot.h>
 #include <linux/dmi.h>
 #include <linux/pgtable.h>
+#include <linux/kmemleak.h>
 
 #include <asm/proto.h>
 #include <asm/mtrr.h>
@@ -413,6 +414,9 @@ static int msr_build_context(const u32 *msr_id, const int num)
 		return -ENOMEM;
 	}
 
+	/* The pointer is going to be stored in static struct (saved_context) */
+	kmemleak_not_leak(msr_array);
+
 	if (saved_msrs->array) {
 		/*
 		 * Multiple callbacks can invoke this function, so copy any
-- 
2.34.1

