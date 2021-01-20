Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762FC2FDC9E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 23:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbhATWbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbhATW1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 17:27:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E4DC0613D3;
        Wed, 20 Jan 2021 14:27:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j18so4110556wmi.3;
        Wed, 20 Jan 2021 14:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2RhxkAG+uWAbxkgUJeC5MykXJe6T4j02mxuLjKdXRQ=;
        b=REnxKbz0huwqlEYZ3Lht12zcAp9m9NJo0l6vOBvaq7V71JJ0R3Yn28L2OIGtecdU20
         /sMYeF2+mSC1B0LXmYdIpB5TfrdH/2YA9h57Jsto34DV1Hsu1oohiXNfKbJb0zYm2Gty
         cVNcjrpqZgNoBrnYpa6OHifIfFYFkGhk3fmidM3qYevQO9COiwMj7/Hr8WtG8RurPzpc
         NXHZRFbk2LcQ+jFksfDnIlZExIAlG1vUMxxU//YCJdIjMjhhKrG1hU2Vg2dfQbJ/tsj2
         Md/x5R059pUUlkQSSRuRmFZh1y9SODC7836qyMOennaBn6SChqhMiQ2+VCOpJTiZ9ehb
         iZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2RhxkAG+uWAbxkgUJeC5MykXJe6T4j02mxuLjKdXRQ=;
        b=ZHMLj98K1vsvRoZBoMzjinf3Kbu98BlFCgD/UrzxqTNGqXbI/Wl24z6B+XAtyv2gm4
         8lATcJ6jHhzZcLUTk0vATvTHjwpMpHitzJqdw7bPXTxNSnYyNBRjKXtTwHsTZSvD7DH5
         Sx9mKK8pWmG55Vz40F2hFnogRxN5RdCs+peBmI/f4jQ8pn9S9Ds+/kLyStcCxonttIeZ
         oxO2xPIM9y8p1LJt20B8RJu+BP08IT61gCR6lgh0KsuVZzI20TA4w+QmUN8flmKgA3cU
         kOsII0JH+XALZuxFy3Wr5Jg+V92FluCt72nMQ9ssH+9dpJ0qbHnR55I8PlH7wXXb34zd
         805A==
X-Gm-Message-State: AOAM532PjtYSVJrpkzYuX09ZXFunShjsWfsYSXVWqrLi18Y01631ngtL
        WGVKT7keSBg3b3O8ajaXFpxA2BnfGtc=
X-Google-Smtp-Source: ABdhPJxNDBPK2Y2x5COb32K+ebOByafJ2EuEbGc9z2peneZUOPgKhmjjgKYmwumg+YemQnVV4Jq4Vw==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr6146036wmb.99.1611181626987;
        Wed, 20 Jan 2021 14:27:06 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i131sm5663710wmi.25.2021.01.20.14.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:27:06 -0800 (PST)
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
Subject: [PATCH v4 4/4] opp: Make _set_opp_custom() work without regulators
Date:   Thu, 21 Jan 2021 01:26:49 +0300
Message-Id: <20210120222649.28149-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120222649.28149-1-digetx@gmail.com>
References: <20210120222649.28149-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Check whether OPP table has regulators in _set_opp_custom() and set up
dev_pm_set_opp_data accordingly. Now _set_opp_custom() works properly,
i.e. it doesn't crash if OPP table doesn't have assigned regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 08d205a55c07..c38ac1cf62ac 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -829,23 +829,31 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 			   struct dev_pm_opp_supply *new_supply)
 {
 	struct dev_pm_set_opp_data *data;
-	int size;
+	int size, regulator_count;
+
+	if (opp_table->sod_supplies)
+		regulator_count = opp_table->regulator_count;
+	else
+		regulator_count = 0;
 
 	data = opp_table->set_opp_data;
 	data->regulators = opp_table->regulators;
-	data->regulator_count = opp_table->regulator_count;
+	data->regulator_count = regulator_count;
 	data->clk = opp_table->clk;
 	data->dev = dev;
 
 	data->old_opp.rate = old_freq;
-	size = sizeof(*old_supply) * opp_table->regulator_count;
-	if (!old_supply)
-		memset(data->old_opp.supplies, 0, size);
-	else
-		memcpy(data->old_opp.supplies, old_supply, size);
-
 	data->new_opp.rate = freq;
-	memcpy(data->new_opp.supplies, new_supply, size);
+
+	if (regulator_count) {
+		size = sizeof(*old_supply) * opp_table->regulator_count;
+		if (!old_supply)
+			memset(data->old_opp.supplies, 0, size);
+		else
+			memcpy(data->old_opp.supplies, old_supply, size);
+
+		memcpy(data->new_opp.supplies, new_supply, size);
+	}
 
 	return opp_table->set_opp(data);
 }
-- 
2.29.2

