Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CAF3B9988
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhGAXqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhGAXq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A6C061765;
        Thu,  1 Jul 2021 16:43:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u20so10780988ljo.12;
        Thu, 01 Jul 2021 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9otFKisgPOH6tThhGv9XOsJl/riZw+uATOpo0ZIOk8=;
        b=Q9kN4sHZQJxoQVjE0ZP/HLsLJis/iLJGM+CGzfnCv2b6P/zbRB3Gxvz18O6C4xuxVq
         He1kFJ+m2p5KzUJn9OjhSfJ1BWs6DhwDQCOYXUnZ83ftq+pB6Ai/A5Up31hAQpQPHAU5
         35kZu/YlVLmAjKe9UkSCNfwpzSEOqOKwFfZ3/LmUVowCUXsSYZTqj1NYB3+oU5FYqBUT
         P9/jrc+RCLB7Z2kc/7g5TWYso0Ko2wb5aTtQXZZdCbgp3H8nVyl+goAYsj3xK2QNW4yN
         7ceLBnPfdPYFrFh2S61TPIyNkM3hduZTQJ6a+3Jqx1uQX0tkeft5Jwm/E4r0/2IJkpaA
         1Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9otFKisgPOH6tThhGv9XOsJl/riZw+uATOpo0ZIOk8=;
        b=rQZj4P/q643F/N07pMuNwYcOf5+cjD4azNxpBLQetkaHg/gF4u1EAz3stB9PYYATgk
         sYLW0QbAwYSY0OhBSvFCT+wM9idWTUpfeoaP8VH8zJ+hKFN5+HdNyRee85YiHlvgPmni
         ByLACJH2oojYO1/sanIl2JmygmmKYwIj7T11q5Mdl0tj1GLo+NHOduG7jdJ0Alrhw6nd
         6o5bpTkfmTOqaSP+kaBqwx2fgJ5qzksH9f5S8Sh4kfXqRoOygb5z0r+JLad0UEW3wOpD
         QINXbNzt7wderWSMxfkEo+nAUiTzKEM/F8+rUzIG0dLafBSFZY60oTUL3dbc6ICzXN7F
         O0Xw==
X-Gm-Message-State: AOAM530bc8prnj56Jz3/Lei8CGtvnIS4JtgJZdVHAt1o1jfPHXHnqYJo
        rUwoToKG96q5QTrV2veb0Y8=
X-Google-Smtp-Source: ABdhPJyuIkipLFi9GnzWx1JZ0RvxTdsaubH+BAY0RHsNGIxZB/8Mz9e6G0uzaVPbU/sMia/0mXwlXw==
X-Received: by 2002:a05:651c:a0a:: with SMTP id k10mr1541060ljq.22.1625183032556;
        Thu, 01 Jul 2021 16:43:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Fri,  2 Jul 2021 02:43:08 +0300
Message-Id: <20210701234317.26393-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All Tegra SoCs prior to Tegra186 have USB power controls within the Power
Management controller. These controls need to be configured by USB driver.
Expose the regmap to these SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1f6872f7b211..73ba4982ba6d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3202,7 +3202,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3263,7 +3263,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3320,7 +3320,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra124_powergates[] = {
-- 
2.30.2

