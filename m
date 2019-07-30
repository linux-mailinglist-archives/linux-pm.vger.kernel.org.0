Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F57ADBB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfG3Qdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:33:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732883AbfG3Qcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so46879524wmc.4;
        Tue, 30 Jul 2019 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmclFA46wXQuDKk5uU+iG4Yqz23zPEinY/Vi4hutc/w=;
        b=YzE3t3niR1sxF+pHCCy14dkq5ZkHYyuPBBhXGqVMPEu87NkE9mByMm+Ne1pro/Td4h
         ABOH40+V6NqDLxjHzKTyAgz8GTsiso6oGY6egD5cYOQcccf+KZ1/Y5wbpyk29Lcf2P58
         lKtQCwj1V+F5LcDeM9awBXpKlGR5vwUp7ZdKAzjzbOlffYy+rLY+0xxWSXsFR1dMPoDd
         918C1IC+j6XfF4xPJAazznoMGm971oxhh1e5+pd3z5PR/8KQbP/e4qzBpxeRlLOT8ail
         IqF5cdYaNk9UqN/qSJORWgtwyQtd2lv2tcZ/IfmbWIAUfTndu7haHdHgN/jaDAZAsW48
         gUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmclFA46wXQuDKk5uU+iG4Yqz23zPEinY/Vi4hutc/w=;
        b=mwaRGsUFS3mlvWw+QcO2OYiii3Cj9Pq3cn0BpVDtyp813mAVjd+Qq8qMQYSoTuLpRF
         NRX7LaVcp5WQ+A/UEjFU5KzJq0dodKx9Wd9n4JsJHf2sEvt78vN7BILZTjWEE3aUfn75
         nz8TICHlVobXEV6F+Q4ANrPcLAsR5wtg+SXmvv1nZA1p9rKRR2fXt8tDtIOnth5Z9j0U
         mCD+cmyuG4KWDhbOSMobsjXCUjisz3hwY2/odz1zq6f5pHsR+uati4KQ1TW/MikiMLuQ
         aISB3h3bwBhtCw70SDY0vzqb5hT9LlE7JoHcvklt/MhquucOlJPr4/EUmCYQ/pReGZpu
         Y6pA==
X-Gm-Message-State: APjAAAXSUKHKM6eDlaZ1kiE/geTIqtADw2SxRMWkzdG1UE/4FmWAfFv7
        TyiZR1vql+QYpCRXFjet1Zs=
X-Google-Smtp-Source: APXvYqynTbyNtG8AXRPwfKrGReBamcnPasILdR5NqQ2fCTlANwgK6E99JMHjaF7yNi7IsN6hHN1YYw==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr5650976wmj.65.1564504356860;
        Tue, 30 Jul 2019 09:32:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/20] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Tue, 30 Jul 2019 19:22:30 +0300
Message-Id: <20190730162236.6063-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6e8ae20c3bf1..d0e971e51faf 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -706,7 +706,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

