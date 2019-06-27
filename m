Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129FF58CDC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF0VOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:14:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF0VMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so3802563ljh.7;
        Thu, 27 Jun 2019 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmuqpQnIKx55SQ15FPcNH4NyOGvXSX+OYiqO97Z8PVk=;
        b=XHp8yt5SXHBv46tQ40uRQ6WQpKz2NPySdGtNzUO6st5/ISIhl9rvMBLOUR3enIFqqu
         yzNp3cCifDjgzhYACl4uFt+2SJgz55yX8DNd5NqWIsrCT2REBtTOyfBdP648HRBTr3+g
         BZJjT+xOsM1aMlhJzgi8VvBIdoQ0K+sEj77oq3kCWRblx9m1R+Bo/46zHtzfS31f00Tq
         Iz3pJFZvSSLYrM1frFTmwZ0R930NkDVuV2h3yTUHICXXwgEJ78h/U0VY3oJv9mltPD93
         qE/IGyNqv+Kf8LA1EOB1yLR5bATf1NQn8jiOMPvUjyMk1Uqx7KU/wtWpTWlH29aC8bSo
         7H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmuqpQnIKx55SQ15FPcNH4NyOGvXSX+OYiqO97Z8PVk=;
        b=q8Kp9M1f72N9tLhuF5j1Ok+5da0COA0NjWRkKTLaIP/tQcj9c1U+0lngJDHSnnpAXt
         p6uSmChn66oxYMJNW0NBlohDL+XhOev73FVoNvo9zvBn3lqfodzXwIHvMdvpBEg8+p2n
         /qbods2fyMHOqh5vKFBcKbHjhfPUkrkFMDVNiSclZNVoUPTgrtLVpiqhk14kuyTWUm7M
         KsnipDCk7DvMRlAijnuZEoPKh8Wld6YNVhNxbYPtLvcDZkvHZClTcTT7lde4FzEIxTLt
         TZEsB9/71/vnlEMbNojv2coZLLXO2vxMedDYb2GXANIRyHCAUGQ30NPdeaxbajhlP+vQ
         9D2w==
X-Gm-Message-State: APjAAAXKUvKH1x+bBoGuqvPEcRnZX8KTDMUbZBXKNxj4lNoXjyaK5KCd
        avrRdA9kad/ojMHb26Igg20=
X-Google-Smtp-Source: APXvYqzdVkA3KCfAAvApHTCkvBOSUb5pEkbuA0yR+LTZAXxf0HWRVz2fOtVR+Ci9TlBucika3NRXwg==
X-Received: by 2002:a2e:988b:: with SMTP id b11mr3903970ljj.110.1561669949703;
        Thu, 27 Jun 2019 14:12:29 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/22] PM / devfreq: tegra30: Tune up boosting thresholds
Date:   Fri, 28 Jun 2019 00:10:59 +0300
Message-Id: <20190627211115.21138-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that average-sustain coefficient / multiplier is gone, it won't hurt
to re-tune the boosting thresholds to get a bit harder boosting for MCALL
clients, resulting in a more reactive governing in a case of multimedia
applications usage like 3d / video.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 0c84ea44c1c0..7662e54f0e70 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -111,8 +111,8 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.irq_mask = 1 << 26,
 		.boost_up_coeff = 200,
 		.boost_down_coeff = 50,
-		.boost_up_threshold = 60,
-		.boost_down_threshold = 40,
+		.boost_up_threshold = 50,
+		.boost_down_threshold = 25,
 	},
 	{
 		/* MCCPU: memory accesses from the CPUs */
-- 
2.22.0

