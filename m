Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859FF39D1E6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFFWcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFFWcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:32:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE70C061787;
        Sun,  6 Jun 2021 15:30:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r198so19601869lff.11;
        Sun, 06 Jun 2021 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4pJty/E5fkO7x6KK6SBQ4sryPDFPkvXMuAlHVfDPrE=;
        b=DUDIGy4V9lZJl5VBUL5fdSSW8QOjmSBZ6tyMfLDFaY6d6PFj+PWvmIMCbCr3WgWhxY
         +6gb1ZDlpbN9WF3BYbRr+jASwWPNdPUt98+h8X6IfZHW+9+vAGFndc1Q89COCYY/Xmzf
         en0tKcbXbShvAsHy5xdk4CFTvzBZLpT/rX6i0eTC4CIq4kHLTDXb2XdVwMQnbI1URjgt
         8U+4a34LbFYonKHjzuMZMEcK2ZIJV3RsCrQUKfKLapcgaddG5i6USqMXfRweIwkVlcOS
         oCvICdhEuJm1e02q0U610xkx3lFDaYLdgMxASz3QgEvr2nFKLPrnerSqTOIdjFgKEfH1
         s6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4pJty/E5fkO7x6KK6SBQ4sryPDFPkvXMuAlHVfDPrE=;
        b=FaDdQXtpfuQFg28fLXn32dh5pM/lyu8TGvIMWGSfYK2LpLPPA0A/2vp+eJkHOne1ut
         W1akTaPzne6b+n3Yj34F5RXmH1gigfVGNXZiQWxdKTU/kcMwpHM2K2ZOHRB0sNAdTX4h
         qzQ7JoHV8tvaItY6IY6NBkXcAu/Rx4Z3ai7I72uaLA5gIM3EIQD8UYgsIyOUlkMZjKs6
         JCnNGeaVH+9KOhC74k+rAK0r0h0BxVnRB/6GXgTwtzdyrfUi7go7X6bE3rh/opJLZ5KY
         /0ajKes+MyXTEhYFsFx5ZDWb1R2jUeQ6MrgLjwUnvBnAtbdCnZ5hOO9n/ep6msLJS48T
         WRFg==
X-Gm-Message-State: AOAM530obvjEZ+jmbqiRXKUnVPOr0dj1BgJ8NOZN84YBwsDpMKzh8HOU
        wutKThROs0eIv0rzhkvxDc0=
X-Google-Smtp-Source: ABdhPJxAkpUuOce7noj7hu/33zYZMfhCOjTWl+e/LfrREA1BCo8jdUqpgLm3riC6Hq1xpeNoQgTErw==
X-Received: by 2002:a05:6512:5d8:: with SMTP id o24mr3975560lfo.651.1623018603738;
        Sun, 06 Jun 2021 15:30:03 -0700 (PDT)
Received: from localhost.localdomain (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.gmail.com with ESMTPSA id i23sm1017778ljg.38.2021.06.06.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:30:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 3/5] soc/tegra: pm: Make stubs usable for compile testing
Date:   Mon,  7 Jun 2021 01:28:15 +0300
Message-Id: <20210606222817.12388-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606222817.12388-1-digetx@gmail.com>
References: <20210606222817.12388-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PM stubs need to depend on ARCH_TEGRA in order to be usable for
compile-testing of tegra-cpuidle driver. Add the dependency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 08477d7bfab9..81701944fe78 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -16,7 +16,7 @@ enum tegra_suspend_mode {
 	TEGRA_MAX_SUSPEND_MODE,
 };
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
 enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
-- 
2.30.2

