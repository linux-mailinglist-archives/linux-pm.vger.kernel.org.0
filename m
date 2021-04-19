Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5636484B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhDSQeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 12:34:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhDSQeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 12:34:14 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqF-00028Q-E1
        for linux-pm@vger.kernel.org; Mon, 19 Apr 2021 16:33:43 +0000
Received: by mail-ed1-f70.google.com with SMTP id n18-20020a0564020612b02903853320059eso2472296edv.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snr6bOpKVS1nofF6NBC7+ehvgRwGojW903lwvMJmgjU=;
        b=rcAM3evE75k+ogzrEUdZZBX5boBlLjgqAI0HQlSsRcPkiWHQdCKE7oPVK722KX0slp
         IccZSIqVUaaqejB1Sz7oQ9zuU/XZRvuEAszFcMV9N9KvfHYPI8MUzIse5dQ+HQArjCiR
         q+50oSfkE6nRNEL8sP6evXCUckw5ZEBMj67kqM4fbsdIaz+/MN2sTSozJhWvFlvj3QRl
         LUd97tJF9/dUFDdFuiMIm/XpIHSJwqnTuxS0o4SvXJX6NC/kDkGr9QMK4gZl5cxtZHqt
         Pi+iOZtjns8QierX7H22EJPIpsZ5mv329um/a2bVksir4LD9jcQza+jLxX87IY31aPHm
         1jHQ==
X-Gm-Message-State: AOAM532oLTD292Ul3h5XfMCwuhAwIi61KAuiAesenIZ0iZNbEIWRXapn
        8ToUmItRc0eu4xIvY/j2bPjFKO0dMd8O3x7lINXRT49G88qkcf8vOtbCevD8NLrO8idfoM/kf9D
        KwQBEkehVTl9odxisY7ZdfqYPFuSZvzDL/bKE
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr15217586eds.305.1618850023133;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwxaqu8Nz38y932354Y2gcGKu9I2RvQcNCKssKJOBhk4VKgjSNbYz6iXMUKUCz+kiKZ1IHPQ==
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr15217572eds.305.1618850023015;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] power: supply: max17040: remove unneeded double cast
Date:   Mon, 19 Apr 2021 18:33:34 +0200
Message-Id: <20210419163336.64075-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need for double explicit cast from of_device_get_match_data()
(uintptr_t and then to target enum) because implicit conversion from
uintptr_t to enum is straightforward (uintptr_t is a integer type).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

gcc v9.3.0 W=1 does not complain after removal of cast.
---
 drivers/power/supply/max17040_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d2053cd0bd13..1aab868adabf 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -486,8 +486,7 @@ static int max17040_probe(struct i2c_client *client,
 		ret = max17040_get_of_data(chip);
 		if (ret)
 			return ret;
-		chip_id = (enum chip_id) (uintptr_t)
-			of_device_get_match_data(&client->dev);
+		chip_id = (uintptr_t)of_device_get_match_data(&client->dev);
 	}
 	chip->data = max17040_family[chip_id];
 
-- 
2.25.1

