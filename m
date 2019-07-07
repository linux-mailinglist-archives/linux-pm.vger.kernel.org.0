Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92FA617FE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfGGWfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46964 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfGGWfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so11823939qkm.13;
        Sun, 07 Jul 2019 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vYdWHvcNeD8bzgZp8vF5XHbjJftawzlzYH1bDaoyZ0=;
        b=TP3zxrPFtJczz039nqsSlo8CKJh3gZO2XxzaDVK2oqqk/ZcSXAAPzEEGd1BHYTW9WQ
         21I8xkIEcc0DZwYsMNVdMhLCcwMwM5erCb6MlCyME+VV9A/cbawvKf/8zqLa85QjItlA
         FQCSwRwFpVEZ2L491FWyZaGHm7sBKHGrsm5DRphEwrjmq6kHhUlcee01QCvZQlFEGhNI
         ZJcpOfvkUkI2hbX2tT7EJZ0Qsae9f11szkotM3D52jPLofJvYomM3RY7rjnOGHRdSxkT
         ORsNmCm7LityX+Qh0/w0rCmT7IEO1TsxetgY5Y3ykzUR/tv4HKaT2D9r66hT8ufaoTcH
         14Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vYdWHvcNeD8bzgZp8vF5XHbjJftawzlzYH1bDaoyZ0=;
        b=bVG6hfznNisDID9gOf9kZpuj/QmUsCdQXrbTIdI7pYdWhOo00tlpE7yeLsDiX+Euwi
         8+Qn0AyQnDbhPTRv3OdyPeaBmf7nDnttPYrUyXeCgQ5EtkAOa0Tm0coSIjpTWVQ4MlpT
         DlwWgT1PLibasbeHf8uyKbhjOY+fRtJZubi9ynotq1Ie2uPln1nEAIJpdx3OVZ0ubJ8P
         Qs6q0LK2zz5+CUW06S/yzcUcTDIu9pL9TMO0I+fvqEBMBtlLMGCI1M6hK/h00avfyVam
         yX4Gp0hk7h3K06hfbGGeCy5E41O4UAFUP8b0qjiO1HXW/pSQDe7lvtvQmTIoCap43S/S
         LxYA==
X-Gm-Message-State: APjAAAUB0jnp5JrYlWnsRwpUuOhcjU313fsSS2IYJFPT+LseRP+r2YHi
        O5r0KGFzoV/dbLyMfPyur54=
X-Google-Smtp-Source: APXvYqwtHvECo86X/+TKnEe4XBqE1z3jXmCk2BA9L5dY++ZA6UJvVIU+z15Fzl49grrUVPMGKAKqVg==
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr11700823qkj.39.1562538933325;
        Sun, 07 Jul 2019 15:35:33 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/24] PM / devfreq: tegra30: Ensure that target freq won't overflow
Date:   Mon,  8 Jul 2019 01:32:53 +0300
Message-Id: <20190707223303.6755-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Potentially very high boosting could cause an integer overflow for a
highly clocked memory after conversion to MHz.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 2f59c78930bd..0de1efdaabf4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -460,6 +460,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long target_freq;
 
 	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
+	target_freq = min(target_freq, ULONG_MAX / KHZ);
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
 	return target_freq;
-- 
2.22.0

