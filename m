Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E911F817
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOOFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 09:05:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35577 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfLOOFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 09:05:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so718149plt.2;
        Sun, 15 Dec 2019 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wk/gZsMdaGy0jm+3Mc8U+KJ30OYinc4tUKVLGNDZUUw=;
        b=t/VfA6zjNq6twSmm/eDknA7wFv0aYMZtIV1Q/W3/cGi6CKebVbjOx+LBZ7SLHxOirL
         Ng2qhp/BPlwwFFFlBibYr2sudgcuJIdXBF4LLxYMgWHEZqpOdckGs4ogO+DZefIFxZaG
         fPMkcktsZi+FNqLp/IieHKmet6RIoWGA/9yimzjbRh5ghbSxdxCCY275I370WG0FXfxm
         kVRQdB1I3Ray17dkdIA+sYKwzxCpjgr4otBZrcXjhNzvgRQKF8KYQMGxILcRm9K4GLHi
         I0kYcC6JVrBqGh/jt4a32hDck2B4ZaL5qs6lVCLKms1RAlWuZP6xH4COjP3kJ8l9B863
         GMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wk/gZsMdaGy0jm+3Mc8U+KJ30OYinc4tUKVLGNDZUUw=;
        b=Q0QMi6kZTgai3xbpXMs/mSq+WL9y33IfqxdXHM8MLk1cURSWnYl93eSaf5HzuaZvip
         VBv4U7AlwfENvKgA/0dBsRXLljow8Gsz4o//lKOi+25FjHfGf+leqnm1oyGPS3KB43Rx
         gABjEBHsg9ZqfBx4N3Cqdd4Hc8/sR+jYoulWnh3F1YBIkWa0HI5RTzQFJ2E9syFmGgO1
         zIywqfvHc1LfUPmV+d08FVY5dZBOSq1FA+wqaMnqXsCXg8lcQuk5V3R7GHfVO+XsEQl4
         TFAXcm9l65hK+klrgrzyrv8F9rN9T8UySS1TwtgrAnk17pIdNoAU4yAPfkFzM2FAVTFi
         We4A==
X-Gm-Message-State: APjAAAXJog7T56egvkMqXHzSdpXfvu1n8NDyJxpfAGSfHl0b5UuMv3/1
        TVP4Dla+VtkCnWlxEjzMKV0=
X-Google-Smtp-Source: APXvYqwd7ja6uBp48Wo3lLb4h2D7DyEkB5M28GRRvi98qmYGhQru7n/aMo6o8DWYNXSFo6U+RcJYDg==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr12215391pjq.124.1576418729853;
        Sun, 15 Dec 2019 06:05:29 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id e4sm19097170pfj.125.2019.12.15.06.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 06:05:29 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] cpufreq: tegra186: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 14:05:22 +0000
Message-Id: <20191215140522.30872-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191215140522.30872-1-tiny.windzz@gmail.com>
References: <20191215140522.30872-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index bcecb068b51b..2e233ad72758 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -187,7 +187,6 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
-	struct resource *res;
 	unsigned int i = 0, err;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -205,8 +204,7 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(bpmp))
 		return PTR_ERR(bpmp);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		err = PTR_ERR(data->regs);
 		goto put_bpmp;
-- 
2.17.1

