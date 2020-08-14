Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26D244215
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHNAIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgHNAHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E1C061383;
        Thu, 13 Aug 2020 17:07:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so8143064ljd.0;
        Thu, 13 Aug 2020 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7B2Fjpe2WofrQ7YRSrsm/9vOVUdpsuOK81+7RfPmroY=;
        b=HaM6qeJArqPXRUxsPKUHAks2qnElfoALYTWeTT9zpff+MRFIE61LHa+pfpAAY2hnVU
         6FQIXAbnNKa8nqQAvYixLwFArz2ht9xxzZIcaG8UDLqd4mvnPI5BaXL6F05MpJwrsiaH
         iiqNN8rpKet0HgKGTFWtrgWj/a77b1RLyoynmITH4k3ZGyfNhBc6kcitvZp3uFHKofdR
         NUxW0fb/4dL6bxmCWqBmfWrpMgjAV84Z/9HDi6TNI2Sg+89WgtUN4bwc6Yu+q+me2PUd
         ffmaSHrkK7qIY201GUp/uWREnjEKqRaZId3nZUT9sE9qsA+HWH6mNndqY1bKEzRiWBAB
         BbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7B2Fjpe2WofrQ7YRSrsm/9vOVUdpsuOK81+7RfPmroY=;
        b=gfsb16JoD3JJFlakgh0N+q7X2aaCTCLH+iurTpMUmUusnMuzIrwID6h26Z2xTxEoIf
         mQmdUiHP1fhGClU9hpp1DYu7icNvKeG0KfBwSeatOpwXRYxlebP/HKVU3UXWuN17reyj
         nmw/5Yj+jlDJIRNCXtAx64qN3xMhNO7UcfkY5ltW3TVkZaiytDOsm1Ye1lyiWS/3+Y5Y
         WcvLtUfkyG6VkDzosPgqVoKGwSqWaKoLKBw3YxpfGRUlSSCnCSwtvogdSqMXa/VOKrG3
         QX/kmZPuOthaO6tNZv2uxVaob5edEWR2MAkiFWmUGgX1g72RkDiaWp7N5VkAPVZPhnb+
         WDLg==
X-Gm-Message-State: AOAM532BYpggeKzWPenB5WeVkekdckMVsUmJDi31c38x08OG9dr6J36E
        39UKX/DouwqGha2ml/bg7JY=
X-Google-Smtp-Source: ABdhPJwiLQtOEsyJZryW1Z/xHL/Syj4Ki1lFQT0pVOuRrIjHNd7mLGMWk53BFO0l8cNZ0e5ryYtlzA==
X-Received: by 2002:a2e:b55c:: with SMTP id a28mr98068ljn.107.1597363660402;
        Thu, 13 Aug 2020 17:07:40 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 35/36] drm/tegra: dc: Tune up high priority request controls for Tegra20
Date:   Fri, 14 Aug 2020 03:06:20 +0300
Message-Id: <20200814000621.8415-36-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra20 has a high-priority-request control that allows to configure
when display's memory client should perform read requests with a higher
priority (Tegra30+ uses other means like Latency Allowance).

This patch changes the controls configuration in order to get a more
aggressive memory prefetching, which allows to reliably avoid FIFO
underflow when running on a lower memory frequency. This allow us
safely drop the memory bandwidth requirement by about two times in a
most popular use-cases (only one display active, video overlay inactive,
no scaling is done).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 850fbcebefc2..4b062408467e 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1999,12 +1999,12 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 		tegra_dc_writel(dc, value, DC_CMD_INT_POLARITY);
 
 		/* initialize timer */
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x20) |
-			WINDOW_B_THRESHOLD(0x20) | WINDOW_C_THRESHOLD(0x20);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x70) |
+			WINDOW_B_THRESHOLD(0x30) | WINDOW_C_THRESHOLD(0x70);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY);
 
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(1) |
-			WINDOW_B_THRESHOLD(1) | WINDOW_C_THRESHOLD(1);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0) |
+			WINDOW_B_THRESHOLD(0) | WINDOW_C_THRESHOLD(0);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER);
 
 		value = VBLANK_INT | WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT |
-- 
2.27.0

