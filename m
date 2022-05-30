Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE5537EFF
	for <lists+linux-pm@lfdr.de>; Mon, 30 May 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiE3ODi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiE3OBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 10:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264CC5DAE;
        Mon, 30 May 2022 06:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3404B60DD5;
        Mon, 30 May 2022 13:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6285C3411A;
        Mon, 30 May 2022 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917972;
        bh=RBHz7ZF803gdhje7BfbRLZ/t4QWWO44yiiVcusiMfKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8/NTmDyRzotAi3x7xTlEWH61THRKmc7AjUChuf3l+r0oosmwOhLUxnVdeVQ75eKX
         uiZxrCRolWGpL3ufS2B5qgE69SZfZHAx2nyKdtzGX5DkfsePcYfz9prRqPljo8nVOg
         dvMDm6RNGRebrZ8a0FKZ6UfHlTXtchFJ5Q1CWk7bBXx8zQS5dT9DpUz4YBy+WcavwZ
         /r133YQilIjfkVbWuqeYTQYj0b6616950vcSz3n5RL9ICtcPQIMBjHG840wR4vZh3i
         bmJZGJ/3zm6nUXLjAmYqFXorxd5XUwy0mCNudsJJIItkCzfr6ElsQWCOgkNpFloidL
         +gOkGU2PGnFKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lenb@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 023/109] tools/power turbostat: fix ICX DRAM power numbers
Date:   Mon, 30 May 2022 09:36:59 -0400
Message-Id: <20220530133825.1933431-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit 6397b6418935773a34b533b3348b03f4ce3d7050 ]

ICX (and its duplicates) require special hard-coded DRAM RAPL units,
rather than using the generic RAPL energy units.

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..4f176bbf29f4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4376,6 +4376,7 @@ static double rapl_dram_energy_units_probe(int model, double rapl_energy_units)
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
+	case INTEL_FAM6_ICELAKE_X:	/* ICX */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
-- 
2.35.1

