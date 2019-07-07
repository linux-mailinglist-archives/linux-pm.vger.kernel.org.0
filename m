Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26B261807
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGGWf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43678 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfGGWfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so13114910qto.10;
        Sun, 07 Jul 2019 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ICuZeSplUMLkTfqTJvkEHZk7YjPYPX7TJabyKVwwTM=;
        b=AdeG6WOwwDo6uXUZ4RDPowi0tNJ9inveFi52N/RSm9kywwrbKUHIlikirnrhFvdVF5
         LW0iwjolrh04ooyDHSvlOFlkI8Hwmi0NIt31JDIAUClcmsqsc5ueDMKuJKrLSnFg+N/l
         t1ywdgbgGUc0OJ1HMbvrNGi1KT5ze19bWPEYkgh2Z1I6QRCjoW14utEr95sSp8KPz9Uu
         DiRRlBT3zw63A1qG9UmuH1PR3FKsD9q3DR71PqzBcRuwgNbBkNxQEb/xXpaw2erANmry
         QvpbGrv96bk0FrLwPwV6jsz1WDu4+7CPJu0RH3veWJFQarIWzg1gqbF6W09QeiYKYQdA
         FuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ICuZeSplUMLkTfqTJvkEHZk7YjPYPX7TJabyKVwwTM=;
        b=HNUwxluurGio3zYeEKS+wSfzONDC+Sz39xowTVLl96fSzMkWJoNApxFHp4IiQAqGEb
         9B6ejB+FmwoZevjI03c2+CFbmJSEhn3cj2HIH82Q/cwkgkUzDQ6hQewLtS6icxo136O3
         Hp5lZ5d9PyN5aiPAIwrbJoOzk1iOh6H7A6gSfMo7VoW3pN7/fPhv+tjyvpANmG4oJlAr
         sYbv7aODgtzkCwBN7jr+ct0qzC0Qlrbb6TfKs7EYYaLkXLh+x4li2to/RlEggKbiF5LJ
         U9j5IvDYhtjO1PpEUKBrd2xMK6aqLJqJqzmMwmFfks8jbfv+J4JY9+Whdh+7XupgENFI
         +XBQ==
X-Gm-Message-State: APjAAAWZVkYAq4inO9mNe/Dn6TGEJnHBWcSmjY4weNlFK20YqKp16k8b
        6skFoh9dW08FlUFk5eAOPjI=
X-Google-Smtp-Source: APXvYqzz8l2Ogd2j+gAwakywckhxE39XSVdl3U2XwEO9xis9NJ04Pz9CpDwiFyYR+wYCXbxqHFtOnA==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr11644087qtq.282.1562538922478;
        Sun, 07 Jul 2019 15:35:22 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/24] PM / devfreq: tegra30: Reset boosting on startup
Date:   Mon,  8 Jul 2019 01:32:48 +0300
Message-Id: <20190707223303.6755-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d5d04c25023b..32fe95458ee7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -536,6 +536,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0, target_freq;
 
+	/* we don't want boosting on restart */
+	dev->boost_freq = 0;
+
 	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
-- 
2.22.0

