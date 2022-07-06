Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA55568D9D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiGFPfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiGFPe3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 11:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A2286DF;
        Wed,  6 Jul 2022 08:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF6861FF2;
        Wed,  6 Jul 2022 15:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376AEC341CB;
        Wed,  6 Jul 2022 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657121585;
        bh=h1wfxGz2vBToOZrZjVl2LDtbJkmq2Kug3U3SqP0uKRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQCSvZiTdgDdMMmKHndM3u/UTA54/J7yWLliFHNXX7d2JkYoiz4A3Ljv4JiQJ3clW
         qSEMuwKP6qV18FcnmdFTU5NG5KwhhVItAQnLYiXfkKQEula1JdnLWSIZaFKv0hyO+X
         +OaCHOaBx2orVcmtABAUBUvcU+wTacBhEx5HYa9wjysqMjYyf/oPP6ujhMfq2flehC
         sS3rBIZKODY4RhKA4iDlVqj/Ks1xkiy1oG+v32XIuF77qa0R74QvWmcPRxoFAk0UBt
         ivyz8L9IWc0jtf0cODYT4Nwra3H2Eiec+yrtzCeO9HpKdCyGNmDhuOcxTJ9D/aQRPk
         9Xd+Gc7xUH+sA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liang He <windhl@126.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 05/11] cpufreq: pmac32-cpufreq: Fix refcount leak bug
Date:   Wed,  6 Jul 2022 11:32:50 -0400
Message-Id: <20220706153256.1598411-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153256.1598411-1-sashal@kernel.org>
References: <20220706153256.1598411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Liang He <windhl@126.com>

[ Upstream commit ccd7567d4b6cf187fdfa55f003a9e461ee629e36 ]

In pmac_cpufreq_init_MacRISC3(), we need to add corresponding
of_node_put() for the three node pointers whose refcount have
been incremented by of_find_node_by_name().

Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 73621bc11976..3704476bb83a 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -471,6 +471,10 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 	if (slew_done_gpio_np)
 		slew_done_gpio = read_gpio(slew_done_gpio_np);
 
+	of_node_put(volt_gpio_np);
+	of_node_put(freq_gpio_np);
+	of_node_put(slew_done_gpio_np);
+
 	/* If we use the frequency GPIOs, calculate the min/max speeds based
 	 * on the bus frequencies
 	 */
-- 
2.35.1

