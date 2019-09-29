Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE57BC18C6
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfI2SAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38953 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbfI2SAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so7102202ljj.6;
        Sun, 29 Sep 2019 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WzGxu5Uzxxq0Lu5as86wPG4OXi9gBVk0Y+PLDjSeQQ=;
        b=MK7dOvVy/RlvfYVUAuigqskJXwF3thms43oKcDxPRMoiIcrSLcheYkO9kVD6b5nybh
         M6qr3QFduXpuRQbfdfpzBHmwvrNSfgx6fsQIivCzbQ9q213gJh9VQs3F+H3HhjMhLXYr
         AOAP8ssMJ30kpPCJ4FPkB3jyjQ94wuct4jZTfciaGF1o2qUhaeYrD+YpTLs2N0le/u0L
         BUIWDY2RKTo+MnHQM48/CxarGovG3imvYko8CeAnpaP+4BkW9UBgsPjCXTLRp1E2p9n/
         LvH+W3PJR3uh2iDp0eBAs5xGpa95glOYJFrv90P1OvSTKXXO1RQruw4A+LILADL8j8Au
         eEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WzGxu5Uzxxq0Lu5as86wPG4OXi9gBVk0Y+PLDjSeQQ=;
        b=bJajjM771wKr1Vhe201JstzEE5r3NZeA9Nq7vwfC4Rf4PWEtoeQdZVvfoLY0BtuPZX
         /K6qfmmWBucuVoeioJW7aESGc6+Sa2Z7wZUVDGVPGfvFOx9MIMFOmDlttauPlTlkUYUw
         +qu4ON0+nwzquSdJCyTLSRGa7d87B8aLZGmBXSEjSZJOFElJBpPH5PHp22teKulifMXl
         lcsqqssPJ6HYe4xMFYONjn+rxR7owZWt+KRWiEKW8YeWXi1kAiBDrvfxDPrkde7mNUrO
         YUZkd8Hn4M7qtPz9zgSbGhQNvKhhFivYb61Lghg8pHPoS12sTBnEWh3yTUj0bghB2YyQ
         kpMQ==
X-Gm-Message-State: APjAAAX03M7upPEKV6/7c80vss7GPrrYH6vjTw3P5e+z4k7DHQhRRYcd
        aILMSbe5Q+eViiRhbI7EOW0=
X-Google-Smtp-Source: APXvYqzQAEP5QQHzoYeemCDiwSZcrgTee5vhjNxTqbt51XqkdHJId79ol4FZKftaYWVSWwhpa1JlDg==
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9470692ljd.83.1569780016335;
        Sun, 29 Sep 2019 11:00:16 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/14] clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
Date:   Sun, 29 Sep 2019 20:59:47 +0300
Message-Id: <20190929175952.22690-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPUIDLE driver uses the Tegra's CLK API and that driver won't
strictly depend on CONFIG_PM_SLEEP, hence add the required stubs in
order to allow compiling of the new driver with the CONFIG_PM_SLEEP=n.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index b8aef62cc3f5..cf0f2cb5e109 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
 
 	tegra_cpu_car_ops->resume();
 }
+#else
+static inline bool tegra_cpu_rail_off_ready(void)
+{
+	return false;
+}
+
+static inline void tegra_cpu_clock_suspend(void)
+{
+}
+
+static inline void tegra_cpu_clock_resume(void)
+{
+}
 #endif
 
 extern void tegra210_xusb_pll_hw_control_enable(void);
-- 
2.23.0

