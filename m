Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4E1F3C27
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgFINS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgFINOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42421C03E97C;
        Tue,  9 Jun 2020 06:14:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so24995711ljo.0;
        Tue, 09 Jun 2020 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpFtIVnKnNndfebpkGzqwkaxd/wyRN7pW9EKTYyaD+o=;
        b=ffYgl05pncbdubAvxWR63NSZaAmUmQNPcFogjQbb+PcGJRKuP8Iq/ynaiJSynit/xg
         keR+9mZfb+LT6ii5FdCO/lBy9nE/++3QDwTMdUwltsZ5pAKMoT9XYkt3z4nHItDpv3Ir
         0qmVkGd6cqv+vkib9r0Xd+yR8tOef58QmS/0k4be7cUsNgxeZ/jn+0LFdn6PFu6n14nt
         q7hPh1Jugmrq4m4erOiKWDXBLb2SCJylG30nC61UA3EcVkxpjArkVw8FpOrzQRtlghtI
         rtLoYVULmY1s8AakiUWvvvk9Pcm179rk9SFjhpkTk6vQCIKeL6zHGKzo+Ek/dkRR2DNB
         JG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpFtIVnKnNndfebpkGzqwkaxd/wyRN7pW9EKTYyaD+o=;
        b=CnmUNTBg5f11AdYghJBW0VhvBzAG78EUtd7o9rlqTfpULa8/3AUHzYwqixnZ6sCxM/
         2s9YXHMix5UU34lzBAsfQ73jdAml8Nm0LMlxs9pq4b4AE03NiNVZFKD6vwmsDz40INIT
         Pz5F/1pO24wPz+2BEnF2JP+eQIeH8XR/hLRL2junD8vW9FMc5OFXnUy6rAUakiaCEQYT
         Rq7sUr/os1QlzJt10dcDRz0Wc8sjHd3rksCEirZ5ccH8BCh2C5wUIP8ZCu3Zvq9hqUF+
         kLZcqLqjAUKlzf1m6ARtV0KJSr1bF7q4JNWlsar+/FpOF5X6njMUilGE5jMecCAW/qea
         CYaw==
X-Gm-Message-State: AOAM5327B9gje5y+VMZXqW8GdQTXaxOUq4gg6FzG3PNPXw6WgHJa5N7v
        MRP/61Zo6OhJjT2AiyRSbGo=
X-Google-Smtp-Source: ABdhPJxejwOTAdW+uqBjAbDKAokXmYlrwzxZ/NkKhjhobM21Hk8tYt+VAfsUsH4qHeMB+LmaIWHrgQ==
X-Received: by 2002:a2e:b003:: with SMTP id y3mr13797412ljk.78.1591708468663;
        Tue, 09 Jun 2020 06:14:28 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:28 -0700 (PDT)
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
Subject: [PATCH v4 03/37] clk: tegra: Export Tegra20 EMC kernel symbols
Date:   Tue,  9 Jun 2020 16:13:30 +0300
Message-Id: <20200609131404.17523-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to modularize Tegra EMC drivers and some of the EMC clk driver
symbols need to be exported, let's export them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
index 03bf0009a33c..dd74b8543bf1 100644
--- a/drivers/clk/tegra/clk-tegra20-emc.c
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -235,6 +236,7 @@ void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
 		emc->cb_arg = cb_arg;
 	}
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_set_emc_round_callback);
 
 bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
 {
@@ -291,3 +293,4 @@ int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_prepare_emc_mc_same_freq);
-- 
2.26.0

