Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E15A76E1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Aug 2022 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiHaGqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Aug 2022 02:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiHaGq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2022 02:46:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0DBFC41
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661928387; x=1693464387;
  h=from:to:cc:subject:date:message-id;
  bh=XhbHQKBK6dMMX1YYDTqim0h/h9vTGqFUSgbRHcu7+5I=;
  b=KEi0INY9fErpTJQPA9wiUj3nct8niNtnNSNHNu1SQjlHWEsMx4TgDWY8
   2aSQT8Jk1WTJzZkldE8HrL6E7M77D2HYUBpW2aJmElVuAlYGP+J78cYI3
   fIaUKrN3Rsyng3BV2aL98GoPkn1gfe0fP5bXC53Fx1FDNNHNCZ4HpPdgb
   0kil4buhDMwWm42/+bRsAnQ57wf9P76pja6LJQ7dGXfehI40KrXyoN5uB
   GPIou4FEC3eB8BgrcwlQHD0IZFCS6rujhVdYmL573hkYLC5TgrW3Up3Mx
   cJMMeq4H6PKMOyvuZPLPb+mUAhXm5w9nXqpdr5Yb/q9sBsvTpQLN5Riky
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296170653"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296170653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 23:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="588929161"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 23:46:25 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com
Subject: [PATCH] tools/power turbostat: add support for RPL-S
Date:   Wed, 31 Aug 2022 14:49:57 +0800
Message-Id: <20220831064957.1773-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add turbostat support for RAPTORLAKE_S platform, which behaves the same
as RAPTORLAKE and RAPTORLAKE_P platforms.

RPL-S 601/801 have different CPU ID than the Hybrid ADL-S platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 831dc32d45fa..df040d87edd8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5447,6 +5447,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.25.1

