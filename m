Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9E2AE5C2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgKKBPM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbgKKBPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2FC0613D1;
        Tue, 10 Nov 2020 17:15:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o15so733821wru.6;
        Tue, 10 Nov 2020 17:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1K9JydNjYGGf9JAlOSaGXH6qVrxRvoP2lWgFH96HkM=;
        b=Cv5xWDPxk8xXbLs5HxX3RHPoQ/O/30KrlaV8JsvI3UTW6WMi5ZV+DQ54BFGXpXnzRh
         LS8bW/a948cqvlFJyN0Wbux7TFaNwROVzyqnFZVwDmeYIwOFNza/f4AO7yHPyUiMLAlw
         NQnndH3KjL36McTSqribKgR/IOaviwOVCedknltWno/Y9aCOxtOZMAQclYpov8HlFjX/
         fPveqyNS8OZF4MeDIuitsWpTPStiNqY4woFrR9u7P//VET5Pl2kJS5AicLZQa3PVTqhM
         DFGNS32ZnNL8QPDjCQ1lkHlx2crcMWW1hCWpR2/0C2WRrvnJIkQLvuTBdsgKt87DlkZx
         Rq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1K9JydNjYGGf9JAlOSaGXH6qVrxRvoP2lWgFH96HkM=;
        b=RMjeB+PDCNwsSgsk7KjrmeHGDcutfIDzxGkGmIm4+DD3E15i0U3gGcmUz9Xp+SQjWj
         j8G/ezMiJMCFC4DGoJvxGIeHV3sHUAUkW3TWtfBBUHzYZqBmeI8TNAjOpMlxLOJAXkIw
         zqABuLJFtg99Dh4/7NeWCx27k/rUwUzNiN3pj9kgCEfq1sEFY2VBomTzm87FyDm/5HYy
         +1pEVJfxIRkyoC6+U2rEM0QoOglVT3YWAjtqgbVoddy71kI/6YT7OIAUUBLP0K2UMTpo
         FHcBsFfiy+bI3Olebeue0irzXH4vV0ASoUO3HETOHYN0atY304G8FAyTApBH27BnNjD1
         jiwA==
X-Gm-Message-State: AOAM530wPNJFgXn/q7VQ353vrh6P9CF6fiqAtcGO/4fAbOPlF5mFYHkg
        FHZ5ACLNlQCWKXOcbFHvPXDwczVMXLk=
X-Google-Smtp-Source: ABdhPJxvEtZ5NFZK3kxR71AKCtUXUe9qQEAfSqUzxsusNyNRfVl9g47Ovk4aXVdck1fJEYx6IMfhJg==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr28589174wro.58.1605057310315;
        Tue, 10 Nov 2020 17:15:10 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:09 -0800 (PST)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 01/26] memory: tegra: Correct stub of devm_tegra_memory_controller_get()
Date:   Wed, 11 Nov 2020 04:14:31 +0300
Message-Id: <20201111011456.7875-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Correct typo in a stub of devm_tegra_memory_controller_get() to fix a
non-ARM kernel compile-testing.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/mc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 43876216de34..d731407e23bb 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -207,7 +207,7 @@ struct tegra_mc *devm_tegra_memory_controller_get(struct device *dev);
 static inline struct tegra_mc *
 devm_tegra_memory_controller_get(struct device *dev)
 {
-	ERR_PTR(-ENODEV);
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-- 
2.29.2

