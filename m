Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF762AA830
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfIEQSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 12:18:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37751 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388676AbfIEQSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 12:18:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y9so2078967pfl.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uGQDHiVh7Y3nm+Fh7RZmraqTkygsaWl9aTS4H8V2qOg=;
        b=G2V7SSCDYkEQo7LiHhdd0FmXiDoCypwneNd0t71NKBiF5VjSYh7im1hJZ8psR9OmdS
         vENjDDDDtQ6NwdMR/F+BtzcV44YofhYGBf5najafmfR9bR99jS1kCvdcrsHzlLCSSxeK
         7GcxrvgtY7wXU8hlt8M2yDvumDEEvUFc4v5wE3taJ+LuREXiOMnvl/Lw2ns+rIOFePa8
         KXF5jz1R9EzIfWODk0dy/N4ScNQsSc3JHGq4NtqlEeVnjTRTJemxCs9WCnFjW8eLTaw0
         DZr6IXQltw83ioNUii9IPkrTtAIZFHKWIM+WRq0gtusHdP3ZkBTPW2WufSyZjWejUhJa
         2Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uGQDHiVh7Y3nm+Fh7RZmraqTkygsaWl9aTS4H8V2qOg=;
        b=Nfw37/QW6K9kJiBBLoObZN6Qxqp7GqBXr70HjqINyMQPHNMO1O3murvHG6cOCVqZTT
         hpYFW9jmRPCLiv50Ryw/7rPdoP3ztJSzKQSXd83r5YljsZAfKn436Gm3R5QNYPQIevBT
         ZHboyX2Z62Uk/wENuuAMOkayJCbe+wOqw8ACe0D9M8CNXw4VLcyXFhJPxfTtIAkz21RF
         5XvM/VJRyJHo0jp4iWgZNNP2jJu8FUPllYKwhedj+QftpZ7LRYfCN8PcdG41qY9eHaHG
         bvDyFtyQ6Q+qvGUrVyOmk3TkyUxBP95MIvE0BoQLc9cgfwH4+cRNbPaw39YoXiaQajOY
         pkLA==
X-Gm-Message-State: APjAAAXmhc0FZNSIVvRDP1cN6eideUw0rMVX7pJzZaso18oqXZNrsFQP
        NJ6Ozy17biwtZTYCWHVHbN6Tiw==
X-Google-Smtp-Source: APXvYqzyC7KQpz20rtOB8zivfhdGWRJPZQhVbOYyx1ZP0zkE+kwOQ1jHtksq4R981qryiPR2vzsmvw==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr3771562pgi.186.1567700300722;
        Thu, 05 Sep 2019 09:18:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m129sm6324005pga.39.2019.09.05.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:18:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [BACKPORT 4.14.y 16/18] ASoC: davinci-mcasp: Fix an error handling path in 'davinci_mcasp_probe()'
Date:   Thu,  5 Sep 2019 10:17:57 -0600
Message-Id: <20190905161759.28036-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

commit 1b8b68b05d1868404316d32e20782b00442aba90 upstream

All error handling paths in this function 'goto err' except this one.

If one of the 2 previous memory allocations fails, we should go through
the existing error handling path. Otherwise there is an unbalanced
pm_runtime_enable()/pm_runtime_disable().

Fixes: dd55ff8346a9 ("ASoC: davinci-mcasp: Add set_tdm_slots() support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/davinci/davinci-mcasp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b4e6f4a04cb6..07bac9ea65c4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -2022,8 +2022,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 			     GFP_KERNEL);
 
 	if (!mcasp->chconstr[SNDRV_PCM_STREAM_PLAYBACK].list ||
-	    !mcasp->chconstr[SNDRV_PCM_STREAM_CAPTURE].list)
-		return -ENOMEM;
+	    !mcasp->chconstr[SNDRV_PCM_STREAM_CAPTURE].list) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	ret = davinci_mcasp_set_ch_constraints(mcasp);
 	if (ret)
-- 
2.17.1

