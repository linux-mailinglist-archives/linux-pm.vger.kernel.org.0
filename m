Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C614189B9
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEIM04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 08:26:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35999 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIM04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 08:26:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so1094050plr.3
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c02pZ3BCbGVMDzCadj3qTa03L2qacf4T10fVMWu3XUE=;
        b=YPhMHKNxEPDNw1vDdp4Mbh9zIpMVdEhn0M53Hq/NY5pp3frBuRpJI9J5KRHHh9D+TH
         U+jt1gWJEgKOep9eanQluguijkRECoK8eSEIB0AD6yT3aFg+3XR9kLcGE9cR6XFfC5sU
         e4cQxgrIpvg+ebn5yHNnbv74jJ994NeZdX4g3vq+dMfyIfOg9jARN0QoB0Wbb2KH1M0q
         CXzZotLxwXfVhoi4P+MN0azYOjlDPSUQq5zkPRi0at9oK+XsOPtA1mbTQUo1S2uqLM8V
         DBShkr7JvhSUtKuFQGGSbTseDniNo5IR8Efg2M/DKlYiMc1R7QY580j7jFVZCV6ICRQe
         H95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c02pZ3BCbGVMDzCadj3qTa03L2qacf4T10fVMWu3XUE=;
        b=SSTF3w52hij1HFMPWelqe5k4/dnla8qeiJ07LOve1sfMjQFjXRpqApQ5tYh5SIEGay
         vwVOdP16NqSNJaSeZFb55ztdlE7KCR/3TIUYYRjPe5v8cIPaN6a+pitOHvD3K08IHN+C
         hwoVZV+gQik4UpvtsQDhoqqKlMalW5mgiXORo31+aD0v6OxWApBZbp8BMNSdi9J9mHrx
         AoRTdBM7heqFjL6FzGuD/1qvAIIqA1l9pZeZv5KT/JVyUxQf5slsSzSsVI1PENtveYFX
         9RuxUoeSLepWXT7F5yQlC5YfcCJQUxYHKPwHY5YDwvfywU1JRL8W3wh9QMedVdN7ZEfM
         yHTQ==
X-Gm-Message-State: APjAAAVoRZzBRMEB6ROE3dvyM3CrIQqqd7j4VD/L5gwyvzBH710ENp8g
        gDnlWECeUbBxo7dn1aTui9Tp3+Prblw=
X-Google-Smtp-Source: APXvYqxoUhBHCAyX7vxhC+MAxymZVP229mWk57mPJoAJicq8suKjib2M1NiRMGEx4RA+7+lC1GosuQ==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr4531005plt.149.1557404815114;
        Thu, 09 May 2019 05:26:55 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id u5sm3194775pfb.60.2019.05.09.05.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:26:53 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] power: supply: ucs1002: Fix checking return value of devm_regulator_register
Date:   Thu,  9 May 2019 20:26:36 +0800
Message-Id: <20190509122636.21885-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current code checks wrong return value, it should check rdev rather than
info->charger. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/power/supply/ucs1002_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index d66b4eff9b7a..33409b13232a 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -592,7 +592,7 @@ static int ucs1002_probe(struct i2c_client *client,
 
 	rdev = devm_regulator_register(dev, info->regulator_descriptor,
 				       &regulator_config);
-	ret = PTR_ERR_OR_ZERO(info->charger);
+	ret = PTR_ERR_OR_ZERO(rdev);
 	if (ret) {
 		dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
 		return ret;
-- 
2.20.1

