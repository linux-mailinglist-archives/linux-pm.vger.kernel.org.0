Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B0ED4BE
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKCUmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43501 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfKCUmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so4472683ljh.10;
        Sun, 03 Nov 2019 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEzUAio8OEZBvo9nZSIV3+A/WsfLupbu1br1SQPd2S0=;
        b=V0Y4zKe3cJ5aqqlAyJ/2n4Q8Xsod3rooSbqnKlLtllfpHh4sYgPoyTKBTvrXX+uueq
         N/WfNjCntRoONQMQ1SWljrt6p3Vwcev3DLj1+pyACQ1dqgcTXo8MsbcAYRZO+nNxxLWb
         HamfgbuyaIGTJ8OEq5Ctp+q2octVwrjLhajYpBxh6pIaEN4ROp/e0eexPOam3Kre5Yt+
         OGzMDFBwg4ru1q8g4Z1pquiNh7yTUnZ6LzxUH1GJkjYSruVcDaPjSk+0YeMozAUjS/cr
         9I02DX3bjsUfZQUrSJM/koA1DLRdo5yO0mMAbYpWnobvp+6kjKYlraftgR7tOFjrLp9d
         6Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEzUAio8OEZBvo9nZSIV3+A/WsfLupbu1br1SQPd2S0=;
        b=tQd6cLRc0Sje4GnNrzMaNjhP4fAegZDoc4vdw3/DN+6KMTYPBQWpOVGh1hqgmZ34o1
         NDGREwrnzahT/41jE38MCY7tVoleZ4SBWTVlzWi1wZfjgxeDBW6Bt6wvqegvyyKnIF7F
         KIT9TEJygzwNtAdBpC4g8U8/GqJd5b+Twoxk+VNol14n/rMQNWAw+/x06rEYGlGPWQIo
         BY5WpUNze1bxpDdJpvqirrjhFEQbhYIxZZTwJdK+cxCAlntW3FvDjwuRiiGF5psAXs7j
         fa3arPgyri2+bDbHo5nbhWWQVx3a78ypfTEPp0aciv9c2ojFSfSWsQ8Cp4U/PYEJPyej
         2gCg==
X-Gm-Message-State: APjAAAXeCz4/HVib2LQHjS7EqS9mI/Yen7FWdEbk6pKZDAlYClh4ao5C
        yjaoKYfvTNrUQJXcRbo9Phw=
X-Google-Smtp-Source: APXvYqzljk9T0yM4tZ3tTOYQSINQJBsH9gACwBTV/uA335JGfkBjAvsn56sN8Tjom5PVOPVSEqLxZw==
X-Received: by 2002:a2e:9546:: with SMTP id t6mr16188651ljh.219.1572813731007;
        Sun, 03 Nov 2019 12:42:11 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/18] PM / devfreq: tegra30: Reset boosting on startup
Date:   Sun,  3 Nov 2019 23:41:21 +0300
Message-Id: <20191103204130.2172-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
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
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6960d8ba0577..9cb2d6468175 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -467,6 +467,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0;
 
+	/* reset boosting on governor's restart */
+	dev->boost_freq = 0;
+
 	dev->target_freq = tegra->cur_freq;
 
 	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
-- 
2.23.0

