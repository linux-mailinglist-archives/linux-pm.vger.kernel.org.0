Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E353AF84
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiFAVtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFAVtk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 17:49:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0731D0596
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654120179; x=1685656179;
  h=from:to:cc:subject:date:message-id;
  bh=kjupCawO0+LBtPbOcEnuq+J1GIETFrc1mcVN9id2tFw=;
  b=aGOjWqkRK+wk5IX582o4irz230+Ds4pYNLRMziAZ2m2WIGIh1CCIzzu8
   lsEuVyyVb4apixjLijVqHRLVKDse4s5BQlV/dHAkYHV9gP/OdFR/WHj7P
   V4QtCv3655/JjPRPTzNYU1jyXPUuv0yrjz7lu9JkOCOnV98yPOj136oxt
   ziMgWZ1f5ve78oatk3ZTFdL5bU4fpqrke/jAASUya+28ezXXAPBsJ8czz
   nWHkFxoNrxeB3XeUsddZpM20e2R1d15R+caRV3tr/5SQ7SjCCfibd1aOD
   FUB6bB1vpe45PYTZTq4vzI+gkyHoR/UY3EWFQQUCUTEBkvRAZJ28YXTIJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257811459"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="257811459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 14:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="680310070"
Received: from otc-chromeosbuild-5.ostc.intel.com (HELO otc-chromeosbuild-5.intel.com) ([10.54.29.149])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2022 14:49:28 -0700
From:   george.d.sworo@intel.com
To:     lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH] tools/power turbostat: Support RAPTORLAKE P
Date:   Wed,  1 Jun 2022 14:49:23 -0700
Message-Id: <20220601214923.13239-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: George D Sworo <george.d.sworo@intel.com>

Add initial support for Raptorlake model

Signed-off-by: George D Sworo <george.d.sworo@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..c42290133646 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5361,6 +5361,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE_P:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_L:
-- 
2.17.1

