Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D434C89457
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHKVZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45348 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfHKVYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id t3so8078326ljj.12;
        Sun, 11 Aug 2019 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iZqkZqXjTfAXjJSJnLg5xR1FkU/5dVzGt00ebVBBCo=;
        b=IW7Zur0Sb2bl1EsIa3wcpM/Goklf8Dqbc2Gape4C5nuMApNEADUdr0iY4VcJi4uwxD
         bnKWzzEoAp0l/RTxGYNoYmXw6gCfwqp9xb99D6qk6xycerNKkoRSDvv7HtyiNNa1ZpiE
         fiJx+T8JaWc1OU0FL23bNAJcTEHkUe0O+rByqRR6g1VUs0Yt6wT0OomkhCgSjAt8VTdc
         qN56pNIZ44GQW6Lz07KCv5xyR5N7/UcrVZGmQt4FaBn/GEOS5co+7g05kuXxnyRhOoDD
         pPGaFkigvSKnadviR82o7aKaqXnrX/ORfb7NAoG8y+/uvyWMZaDkb3ttYyfitmBxoRfG
         MReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iZqkZqXjTfAXjJSJnLg5xR1FkU/5dVzGt00ebVBBCo=;
        b=JWnxRv8AxI4fUn77oq9ZoRlQhW0uCMLfxYcouYoTYff5CBWh+9uI1e06Kj8ZfLZNOD
         ET8r0LdT0oxHGM44pWveCCS/EcuM6jkWPtvhamcDKT2F3sq14IIRCa0Q5rWpYEk0nrx8
         oogAVirGy66Fo2eJiJNHCaDPIDDUVpdjk08i8g+SGcSGH9VNzWmOzwU2iQVUav+aw5W5
         W5yPQHRXFyN3/s4ZthVygpWXdCrVtMa3hSJT9cHHoM1lbkf/2dbgJjOHGcDROdsIo0Lq
         CUjKjIGzyWPb4/uEg72trh6iXq66c3uDyyqehRjNd2BSlj3s69TqTqUAKTmfO/728I8Z
         a3tA==
X-Gm-Message-State: APjAAAV6Bet+u22Z5BqMRPqoQ3ie91t73QNMvrz43LJrbPoXnrijWTaH
        5/yw4vp0NTC+JTywpAUgI3A=
X-Google-Smtp-Source: APXvYqya0zCiYcOoJRRq2kn3mBYGFFSvmTYY9YIjtGxboGLtlI1nvjKso8rkvFoY3s6j9g+bhH5/HQ==
X-Received: by 2002:a2e:970a:: with SMTP id r10mr16237270lji.115.1565558681453;
        Sun, 11 Aug 2019 14:24:41 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/19] PM / devfreq: tegra30: Ensure that target freq won't overflow
Date:   Mon, 12 Aug 2019 00:23:04 +0300
Message-Id: <20190811212315.12689-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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

