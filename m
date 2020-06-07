Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E171F0EAD
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgFGS5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgFGS5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF1AC08C5C3;
        Sun,  7 Jun 2020 11:57:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j18so4707901lji.2;
        Sun, 07 Jun 2020 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOO2W4vvP/igevCu4IH6JEPHANPVq7vKrjpVvFg7+eU=;
        b=dRtC+StqRuLCpCgHfPYwlofqS68lJG79Brz1SZw7VYMfL8IsVxpCaJFAkWxV8XNqf2
         MPaI2Jbrx83MX40jZU+0KfrNwEpEEohcZWmAPmxNXnnhvsOfjaqJsr7xvyovlbe2akvi
         Y9gDGYBhxZ8Q66atM3UeToZn3Dl1BStCgHZaFihaHAxdXvVGHW3vAs/1xQNB1UJom3Rq
         jef6QYkisaogv0RqywxdSr2uM4zIIUZ+5wyvYdRxDHdHWZVOPdbYM5urPZ+V60RoIoJ/
         W/cKBeEvHGXIaHei1TZzk6FsvNUT+K4KdSscJLl9GBN4XnnnU9ZcsjtiGJTIyHWI2C1u
         hAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOO2W4vvP/igevCu4IH6JEPHANPVq7vKrjpVvFg7+eU=;
        b=uXvPJewzM4L4IYdbAm+zFXF9dGKqaswT0+vCRihnzOq1XfnAexvOY7OoLdJNtP6QEC
         eYXfscLpmBFch7mxYCVZ7xb4S2ZUOtBOAiBtdoEPPlCwvXMPIB3ytxsyEUNYnezJ3qjo
         fIQPO7AIdb/msc1bT+STIqYI73VvWT95oC4MoB+7m+jkTnMfnpLd8HKPrpQsyDPSPFx2
         vDsrlpUcB4qU+LzWMhFbaBXDLPlIrgsbJH4KVSP5AnihPdtCnERsGw89CcLCtXThuA++
         zN4+rAhCWoywTMzptSNisqvKj3Cy8lMtWq+iZFeG+9Bw7P3dERkuCASRVK7WMIrSWrcI
         nxSA==
X-Gm-Message-State: AOAM532BBuhfKBUsiKI0QSOyR04sXSNmdaSs1nBfUnev9RL4yItFYJuK
        CBg9E/jBq/qjcx8Fh7iyKEI=
X-Google-Smtp-Source: ABdhPJzxLPXZteuNlyWl8auR9iNrq1tcOwGy23AKnpGEA2ohuyWWWo2bNz4jA8TTZz83t8FlbmeSvg==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr9789863ljp.57.1591556242946;
        Sun, 07 Jun 2020 11:57:22 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:22 -0700 (PDT)
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
Subject: [PATCH v3 10/39] PM / devfreq: tegra20: Silence deferred probe error
Date:   Sun,  7 Jun 2020 21:55:01 +0300
Message-Id: <20200607185530.18113-11-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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

