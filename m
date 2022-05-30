Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC9538201
	for <lists+linux-pm@lfdr.de>; Mon, 30 May 2022 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbiE3OVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbiE3ORU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 10:17:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3B1157E5;
        Mon, 30 May 2022 06:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC947B80D6B;
        Mon, 30 May 2022 13:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C586AC3411C;
        Mon, 30 May 2022 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918285;
        bh=u+z48SM47mESXsWhumFb6ZKzLhZAopSDcM0JtCRIbDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSjMS/OCX8GoUaDuybE0m1Voq/QxQOL56Lyk87DqGGUSu9Q0RrItkj39vv50tSHSX
         PrQd/NqbhrKYpcOxuSE2j07X+VIbd8NQtUZ8lzALOuM3m0Z0IJzymO2h9Y9c7beE4+
         UJtf42B/aF5LwJYU20WwLmJuFy1zR6bG03xTLDaqQkAIkKjksBufnGzmkqnT2OtB9E
         fZIMvmMfQH8PmRT0ua9wseCH2A9BXzQDSPACwi511zFj+GpmPlGDSolkvzBP4JQFM3
         Vso4G7HRLYKSXsXw73I1ORr9uCgzVc+cRj19X/NRt2xprskpnSeCsJlU+HF6DZ7ouy
         uPrQz0+5G0/gA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lenb@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/76] tools/power turbostat: fix ICX DRAM power numbers
Date:   Mon, 30 May 2022 09:43:08 -0400
Message-Id: <20220530134406.1934928-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134406.1934928-1-sashal@kernel.org>
References: <20220530134406.1934928-1-sashal@kernel.org>
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
index 424ed19a9d54..ef65f7eed1ec 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4189,6 +4189,7 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
+	case INTEL_FAM6_ICELAKE_X:	/* ICX */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
-- 
2.35.1

