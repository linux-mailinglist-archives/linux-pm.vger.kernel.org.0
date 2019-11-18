Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0411A100C9F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKRUF6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36253 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKRUF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so20442681lja.3;
        Mon, 18 Nov 2019 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyTaXEZ3tQr6gf1Qv+aBwt97ClEn/+4wm6FeUO95GEc=;
        b=DwLNp0YwsQKuC9IcpcWDPUPMzmzkWJvboxFQdmvJYossT+E0yerpmntNXmzqiPEHlR
         URDoWmUIV9a6WWkmQKy0yjo777OC4xfq5TVk6hZfUo8II/1Ox20SO/ANeevsBFtTou7V
         zH4tV7JS7IkK/GpWnNdrOyslCZwwKtg75gW4MzkHhKyFoomAUu3Gt9CknsC4YuRAABSv
         1UkrNU60BC+M23SBhiu1Hx5yQ5Pc9mKnZawkeRW+jBU4SEQEgwu2eDMC7TzDXgWdq4RW
         7vrAF36bToZJin/g/l1lL/9OvnnrHePbJkT50OC53vk2HMvwY+B1JgTD18jAuIu2id/k
         WUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyTaXEZ3tQr6gf1Qv+aBwt97ClEn/+4wm6FeUO95GEc=;
        b=bIJzME815i/pmjIGzqCZO69uTd8l3zi1IrNdPAsUC4yegFXYzpW6s4jhVg/d0B3qgQ
         rD+eMDCSzgqKqvcF9L1gIy8ZbpTesozYS5yk2zC5WWtnb5pMj4Af0JtOVvjXsmUKy4O8
         1VdzyQiMm0/UqqLXoDreyf8PktRs0E0qeNn2+OzCnbk71xl7g9sIDsL4sk28KWOs3eKP
         Yi50eJQ8+8wRyEKicXj8LZars2j0KYR2riS8QMQLjBewS3+ryYh4bK0LeT3To0BxUvqx
         RUSIuKukmIjgGVtL0iCy+qExs+51aaoNEwvmHvo/6s4j2aBS2iqpUdHVq6tKY+pf2COs
         ZWjQ==
X-Gm-Message-State: APjAAAXNVGASGF2tlJXuE/+HHUHxv17F4oXxUdlh/Qi9Am4mBCMLLvI0
        9D/9pp00oJeQbUxLR7PD8Wc=
X-Google-Smtp-Source: APXvYqxzajfDxRsiMW98EBWaSsQPOP+h84fAddaOImVLVQhLDtN+yixqM2y+1kQbQvnGBDX3bmAHIA==
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr890995ljp.133.1574107555600;
        Mon, 18 Nov 2019 12:05:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 25/29] drm/tegra: dc: Release PM and RGB output when client's registration fails
Date:   Mon, 18 Nov 2019 23:02:43 +0300
Message-Id: <20191118200247.3567-26-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Runtime PM and RGB output need to be released when host1x client
registration fails.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 14834cba5455..c2c61156cdcf 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2504,10 +2504,16 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto disable_pm;
 	}
 
 	return 0;
+
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+	tegra_dc_rgb_remove(dc);
+
+	return err;
 }
 
 static int tegra_dc_remove(struct platform_device *pdev)
-- 
2.23.0

