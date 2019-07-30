Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11557AD9D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfG3Qci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732875AbfG3Qch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so66460546wre.12;
        Tue, 30 Jul 2019 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Le+gPqc9tIQojy6SU5vThsC8LVskQQb69uxlrI0JsWQ=;
        b=ThonQR5NO1MwLW/8JmmHvoM0emVn+1GOrm2plUd6BXed715xsPEli04ZdADVsx8GK2
         dyUcBuBzKG2Iprzjoo7Li3DfI2LnZnY5Y6Mt7gT3/lcViRTxmIBO5/wkuYktxR0mcXTo
         w1ZMqdWOVE2Sfe7XVhKjzPuj0elSi/fbsfjI3GKWVQeskiJIQPKy0gTTU7jl0jh49r5M
         a8bpYlU2aYGu9jGfccr6kv2YP1X7fuY/wSB0bh/ciOWJ5ZuVxW8fIk/oUgl2cA/fb+7k
         mGmsJtYBTolFmxOUSA31SclPoL3g/OHYJFzzKRNOx8szxVYUphX/tSZKM9ZY56Ub+Asy
         wupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Le+gPqc9tIQojy6SU5vThsC8LVskQQb69uxlrI0JsWQ=;
        b=CAOfGVp5JvbtrhQY2jFb6Yg1ID8OntUWX6u0UvR3SHZSxMhpd/KmLepKgHcwmbFiM9
         avoWKUiFXv86ZK6CoPul6jVH48jAYLFeF+FpSgE0QNuLyzb231/YtyzfFq3ZdneU10uy
         ldooUGIsyEO5K77MWRUisv61CVVaQLNYG5SLc98/v+rKtUPlVpdH8mz0+nuVcRziB64p
         C0ONAnM0ZR203u90Wf5VNuPN86DWybsxEy1UClRsmA67kJH5BRK7mn9fOXReMx7EIoKd
         9x3SqY2I4D1BeJKCoDDYWsh9o12eW0FCeA30KnBNh5vpo8Qa1aQTR8QOwPXQ0wZSNljA
         4oRQ==
X-Gm-Message-State: APjAAAUwe9jhh1i8CCZ2/vZloqshECdnw2uhdxwzt3dx9YAFSGR97nwU
        v1Zj3lLJ44/AFgMutzg48Io=
X-Google-Smtp-Source: APXvYqyAmW83NC2q6/Fkgl/M/lLil+J3NzM/Cyfj0gFaeMT8v1hCIN4G/cFmzhPIhHDkYfTXnRno8Q==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr5371078wrp.59.1564504355595;
        Tue, 30 Jul 2019 09:32:35 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/20] PM / devfreq: tegra30: Reset boosting on startup
Date:   Tue, 30 Jul 2019 19:22:29 +0300
Message-Id: <20190730162236.6063-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 762e17323095..6e8ae20c3bf1 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -684,6 +684,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0;
 
+	/* reset boosting on governor's restart */
+	dev->boost_freq = 0;
+
 	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
-- 
2.22.0

