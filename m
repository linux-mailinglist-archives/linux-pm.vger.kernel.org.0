Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99C2244201
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHNAHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHNAHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C6C061757;
        Thu, 13 Aug 2020 17:07:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m22so8091716ljj.5;
        Thu, 13 Aug 2020 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYVrVqyKmi1R5n5EphsB7nCz8XZpBo0lBJhV0Ix8t+w=;
        b=kHD2fNCDU7lJmrFW6dXFuOYm22bBYvr3VdsN9nKcyfb18EcS1FH+7kQ7JrxIqkMhOF
         BULskAMHRRV7KO+7N/NkWA1lQ4nONQz1EILPJD0F2L0kwmo4DHViU8MnUzUwFegY60kQ
         7tbY7ZiTvc8il6FQp/3xToaxFb/uwTQRj91YtVI6iE0fEsjePGJtz2UlAXQ+aegw0Udo
         kTZu3m2DlUeNijlHo9oFblbttVhqM8jjworPOKtJ3GP6mqSoKXBGbOpuzlsz1mWE05H0
         zhtAHSMNb60N9aiUaAf8rCZA4nkWRrHFdDUxAmZjYKgZOAvMJT6wKTDDsW6yBqwZhFoy
         WxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYVrVqyKmi1R5n5EphsB7nCz8XZpBo0lBJhV0Ix8t+w=;
        b=XpRAhkCJlJnDN2l7KfAAlHXzyS1mNcW9OUWqUhRU8+nGXphJDXqtWUiJkGRhF1ZCQv
         vLLF8dvsS/A1sPdrWGhUNgKsOZlLGlgwo8d0yWsoYwUtBIhfGSJ02iZOosg3viH2WzRi
         9IPAeF/j1QLEvnW+POZdm4UGp3n20Dcv0A3CSshVNsaqlS4HtMNIDPWZnrbsg7nJhINh
         buBelvdbcXwiT8K2t6vorVhVK9urRm8DIIRxVbFpOV3FsEx9qWZnZnI6bVMrsIX8Uo1g
         laZMTLpwZZ8CZKjYi6/UgXQ773Xus9qxfaySLl9RFwfIgAjiVceBhNncD45/N21A1ExG
         ev1Q==
X-Gm-Message-State: AOAM530ehnbJZj4lqYVEKok61eCVLXkRoYz5CXeFvTLi5x4cyAvmu+Vu
        TUHingZcy86M8mEn/eAyuxg=
X-Google-Smtp-Source: ABdhPJwIs4y8aNM38rBL6i83ol6zAmutagnBs98xg1dZ+TNRSEXv4E1FjDzY79vpk5xE4Wzx4pmpiA==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr107011ljj.144.1597363655869;
        Thu, 13 Aug 2020 17:07:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:35 -0700 (PDT)
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
Subject: [PATCH v5 31/36] memory: tegra20-emc: Create tegra20-devfreq device
Date:   Fri, 14 Aug 2020 03:06:16 +0300
Message-Id: <20200814000621.8415-32-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-devfreq driver provides memory frequency scaling functionality
and it uses EMC clock for the scaling. Since tegra20-devfreq is a software
driver, the device for the driver needs to be created manually. Let's do
it from EMC driver since it provides the clk rate-change functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 437d9d789941..e603cc0b0341 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -884,6 +884,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	tegra_emc_debugfs_init(emc);
 	tegra_emc_interconnect_init(emc);
 
+	if (IS_ENABLED(CONFIG_ARM_TEGRA20_DEVFREQ))
+		platform_device_register_simple("tegra20-devfreq", -1, NULL, 0);
+
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
 	 * extra complexity which doesn't really worth the effort in a case of
-- 
2.27.0

