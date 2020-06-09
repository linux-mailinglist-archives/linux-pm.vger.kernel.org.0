Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED31F3BBD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgFINPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgFINPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F61C08C5C8;
        Tue,  9 Jun 2020 06:15:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so24980176ljp.3;
        Tue, 09 Jun 2020 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CY3FjRZp76KZl7tgz6s6CVjJ18LTSPB3H8v+jn0FVvg=;
        b=lth0L5t9emj9h7WIYX4C+MyILmvEn5rTTR1t5uicbsTDyqJHzlKcyWeEs+jHZVNJzj
         l70X/+iii3orOOm+/qRAbf04E/8ratqT+pkIkxA4gUIn0cKy2gvZ/6Jx8SngR5UiS9Mp
         aee+TaQwprhii8V5NQiFuidrF9Zz6k/1nClU2RMmumlId5X9OxKiuiMyLIgP7UMG/7TQ
         cQtqtFqoALbccdsQwu9AZRcW7C9cuMOYqICxIjiLtqDdSA5iz73Liq8bbE5qkvPZo8Mm
         RJsp8K8MmTxkaaf+IBPlzLtUNR/V398oOAZrjD5/9Kv6RwhW+iX7FLwLHU02t7HbOZE5
         oMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CY3FjRZp76KZl7tgz6s6CVjJ18LTSPB3H8v+jn0FVvg=;
        b=Q4QZDoT7ObGDNjHr52BalLVazc5HJEDkobpySDiENG4QGIZYRXFo8BWrnrDGDaPJfJ
         CB96AKBcBxm7+7ot7Z6I5/XvjvUPIXknd6fnJmhpjgKd8jVmS9bDPIxOBgeTSRKJ6+yV
         lquEFRaMMzq44RUQttAIDOhQ4bWo6P3j5E3qAqi6XB6QCrLgRlh6jM4juYHeBp+b+e+L
         3aFI46PIZ1A6G/WUOAYV2Vz2ymg6ldUpkDoMXh/8/crpn78VJqBntyuvifmT/NeD/FM7
         fsxfSDWqH7H2U+rT2v1KWOG3WHif3z2njNs6KrMQxUFUtvWOeU9Nch8e0j9+sZM8NBXJ
         RyFw==
X-Gm-Message-State: AOAM533G6RkZ0VmTFPK6vlEUHBnnhse03rszHcmDi1v8nKege/OhgdDj
        /BOwMGrzWHgW+6eLzEAjSb8=
X-Google-Smtp-Source: ABdhPJxMnBTcJsjI4SwfSsZ6hCPM8ucyzc3NT3JIFYxZrzE9tWkzhkObz7tEzvH9QZyudwmh4j7wHQ==
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr11786526ljk.324.1591708509218;
        Tue, 09 Jun 2020 06:15:09 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:08 -0700 (PDT)
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
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 36/37] drm/tegra: dc: Tune up high priority request controls for Tegra20
Date:   Tue,  9 Jun 2020 16:14:03 +0300
Message-Id: <20200609131404.17523-37-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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
index 12b318bb8475..48dad375b470 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1971,12 +1971,12 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
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
2.26.0

