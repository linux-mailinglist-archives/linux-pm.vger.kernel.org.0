Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94BE11F815
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfLOOF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 09:05:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38999 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfLOOF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 09:05:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so4166657pfx.6;
        Sun, 15 Dec 2019 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4NNHMwwOja9ATqtB8C83gEq8h9vLXG9GKfSmzXJLSCY=;
        b=PCh3CAQ63AJjKVVNhM7n8hXDXGssqKDAJYA8Ey03huv5tbwiNSh33rs2UUgYNEvWf6
         WzJtPDCTrwUW1t9IfArl17r0/9jcLzrd6AaS8CirSHGhbA5LnN2rCA1ZoPcxTIpDFAA4
         aYDMIZOe8EJ4JjB+rJctg+3ugsJyBdoEA7rFdMZmXJBviHrSiguzi5slXGGzVQHktLL0
         MXNMHAlNVYBe8oqLdSMSEELrNu+E/qcDOdlzxNT1rvWLYTAlndOCYaEEnUjPAJh40uHk
         YE0PBVbCi6YWSo8SvAGxtORETQX3luFo43Q8X2u+kY0DX30tGMa4wG7vO4sSxQQ6m/gB
         DRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4NNHMwwOja9ATqtB8C83gEq8h9vLXG9GKfSmzXJLSCY=;
        b=D1NxWz/JoDHeWjlkerYJYoiuZHg+fNBou1ndjsudiD3+IyfhO//iV9F8BzHKVcsYXD
         A1jNBdjcPSSeGeGegScb8qHQxELkiQwhfuM1rQ5cfkAgXsonRLsJr2aUh6DEQBT9prkE
         J+wCy/QnigWWQtJ4ussIh6s2Y0PIFybFREr5mmNSyofyFdks22otW2+cC5917djE6oiR
         nn8smiPAKrIt2GF3PzbdGyO6UeUA/SdPaWpvv5nABh88O4HFbY8rz94df+Tn8IgQTzFU
         Cul/Rj5Z5nDdOc+RW6xoudx4FCKV/eeKOZnWpFpSCA6wghPGkkBXu3aIWRZa23NOwnv7
         drPw==
X-Gm-Message-State: APjAAAV+kuA6BACn7JWUu6UahvJwx/A3aWzpVG11slK29rudYGxZaLop
        q1qyAYoqgaVugdh1mZSXQdrqjxngyUY=
X-Google-Smtp-Source: APXvYqxy/gcXNvBzfFhCo1uT1bv0yhQiJ8AX1KU0sse/0eMn785emg+gJFSoqKrJT/HlN+nBG+yCvw==
X-Received: by 2002:a63:534d:: with SMTP id t13mr11784959pgl.89.1576418726531;
        Sun, 15 Dec 2019 06:05:26 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id g17sm19381950pfb.180.2019.12.15.06.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 06:05:25 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpufreq: kirkwood: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 14:05:21 +0000
Message-Id: <20191215140522.30872-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index cb74bdc5baaa..70ad8fe1d78b 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -102,13 +102,11 @@ static struct cpufreq_driver kirkwood_cpufreq_driver = {
 static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
-	struct resource *res;
 	int err;
 
 	priv.dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv.base = devm_ioremap_resource(&pdev->dev, res);
+	priv.base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv.base))
 		return PTR_ERR(priv.base);
 
-- 
2.17.1

