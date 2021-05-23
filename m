Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59238DDBB
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhEWXPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhEWXPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D88C06138A;
        Sun, 23 May 2021 16:13:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w15so31118734ljo.10;
        Sun, 23 May 2021 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/aL8Sm3/Y2q9Z8s81GaMkRCnQV+teKP5pmpLN0OX18=;
        b=NzBR2N9MPw17OtdJKukPiyKNoBqj/h83QN2kpZBFXYHglqia0YSJ7inySZpLop7JNr
         PrrOpeezNxp4uhBdsR3Ef4lSVNHHSBhHJKpt7MWEBDpxmxfD06P9xXz2gTsvMB3Rafa8
         ec9kZpQ8n+T/viQXE9S6WgKzNhVXwL1HZHrT2044JNFC/eYbrnCZmWXDmzi0uom/titR
         zSqzcks9lv0tAe7OP8ij62xvLXJAuyLtD6TGNqI85W+JkOlA3F5q8jnbcRJlm83IXOy1
         O9v6RscIuTUqjQAGMub5XJoraNj3s6PD6GFEEZxRnIA9+EEPbtvyb4YuqnpQ+e15XwEt
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/aL8Sm3/Y2q9Z8s81GaMkRCnQV+teKP5pmpLN0OX18=;
        b=BID44itmfrGUsoLDQJApV7d/IqmUbideusZS8uWa5FhHqkz0a3n+i/1FT5YoUMvu1M
         Yr8YetRxdRtzpNGOPcv5Fm+7ozh+AMDx/bnGOZ10VXGTShR/0m8Un2U19hlDzCRcCeBi
         mxAS0zXm4vm70zB8RIKqdJu48Ry1vqOoukxtFL9Yt8TErE5+hpZiqJCJtZWrDpligG7N
         XAobSa2EwOooULjzqHcM76vAoR9uI1fRP2MDsqAZlg1EpKlgGTwBvbRV2hH/GU6I1yG7
         SbzJqldBT9xXMW84fZfcuBP72yNjfRRf/GdVftdxqe+4Qoev+Hiowmb3Htgc8Fc6GGoy
         5Fhg==
X-Gm-Message-State: AOAM533r9edwnMsMH82PRsS5750YpQjar09xK7JthZfvJk9yyqwdHoz7
        g1EoLgyXOFu2ivPZEDtj4UQ=
X-Google-Smtp-Source: ABdhPJxcQcXnrlsglLBKj41EHLLupEHEEwL/Kjet+9tvFXeabty9X+/oxKscvz/r5ulV6i8ByLpwdw==
X-Received: by 2002:a2e:9d47:: with SMTP id y7mr14481109ljj.293.1621811628543;
        Sun, 23 May 2021 16:13:48 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 02/14] regulator: core: Detach coupled regulator before coupling count is dropped
Date:   Mon, 24 May 2021 02:13:23 +0300
Message-Id: <20210523231335.8238-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Detach coupled regulator before dropping coupling count in order to allow
detaching callback to balance voltage of regulators. This is needed by
NVIDIA Tegra regulator couplers in order to bring back voltage to a value
that is safe for reboot once regulators are decoupled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index aae978c0c148..83571f83af04 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5084,6 +5084,13 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 
 	n_coupled = c_desc->n_coupled;
 
+	if (coupler && coupler->detach_regulator) {
+		err = coupler->detach_regulator(coupler, rdev);
+		if (err)
+			rdev_err(rdev, "failed to detach from coupler: %pe\n",
+				 ERR_PTR(err));
+	}
+
 	for (i = 1; i < n_coupled; i++) {
 		c_rdev = c_desc->coupled_rdevs[i];
 
@@ -5111,13 +5118,6 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 		c_desc->n_resolved--;
 	}
 
-	if (coupler && coupler->detach_regulator) {
-		err = coupler->detach_regulator(coupler, rdev);
-		if (err)
-			rdev_err(rdev, "failed to detach from coupler: %pe\n",
-				 ERR_PTR(err));
-	}
-
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
-- 
2.30.2

