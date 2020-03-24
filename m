Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69D191D0A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 23:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgCXWpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 18:45:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46382 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgCXWpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 18:45:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id v16so400033ljk.13;
        Tue, 24 Mar 2020 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Hy+gQXXd2yXLzvlo+vKQ0DCaXHroqYu+Fy+jYraxjM=;
        b=IGbRH++VoABOyGXkuQVc93OU/loUgy9XQLhh0juQ/zuocAHQcRI5jaBnikUVcEFxyi
         IcYfdYX18WPtyyLqg+cnNVHG/XhI38r/7fBrK4J6pGh4fZQ3LxE3hKuRXxeYRJvJmuw3
         mTYaQgXYE/0pqWM7BkRWCMoRblZD2IgrPMvkbWtFk42uvq3DXOE3lZ4ek+24ea37xzYS
         0prL0TKHL+48w79UFWvui7h4krG4fUery12qRMLlYcdbn82MvowHrgwe1tTnrY/LdzUe
         ksNX33NJOuywRiQ9ChlJ6Jheg98NyMNhn1FFpEnedcO0RUxMa/LDr5zTO8eUkHlMPBug
         EkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Hy+gQXXd2yXLzvlo+vKQ0DCaXHroqYu+Fy+jYraxjM=;
        b=qlScfDfn2/iVqmbstCFgUvJo8t7qazF5ztfdtfgRAshI38OfPErwTjCOqIHaYpEoj1
         YmIKCTQgRIQCDXSTgUq8Y5dBvTl2qS+91cD08cYl+xILcPfMm3QykBQweAGlIfK+kciQ
         KMfeEcQAYIIPngixtJoOoa0oVoIRYLprpSWVN+Dk2mDX/siR8qiwF02tA+cbXRQv/xcx
         qNP8cZcsQGRbp7Pj4tUjb832sou4Sae4kMDuHFAgt/uKFhkAKXyfywDvvj5PJJwoEU6y
         p2JRfyjoSuTYE/1nmqan4Dg4S5fukYrR03FM2x4uLssgzvVkE3UT+bWmrekyWAkcwU/6
         bsdQ==
X-Gm-Message-State: AGi0PubJmYdXs9PVdW8hQDSDXgyf3rVX7BMm7IrPyoKTDiBaf2motUNz
        4ylYnuM29pF3ogtg9j72A68xDiqG
X-Google-Smtp-Source: APiQypJTc7454E7D3MdGDJTaCybxAhN7+8nt5udksXN5OeHNHwUkZ2VMvrRG/S2bIdDirFVEf3HnWg==
X-Received: by 2002:a2e:989a:: with SMTP id b26mr23227ljj.274.1585089942074;
        Tue, 24 Mar 2020 15:45:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id d4sm10534279lfa.75.2020.03.24.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:45:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Wed, 25 Mar 2020 01:43:35 +0300
Message-Id: <20200324224335.5825-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324224335.5825-1-digetx@gmail.com>
References: <20200324224335.5825-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Tegra CPU Idle driver now has a unified code path for the coupled
CC6 (LP2) state, this allows to enable the deepest idling state on Tegra30
SoC where the whole CPU cluster is power-gated.

Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 313b0290e97b..150045849d78 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -365,7 +365,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		break;
 
 	case TEGRA30:
-		tegra_cpuidle_disable_state(TEGRA_CC6);
 		break;
 
 	case TEGRA114:
-- 
2.25.1

