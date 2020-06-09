Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084BA1F3BDC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgFINO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgFINOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B7C08C5C2;
        Tue,  9 Jun 2020 06:14:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so24978222ljp.3;
        Tue, 09 Jun 2020 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvPgx7nfuClCEbY/9qNxk5Wqh42dXshULVk6+zlWjrI=;
        b=kmbgzZbGDUNhDeo1Alj9Av1nLUQou1tKAx3nPuQjstezuyq0GcBpfJoNKBkhFee4Wc
         eF3nGpANT2Rizt9dotGWkY18sFTED4pkbBbLj6YYM20gHWEzZmKkAuMmL1mpU6m2WdUw
         F/pMtlm/LNaFMLlkso6nJ6CdSyrVeBgf7aO6Sv2e0dfOHu0HNkPvBCvbIic0WvY3pOb0
         nO1voGw4DX2+X27RKEk3b5K/qOfjKk+gixvYeNjjUpOaIYNOCS4VSaTfrlb5Z04c+8Qs
         iUI5BedVAy7lGeX7TqeO3Oy+VTt2LrHAmA9NQYhVJDI7ZMHjnYYmgl3/ftBz4roif9p2
         2l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvPgx7nfuClCEbY/9qNxk5Wqh42dXshULVk6+zlWjrI=;
        b=kCL/Gy3Sr/DdzVJ73VN7PHoq38JmqeqqTR8HL0vioE/ZnpOmHQNuavn/sZnYXvfkez
         lOhig/wEW7lV83pDTaAZY7mPX47DRfvw7W3h+rtXAJwKmWwYPyiLrYk9MiKT7+/ptdua
         RizwAvd0Wfchow/XQUimqC2o4ea1tsgqagzvgWtedl04dXv0MrkoCdxe1gne8GlancTm
         oUj84zMjlo+C6XnNAyyMHoNVT6q1WELbED1AZDhxQ1RRJlRlDJvQFS2b063hKdgVJ3Os
         4VM7zf++a7gy4/GPgPTpGaBD1x9UeKWNlTRmWOHuulSpGW515psjtp7Sr1OvVRH3BXXX
         ecAg==
X-Gm-Message-State: AOAM530IDdkFeqzt9PiFjrlRVoB8uDAy+Jvf4X9Ui/4NW9f9Kb61u+b/
        +k1RH6Amsyw9oi0/dgyLHDg=
X-Google-Smtp-Source: ABdhPJxy7827AnW00tq3e72FmHEJUOUiWbU5qfNMToZ6NGjWCxmQTn6D06j05VnrzcrxXbNW40Bsfg==
X-Received: by 2002:a2e:7011:: with SMTP id l17mr14742315ljc.424.1591708483540;
        Tue, 09 Jun 2020 06:14:43 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:43 -0700 (PDT)
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
Subject: [PATCH v4 15/37] PM / devfreq: tegra30: Add error messages to tegra_devfreq_target()
Date:   Tue,  9 Jun 2020 16:13:42 +0300
Message-Id: <20200609131404.17523-16-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 13f93c6038ab..a03fb16c5c4c 100644
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
2.26.0

