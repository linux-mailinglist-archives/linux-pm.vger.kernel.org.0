Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D84294ED
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhJKQ7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 12:59:55 -0400
Received: from marcansoft.com ([212.63.210.85]:56620 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232955AbhJKQ7y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 12:59:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A1FE742468;
        Mon, 11 Oct 2021 16:57:46 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does not exist
Date:   Tue, 12 Oct 2021 01:57:02 +0900
Message-Id: <20211011165707.138157-5-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When required-opps is used in CPU OPP tables, there is no parent power
domain to drive it. Squelch this error, to allow a clock driver to
handle this directly instead.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/opp/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 04b4691a8aac..89e616721f70 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -873,12 +873,13 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
 		return 0;
 
 	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
-	if (ret) {
+	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
 			dev_name(pd_dev), pstate, ret);
+		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 /* This is only called for PM domain for now */
-- 
2.33.0

