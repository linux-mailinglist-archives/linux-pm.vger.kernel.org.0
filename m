Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED59B198802
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgC3XUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46212 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbgC3XUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id q5so15687397lfb.13;
        Mon, 30 Mar 2020 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UfEWDNpbPolJKdkCOPoWcOQm3ENr0nRZoY0pU9he7s=;
        b=VTCqpi5okGLjmoXrf1j3aExTZ9AFELj7Vftzd0Al0NCS1VdY/r15/0dIj3jK/u7YQh
         8hLwYBtbaFIqJNHpr+hrs/LhRZbM6Sa/EqwYp5PGlixtSSu2t/U7qQx+ZC+vYUN7ss1A
         Zg7QLLKdwsigG1LT38wupUn9cBrdj808HGjcRNacPn3JZ33YcGWG3e6syKVuMfzWbG61
         RmmMbe0sFKxp3CIX2rH+SWoN67hQpmHvMCeL6CLV9Z8w2YYPDa9ZdxWrETGvnm2W7i2q
         qFJyBG64ErwvZEkCbadrPvxULjJ0tockdQNHRNXc3sG7q4c3Fhn86qqSS2B3bI1PIA3B
         Oktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UfEWDNpbPolJKdkCOPoWcOQm3ENr0nRZoY0pU9he7s=;
        b=qSx0HhH/n8TJ4f1vIIWgBIzq9MmwYTVYM8fBsV8Yh2iig80Eh3/GWoS57gqG8f1piv
         XGA59KAfQgYvb7IoJ9O3jhda+7ZqLPvxa8Q81KEJiKlsIawEoZ5ciTrntl1OkazpRWXu
         qBBcT6gvAhP8eVRIcUoQ2qU1lf734le42NbmD6QUWy4OGii6sdRJO7KhWbX/vH1mN4c0
         u3WWTdLUBNTgnXCSnGlY+8sH5oYVyUC6FeA91m/8jldSAGRm+m/yxhR6ML+CBG5wEptu
         wIlsb8xTW+MZLYr5uxiQwPyZSMlmH8Tb26s0OlgWeKjPr3Fq70IUuDyIeCBmjWDKsDY2
         fO9g==
X-Gm-Message-State: AGi0PuaK7Cko9o0MsIg7axqfUQ1NrlavQdVPZuU4wQ6O3An0JjOKoi7X
        OO1STnVDm4iLTIrXZDn2kik=
X-Google-Smtp-Source: APiQypJMkkzsX2IZGzZHLEQXNLovTYLWU0IXUh0iCXC+VoKvQT5zhnCisz4dWTHvzkjOnuD74gcCFw==
X-Received: by 2002:a19:f51a:: with SMTP id j26mr9556871lfb.54.1585610411689;
        Mon, 30 Mar 2020 16:20:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] PM / devfreq: tegra30: Make CPUFreq notifier to take into account boosting
Date:   Tue, 31 Mar 2020 02:16:17 +0300
Message-Id: <20200330231617.17079-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330231617.17079-1-digetx@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MCCPU frequency boosting needs to be taken into account in order to avoid
scheduling of unnecessary devfreq updates.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 34f6291e880c..3b57aac9894c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -420,7 +420,7 @@ tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
 
 	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 
-	if (dev_freq >= static_cpu_emc_freq)
+	if (dev_freq + actmon_dev->boost_freq >= static_cpu_emc_freq)
 		return 0;
 
 	return static_cpu_emc_freq;
-- 
2.25.1

