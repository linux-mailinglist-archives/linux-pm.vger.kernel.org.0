Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F02FDC9D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 23:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbhATWbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbhATW1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 17:27:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD36C061757;
        Wed, 20 Jan 2021 14:27:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so19345721wry.2;
        Wed, 20 Jan 2021 14:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+YYPxYgIaXaJZpbVcLE+s+aMMIfmEVlIGclm9I+uGo=;
        b=jWDK5lkswMxFB5eDSywZJkZnnjT1+XRgOnMTr2hqt5W6G+5IGqI3QqX1kWVZHD3Q5Y
         HAxAKqu8v9KK/dAIm6xL5tNTLPn6VppSZCF6Kahpzly/AEbtelgNjuq+xVbNA/4Rlscq
         Y5oRecBmc+UMufl1gZZjhWofYJ0qBnJ+uMqnMwNucrDbnRIKvfpjezDP05HU4E6C5wHM
         /s8vcMqQjPxoO3X7hXd2t1zcaexwrC4hvpV4kQ6VbLCGVrw5fo/4CV4AySEqb5rpZRr/
         +e4Kca1/mgUveyl/mMEJdZi4bNOUNz4qZPexBDSRzH2P7b8KFgEys/bqeV/WD7KZc6bh
         wMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+YYPxYgIaXaJZpbVcLE+s+aMMIfmEVlIGclm9I+uGo=;
        b=pflOE2VLxcJMlG5/E0oCZMoDeusOKXKQQ1lF3VjZn1vx5gdand/e5t+imGQ9nVvYwc
         XtZrJieCORz48a7rXS2ZxdA/HztMNMsZAVPY0v59cWQop+9PlBVIqsdaJdVTQVv7H1QD
         i1xi9oTyCSWjvDPgSVGAScCwgTmgmPoHir6bFBGqBiGq8J5jh1nzxPNF5t5NEaT75aHl
         92iERZ0MfD7M9ZpOQq0RkdPBqNjtePp8b2wzqgxPYggDFwVONcFLtJTvh8mHTFiGgIja
         bOJMOzaifteDYp2MUFMqtuY0FHv6KytUIBcXJkAKJD0/r/akS2mX/q6YHnvfzTv1k0OE
         JpQg==
X-Gm-Message-State: AOAM532zVpcJTN8NUcSRb+50VtHRxoAcVbPmOkcGo/obtyMewxMwSXQC
        UxsIeWMNriaATNI4RydesIs=
X-Google-Smtp-Source: ABdhPJyrZQPB3Ey0eDn6/hzyTw+mqhkHR/gqn+t/H8qUzNN0aJvK4qP5fvE8ZBW10NjAHqsqO7KpKw==
X-Received: by 2002:adf:fdcb:: with SMTP id i11mr11401188wrs.349.1611181622424;
        Wed, 20 Jan 2021 14:27:02 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i131sm5663710wmi.25.2021.01.20.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:27:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] opp: Export devm_pm_opp_attach_genpd()
Date:   Thu, 21 Jan 2021 01:26:46 +0300
Message-Id: <20210120222649.28149-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120222649.28149-1-digetx@gmail.com>
References: <20210120222649.28149-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devm_pm_opp_attach_genpd() lost its export by accident when it was
merged. Re-add the missing export, Tegra DRM driver now works when
compiled as a loadable kernel module since it uses the exported function.

Fixes: 22300b8fd92a ("opp: Add devm_pm_opp_attach_genpd")
Reported-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f80b6f1ca108..6049b17f99d6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2297,6 +2297,7 @@ devm_pm_opp_attach_genpd(struct device *dev, const char **names,
 
 	return opp_table;
 }
+EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
-- 
2.29.2

