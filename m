Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7877A7AD98
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfG3Qcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45979 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbfG3Qca (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so66460177wre.12;
        Tue, 30 Jul 2019 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iZqkZqXjTfAXjJSJnLg5xR1FkU/5dVzGt00ebVBBCo=;
        b=AAghT0wsfPhV/j6U/ghiBwRe0n/heMMEDTKhX2F4Ap9PQ0gtxj9cOQMPDtVpf1ZA/Y
         krISxNXiKhB/09kR6KwRsOdNFTzIcf3UjK0jRxbHmy3fvqHoG5hp+gxz4B+mnY4IKcW3
         jTy43gQNCP4Tdml8w/wbqZo5jKjqwBHV2pDkpuhXsjiwXWypGHf0IsafhHKAKneOTrDs
         VSkA7xIUDqmMl9Babs+F8HtxIR2AFJhFKqd5J979soBf8Q8+3MTnkFuYYokY/4X50q2K
         O0yupl8qcgZoBfAe2jx0SUzeRYngNIL0PhuDadvxR8YwGhx/oR9FGB+u45y32nW7Mp1r
         /1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iZqkZqXjTfAXjJSJnLg5xR1FkU/5dVzGt00ebVBBCo=;
        b=B0i39xTkpg2LJKgK5ft855jvBqJvSWNlL3myr4jMPSKeVohNc6qY6L3lAd78c4RpbO
         RpJddkxfh8XG6akU+HmNnM5Jq6q0C5ac/sm5LOQSfu1RiNnfjuJQuQgYbnSYqdbBf5oR
         Iqcuj6aZImD4vfmOUS2g9qx3cnwGeT77APu+LUT+GQj3veQuChqjiZMaKaNhxhc8yHbB
         WZfW9JyN/Sd1M7sXR/uoOUOkL7356o1ePtn+L1UPYrFx0WwLme3wYBn367hLeuyEen7D
         TQO/IeLbzi4UQlI4m1VEMFDFjH1vzm6sWZN+HgwBqpVbn36Zm5k8l1KC27fIo9qnEKeL
         4z/Q==
X-Gm-Message-State: APjAAAU1xzFcgIKaOKIflbCllQ0uj3QiCoW/f/c3OMqdo6OHwJxNuI3W
        SHaO+y1Nir6xjHNTBm//lic=
X-Google-Smtp-Source: APXvYqyEu3zYvYk5Z8X5j1eud/4T36h60HChVLwgzdl/ZXaiN1ilLV6HKBPnYOMEz55QfG+dw+3DXA==
X-Received: by 2002:adf:e552:: with SMTP id z18mr131981622wrm.45.1564504349166;
        Tue, 30 Jul 2019 09:32:29 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/20] PM / devfreq: tegra30: Ensure that target freq won't overflow
Date:   Tue, 30 Jul 2019 19:22:24 +0300
Message-Id: <20190730162236.6063-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already had few integer overflow bugs, let's limit the freq for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 70dce58212a4..ca499368ee81 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -430,7 +430,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
-	return target_freq;
+	return min(target_freq, tegra->max_freq);
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
-- 
2.22.0

