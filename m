Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3636B3A912D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFPFf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 01:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFPFfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 01:35:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4109C06175F
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 22:33:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso3296834pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltLj09RyfOdWMIEM0MG0ccEuiq6U59etKafB5sPzk0s=;
        b=jHE61uyUv0XMNagTHrkkUEaFsVLD9NrLsaj4xu+pGVb+uh/e2nz3UlD2zJArDaCADd
         zhtRKsfghNSVYOIlQ4kFJRmagRDAAANsqEYHE6t1IgUyYW30wtB73KKizNTIwI9vdMx5
         0WFHzvKLZ5yYmFjAMYMAKjYO5l+iX0aD9ZQrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltLj09RyfOdWMIEM0MG0ccEuiq6U59etKafB5sPzk0s=;
        b=eJ6ojor6QU8B2rCvWU0Hoq4wXiTVIBMiwD8WyCb932BY0MmF4nXf7NnFWloxQKfTYF
         kiuBnz8cSfe2fUyhJvmRLOcASrStOpwAtb6BRS8dVhzSf1WHYcBBvzFiBegFuJ1TCmRd
         oPefwHIhfQO47vGTlHNiYQBiwBJ8L2iQwk7GoKp3Dn13ubW0ERZyK0Tr3pqyYtnuBtO5
         VIn6x5jr0wfFmr7AMVxcjLNTum8g6zQjGuw/nUKTKQW7YRHnvuXG33UhnYsJyV9AHtqV
         Guk7P3LvNqbOER6o8y8qcsa5n8aMDQv9mzLLa120IjDv9hjvWNeCqMZ61WxDkn0NL9QC
         6BeA==
X-Gm-Message-State: AOAM531W6STVPHlAGcdyXj3a2go6dlvB5TQwEuU0zEaQaVgNrebkcAKy
        jrIPJRntXOFVzXJ3G5Ga5dBf6Q==
X-Google-Smtp-Source: ABdhPJzXqJSIVEfVTm49SsH66GLHTyQUTiHWKL0+3DqMB/qsMzfrj/hkbqfKj7nbImIaloR5Wk316A==
X-Received: by 2002:a17:90a:a585:: with SMTP id b5mr8922657pjq.10.1623821621350;
        Tue, 15 Jun 2021 22:33:41 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:2915:9186:62d1:9af3])
        by smtp.gmail.com with ESMTPSA id c21sm808034pfi.44.2021.06.15.22.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 22:33:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     "Viresh Kumar )" <vireshk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Date:   Wed, 16 Jun 2021 13:33:35 +0800
Message-Id: <20210616053335.4181780-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't limit required_opp_table to genpd only. One possible use case is
cpufreq based devfreq governor, which can use required-opps property to
derive devfreq from cpufreq.

Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
This is tested with the non genpd case mt8183-cci with passive
governor[1].
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
---
 drivers/opp/of.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index aa75a1caf08a3..9573facce53a5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 			lazy = true;
 			continue;
 		}
-
-		/*
-		 * We only support genpd's OPPs in the "required-opps" for now,
-		 * as we don't know how much about other cases. Error out if the
-		 * required OPP doesn't belong to a genpd.
-		 */
-		if (!required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
-				required_np);
-			goto free_required_tables;
-		}
 	}
 
 	/* Let's do the linking later on */
@@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 	struct dev_pm_opp *opp;
 	int i, ret;
 
-	/*
-	 * We only support genpd's OPPs in the "required-opps" for now,
-	 * as we don't know much about other cases.
-	 */
-	if (!new_table->is_genpd)
-		return;
-
 	mutex_lock(&opp_table_lock);
 
 	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
@@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		return ERR_PTR(-ENOMEM);
 
 	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
-	if (ret < 0 && !opp_table->is_genpd) {
+	if (ret < 0) {
 		dev_err(dev, "%s: opp key field not found\n", __func__);
 		goto free_opp;
 	}
-- 
2.32.0.272.g935e593368-goog

