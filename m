Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443053B991B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhGAXbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhGAXbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45CC061762;
        Thu,  1 Jul 2021 16:28:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f30so14845681lfj.1;
        Thu, 01 Jul 2021 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwOJ20tk8kjpaRiRDn1XpVtFwULwReEN17cJsGWj6+8=;
        b=NojXrFZp/7Q8tPOBKVI3J+C+NE/PsOEWaZtVAWG/N6fIQTzolbykWw5sOHzUwHonIN
         zWyLn+xbd0v8fhdGt9La2ib2HVL8hbtyuKoMT31LimLM/eTlrubVsO4eJhWETZI8c53v
         LYnkgBaC2Nb2NtTQiKlZ+kv+DmgeBRduvCG1eWMNqm6lcmYGUE6v/jDryM7IvPqu6Zde
         AMioZHun/qZnTAy7F9hQaQNYULHTsWf0BAu61ID3v0WyCVap50p5oVUTzlIJJdaLAR5X
         dM5wTztDr5qjYIKy752jApIkhriEU540qIOMvxSAE0tC3WRNzZrW5ELGEJV3Qw/fl/z1
         pCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwOJ20tk8kjpaRiRDn1XpVtFwULwReEN17cJsGWj6+8=;
        b=eidW48uyL7FKcXqCuwvZvhw3XeJ6msocarhpE3zjESoctDvRBBcFZoQiMfhrq19SAf
         CQlFQnm8fVhhB41WZy1qUiQXxFW70n+56rG7ZYVJLqFYpTJSkv6eriMnJ3FiX6zwMb/0
         05iImBEylAkDr6PJFZB0jH8N5x/eMCtW1Q5jeS9mVY3hGdSYKc3SgA3uUXlrwY8kp0OE
         pd4h5GQd100ssRju4EeektQbaeOSwB9pBOHayYzVCPbmqAOPeql9GisVbvigEb9N2gNw
         CQoCAewOPqwTXH36TjAoAdDMWP/ZHynwCNi1Fn7au+22GU+4ufZ6tXwM8gKJn/AA08dd
         Lyzw==
X-Gm-Message-State: AOAM533MFswzVvZr4vpALONW+mW+2/OP7DqjeqHBeic/zyDip/oKrbMD
        pesoVhUUOrV7ZEyQIpqxdZ0=
X-Google-Smtp-Source: ABdhPJy7KU0D+3jQwxiZv9vXMRi4gvrk5DWx3FViwnlVnC0wzD9keDEBIio9Ntzh9lgp/Dtmn9ISlQ==
X-Received: by 2002:a19:4c85:: with SMTP id z127mr1574009lfa.336.1625182119638;
        Thu, 01 Jul 2021 16:28:39 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 16/37] drm/tegra: vic: Stop channel before suspending
Date:   Fri,  2 Jul 2021 02:27:07 +0300
Message-Id: <20210701232728.23591-17-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Host1x channel should be idling before hardware is turned off, hence
stop the channel in the suspend callback.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/vic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c9d55a9a3180..3bf08893b561 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -525,8 +525,23 @@ static int vic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static __maybe_unused int vic_suspend(struct device *dev)
+{
+	struct vic *vic = dev_get_drvdata(dev);
+	int err;
+
+	host1x_channel_stop(vic->channel);
+
+	err = pm_runtime_force_suspend(dev);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static const struct dev_pm_ops vic_pm_ops = {
 	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vic_suspend, pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.30.2

