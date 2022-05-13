Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327BD525AEF
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 07:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357388AbiEMFC3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 01:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377051AbiEMFCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 01:02:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E03562F0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652418142; x=1683954142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vCjYgXxKmcVJpRjq+/TVYVoMzyqMINUAw39OPJvBZVU=;
  b=lTevDjbptlrEnWotxOzFPwv/widJ9VQrJPXDcSwhiwmJl0zDPCC2wmK/
   Zpgqimtvx/KlGi/nRQw6d+N9sU41hqZCsWgeK/Hxjk3f+bb0vhflUHgd1
   lk8WQ3B/FPLbR46KBdoMkW532mB8oaVyAmlzBBwi8de9wjbF5/Eq4JxQ/
   AkifwdPLieIORCudGHX+Gsaee2tfh1akPy6TnDY5mID7B0xxjwVH6TIJ1
   Qh/QZBdxqDZZfG2sdXOwpqcOEIvHfSalomDT+6T3c31IKpLTEsjcb6hDw
   TJJ2DKXF412FKHBV6DNv/7qN1beSF16BRarChr6U0dZAlhdPNIEYDfe79
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250748177"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250748177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 22:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="712254265"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 22:02:20 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH RESEND 1/2] tools/power turbostat: introduce support for RaptorLake
Date:   Fri, 13 May 2022 13:02:28 +0800
Message-Id: <20220513050229.3387801-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for RaptorLake processor.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..ab45a2e1a70a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5361,6 +5361,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.17.1

