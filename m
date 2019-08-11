Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2089434
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHKVYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46100 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHKVYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so4571054lfe.13;
        Sun, 11 Aug 2019 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YjdyDUArQgVNGBFF8GoRE+JSrDDre7zGJm+qLt81K8o=;
        b=p8hnGGEga7xbaoiK8QM2im6a4gRD5t1/+F2SoZjGEHYEWw+64u+ChRwxfjul54Qvto
         QH600IGoSiBBqy5k5sgWoaFrqwrHeBw57a27aPq+nG5v2ee1fC7ApfZxF02ajw5SJlaP
         n7iVhhSE0W2yNiXTwz8TM8MpXQLJsUHNgIcxVBDPWEzkqEcHXHR+0BIZHtTGk6PKCy0l
         /f87d00w4sju3OtvU5QxCP6/UONk/zeK+NiI+LSriVUTsaXwJWXdtIhpMrCwDBCp06DL
         NHZYwxXj8sy19o70GcNDuHsIgQ9ma/nPH6hfZyxBDD+DXtmUqFirRvLXySJHKT1JlqEI
         IN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YjdyDUArQgVNGBFF8GoRE+JSrDDre7zGJm+qLt81K8o=;
        b=lBtNG5nabeyRnBkXE//dX+2Vp7aOmAVSaQSWMD8PmX6P7kqE0CD0POxe82JCpqDIOh
         YHEhfFE54zkx+DwCn7nWcvCmZPGQ/sg5VmuTkjzGvXYwxXqI1GBBUElzIl5rU0XUahyZ
         fQ7xvQG3xjqoc39N48TV20yr61Zi4TxyCf9XYDgkao6B6cbQFFs97b2dv5ijbDU8p3B8
         nlavX0p8zN/9PW1QH/k+KyCxo7EsBIu//rGl2HiqB6/n97U22/iNpZbMn8DNFoeqyh9o
         MhbDlnCwSZS8q3zfFpnD4zDF2W6KHxIg2fvOFUr3mfZJItr1yF5Jmj6YVPE/fHDtcyzq
         DEJQ==
X-Gm-Message-State: APjAAAW3ikvxIkeyZ3ox4fhf3U1YDdaZzSL4ruSSlXfAb39pYUk4/wga
        90dyAjtgpYD9igRcn+nPBX4=
X-Google-Smtp-Source: APXvYqwKQQsMoVhyRZmSzdVFefMc6sJLJH0M8Hou3BmHB2GmOGiOnPht9RKvftyERp3cTkPfO41izA==
X-Received: by 2002:ac2:5336:: with SMTP id f22mr8350527lfh.180.1565558688021;
        Sun, 11 Aug 2019 14:24:48 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/19] PM / devfreq: tegra30: Constify structs
Date:   Mon, 12 Aug 2019 00:23:11 +0300
Message-Id: <20190811212315.12689-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs, for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a0a1ac09a824..6446bf705b97 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -109,7 +109,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -177,7 +177,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -216,7 +216,7 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 					    unsigned int cpu_freq)
 {
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
-- 
2.22.0

