Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF21D477A
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEOH5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEOH5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 03:57:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122CC05BD09
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so596569pfy.8
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elQ0qcrtLj23yRuHcP4iQkFYaetay/9RqnWGnNoLGo8=;
        b=WwdP3nRL+VfvcUuP38UNzmDQu7IFRdu3HRlZjjNcZ9XeAC41Z24rK7S+xCMY6M/zp/
         P+bPXlMNQgGDGUTokMXEezvVrV3DVJ7nzCWrSbiocbQ5ZQzZz3MUZPcbaNoTLsaPcm3Y
         oZB+BPrUrc17AX80piWyR0PvhAjZo9ZHt2nBju5MtGRYPp35o/RxhA4z+Sxtb3p7GHC7
         RVlDn2SYgjRAkCEcc/c5AAvIKvUZOinqSoIc0WZ7KyE4YitwSqYMBboSr+HvP4qS2Qps
         5maBaW4el1fmqZWpnmc800sNx/jwkmpZQzRATwQo4IfufYj7I6IxJBHFZLfFbTJ4vVHE
         o6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elQ0qcrtLj23yRuHcP4iQkFYaetay/9RqnWGnNoLGo8=;
        b=ML7ZNQwJMA11NRp/jYn6gupu8aEcBWwmVXLLc9EmqjU/AP5dwA82QPzfDARp2zIj36
         91vNq9+YIbEVHdO6GdAtlj25HHYbT333O/RBsVItPa67TFT9x3ta/GT2Kc1TPvwuHcR4
         rFrxedXEyAhW9dWBebVRP1TbyIWnV5bNy+SPQMaEtPh3dPBdwcBXoslm+xpLnwv/mRzQ
         udKuVq9Vw4ja0+0hklblmIQ6/WEHE95aUgAT05xJI39K/tlHt0DHx7Qz3TmyJ5PP5gPG
         gFBIpz0t2zpo51srR/N00HAVQctQwH2NOuP0pPMY5oScPccdQtqXegJ+03xc5Tc//hua
         b58w==
X-Gm-Message-State: AOAM5303tmM62/wwJMJMkD40nqRRtr3IWou/TcvHbNG67lKnz3daiYez
        nQh80OvjgjnMqEM08+a1WLROyA==
X-Google-Smtp-Source: ABdhPJyWr3A49hhwL3JHGHq0FLYsrWLPnDwiWdm26NyePL1P1skJcLSLHyvPUFgMboqamu2ra0psPw==
X-Received: by 2002:a63:6447:: with SMTP id y68mr1874140pgb.395.1589529452585;
        Fri, 15 May 2020 00:57:32 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id x12sm1213258pfq.209.2020.05.15.00.57.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 00:57:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@samsung.com, peron.clem@gmail.com,
        m.szyprowski@samsung.com, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Reorder the code for !target_freq case
Date:   Fri, 15 May 2020 13:27:20 +0530
Message-Id: <e5875b12062c42ba09f9b67feb5f2681ae025f63.1589528491.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1589528491.git.viresh.kumar@linaro.org>
References: <cover.1589528491.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reorder the code a bit to make it more readable. Add additional comment
as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e4f01e7771a2..dda8164fad56 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -817,15 +817,20 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		if (opp_table->required_opp_tables) {
-			ret = _set_required_opps(dev, opp_table, NULL);
-		} else if (!_get_opp_count(opp_table)) {
+		/*
+		 * Some drivers need to support cases where some platforms may
+		 * have OPP table for the device, while others don't and
+		 * opp_set_rate() just needs to behave like clk_set_rate().
+		 */
+		if (!_get_opp_count(opp_table))
 			return 0;
-		} else {
+
+		if (!opp_table->required_opp_tables) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 		}
 
+		ret = _set_required_opps(dev, opp_table, NULL);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

