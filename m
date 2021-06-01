Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E171D397CE4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 01:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhFAXL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 19:11:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497CFC06174A;
        Tue,  1 Jun 2021 16:10:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e2so142924ljk.4;
        Tue, 01 Jun 2021 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnoq85YcNNqCCtQqXLKZ4thvXGfzyWfnRifmLD508vU=;
        b=JO9uR7Cx8X0thWrL5UTbem+oBmHh/DHdXS9tzPZQFgXx2VjagcSVqYsmmsb/vTEsVt
         CqTXnp2TAI0F9WU8PQ/bVLBx0dxGtQx19byR2aR7uZT5bp1xUHpG2LxOJIvsLY6VsYQw
         9DrBZatGWZcczhBtJXQX3sGi/6PuA2fBnPtlgLg+jkJlRaFEmyOeS4YXiZaK/iFLXGTv
         eeE7ZnQj0AiGRJK9OObRSlYl7aRrmAkOUzHAShDSeGZ80hfgdfo6spGqwkJsksZsmmae
         OgywEuL+8KVpgUPPcJ9lUkeTv25H0XO4mPZr5lebyf5hhg7aKLLMJiufScAsnWYQDMqG
         e+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnoq85YcNNqCCtQqXLKZ4thvXGfzyWfnRifmLD508vU=;
        b=iJdupT291G3qWDBZ0rAQ9Ee94QsCC8SHdktcLuEuTp0KAzQMxBnPxSW04rF9QLtKWm
         D1e9nJV5eiFJQPN10aE2T+6uWgXNj1VHXJMHMjsDQZ+mxHT8xabreixgT9eQdYtUhcok
         NwSuuqbOd4oq1eb9Md5I6Bu3Z4ry8gHn2G3e73LUeZd+inNLG0UpERRGnPVvMJObX6lT
         t2LHj45ZxH1MJhClcJ/dJnoyAEP+6ITSAixmuOdr6zfa4G0KNW+7qdbZgUBz/o7kaLpl
         XwwxAQqyhAL5vCavCW9cvHgMiHgGSKEQckxE1CCuWMZAjq4iVNNYe3zBRwAkaphKPe1Q
         tbxw==
X-Gm-Message-State: AOAM533fN+4XEgcHFzFCfOsWypbXBvtCWayWg99OKTkN6jb6X+6XyJnr
        3ExGkdNOlKXt/tYqHKvdVDXUS/4br5k=
X-Google-Smtp-Source: ABdhPJwN+kZ8wdq/uXAzvKCDjDuNGcv1QmkpnieeqkIhuij4nsoKL+Yb40zrjKAJHnecK2pvBAcZoA==
X-Received: by 2002:a2e:8653:: with SMTP id i19mr22924311ljj.11.1622589013644;
        Tue, 01 Jun 2021 16:10:13 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id s9sm1813574lfr.231.2021.06.01.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:10:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
Date:   Wed,  2 Jun 2021 02:10:02 +0300
Message-Id: <20210601231003.9845-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601231003.9845-1-digetx@gmail.com>
References: <20210601231003.9845-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Older device-trees don't have core domain node. In this case we shouldn't
mark the domain as synced, allowing to begin core voltage scaling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d8eee285fd58..d317532130c3 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -431,6 +431,7 @@ struct tegra_pmc {
 	struct notifier_block clk_nb;
 
 	bool core_domain_state_synced;
+	bool core_domain_registered;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1382,6 +1383,8 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto remove_genpd;
 	}
 
+	pmc->core_domain_registered = true;
+
 	return 0;
 
 remove_genpd:
@@ -3798,6 +3801,14 @@ static void tegra_pmc_sync_state(struct device *dev)
 {
 	int err;
 
+	/*
+	 * Older device-trees don't have core PD, and thus, there are
+	 * no dependencies that will block the state syncing. We shouldn't
+	 * mark the domain as synced in this case.
+	 */
+	if (!pmc->core_domain_registered)
+		return;
+
 	pmc->core_domain_state_synced = true;
 
 	/* this is a no-op if core regulator isn't used */
-- 
2.30.2

