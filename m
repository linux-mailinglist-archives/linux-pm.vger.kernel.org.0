Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBEC18B6
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfI2SAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38957 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfI2SAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so7102266ljj.6;
        Sun, 29 Sep 2019 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIia84ykVHW2WvPfpAR80a4b7Z4klaa99JCqOyNbBA0=;
        b=eceYAUFZnQZlguFVOYmLI2Hq+jx4RIabIW46ap2erZ9g20+SfUNJj5ZAn6cSVnrbEJ
         37AzwqyZINAWgFgZA1dTzkkip0EVcwjuZIiPZXkUW5mmcnY4h00zpAz7Wb/GUE/tyQSp
         zw1nK5pujPo7ZUsd/Xzch98KbDOp8Aw7nfQPRhyciRM8qabnGpXSW9RbcysKuPAoCo5K
         MeNIwfgsFrWtc4jMBQRrk7zPWjFfFcM4bO86cgKx0tfZw31zHapcEIAzEPIr5/9HviFZ
         OK0kgRhQdzNgC3+M/RFW83xF27MSTiEfM6tzkR4QUHbSX/y71YcwA2c75Ba/mbzqqWkY
         fZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIia84ykVHW2WvPfpAR80a4b7Z4klaa99JCqOyNbBA0=;
        b=MeBtCm0OZ4v5vQoTyErWo6QxLTeIwYHhP7Iv+eHrRFaYMy4PXXJSZ0vzoVgAE3X1tj
         6X2aNDFlcMRAYm8PPsVfw4iKmCWDJIypsE7pS442kB3TC7wDpUQHwuvieSf1bhbHste+
         OYCdHAXaAe4bkL/y6pS4h+C2VcyRNrxhOGby9eylQHHnspY7kh8XV6ESXCxs/PwaRaD9
         H4oUpVM5LWDTlKu2GDuOVFFOGyt/QLtM8sSjCkjh0jbLo5EWME8woAlptoucc6DeLMPq
         bmQTkGfRrD/9LkbiNaLyKcFXqCevemTN9+ZMLYx+AkH9iLctuVKoRrMWMd3LUpjfBQ1D
         59DQ==
X-Gm-Message-State: APjAAAV0WiOf16OyfOmZQy1sxNBYw+7SvVkjpafk1VpdU2m77stO0hBD
        2eHvnkw8NXgSfO+xcUBflGI=
X-Google-Smtp-Source: APXvYqw6UggfZZQheTNoMTawFDvoepFSzp7aA54v0PPS0v4pqSpnpEAga3TixNpWMtCVcAKCUpivkA==
X-Received: by 2002:a2e:810e:: with SMTP id d14mr7703199ljg.160.1569780018198;
        Sun, 29 Sep 2019 11:00:18 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/14] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Sun, 29 Sep 2019 20:59:49 +0300
Message-Id: <20190929175952.22690-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Tegra CPU Idle driver now has a unified code path for the coupled
LP2/CC6 state, this allows to enable the deepest idling state on Tegra30
SoC where the whole CPU cluster is power-gated.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index a926d2781227..a30a5e4fc863 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -325,7 +325,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	case TEGRA114:
 	case TEGRA124:
-- 
2.23.0

