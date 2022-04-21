Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB165098C1
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385603AbiDUHOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385621AbiDUHOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 03:14:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D39217057
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650525120; x=1682061120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/cw/sNTx4EM2SSc2yheXO4pAk8iXKAFIMsAs709aLGU=;
  b=iLWEPJP6oVpu14t38aV93oHeExWQorgQ6zYQxkB7yNL4Cf4LhGMzuX4r
   SwcA1cDRuML0FxX1FTLAudD8RWs48PvJ0mfERIfgnxA4ssG1bWzQO8ecw
   bklinRj8xTT/N3DoLlVI2HU/NN6m/3REUwXMl5cvkRKr4YaVLoUCpDUs5
   VZhB6KZDSRNpyi9veClT4TfgbRkxBlvkohhyaQMCiYDsuSsngoy0TwYqM
   8X2qpA4BUEpe/G1w5ksoGtcvaUUpnXV6I3oen6/OEn8yLebplqAb72Np3
   PBfQV0vjCzqPCDs4JIqc2W4Tvl5oFGL49xNN08WiYnElaPTBLLZm6lrdZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264434637"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264434637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="577064194"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2022 00:11:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: add support for RaptorLake
Date:   Thu, 21 Apr 2022 23:07:36 +0800
Message-Id: <20220421150736.94717-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add intel_rapl support for the RaptorLake platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 07611a00b78f..83da499dd6ec 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1107,6 +1107,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.17.1

