Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF4E92A2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfJ2WGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfJ2WGa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so365049ljj.3;
        Tue, 29 Oct 2019 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOKan3CLVuuggtEwiJ2dOdUbhegm99fdKupMkWRSejQ=;
        b=jWPG4khJIbpbvh/BtmbDvzACurG5Z2WUYb63PX7u6SsZj5yotkQWZSo9DcLZllabRc
         pQWwzivoCPZWjOpp2G9taWtV+HJijqD0vexMkHsIsuTY46dlcjupfGpzXav86HkCTYKo
         4APSKpi/yesfEsk3lKOEoRdoedY+vacaQtUZagbSkZOx5UEOqcpFS2GyrYK+ei66YLbV
         rpJZXfWP6sepmRtenxYsdo1/Hxtac1pOWnrYxIFvxvDjFPNZBiYOS0U4rXL6c+04YHev
         5hfnc3xNfgZWK5ZprFkfiYfXpYlwcvOqzB6iAl2Oy89PPOfoFc7nWr2HiC+K/hUP/y82
         mr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOKan3CLVuuggtEwiJ2dOdUbhegm99fdKupMkWRSejQ=;
        b=E4cFRrd7yP0faozfNwTgG4vaY+A8XbnrRtR5NaqlQkTJiyoAgFDt0m69fGhRjme4Fc
         Dyw4Hbg5+K0I1QE3MMKIDB4PnwFD1lwMdyiS9jvVtefEbUJbA+I996RQW39vMSHh6yW6
         y/Zm+PhW+yIXx3QYagqayNTwYgt49VKIBz+ThPg05gdx/Zd1Tl1lC2uWEbm03yp2EDpx
         P1/Rv8razn5vqYPdto2i5ZFXPlIuqACL00KUMRkpuNIzYdSio8M0sKrK89FWTJh9r1+D
         BYbcK9FzzhlsATjb0c8yWu7WaaxysA4xWvRCq2qYvmHm/Sx4kVpUfYDKaTzeotNeW+gb
         aBIw==
X-Gm-Message-State: APjAAAWxaBXndec9m9yoD1CHluJwonxVNqNMn1+Im2W40bNwhIcO0sgv
        2faO5vdP5FWHcjIDSg0Bf8g=
X-Google-Smtp-Source: APXvYqxek/dVgREG9HDGjmd0s1GV2YQBzqBUtodR9xEh8CoSPKZM/5t+5NvHVjNjcRjAFonSC4w1jw==
X-Received: by 2002:a2e:7405:: with SMTP id p5mr4170166ljc.191.1572386787699;
        Tue, 29 Oct 2019 15:06:27 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 18/19] PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient
Date:   Wed, 30 Oct 2019 01:00:18 +0300
Message-Id: <20191029220019.26773-19-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MCCPU boosts up very aggressively by 800% and boosts down very mildly by
10%. This doesn't work well when system is idling because the very slow
de-boosting results in lots of consecutive-down interrupts, in result
memory stays clocked high and CPU doesn't enter deepest idling state
instead of keeping memory at lowest freq and having CPU cluster turned
off. A more faster de-boosting fixes the case of idling system and doesn't
affect the case of an active system.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d0dd42856e5b..9a21a29198ee 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -123,7 +123,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.offset = 0x200,
 		.irq_mask = 1 << 25,
 		.boost_up_coeff = 800,
-		.boost_down_coeff = 90,
+		.boost_down_coeff = 40,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
 		.avg_dependency_threshold = 50000,
-- 
2.23.0

