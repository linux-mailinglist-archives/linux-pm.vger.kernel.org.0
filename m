Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C658CA4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF0VMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38890 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfF0VMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so3810570ljg.5;
        Thu, 27 Jun 2019 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcR4WRAzBYh5+2wDP0kla0NYqTODjLGD2168Fl2jbZ0=;
        b=LP7U5VucPkUu7nPLpKvTeiH/NvCEXo0SXrNvNYt+3bmQwDnvoVh72w9mMO84Ycw5Tp
         zHL1lzIt9hiqCjTEeVFqY8nwAHyF77B1uMibBLs2zdTrVYdb3R9f+A7T1f4abiqF0br7
         69M/qYolOw8Sff1U5Jb5+jygTwkLothvYBuhkby1GhFJopELCyjL6GmWQFTyj9PdB8T9
         EmEJgpB5//owW1Kl1TPcjO+8ntO3qifkm90d+eVhfq+LhwRilRLYZH9KkWhdoXp0cz7q
         +cl8YWV7YJmbYVwJ0qjPZUrdqNEjAU57W4ttL+kXiMXPLIc8NlyB+4GIkb0ZsANc8+lc
         IKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcR4WRAzBYh5+2wDP0kla0NYqTODjLGD2168Fl2jbZ0=;
        b=TlksTrn+J5kKTl9HFNiuRCXW0PBXiqmjYPriTpxWRKUGfSbd2mr6vb8TRO3YhffNkd
         r9dAi4spGgK5o1WhUDppyY2XZtnVQMcjm6nNHhH/7r+IxyvYW1zl1TV7Bj5e2rp5SZOD
         hH7IL1P/Khgdk54YD8ExQzaoekBWSb0tNyLFk+Sc9gvLVpqArKt/9XpA3+WM6yEwy9HE
         EwD3TRQAaAadPPRd4QkCRAemI1X7dWr8qr7VnN9xuzGiiw6XTSIcDcx/ubuE1xmGhiY7
         B92z1qXfSLnm+OlvpQudix1lIpWQqqoo85f6Q7lQKbqB1AGnaCmVkZEamIF2zMxO0Cfb
         wGJQ==
X-Gm-Message-State: APjAAAXFm7+2ynpwSp2sWgOkKs66Xz9eNu9NvMN4uacrZBszRdSuA1Lt
        fOXb0etKEeMlIBIBiyzIvH0=
X-Google-Smtp-Source: APXvYqx+0Ivl2tIcqA1DxDAMwApZ4JC4WyjRe5SXqMG+zyok0JUf40V7LQ6c+2ld7zUw5lwP5ywT/g==
X-Received: by 2002:a2e:5341:: with SMTP id t1mr3946266ljd.170.1561669963047;
        Thu, 27 Jun 2019 14:12:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/22] PM / devfreq: tegra30: Optimize upper consecutive watermark selection
Date:   Fri, 28 Jun 2019 00:11:12 +0300
Message-Id: <20190627211115.21138-20-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The memory activity counter may get a bit higher than a watermark which
is selected based on OPP that corresponds to a highest EMC rate, in this
case watermark is lower than the actual memory activity is and thus
results in unwanted "upper" interrupts.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e8f7cc56a340..1105104445a9 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -363,7 +363,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
-	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
+
+	/*
+	 * The memory events count could go a bit higher than the maximum
+	 * defined by the OPPs, hence make the upper watermark infinitely
+	 * high to avoid unnecessary upper interrupts in that case.
+	 */
+	if (freq == tegra->max_freq)
+		upper = ULONG_MAX;
+	else
+		upper = lower + delta;
+
+	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
 
 	/*
 	 * Meanwhile the lower mark is based on the average value
-- 
2.22.0

