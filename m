Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C431F3C14
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgFINSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgFINOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BBC08C5C4;
        Tue,  9 Jun 2020 06:14:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so25007509ljn.4;
        Tue, 09 Jun 2020 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOO2W4vvP/igevCu4IH6JEPHANPVq7vKrjpVvFg7+eU=;
        b=A51TyIWJ7Rx+M/S8Z4AxBJiGchLlAeYlZ9ygTRNM9UaeJytu7axCuE6NJ30tVQb/Qr
         wEt4bI7SGiqBmsN23yEmDSXOk+m58XiRM6LaVPColj+n/rZS7rRxDn59tMQNy4EigbVN
         nYYQAN9mrEc6YG9EFJrx/xV9JUFeBG56QJaaK6ctw0n9H4UKpcK0yeWeLRtKGRx0Ilpf
         YcOWTe4IS6rfIefYSChRPl65tCRS5zLpNX7ENVYDg8VG/t+Nzn6WGjwFHYKKfIFm6jzj
         1OzrGWgkKUDR7rluN2q1UJjrqxJpHT1ZyFL0NCnjLpU9/VG3Pvc+C+YBL4o5gX6JHfDZ
         DhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOO2W4vvP/igevCu4IH6JEPHANPVq7vKrjpVvFg7+eU=;
        b=Ux6iqNuanZ4H1oVjmlCYw/yAYttI50FEWpFSDpELmDkbyTpF2gxur41LjcAmvM/PVn
         oXVWwAxkQZDwOVlAXk4ad+WJmungYuhx61zLt7C8UxLrYQb0Gsl0lx1KeDEFPHPAAN42
         DjFCs3DSsxTPzBcOL2U58saUd4gQZVC94Fm7x+utuNahAdbyrG+SBo6D7QKueThzYj0W
         Lvr2hgK2CgvRho/mrK09qM2qjs+MtDT8rOymZKvsDYpX3ICLOIJebmcfziBoLrCdYbo+
         6PpkrZaJHnx7trpZL9x796hLoLN1W3AnbQqQjr1K+TcsXclnHCnywbLuH2/RHlDdC0gJ
         oCFA==
X-Gm-Message-State: AOAM533EcYOMrwLqjtGXRU4OcJcVtbn3e9+11nosJiGqUbvPHydpgO4e
        BnL5VuzxRk+F+B8YSu8fuzg=
X-Google-Smtp-Source: ABdhPJyVqj4ryz9H2FvaQa4kZS3Q1Z6etIVNWy3kfiBgX8s492y43kO2ILP+3gviTVFVyE7n7KtZEw==
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr12768662lja.116.1591708477515;
        Tue, 09 Jun 2020 06:14:37 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:37 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 10/37] PM / devfreq: tegra20: Silence deferred probe error
Date:   Tue,  9 Jun 2020 16:13:37 +0300
Message-Id: <20200609131404.17523-11-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra EMC driver was turned into a regular kernel driver, it also could
be compiled as a loadable kernel module now. Hence EMC clock isn't
guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
there is no good reason to spam KMSG with a error about missing EMC clock
in this case, so let's silence the deferred probe error.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index ff82bac9ee4e..6469dc69c5e0 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -141,9 +141,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	/* EMC is a system-critical clock that is always enabled */
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		err = PTR_ERR(tegra->emc_clock);
-		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
+	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get emc clock: %d\n",
+				err);
 		return err;
 	}
 
-- 
2.26.0

