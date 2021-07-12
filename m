Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87FF3C4045
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGLAGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLAGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:06:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB0C0613DD;
        Sun, 11 Jul 2021 17:03:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g8so12574430qth.10;
        Sun, 11 Jul 2021 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+RoyTz3ioafoGh1CV850v6zHYBwTfvOJ8SdICb6XYM=;
        b=U53qDbIR47l3Xnh3SM8c+JxK119FMEOq1vmVL+WVvmZcc/UpaxlN4adUp2mrY8yJ5u
         aOsntTmiXbrP8+p+LaU8nsWK8IIhpAi44P6PUHzKZ5+/d91hhxKllJ3LRX9EBH0rUSgJ
         JIqVy9eGyvgWDxzBSVVzzy9bLz/RMaW400W4Pkz5QavptjNiGKJO/+0e8HGKGyZmD75Z
         r61gXDVoSBrj9iAoX+3PwzZWuK/EGXIOTziHvSqPDyCbboEue3N1+rlz/+rVecHBWNfV
         MK2Zwzyy/6Jb0siCnW2dkgYQ5pfYC9RyCXGRs3rv+Ucym3YXjEzu3+oy5fOhUtmXgqNS
         E3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+RoyTz3ioafoGh1CV850v6zHYBwTfvOJ8SdICb6XYM=;
        b=VlKWnczOZsC/kbU5zXaHf/h8GHJzYuyveBrQ3mCpoiNaI2s9kwJ8cPiwDhEbxI7jWD
         Ocjff3LJSPDO615b78TqSMA79M+htE1Ott37csce58GoahzD3TUoCNHN2f38EUGMtIcx
         uvgca9I5DoXJcVSpHzgcZg9yfYcC8F7aGvQVe9sLj2eRAyzj1SpQwnzdrdaWpU6Sy3xt
         bV0Lz3+/LXAudPR6+SdaPwh8Y5jnubrtSxIAAM/IlpmPW+3KB+PvbJKgbm0dax9xEObG
         HLFS93eVqmSQcZczN0kbQUmSs13vCVt3e+AwR/TjCzZQI7HuiFEAC4uln1SfuIQXjq7z
         KX1w==
X-Gm-Message-State: AOAM531rA2ZPl6aS5G5uxaBcawnCXLlsjmfk7PfelvpoOHmejFrwB+Kl
        r4BZuUakcgBFprgcyahiGwo=
X-Google-Smtp-Source: ABdhPJxfR8HnL+OYJPS86Mj4YW/rYlFIKRTtgPAJ4YYQQr3+pG/W8DVlyJsJDP56SmzPsDj2OeVTEA==
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr44142363qtd.337.1626048228764;
        Sun, 11 Jul 2021 17:03:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h10sm4970290qta.74.2021.07.11.17.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:03:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/5] soc/tegra: pm: Make stubs usable for compile testing
Date:   Mon, 12 Jul 2021 03:03:20 +0300
Message-Id: <20210712000322.4224-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712000322.4224-1-digetx@gmail.com>
References: <20210712000322.4224-1-digetx@gmail.com>
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
2.32.0

