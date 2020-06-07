Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCE1F0E46
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgFGS5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgFGS5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBD6C08C5C3;
        Sun,  7 Jun 2020 11:57:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so17763973ljh.7;
        Sun, 07 Jun 2020 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGygXNg/Km//fsZYaJ9FCB7/EL/aLlPnXW30j/MHS28=;
        b=r69z4d5J6lw0MRto8JQP61swFFvrkt9EKKNOcCq3rCRg7EIAIsZaDjNVNgyBuRwV0S
         7ijJy8C0agS/gqOY7BNwBIs5ZetGcslLUFwZ6hmBc5CtYDGNhmZF29wmgcpUbwhjeq1V
         1owdiPk4FIGv3uNDMI9BkDZPb7yLq7i/sH9m7dSoDhZIjwtlq/qjLJKtvFqGF10CW4wP
         Y5Z8QQz6CnRPo+vuXT/6fmW4+x66SZGAxBstje6762r5jAO03am3XVxPbu0kZofHgtrk
         hhup7H0KAtelm2rB0pS4mZlaTzbk9c9QGeDZ3n5trQN/h8oowvomVWAGdPGbhTb5qeae
         1OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGygXNg/Km//fsZYaJ9FCB7/EL/aLlPnXW30j/MHS28=;
        b=FNIjHCyXHhUZCMoo13g3eGOuFg6GHOU+ntWstliznPxPEPt5pFmgKljNw1JuQZ7ah/
         ghTHfZ9BLJ2u42Yg5pRGAzmWnS5yjSvZc4HLvZbubqi6LWV1cKrIV/AxC7jssYi90FCc
         JFGulr9XZj3bU90CSUzHKjlZIKknZAg9qXBJJM8CPIbgeNkpmG4OleaJyI8mpnb+Ru6T
         ULM8Dw6BSKG62GWoULjd5kmtbTbZuNE6LNi34jUHqiAZCnco+PVRM+JCnGg+xGIAkEM5
         I2v6NXyXPVwF/nIBa0kdYLIcbL8FzEEM6Jnr1oj/KHGY9fvS9ikJwr8VX7j5leMzUDfq
         giTQ==
X-Gm-Message-State: AOAM530CQVBtU+GhViQXFX2GsLGN7UbsV1FbWTK6DOwsB66T2py6GZeB
        ge58F+sF4V9oR9CNl3xhw14=
X-Google-Smtp-Source: ABdhPJyBa1kXodoEieeADUeO0t1g6uNXUR0h+2t4KNu7AMrcT7MZmLutI7pTwO0oEr2Dly6fNoUstg==
X-Received: by 2002:a2e:b6c5:: with SMTP id m5mr8870445ljo.94.1591556252328;
        Sun, 07 Jun 2020 11:57:32 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:31 -0700 (PDT)
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
Subject: [PATCH v3 17/39] PM / devfreq: tegra20: Relax Kconfig dependency
Date:   Sun,  7 Jun 2020 21:55:08 +0300
Message-Id: <20200607185530.18113-18-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra EMC driver now could be compiled as a loadable kernel module.
Currently devfreq driver depends on the EMC/MC drivers in Kconfig, and
thus, devfreq is forced to be a kernel module if EMC is compiled as a
module. This build dependency could be relaxed since devfreq driver
checks MC/EMC presence on probe, allowing kernel configuration where
devfreq is a built-in driver and EMC driver is a loadable module.
This change puts Tegra20 devfreq Kconfig entry on a par with the Tegra30
devfreq entry.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 37dc40d1fcfb..0ee36ae2fa79 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -123,7 +123,7 @@ config ARM_TEGRA_DEVFREQ
 
 config ARM_TEGRA20_DEVFREQ
 	tristate "NVIDIA Tegra20 DEVFREQ Driver"
-	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
-- 
2.26.0

