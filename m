Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D626836E80D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhD2Jdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Apr 2021 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbhD2Jdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Apr 2021 05:33:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F6C06138B;
        Thu, 29 Apr 2021 02:33:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z16so5803145pga.1;
        Thu, 29 Apr 2021 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n5L2AIimKFLAUZfgpspVAt5w6ETv6xW2xRf+VprbPEI=;
        b=rZ/qOYwIqMbJeNJP7b1oAUXx8u2Cep0qq1Ex6A4v+AlAg/rpmdZ7IOGF24S6DNfY6J
         ZFRq1bZ/ZjnjGJvfHnkzDT8k8L0+ejFzvgIpDZqIPcAG18CJ4OrLiPUYnlV9lsBKxdWY
         S50/yIR31xioZZ0V6U1QcdeMCA33NSZRRo8nkHGO34CJLJiqwx10VurZ+nLd7BKh5rG+
         h11KBwstWrYdo0RVcOgKEa9LrQ0up3LBgXYPNcBQzZY0dbHVyQPSvmFzmm//FG2bH5Ap
         4kgVtYXVGfmTiGw9EnUAomUOy2D7DlTRogS+ns/1UWzm1yFz0sWrOpeIdGF8FKu1SYA2
         riew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n5L2AIimKFLAUZfgpspVAt5w6ETv6xW2xRf+VprbPEI=;
        b=oowW4ju5QbMs+zSQyCyne8mPW2KEcCqEaw2mrBuBvqCPeUCqlO70OSttifzGLh6sDm
         FhTUNlYZKSu1mJQwqkiYzkDza2btibgRjP1HdRUpsPC/JuQx2OSHB5o4q2qSYL5kNV6G
         2YRvy27EfsNpbE9hGqVF53kNuyZqe+DdcC2pzNTGy55/RSrmzX4rFh4Fe7MMqcIQDOLw
         YInYjNFVTYeaMAeN4hnTU5+3OwWndDYMgGH+ggAFfbh+RWe8IS/sxzQwo8EXXbAgcvSb
         7JRCTQnclKfNeFF/LsywhGVsT12euGAozSAgE9v3wAczdRbJotGeE2zoKf7pTEs/sf7Y
         vkrw==
X-Gm-Message-State: AOAM5306xxzsOGQ/0UjJgsdgt6Q2puNA39NgB8tDZbggQodY+vKlReyF
        pF8KrLB3a5vIUukSUMIAS05ow/vU8c6pyHOc
X-Google-Smtp-Source: ABdhPJxxPm3ss49Y7LcvKCuK9DvuJcKTrXCFm4sRVhlW6MeChLs3GP9rc4KBPEbUiSbmxb8KUNyd4Q==
X-Received: by 2002:a65:5a48:: with SMTP id z8mr30167905pgs.71.1619688788591;
        Thu, 29 Apr 2021 02:33:08 -0700 (PDT)
Received: from localhost ([157.45.42.16])
        by smtp.gmail.com with ESMTPSA id 23sm2013225pgo.53.2021.04.29.02.33.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 02:33:08 -0700 (PDT)
Date:   Thu, 29 Apr 2021 15:03:27 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     jacob.jun.pan@linux.intel.com
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: idle: intel_idle.c: Added a blank line after
 declaration
Message-ID: <20210429093327.2c7hfq3rycocb56t@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added a blank after struct declaration
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3273360f30f7..25023690625a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1715,6 +1715,7 @@ static int __init intel_idle_init(void)
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
+
 		printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
 		       drv ? drv->name : "none");
 		goto init_driver_fail;
-- 
2.17.1

