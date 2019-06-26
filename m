Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB17855DBC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFZBgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:36:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44666 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFZBfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so395867ljc.11;
        Tue, 25 Jun 2019 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ES/vfze9v/7K/EDiZc6SJwTqcOwXLf9AWF6aBFoXttY=;
        b=ZttdUf7hWHbaB81wbjh+EvDj/Mpwg1YtoXbxtL0qk9UojPdodpPrruN5gkyJB+DeWc
         g6ONXUa27Hshc2cY42Ft0OZEJWsUI1doM2LjCLnmU9tVFulkDlgkeLqyTHuHjkwPdP0e
         gUz7NsOnV+qedlsefC2KhwEy5NcpzYHHp6/U+Zcy7FNzoUg/cmiTx0GwbThuOnSv1t6O
         HxMUTBLiXTXWnyLHAgc6h0nsB/ntEG7MZBUNjUi9CLrCjci+2568TsmkJHSrbgXTpqoh
         AvWgicDdRes/OCplKeNm15WIASM+o6Zk5QXPldsA+2sAhxdHUVjiHi3H3UJjYGRlYppi
         lHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ES/vfze9v/7K/EDiZc6SJwTqcOwXLf9AWF6aBFoXttY=;
        b=IJHeXVbvwHtp3C/IHXSyRgkAr7gg5Jb1ovBeCD+/FUjmJMxPfD/ci+Eaoef4CcMOtO
         ReLVIH6F9+o4UrCzmzxZL8CugjuZ+r+hjusSJFarEtqw7oRbYN1zvjnIByNzUA8Bq92Q
         +g0Q2YtEl+eFGokQ50eaklymqR0qNU3rOl1NncffIy243GjDyZgK0WekqPUvlhpv2PC6
         TQ1dw+vjh7WwHBO4zSrkIt55uS4I95fejw6DDZNciOjmE0owiSaJEsyAiOsXXVQ82pY/
         6ySJwEE20B7gzNq/PRVTLVXi1+cD8kaNi2YESO2vcrYytTjptZ77Jgy4/9rwg1oPVhsR
         y2xw==
X-Gm-Message-State: APjAAAU7O19ifMm7Aqj3P7kRLd+UKDD7TCpUiuxSjSQMx121QUlif/Kp
        mOjnH9fmGbH1KwoDeMnkBsA=
X-Google-Smtp-Source: APXvYqwaZuxZv1us6taG9s9eaWKkPnGOJ76CBFEm46O4t7cCsWvFg84pMcQHQoAQfxQ+PF5jjvFsmw==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr938152ljj.34.1561512905920;
        Tue, 25 Jun 2019 18:35:05 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] PM / devfreq: tegra30: Reset boosting on startup
Date:   Wed, 26 Jun 2019 04:32:43 +0300
Message-Id: <20190626013252.30470-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8e1c56790ac3..b36d5d644c6e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -534,6 +534,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0, target_freq;
 
+	/* we don't want boosting on restart */
+	dev->boost_freq = 0;
+
 	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
-- 
2.22.0

