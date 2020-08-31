Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A342257371
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 07:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaF6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaF6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 01:58:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F2CC061573
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so3850pfc.12
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6AsLRpDHwakDmuXrbGWlIm7s+3UR/W0JknRh2YDfh4=;
        b=hzSoGJdVJFRfVadzVGFkdQzGa0rAgCZxrxlqYLE051aqDUx0LJxBy0I2Pdmv8pwHuU
         DwNzkona5VKhZ46ENMuGjoCwsHU1v+yBSm3P24B8YKXx50N9bsqT2VCenkt1U/SDNjeE
         D3yzzwbTd2L0AIUT51McE3J0pNiuKL59rLHRMGYtgBj8rG37ySSCvzlQlriOHSkUn8tp
         waJG/BfzTpgOkzohwxav2k4ItlgCPwbed2qxlSDRkyC6/fKLJxKQ+2523ymDD10YNddZ
         P4SB4dZYGkgjdMCYUlcOAnFURre+mHzZ1WB45GdpsnN7CgBJdXkYMa6ntYlCcJyuRZA5
         TkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6AsLRpDHwakDmuXrbGWlIm7s+3UR/W0JknRh2YDfh4=;
        b=MYY8WtVamyGB2qC0PBISaQFyFNztqujj7K8bsLeK0qUlVy5LQaTCTaE3yWnvF97D8j
         5pklfC0ls+65isQq1FadlQqK7XNdVm58X4LRLE+EjLC2mzHaeauzAOEUGuv0nkbbmKsS
         L7/UrxGUGl2fJvvsqGez2X9e/ANXrs/TXMnTeSpnQS2goxpqWiWcClPKEAgh0wHcLrYR
         8zl+dBES3dV4O3O5or0vOLBAQdNiw+r5Gi70oxFmlrPv4VFwOSxqw3Ww70qSMBLiEhOu
         0lmai2+7bAe8U9+F2HjKVduJQ8C13tzrbYmTZ5AshuXhewdQDdyQvJkmFeBD1m0jtOdF
         R1rg==
X-Gm-Message-State: AOAM531GlHcaxaUeeJgf1mtFMtXA0V3QFerNuCscc7VFSZ87OG31pu/4
        YarS5K22VzHovXoEquvybclsbg==
X-Google-Smtp-Source: ABdhPJwGXbHMsM66b23MXrHGO0zax4LzzRWevubMgGap8kSljvyXheQp6cNZ81GCwAXsKxIxJRe9dg==
X-Received: by 2002:a63:5161:: with SMTP id r33mr91670pgl.242.1598853516288;
        Sun, 30 Aug 2020 22:58:36 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id 79sm6549290pfw.97.2020.08.30.22.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 22:58:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Prevent memory leak in dev_pm_opp_attach_genpd()
Date:   Mon, 31 Aug 2020 11:28:28 +0530
Message-Id: <1cadaccf3728ce84d5d0af50a48ce8caaa29eb53.1598853505.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If dev_pm_opp_attach_genpd() is called multiple times (once for each CPU
sharing the table), then it would result in unwanted behavior like
memory leak, attaching the domain multiple times, etc.

Handle that by checking and returning earlier if the domains are already
attached. Now that dev_pm_opp_detach_genpd() can get called multiple
times as well, we need to protect that too.

Note that the virtual device pointers aren't returned in this case, as
they may become unavailable to some callers during the middle of the
operation.

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 000d0fcb4680..e65174725a4d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1960,6 +1960,9 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
+	if (!opp_table->genpd_virt_devs)
+		return;
+
 	for (index = 0; index < opp_table->required_opp_count; index++) {
 		if (!opp_table->genpd_virt_devs[index])
 			continue;
@@ -2006,6 +2009,9 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	if (IS_ERR(opp_table))
 		return opp_table;
 
+	if (opp_table->genpd_virt_devs)
+		return opp_table;
+
 	/*
 	 * If the genpd's OPP table isn't already initialized, parsing of the
 	 * required-opps fail for dev. We should retry this after genpd's OPP
-- 
2.25.0.rc1.19.g042ed3e048af

