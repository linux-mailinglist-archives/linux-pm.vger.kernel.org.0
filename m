Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73D36484F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhDSQeS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 12:34:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhDSQeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 12:34:16 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqH-00029H-GN
        for linux-pm@vger.kernel.org; Mon, 19 Apr 2021 16:33:45 +0000
Received: by mail-ej1-f71.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso3847497eja.19
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tffa8FxLRD95q68BP7WAuHuH/QuQK9CLj68muj3l3Us=;
        b=B4vyaMo/ht8MjBocEBJGIGEoGfRKwN2arJuFuqKezZK8loDauGwbiG3TH5S8aslJTe
         VZ9dV063mdWPhwhvOLjr5rUcJ3mgEGa/Fh2ot4lnqrTEqrxMgwj1mSzlsPc1BmWTVSwf
         qzAqJ8bdyIZJ14xotkp+B/az7MG7jqz0OcGdr9fI0qhBce/S9N51eeWa3QqJ6dKTDPM8
         3CALqnHGjImOmmYj2pOyTUyahtsJMTGrxeXpl9TR5XKFmvURTET/Nji+ciRmNkvpZ2oa
         4RByMUJ0QfjRqIL6CP+ArpgUDUtfz7Lgjp5J9IOk4v9HuYYnVMOotwrwIBqJNGJ4bBtg
         xwMQ==
X-Gm-Message-State: AOAM53012AUErcPVRvLaoupesqDe8tbcVdB0aWCia1R4J+s+ZHgUJjU4
        DlOErEeg6BbG0Zt5GzaJ+NauuaRhFFkesiBN/vYibrC57NbBMGg6DC/USzluulkVElHH+xlaBSK
        xBgsKX9s/El6B/YwKuLAVF8sB2RyeQTDJrcMZ
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr22280296ejx.264.1618850025028;
        Mon, 19 Apr 2021 09:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIPWR8ANiEgnuHcBPUQLALdaXMV0Sh7rj34LKbSDdNWxalGwJMT5vUSg1W9Vn8ufz87Al0uQ==
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr22280287ejx.264.1618850024906;
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] power: supply: bq256xx: add kerneldoc for structure members
Date:   Mon, 19 Apr 2021 18:33:36 +0200
Message-Id: <20210419163336.64075-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document members of structure to fix W=1 warnings like:

  drivers/power/supply/bq256xx_charger.c:240: warning:
    Function parameter or member 'charger' not described in 'bq256xx_device'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/bq256xx_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 2ab5ba4af92b..f501ecd49202 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -202,6 +202,8 @@ enum bq256xx_id {
  * @client: i2c client structure
  * @regmap: register map structure
  * @dev: device structure
+ * @charger: power supply registered for the charger
+ * @battery: power supply registered for the battery
  * @lock: mutex lock structure
  *
  * @usb2_phy: usb_phy identifier
-- 
2.25.1

