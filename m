Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC08D1105C
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEAXlu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35567 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEAXlt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:49 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so376567itb.0;
        Wed, 01 May 2019 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pafXGoHRoY3A9Ph0hnVkDMbF8BglHn/cfuWPvnCS8lw=;
        b=nigCYDpOgmLtrcVFIoZU3TIg1KrhqoK81CSwx03NR/QB85HmPYu1nasg69LZViyM1m
         xB9lx0wduOqLJMo8FFrGwI5XOKYaiDv3h5R8moZ8TnBRgcO1UAt9k5WG6xiif1uZnAHW
         erIugG5TZHXNHD/0NKwGNDOfu0tcvGfZCs5swFkOzmU+H5sR+aTUGdK+OTo2CP1fy5SN
         yR04Of2L6lb2vnRR/qHrhC3iGsaA9CP86pdafz3x8ws4rmZb55EYB9vRwnunqpg5uQUZ
         vy7r1MJrpWT8EnJ+cD2dDl10lgAr6+pKS+iuXDscow+dcH6tblvHOtJGGytRAmCuypuG
         1wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pafXGoHRoY3A9Ph0hnVkDMbF8BglHn/cfuWPvnCS8lw=;
        b=t4gNG1eBU5wga1PUTCeLopyPpXGinWP+H4nVld7snfkLLZgeOrO5fFDf6qSN9+VhmL
         QChCDyqiHa4chmYnwf7/vxsqtIq9HtJp9ba5VQjxgb0FsBw1UmyItvo/iC7w+BVsGvlM
         dEKp67k70Acj1kWpGvi6QKMHT+45AeTT1XHxio/AiVcrOaOqZZt8xrlsZZtdlnahQ4vz
         GfOBpO+acABTIIwc1gDqJ2rF0l64i6i0z9qcTIHNJQBapTaidQbVvnheePntNeZCg/KT
         +ub6PoJ/3sZgHgbdZ300nnOsGaDXXQzKcgrZAGCN5/T2dNqv3/OeCNP/OFIf3TjsNK+i
         +EEg==
X-Gm-Message-State: APjAAAUHN18sfiB8CgQ7fg105VCnZ6Srn2/yB065/TyY34yoJKr8OEc5
        yq5iwRSjrNzozdDz2ULHJtA=
X-Google-Smtp-Source: APXvYqxkgdsys1uzuzkgHVvAYID0GgD+w+bdMYzY2jbxUi+s1pjsjKgDQhpKcOKi/rNrmGUl4vje+w==
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr227439ith.72.1556754108465;
        Wed, 01 May 2019 16:41:48 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/16] PM / devfreq: tegra: Replace write memory barrier with the read barrier
Date:   Thu,  2 May 2019 02:38:02 +0300
Message-Id: <20190501233815.32643-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The write memory barrier isn't needed because the BUS buffer is flushed
by read after write that happens after the removed wmb(), we will also
use readl() instead of the relaxed version to ensure that read is indeed
completed.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f7378a42d184..7d7b9a5895b2 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 static void actmon_write_barrier(struct tegra_devfreq *tegra)
 {
 	/* ensure the update has reached the ACTMON */
-	wmb();
-	actmon_readl(tegra, ACTMON_GLB_STATUS);
+	readl(tegra->regs + ACTMON_GLB_STATUS);
 }
 
 static void actmon_isr_device(struct tegra_devfreq *tegra,
-- 
2.21.0

