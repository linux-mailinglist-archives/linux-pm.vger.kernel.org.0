Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52BA8943A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfHKVYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36377 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHKVYx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so1645772ljl.3;
        Sun, 11 Aug 2019 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7LGlq6WIVQMLtb/JEtFncARlenXInquAoE0QDVW21U=;
        b=P51t0m3rzz0PnQOdu2pOxpETktNoisJUH72+SbZPzsmw9KgYP1PMraJK99BR99qkxa
         Hcl1qqDbcvH/fE0z1IJom0SsGKljkT0HZKKWGUHqsC+Hjd4wTH5wQRxe5MCEKXHvY03y
         OqTJeUSCBF3h36AnAQHmFlc6KagyLk25Rt5YLzblEu0Zdd/GlSxivXawqJDX7qRKydxe
         X8Q47iE9OdFkXsASbni2Or/BQZxx0w047gDLhegRnwQsNjWFOd1BJBLDgm14556UJ/Zm
         TWxIs97EDiGpwhveypfNLeT3amBCtEHz5J+i18XKQn1aZfG2333mUsDDvibssXt+dtoR
         Po9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7LGlq6WIVQMLtb/JEtFncARlenXInquAoE0QDVW21U=;
        b=IAgOUU5cnUOCyEj5rkDSBJ2QcB94Cl8ONdYPPBDCS3P3fRe3d3ody+1hQy5baxETJu
         buznkAggIBDQl/eCpzvTtvMuy4ptoZZei+GZAhokirHsLkmUqdCPWbCRX7odkBsWi7ox
         mfY7qOSevs7tmuGnR/OERfsocuVDBQazQHwrS+qH6YHMiMtsfHM5zDXoxGhf7vyh+lZ2
         ihq6nv+i2D4sUB8qiOwPoVT2gk3Tlwv9oc+Z8ooIw03OfakJJXyYHh90/T9olqaBKs68
         KVBdmaTiwPTj3VKPjNkGtqH6smnTnCKw0Kj2/764YeeOKtjnmwTLkwXqvhfiK9eqmTSf
         SnXw==
X-Gm-Message-State: APjAAAVjCc+pYBXRI0NYI6SkDv3PyvKR6WopwP5Ac0uA55WeeCuaqcj1
        /uxIQp6TU0slo+njOBwYzJU=
X-Google-Smtp-Source: APXvYqwLe+JA9gDyV0I4Abvwjk3D+0Nufs1khKyHDrSKSFRdXMkl7MVQamMrjYtd6zjrlU56W0uF1Q==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr17382353lji.75.1565558691639;
        Sun, 11 Aug 2019 14:24:51 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/19] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Mon, 12 Aug 2019 00:23:15 +0300
Message-Id: <20190811212315.12689-20-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
index e60f5c361969..8a78abe4739e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10420,6 +10420,15 @@ F:	include/linux/memblock.h
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
2.22.0

