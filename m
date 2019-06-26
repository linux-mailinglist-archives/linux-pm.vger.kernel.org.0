Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDB55D8B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfFZBfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfFZBfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so376421lfg.2;
        Tue, 25 Jun 2019 18:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=blagBfA/RhbtGyvgWrThVNlgnXp2+faUZVnjQLZSgEuUcTLYdWEECrOA1eIrtCbeUh
         iMiKnkthJTBrqHKMTidO4emPabBb9cJDxG3CRwMiPuvQGJR79HfqIsk6gZptrnEPUgSR
         +sLNVsd9eDjGTc2ox/iMofkME/8JStaOLVyA/zCbwjGkV/7KGUXDuyqyaSofx+cFGU7T
         NHfZMaRF7PTLLM/JBmq2na6YPGOwwRteZxE+JSAUqAQfgxGP2YPnv17nixqepmXiudqA
         hMIQ3UAnBSkxl8ZOShKkOKoBuraeRLC+XA4bl44SgH+Lvvw147RO7c59wQZZ01kRRNYa
         8MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=YZGaJey+h2l381OBC1IUJ+5SiTytOL9SFp5w8gtBeMXdP6xj7s6qq1ehm2T+UQQYCO
         nzoBMI+loClAAH2ZWOIC9NCvFvMnJQt+xD54w0A3WNSX0Dnkzo98TYSA6CX2lFH+VnJS
         ug1WlMCsk7cCfJBbRfIyu3n5f+za5mEztxgOPOk++Gg4d7djnap+GySgTOvX5oa1SJR1
         HxvJYwua03DBw9y5KDivykMQ5JqpDqJSJgAuQod62K2j+UsMDmiph+KXuA4pagf3JStV
         3d30HKyonXlFCN3ZpU8dOP2gc5AC3FdC+zxwJzZTJxq7WcYm9cYogk2B8SfPl31nolwa
         qQ7Q==
X-Gm-Message-State: APjAAAUszM2r/bU9uWMfnvGkExQDpoyDdg3tCr/oJV6lgMtQVwecAmXK
        at3BN7WLdND0Xi64bvY3it0=
X-Google-Smtp-Source: APXvYqz6FUD1Zdipfg2gu7u65/qlq6MzXzjmh6Cb2R0/kWZ8AhqdxteZ3yCgJEt/jUZGWFOjcYm9zA==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr903056lfa.104.1561512900865;
        Tue, 25 Jun 2019 18:35:00 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] PM / devfreq: tegra30: Drop write-barrier
Date:   Wed, 26 Jun 2019 04:32:38 +0300
Message-Id: <20190626013252.30470-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need in a write-barrier now, given that interrupt masking is
handled by CPU's GIC now. Hence we know exactly that interrupt won't fire
after stopping the devfreq's governor. In other cases we don't care about
potential buffering of the writes to hardware and thus there is no need to
stall CPU.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5e606ae3f238..4be7858c33bc 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -230,12 +230,6 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 		      ACTMON_DEV_LOWER_WMARK);
 }
 
-static void actmon_write_barrier(struct tegra_devfreq *tegra)
-{
-	/* ensure the update has reached the ACTMON */
-	readl(tegra->regs + ACTMON_GLB_STATUS);
-}
-
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
@@ -287,8 +281,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
-
-	actmon_write_barrier(tegra);
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -376,8 +368,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
-	actmon_write_barrier(tegra);
-
 	return NOTIFY_OK;
 }
 
@@ -423,8 +413,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
-	actmon_write_barrier(tegra);
-
 	enable_irq(tegra->irq);
 }
 
@@ -439,8 +427,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
 			      ACTMON_DEV_INTR_STATUS);
 	}
-
-	actmon_write_barrier(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
-- 
2.22.0

