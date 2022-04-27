Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1155110E2
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 08:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiD0GMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0GMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 02:12:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0C66C95
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 23:08:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245749358"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245749358"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807873510"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2022 23:08:54 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Jan Beulich <jbeulich@suse.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 0/2] intel_idle fixes for 5.18
Date:   Wed, 27 Apr 2022 09:08:51 +0300
Message-Id: <20220427060853.3975453-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

these patches fix a couple problems in the intel_idle SPR support code.
Could you please merge these fixes to 5.18?

Both problems were spotted by Jan Beulich, thanks Jan!

Thank you!

Artem Bityutskiy (2):
  intel_idle: fix the 'preferred_cstates' module parameter
  intel_idle: fix SPR C6 optimization

 drivers/idle/intel_idle.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.35.1

