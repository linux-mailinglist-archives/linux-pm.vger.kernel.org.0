Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561552D62F
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiESOe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiESOe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 10:34:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9E79398
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652970897; x=1684506897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3ZZxLXW0g++7yQ4TCcNc5rHJLllJ4ihW+EZESk4M/k=;
  b=Q/UuZByf0LwEMwRru8aYs0Dkmyec3SrmGHooL7p9WXGNQqD4BSLFG59D
   XtzPh4ZRrJ7QLA7i9OBC3pI1hElH3xDPCFuV5xT5oAFPhZOuTcWuAxZ7k
   s9EjT5O+kvcuPTRZGCi+qKl1Zl0zBESjZiGr02kaQ2OSxN2+hb6Gkn98b
   Du+qaPM2Mtfngjk6LmpTh1BtE0l9MuBS7buj9uAPePQmmwPuk0JRG/vCJ
   G5TvoDfjVYmPjHCDoSyEW9eGSnNhTTV4mIs8S3oyyBxWB0HTfRJ31JIAp
   +t16J5N3xwZQK/hdAlnoJqUbhk1j5HOhn5mem1E+1w+7Tj9uJUGVNqGMC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259804219"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259804219"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="570244525"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 07:34:55 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH V2 1/4] PM: wakeup: expose pm_wakeup_pending to modules
Date:   Thu, 19 May 2022 22:35:05 +0800
Message-Id: <20220519143508.3803894-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220519143508.3803894-1-rui.zhang@intel.com>
References: <20220519143508.3803894-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

intel_pch_thermal driver needs a long delay to cool itself (60 seconds
in maximum) during suspend. When a wakeup event occures during the
delay, it is better for the intel_pch_thermal driver to detect this and
quit cooling because the suspend is likely to abort anyway.

Thus expose pm_wakeup_pending to modules so that intel_pch_thermal
driver can be aware of the wakeup events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a57d469676ca..11a4ffe91367 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -930,6 +930,7 @@ bool pm_wakeup_pending(void)
 
 	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
+EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 
 void pm_system_wakeup(void)
 {
-- 
2.17.1

