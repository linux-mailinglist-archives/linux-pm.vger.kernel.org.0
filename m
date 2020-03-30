Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E91971BF
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgC3BJ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42913 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgC3BJ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so16239520ljp.9;
        Sun, 29 Mar 2020 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stlNTWc9aUdJpsj0CRgkxaVzFvCy4PtSWcEihJg934I=;
        b=GmV6d+mK8slNNEw6qzIvmLHNGh+x/WLd+YD7Hh9dEx+Uu8C+gPQTkll8G4/5FnuBB1
         68o56wo7QLyaEo/25iN8MEb/UH7dEmIrID/nxhAX1fNh3xMFGXSqv638b11xdqGPePCL
         0GrrQqS4zely6Zu+cCsBAb02zIifUAvduno4Ebk/3o2E0CeTce2kpCG6zTkzDqWBNzLZ
         hGYFCPgfJMP1K+n9Iac34mAr0wKHbVbKMdGvfUoZTa/FxCxBrhKvNq4s96Ycm5K92udv
         wLq5Y4kIe/Hh309g/9VVGDubPvFEbst++6UqovUJwnjJjOYXn1b6t6pJUjsMHzqQ3sFh
         MzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stlNTWc9aUdJpsj0CRgkxaVzFvCy4PtSWcEihJg934I=;
        b=YoMwIPT1gn8fIY1vl+WeScddeKNiywGj6qc66cYsowo0CzRtOuolmdhPQofY8+/Txz
         yOBtxJ080kA3Aog/12ZC7WZwIRE7+0+rc4UYJL+SSJqq+k/fZc4nAlrbbKdLSCB1TTWf
         jpS5KMJ/3vvcAbiIFEfSnGcF+IeHWx0fmXnnu5Rwrj1Rt7zbM+8d4mGPcCFHuhSMIbid
         7e/yq9xI5GPamIh5pzW/0+HPSh1QjpgYl/Wn3wxbyljxZ4qOR2vxpsEbj9lO+mJNoK8Z
         gLy9QG+Tm2DNU9M6tZUmbRJ4pvc6nfZHGtaAfEjzL31EJVl5fkOHu6pyJl4zYyBvOMhs
         QnjQ==
X-Gm-Message-State: AGi0PuaxKLlhHjsQeWlWn3Rz8mKtnrMgPeBvd0gFWmE3aiqu9VLdvThi
        324XAdGJ+S1yjcF5toWomHo=
X-Google-Smtp-Source: APiQypKsysMvdXjN0pdMwS7t/sXNKen7udhhcltvbAzFnJQTm+jBxHPcXJ1OcZOvorh0PVEvp3TerQ==
X-Received: by 2002:a2e:9acd:: with SMTP id p13mr5425374ljj.131.1585530594184;
        Sun, 29 Mar 2020 18:09:54 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 19/22] drm/tegra: dc: Tune up high priority request controls for Tegra20
Date:   Mon, 30 Mar 2020 04:09:01 +0300
Message-Id: <20200330010904.27643-20-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
index b540ac6ffdc4..564af302a965 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1980,12 +1980,12 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
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
2.25.1

