Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E325724424B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgHNAHU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgHNAHT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FBC061757;
        Thu, 13 Aug 2020 17:07:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so3938555lfg.6;
        Thu, 13 Aug 2020 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fHS4JZ6NTiAMWoTmk+f2h360uLuiAqGO28JRAaIjCg=;
        b=Lqx09r7+P63CZvLzEGEDL0uOTZeO/s26FbByWHeGJ1n7nOIxKsE1UXqDfldmqaZTKH
         Gse1kFdFIIb0N09gKhG/eWwLQC5KAM/jXs12Ba+3mY5jhQYYYUJTBowkarLKzuTbxXWk
         lNaz3TEdJwyZDtHoHss7PDWWQi2fHb0AhTsUQ5qOik29Z5mSA2gK9sO2nkpimESw+kjr
         MnXfdqx49jUBIsT7mAlXTtmkI+FnXOl/u0uJ7Db5ko+5X1MgkTwxny9l2juuh82duC/6
         8pcx/n9G3afmZF30SBMB0zKAxL/asyFIHHF1RSRvNCDeJikEPXujNV5tPnPUpyZFMekJ
         vVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fHS4JZ6NTiAMWoTmk+f2h360uLuiAqGO28JRAaIjCg=;
        b=XgJhAok6Ejh92uwlnS7lAbWwhqlm9e7VPPWWJCP7wnVO8ZgtDXkK9YLCFLwgdaIdAS
         zBg6yKZp9qHcwB2pSIh1JANxfAS0B2I66ig1VoMgyqCMs24W5xO+YynneMNx375K22Nj
         KPw4uSGa8WtivpiWyHqzD56sX4ndovX579a5Rfe6OJMCxMu90C/3VjvOCxBS0uxQSUNe
         G+SeNQMd9mzSem3I+1Yjvj9xfjHiX54oZ4k8c9Vjx8QmmpVcs4bi4lnct4nfD/Cqm83b
         i3yXa1Nlp1n2Zr02VXvmW2kyKbGzX3h7G51e52srCurDob/xKcGAb3V4xKUz+F6f8o7N
         HVkg==
X-Gm-Message-State: AOAM533QezCkJ5PtBiumrMSgFogQfQhNb1Z/hBXKQONfSSpCT29AXU+8
        3NGqPj24G0EsizZFXmQYo08=
X-Google-Smtp-Source: ABdhPJxvOiaOjt9dqdR33UJkVITr0YjNchkctX2ILPK0T5GLwCiT4LZAsrVrwRABtUfkiA3Lcg6juw==
X-Received: by 2002:ac2:5335:: with SMTP id f21mr3268841lfh.114.1597363637850;
        Thu, 13 Aug 2020 17:07:17 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:17 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 15/36] PM / devfreq: tegra30: Add error messages to tegra_devfreq_target()
Date:   Fri, 14 Aug 2020 03:06:00 +0300
Message-Id: <20200814000621.8415-16-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6c2f56b34535..a0d6f628aaa4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -641,12 +641,16 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	dev_pm_opp_put(opp);
 
 	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to set min rate: %d\n", err);
 		return err;
+	}
 
 	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to set rate: %d\n", err);
 		goto restore_min_rate;
+	}
 
 	return 0;
 
-- 
2.27.0

