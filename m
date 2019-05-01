Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9911058
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfEAXlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37346 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEAXly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:54 -0400
Received: by mail-it1-f194.google.com with SMTP id r85so360789itc.2;
        Wed, 01 May 2019 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hT2F8IjKIQoszn6Buk6j3BScSUALq9H2lCvIgZ7MA44=;
        b=qI4SpIkw8aSy2zSnENGPxKIvXxF9LC3SnVRuQ1yCmAj2zoYH4XtNemCE4SeBfR2SwQ
         yKiF3+bTOOGYVjr9ddSA96gwJc+8TB/NKaGsvS7NjsYMUtlTb7QG9AXjLEI20YsKdaX/
         Ju0QILLqIa5S1DIUySEe+9oqtIx5MCXwp59J1JhhgirKB2UgO4RiLxm+3YJu/hBDXqWc
         qD1zheW85alvSgrJ/nkkYsrzpU2El9dX8AhvDa8B29fLdf4xJe9E+f8R3SJHPXIlOgjH
         iHUcztEclsNEg6IePqqqYZz+P60KxIlJ8mR1/2Q/NWI6GJfu8b+uISUSrQPHo8FFe5b3
         YIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hT2F8IjKIQoszn6Buk6j3BScSUALq9H2lCvIgZ7MA44=;
        b=Wmt7eLnKsN24B6EjNzb7MO6qkVtBeP05li0EfDQuv7BU4bphfgyrBQXo3Q915GkU7K
         NjHke7CIXTm6CPnKcs3T3PDlgUWKmAEuuNiyzRRmcU5NZ9F2K5XjmStHRk/TMD7dujaf
         N8qcCwTjvY5u7W7otMXrE1YzqZQiqqmRfNYzb/aFNZgPWP5g6od9nFoyVPTF7mm5vcAu
         ZeTLPLiG9a59OtLh2Mrd6xpIN4OFPAT4C4hjNJGr25zVvjTsCfzSEmZq/H7RvpyR049M
         qVQ4fQ5bESObn1pE6KNJtWA+yg+nO3pq39bsbXPJE/m/4b/KmPcMK40Yl7vZIbk9jnAV
         MiLw==
X-Gm-Message-State: APjAAAXOGXN40LP5qXgmMt8Chr/JxhgPCKAHmkPafr+uyeftKv0XYOKi
        o/Qkj1Yhghk3Oo/jdsc7ptQ=
X-Google-Smtp-Source: APXvYqxSdCcEzp6heDrn60nbkhWlRk5OlSZvuvVKyusrg4FcPDmWK6bXirTXL5ysNPH04/RISrpr3g==
X-Received: by 2002:a02:ad07:: with SMTP id s7mr282942jan.103.1556754113467;
        Wed, 01 May 2019 16:41:53 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
Date:   Thu,  2 May 2019 02:38:04 +0300
Message-Id: <20190501233815.32643-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real benefit from doing so, hence let's drop that rate setting
for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c7428c5eee23..24ec65556c39 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -653,8 +653,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	clk_set_rate(tegra->emc_clock, ULONG_MAX);
-
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
-- 
2.21.0

