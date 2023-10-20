Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231C7D1026
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbjJTNAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377411AbjJTNAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 09:00:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F745D61;
        Fri, 20 Oct 2023 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697806831; x=1729342831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLOxA8Bx0MyGO/U31hrvN9KrvyYCpT1lmRzQsWSFyG4=;
  b=A5+YiMkMQSNw7ROhdXG/PcgSMTruZhIIOiPy2rZMoxo5KBEIylh1+MEm
   M1GmBnzuM1mCBSswmikYZ1Li2Zn4lLMG2S1SPkCh1aaqC3i0AahmAyk/t
   5i1oNHHAkmpkRLkkOitrTr4x2kroNvd/XxPHycfMwyp4Bq6jxvQ8D64DV
   ir4kGjUXZ7IHSmvXK6DrLwDnR965jy3XBPQFERWSKPV1N7TW/n1f2fDj2
   aQp+axo59FbvBMPaurp/2qdKf9KyBaIAbpVGxY+7E4D4WWeiWnGB+jE89
   3Twj9bVvNwQKtyzdfyIq4P4jjyJygSXN/0VkJDAlQAJXqxHQadgnMhydu
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="33575472"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Oct 2023 15:00:23 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C026F280085;
        Fri, 20 Oct 2023 15:00:22 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@ew.tq-group.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 4/5] clk: imx: clk-fracn-gppll: Add 477.4MHz config for video pll
Date:   Fri, 20 Oct 2023 15:00:17 +0200
Message-Id: <20231020130019.665853-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the 477.4MHz frequency support that will be used by video subsystem
on imx93.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..deb03c6d16e9 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -84,6 +84,7 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(519750000U, 173, 25, 100, 1, 8),
 	PLL_FRACN_GP(498000000U, 166, 0, 1, 0, 8),
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
+	PLL_FRACN_GP(477400000U, 119, 35, 100, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
 	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
-- 
2.34.1

