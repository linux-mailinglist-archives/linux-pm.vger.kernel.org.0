Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908716E7D07
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjDSOkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjDSOkO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FB44A7
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079342"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079342"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232552"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232552"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:48 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 0/7] misc intel_idle cleanups
Date:   Wed, 19 Apr 2023 17:39:40 +0300
Message-Id: <20230419143947.1342730-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

These are misc. clean-up and minor improvement patches for 'intel_idle'. The
common theme in them is improving the 'intel_idle_init_cstates_icpu()' function
and things around it.

The patches are against the 'linux-pm' tree, the 'linux-next' branch.

Artem Bityutskiy (7):
  intel_idle: use pr_info instead of printk
  intel_idle: cleanup 'intel_idle_init_cstates_icpu()'
  intel_idle: further 'intel_idle_init_cstates_icpu()' cleanup
  intel_idle: improve C-state flags handling robustness
  intel_idle: fix confusing message
  intel_idle: do not sprinkle module parameters definitions around
  intel_idle: mark few variables as '__read_mostly'

 drivers/idle/intel_idle.c | 58 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 22 deletions(-)

base-commit: bc538c8be4bd17479f88f2e1a78d5b76b5523319
-- 
2.38.1

