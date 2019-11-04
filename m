Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2DEEF0B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfKDWSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:18:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41710 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388656AbfKDWBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so19370475ljh.8;
        Mon, 04 Nov 2019 14:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCIWMfP1VPP4Mlo+oAntsMXZNvH354k2VUOlKxxlyNs=;
        b=bmQHksK9yY/V7YYJfquoSqTBqSgpAi//o6+WDsa3ucjYlxs+iNJWJ7OHB0XXaR0cEa
         dhXpt53x/EYthqGDGcO3lR2zGgETSrXqagLvoaIhT0rYSVO258GU1iax/zlXdOqQtySP
         yhJ+AA8NOD35r/1pb718wVQFHiZZd2fkmzuO9WPC5KE92kDdeFJ8EWSC48mLCncLHfXr
         gQ4b4UPO2zlWujKmHtSv/gZW86CNGBGSRsVBHtmwDq4/8QXhVeM4e/4dx7pOwOvVdK0D
         7L1bD0W0beAiufHgC7bmg+2WXhBe9Hw8mEcIX0KjSHx2C+QT/cDb0letMEDREZ/hxecJ
         Du/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCIWMfP1VPP4Mlo+oAntsMXZNvH354k2VUOlKxxlyNs=;
        b=BYoTb3ampLmdy8Hg/O27KEm0jCjT0qpW0wPDB+Pg0GHZLTYJ63vR4e9vUGsHnufeCv
         frHKn9ib6XcoeYTLz6oYtgjOz5Dka9064opb/7OiSLaK3re/yY6PmC69GgZ/o68XQNS4
         a7gnYjEDAJWHr6861J/HmutnSRGxUivF1azffFBcvHPze/GbhUaD1JMndZ9TFXJHrQuk
         YusylAAACRxJLzzt/tVPpfg5tEqnsUKgpulvSmNDUvJnaxAdfhkPHX0Pygf74HENDwxv
         ux/0FNauKy3zkVa3D0/IDryX1skdp3x0es4F/cV0jCMtPyRcRib3Ogith5JoYBjSjwDk
         6a6g==
X-Gm-Message-State: APjAAAUjvocm2zm5kf6tdeETNLdDVp/TcpQs2PHV2g6l9lrQTFRLCipQ
        stOti6zvSctAjOe33HyrhHwts6J6
X-Google-Smtp-Source: APXvYqxU61urBbJtIU7aswhY0D++VEJxl14uOim843ou0VrRJtc9pL22FdchXaHRBq4EWetYaQqeFw==
X-Received: by 2002:a2e:6a10:: with SMTP id f16mr302864ljc.100.1572904877652;
        Mon, 04 Nov 2019 14:01:17 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 19/19] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Tue,  5 Nov 2019 00:56:17 +0300
Message-Id: <20191104215617.25544-20-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f69d01da3a6..4b9679988514 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
-- 
2.23.0

