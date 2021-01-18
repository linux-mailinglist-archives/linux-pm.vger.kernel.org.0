Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB12F973B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbhARBRD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbhARBOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 20:14:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199AC061757;
        Sun, 17 Jan 2021 17:13:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a12so21699645lfl.6;
        Sun, 17 Jan 2021 17:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Nk5JfeL0rfEw3jluwURnbi6QdI3Mt6nAwBx118nXYk=;
        b=kh/7kFyyjCOO3CyXpnJKndO1EaSea7v8nazjI/DQMt8ty3ZzclxSaJS4K5QkktICF1
         /3pINNugABrlpKbA1b4sSJx6087y7sdA5Q2VZDUmF9+UztAvGSxUIhF7br/55Cdr9PEt
         VB76T3AJY6Qz0HYEFMrhvxvHlVN1WUQthFqU82T+RWv+0o9BlupJOB0u2LVWacMqpwCL
         8tHsz4DmNtQrje83NfD7o8NnhNT3mQVc3KMfpfag3U8dNgI6odJRohMqH5hlewnk1tFz
         EqNDsdf7cGFLPEOgW/+bBx4QwGntFQUF1u8rW7/zWw+cgYJqhWl09RVwjgq8uKaJjFk+
         mqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Nk5JfeL0rfEw3jluwURnbi6QdI3Mt6nAwBx118nXYk=;
        b=J5uoTyImV39Gaoa2sBSBXzW+DMiBIgO6S0PcJrqPr0B2CtoNMZznkOlXK1z9ovTRMZ
         SGmv0/MnbEattnjUyEszsOnIGCUJRiSAbNzMn5n/Nizt99n+iUk5PRR1e4R/NZWXhY0n
         NJJYxfYWVounHfjAixiTYIIL0aiQVa+kNHgW80zvOv4NZJ0u7RTjM79xE9qQuV5FRCHb
         WefTsI/CpLWzUx1LqzKhLG8hGT6N17p/WU6chhyQKkPTCGKXHtHd67zjkDuIC/RcY3mt
         f5YyhxVaFvIfRi8CgGAxeVf5CQA5KOu6aKwq9RFqCmz25nrqVKmT3nA46Npw42ulNSwM
         4aZw==
X-Gm-Message-State: AOAM532Kq0oCjcygyxPac9PZd6ZezKOMXFzoLYIfMu9y8Z7AMGKFPnGO
        og1uSRIZTFFFTEzen7SQMfg=
X-Google-Smtp-Source: ABdhPJzuceZQJcKqnQLyEyMgtZDjrZ9FO0+4pCiiperzyirbIXjXxlB+VKPzmAST9gNLBlQTpyuFBA==
X-Received: by 2002:a05:6512:208c:: with SMTP id t12mr10277449lfr.165.1610932436156;
        Sun, 17 Jan 2021 17:13:56 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id l84sm1710836lfd.75.2021.01.17.17.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 17:13:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/3] PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
Date:   Mon, 18 Jan 2021 04:13:30 +0300
Message-Id: <20210118011330.4145-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118011330.4145-1-digetx@gmail.com>
References: <20210118011330.4145-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver of a power domain provider may not be ready at the time of
of_genpd_add_subdomain() invocation. Make this function to return
-EPROBE_DEFER instead of -ENOENT in order to remove a need from
power domain drivers to handle the error code specially.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2ab77aa516eb..7ef6764ee30f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2462,7 +2462,7 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 out:
 	mutex_unlock(&gpd_list_lock);
 
-	return ret;
+	return ret == -ENOENT ? -EPROBE_DEFER : ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
-- 
2.29.2

