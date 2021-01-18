Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B42F971D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbhARBDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbhARA5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D1C061795;
        Sun, 17 Jan 2021 16:55:47 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id w26so16519202ljo.4;
        Sun, 17 Jan 2021 16:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DilXPRI3TRJmzULgddpAwxGtKs9uc5bXa700Snpt8eg=;
        b=jkazrJTlp36hPiUFrC7+kV3l/6K9OcH+n0l0ToQZJatwEfH45vuOuQHKdbSx5Agt/m
         Zkx4gfKuxm8joxqX1fCVKjv7tfssLoyYjVBzVbctl4sHyY31hy2etFKh5TVmGHunzGVI
         wPoW89LcSShSPDDGOzHRofjldjka5fVLPMgggkwnu1crxdMRmSPz8+dz2F4YrHWV2RrJ
         jCeJtjFJV+hsdcu0GYJJYVIBKfiiKP4ggQ0wjotl4yJ1RhXZEuWz7fmiQlkPh4hkgIwV
         /gD6sxhVwLpG9Sq+P0k6ktUIuGfpb1HLxo129X+uf5ZDsRhPvKjZQKfkTICNf9HtvS0R
         hK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DilXPRI3TRJmzULgddpAwxGtKs9uc5bXa700Snpt8eg=;
        b=YejkF1/uF7f5rPtNmCHgCRruilv7dIfoQP0fODcbnbKZJKfccrV9dvxoCuK2pgx7hD
         /o4AqqTefUQIg27O19FYvBU9jVGO2ku5D6aOmQ4OGgSJatFdkUggOI7Ep+wtq7Z1tXRk
         lVMwTQPQPuFaKOfSsTS6HtCfpo3kotzadMW4KrxN6553/SC83WWqEF+VMTLcAJ+oAfNB
         MeyLg8aE5W4Nfs8T2IecvGIzRD1sP4k1FwUq7nzdKZhRUg86XyUFPdJLByHwH9neewpG
         Jh9mXSoN9T/1FP4pGAyUHD8bsDbjv4TMm4jXbLjFd5qHf0RzyfQ8lhtBuo5y3DKoja2r
         uSDw==
X-Gm-Message-State: AOAM531yrYcu1sFMV1B44rv5e3BMCdEPq9TQywIgIHh+gokh92aci7QK
        qyvHQ4w6YAZ9HVCbsFFzL5Fv2+Wcjps=
X-Google-Smtp-Source: ABdhPJwJPyNTEMevAfSEECE2toaXbJUsIn96iIntXcmUHGkNfR12JhXMpsdGv6/2GG1f0eSXZU1wzA==
X-Received: by 2002:a2e:9497:: with SMTP id c23mr9805613ljh.362.1610931346276;
        Sun, 17 Jan 2021 16:55:46 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:45 -0800 (PST)
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
Subject: [PATCH v3 12/12] opp: Print OPP level in debug message of _opp_add_static_v2()
Date:   Mon, 18 Jan 2021 03:55:24 +0300
Message-Id: <20210118005524.27787-13-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Print OPP level in debug message of _opp_add_static_v2(). This helps to
chase GENPD bugs.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 63b16cdba5ea..758730d070da 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -822,10 +822,11 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (new_opp->clock_latency_ns > opp_table->clock_latency_ns_max)
 		opp_table->clock_latency_ns_max = new_opp->clock_latency_ns;
 
-	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\n",
+	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu level:%u\n",
 		 __func__, new_opp->turbo, new_opp->rate,
 		 new_opp->supplies[0].u_volt, new_opp->supplies[0].u_volt_min,
-		 new_opp->supplies[0].u_volt_max, new_opp->clock_latency_ns);
+		 new_opp->supplies[0].u_volt_max, new_opp->clock_latency_ns,
+		 new_opp->level);
 
 	/*
 	 * Notify the changes in the availability of the operable
-- 
2.29.2

