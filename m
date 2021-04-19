Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E036484C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbhDSQeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 12:34:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38538 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhDSQeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 12:34:14 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqG-00028i-8g
        for linux-pm@vger.kernel.org; Mon, 19 Apr 2021 16:33:44 +0000
Received: by mail-ej1-f71.google.com with SMTP id o25-20020a1709061d59b029037c94676df5so3865904ejh.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS3kDXJbb+yWpJYeuhePkBZuXsYPhImHPxwdAy9xHJY=;
        b=W7oYkfjek15TcQMziqo3qJ+5IBPl8jh+WGE5OHEWDHTO2W6CgEliLN9G9GDl44OrN9
         MrrCADVAdih/BRtTxH4emZmQQWmmW9/kMYHX6dDcGCr/hJ/xD3kbeBTSIPWJIBGeC/Ha
         EgdO7DJyQfxZfpKVXUDD0TdnVUVla0jcEsYekvft/rCjnOn8dZYInSzbF7d4pewolpTk
         8FTc9Ey0ujlSv3OWUCVOGgknSKPNfzhudkSeNIfyWFpsfRBxPSGYxOaeaBNsrVCWIvKQ
         8tVqrrERjoxoT8BNjpN6MqRENDrSHQu0F9VnWkCHib+w6Gnwx63DT/NqxOPy2TG2/QLd
         6VbQ==
X-Gm-Message-State: AOAM530AiYso4jGf348zNdnUbkIOC7Id8XLHKTK9Oq+LH3P1bOq2o4mC
        PSzr+G49UwiJT2FKNbB1FuX/x9bkSIAQ7Zz2t4gSgq6gnvDwyiUhTY4af2hECGgUey+0gOmNv2M
        vPhxqH0claGHFhl/djmBhdjFFeKsQxw+dTOfF
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr27160882edd.344.1618850024045;
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Nlz3x2uIOlIMFvCXOrt3t1Rrh6I6eJcYBGtc1yfXtuXqnznZudlXWhga/rZMGGak1BMwDg==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr27160869edd.344.1618850023920;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] power: supply: act8945a: correct kerneldoc
Date:   Mon, 19 Apr 2021 18:33:35 +0200
Message-Id: <20210419163336.64075-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove incorrect kerneldoc marker to fix W=1 warning:

  drivers/power/supply/act8945a_charger.c:22: warning:
    This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/act8945a_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 5f3eb6941d05..e9b5f4283772 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -18,7 +18,7 @@
 static const char *act8945a_charger_model = "ACT8945A";
 static const char *act8945a_charger_manufacturer = "Active-semi";
 
-/**
+/*
  * ACT8945A Charger Register Map
  */
 
-- 
2.25.1

