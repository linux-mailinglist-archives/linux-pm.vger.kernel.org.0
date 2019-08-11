Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5105F89461
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHKVYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35748 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKVYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so72932572lfa.2;
        Sun, 11 Aug 2019 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAb/Wbf6jN1XW90qv7LwGWyr9ST9lsuKJ6ZQmhSvlSc=;
        b=BiQzBctpmmIl+DFhnqskDUHKskSo70mqGg1OwBP/RXn4hVZKsZ4ALnHKRktswCxBnb
         lKoOsK3+O7kJqldO3u8NO9YN+jp5sbOQlOEp71WoBhehpMq1q7hMe20oGA1BITIuWvsh
         +rso/niw88+7Jo6HLGesqBPeg98rIoSB/6Fc+c50l9iAukOSt6rSI234+dxJ5QXmJ7Of
         c7cx2dWCff+hDss7roSvWQ4aQISVEaZ5Pketk99LR9aEyebQ1nCoRIUkReJKYJl6gn2X
         81HU+485Z6MA+lglnnjKJo3thoklFZHNx2OrkP8cXhdftd3sqgi+sVHCqYgBEuzAetLu
         yTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAb/Wbf6jN1XW90qv7LwGWyr9ST9lsuKJ6ZQmhSvlSc=;
        b=D9aHh4i/3VJ3/kAwtJh23s+tNkiEw43E9c+WkxHDacVlD8fzFWySW8E0G1t1ApaYhr
         b/16rgWHDKIDKBDmuXopvJSASKjcD6GR+BktDdcrWLBTcQsR/SdhXdvqo0pDCS+ACtyp
         Il4YO8/JVFOuwW05lVSA0TqbZ1YI7TVDuvvfIcEdg/BwK44rF1zUTANgZxrsaNcNP60i
         f6Kjfw5Z4j+v2JRRi1mJji9ruRcQoAKBi3AjWUxZOlUhAHEUwnyDrwE4LJ58P9EwZ4zn
         K0JMrvxtZN/mQWhjjT/udfeEhIx7kj2svDlY9HoiYYVUvx8E9KIYXl0nT4Le3unyAAX5
         o+1A==
X-Gm-Message-State: APjAAAXPqBlzFuiiuTISvrMqfnbF34+ZIr7BSHjjsKzgAKTlZ2g9fReb
        LIQYJBL4Cf7+N5TlWIoCp+8=
X-Google-Smtp-Source: APXvYqwPPfBbW+6UiJYYLhkZT+EkEJxDbuPYn5DSBVbyEmbRNgL/5ZWcnD59iJknxOczk2VBKsm3cQ==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr5694040lfk.41.1565558674126;
        Sun, 11 Aug 2019 14:24:34 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/19] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Mon, 12 Aug 2019 00:22:57 +0300
Message-Id: <20190811212315.12689-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQ numbers are always positive, hence the corresponding variable should
be unsigned to keep types consistent. This is a minor change that cleans
up code a tad more.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a6ba75f4106d..a27300f40b0b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -160,7 +160,7 @@ struct tegra_devfreq {
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
-	int irq;
+	unsigned int		irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -618,12 +618,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
+	tegra->irq = err;
 
 	reset_control_assert(tegra->reset);
 
-- 
2.22.0

