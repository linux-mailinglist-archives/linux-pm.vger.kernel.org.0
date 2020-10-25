Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32179298425
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419583AbgJYWTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419261AbgJYWSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3CC0613D0;
        Sun, 25 Oct 2020 15:18:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so7734433ljk.1;
        Sun, 25 Oct 2020 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ovd3NfCSdg9bU9dh+4Q2Hup4+qw/LQb8GLpwFqymMtc=;
        b=vApupjdqceo8kwP7tkGiF+CeQ8HvVO4ehToXNBsBsUmIc4KnM+YJ0S4Y4ArrsEMGjn
         +BPJRAJRcghbrs0VxErvKhsyNxIp/ZJ23/QrhfQjJ4uJk51ZXep0Z+ZPhPhCmfaoN6Rn
         eaGHbRlrBGqavhKX+ofjdK9bnocwog2+2nA3fmns0BkNXQAdeQ5ufrg3tih/245qGrOn
         tGM1NY7Bp50qpSHx0SUuiH2KMsCljtOwXJPwAv9Hm2zUZqQViG0UbP36596PMpPi9dQy
         x5XDMfT8AplUSiGEnjQB4KLE11Puqq+7Uahrf+KUEqJAtCbDvDrczogIMmKe4iKK/Pn9
         Zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ovd3NfCSdg9bU9dh+4Q2Hup4+qw/LQb8GLpwFqymMtc=;
        b=pyojTumWLkxNe6Q7NRq6kUvKkxpDxs5FEtdGRuDHDK08Hj58+PzSdnGFOwwsiJeCWW
         3t/G1uOiX45aKQopIzBnDkMCObN0TPok/0KjEDQ5Kix8SVbhAUhH+gKoMycGWc2N9USd
         rRDRK/UJrv8ybHoTr1QQ4ZlGizHidKNVaaxJxpPeSFkneQ/0XrV3hX1ETr2mIjLomaau
         4UUGhX+SYbySDlq5eom8N0JaOLx+M3STJwyYxWNKGZmdQHDMzJol4AuWbyeK8VpNzu6j
         dY83+n0iK75Fj6DHmlptHz9mYTtlht3NRpKhd0gyCrCfGEcqTDw7iyOBQJ1Pn6RqjgI+
         chSA==
X-Gm-Message-State: AOAM5328l7r0hVHIdv5H374PAYx5M/L0UUXbWO0Oz52KO9kK0MtG9+it
        CEKPp3dX8Ag3NT2w2ZdyzSl/Ch9T2zc=
X-Google-Smtp-Source: ABdhPJzbzWcQnlQaOvimb0g2tW9/XFIjvrZFeaz5eC3PWUlh/rIicLca75To2aVhmYyDwr8FIPqAJg==
X-Received: by 2002:a2e:a549:: with SMTP id e9mr535291ljn.378.1603664320708;
        Sun, 25 Oct 2020 15:18:40 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 46/52] opp: Put interconnect paths outside of opp_table_lock
Date:   Mon, 26 Oct 2020 01:17:29 +0300
Message-Id: <20201025221735.3062-47-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch fixes lockup which happens when OPP table is released if
interconnect provider uses OPP in the icc_provider->set() callback
and bandwidth of the ICC path is set to 0 by the ICC core when path
is released. The icc_put() doesn't need the opp_table_lock protection,
hence let's move it outside of the lock in order to resolve the problem.

In particular this fixes tegra-devfreq driver lockup on trying to unload
the driver module. The devfreq driver uses OPP-bandwidth API and its ICC
provider also uses OPP for DVFS, hence they both take same opp_table_lock
when OPP table of the devfreq is released.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2483e765318a..1134df360fe0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1187,12 +1187,6 @@ static void _opp_table_kref_release(struct kref *kref)
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
-	if (opp_table->paths) {
-		for (i = 0; i < opp_table->path_count; i++)
-			icc_put(opp_table->paths[i]);
-		kfree(opp_table->paths);
-	}
-
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
@@ -1209,9 +1203,22 @@ static void _opp_table_kref_release(struct kref *kref)
 	mutex_destroy(&opp_table->genpd_virt_dev_lock);
 	mutex_destroy(&opp_table->lock);
 	list_del(&opp_table->node);
-	kfree(opp_table);
 
 	mutex_unlock(&opp_table_lock);
+
+	/*
+	 * Interconnect provider may use OPP too, hence icc_put() needs to be
+	 * invoked outside of the opp_table_lock in order to prevent nested
+	 * locking which happens when bandwidth of the ICC path is set to 0
+	 * by ICC core on release of the path.
+	 */
+	if (opp_table->paths) {
+		for (i = 0; i < opp_table->path_count; i++)
+			icc_put(opp_table->paths[i]);
+		kfree(opp_table->paths);
+	}
+
+	kfree(opp_table);
 }
 
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
-- 
2.27.0

