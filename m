Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D75364849
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhDSQeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 12:34:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbhDSQeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 12:34:12 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqE-00028D-Al
        for linux-pm@vger.kernel.org; Mon, 19 Apr 2021 16:33:42 +0000
Received: by mail-ej1-f70.google.com with SMTP id d11-20020a170906370bb029037c87968c04so3865196ejc.17
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJFDAj6TYp7FZZ9Zf4ZhG/lOPFtwU6nBh8dkTxsEpU8=;
        b=R77ReJEVxS0Khd9I9dxBMqwKmX54jCy/qscvPLidnazR7gBBJTBGZPZJ9C5lGOLYsi
         LZeTN0j/gA1mzhPM8EjCBQNKYJ5GDTBGINtyimRMbiNwcjGf31I1XkHKjDC+BoQ0wvQC
         Y/CXBMDuLmpjj82ttxVwfGe/zsTEn2fwJ5cVHapnHkbRpwHKPtQ83O+xfkk1UOMkHGGR
         3m8GmcLDL7GEE9LLvLxB/5fY23LLDuD7dZ3MMOT8FQUdjGc6AiI1cYVjf3Db0mQx755l
         3vk6H7Xd+g6D7DVSDC0wrxOotRYijTFWCUS0iOIo6Vqe4tJRfF0C1qUopow+rQJbyYS0
         ImBA==
X-Gm-Message-State: AOAM530z1TJkTij6h0Ncb0/R9k6TFxKhsXa317tr2+00FHo8vb8OZffL
        jebnE/DCeLU4/30ofT03Vz9HpOe3hAORZQVAkjzEf3FObWjMsplmLHxZqDUDVVbQDJftgm69f+O
        6WkV4oaqPHuhEij5wGjHXa8Gs9f7nJZMae90o
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr23186445ejy.216.1618850021747;
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUor1TH50RdkNQ0brGoOfZsltUgbORXKk/u2PaE6e5BIAtrg/yKQPZA5J2g9XQ7h+mSE+6NA==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr23186432ejy.216.1618850021640;
        Mon, 19 Apr 2021 09:33:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] power: supply: max17040: handle device_property_read_u8_array() failure
Date:   Mon, 19 Apr 2021 18:33:33 +0200
Message-Id: <20210419163336.64075-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device_property_read_u8_array() call should not fail because it is
preceded with device_property_count_u8() and check for number of
readable u8 values.  However the code is more obvious and easier to read
if the return value of device_property_read_u8_array() is checked.
Otherwise reader needs to investigate whether really there is no risk of
using random stack values of 'rcomp' variable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d956c67d5155..d2053cd0bd13 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -268,11 +268,10 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 	rcomp_len = device_property_count_u8(dev, "maxim,rcomp");
 	chip->rcomp = MAX17040_RCOMP_DEFAULT;
 	if (rcomp_len == data->rcomp_bytes) {
-		device_property_read_u8_array(dev, "maxim,rcomp",
-					      rcomp, rcomp_len);
-		chip->rcomp = rcomp_len == 2 ?
-			rcomp[0] << 8 | rcomp[1] :
-			rcomp[0] << 8;
+		if (!device_property_read_u8_array(dev, "maxim,rcomp",
+						   rcomp, rcomp_len))
+			chip->rcomp = rcomp_len == 2 ? rcomp[0] << 8 | rcomp[1] :
+				      rcomp[0] << 8;
 	} else if (rcomp_len > 0) {
 		dev_err(dev, "maxim,rcomp has incorrect length\n");
 		return -EINVAL;
-- 
2.25.1

