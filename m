Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87C3364848
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbhDSQeM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 12:34:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSQeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 12:34:12 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqC-00027f-VK
        for linux-pm@vger.kernel.org; Mon, 19 Apr 2021 16:33:41 +0000
Received: by mail-ej1-f69.google.com with SMTP id w2-20020a1709062f82b0290378745f26d5so3830385eji.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQxWDozA0tVYdPvSIjWgb2svpfnzLps1lAqPUiFgCgM=;
        b=t3+78P80OGkEpYEiMewTsnqgniY4N11Sp8B6v14KWHYnu5Dy9EBTg81vXaJQi6fD8J
         jjbvYX7DQVn/ySjm6MbZ8/gcbieW99gZg3JqS1MdTatlJ9SO18zOnv8/QaobWdKQ3HN/
         88P4KduKcY+SizFa0x+fRBVonLcRaikoNlp4bPep2dpBHJETvbXoMvSEscZLvNZ15RKL
         reJtbo1CnHrFA4wBpfnYrqViy+Lq/ALdUFZ7UpoyozSY49TvlnW7a7gbY1CtRJvls6cA
         tHNPMLk9FVCqPS0J/jqY6lO8l6F2Um8dMxP67g0PLVxt4Bs1v7GwzBBlCnAxAeZSKdA/
         BSBQ==
X-Gm-Message-State: AOAM531QDKFKCCuWHtg83CKQ2y5d6KhdNlFd7h7yIjXtBSXyaMZ4I7Nf
        0i+pJ1w0wfiV3Mh/VDsuE4coGQeocS8Tm7kUA+7Ek6n+kDLmxHMyozYM2FHJ+8PLhjS/eqtiDNd
        ExepNqu/sxXshbiSkTjl+vtZ/wMX3LWBwEgxV
X-Received: by 2002:a17:906:747:: with SMTP id z7mr23437096ejb.192.1618850020677;
        Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS/LNiUGt0EvGgoYA868p7AY80Rrv/sN3QJhQcSvtrE8Pou1sjnlbZEZD3aRmOBpMQwnAgzg==
X-Received: by 2002:a17:906:747:: with SMTP id z7mr23437085ejb.192.1618850020537;
        Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] power: supply: max14577: remove unneeded variable initialization
Date:   Mon, 19 Apr 2021 18:33:32 +0200
Message-Id: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The local 'current_bits' variable does not have to be initialized
because all cases in following switch() either return or initialize it.

Addresses-Coverity: Unused value
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max14577_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index dcedae18d7be..f244cd902eb9 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -261,7 +261,7 @@ static int max14577_init_constant_voltage(struct max14577_charger *chg,
 static int max14577_init_eoc(struct max14577_charger *chg,
 		unsigned int uamp)
 {
-	unsigned int current_bits = 0xf;
+	unsigned int current_bits;
 	u8 reg_data;
 
 	switch (chg->max14577->dev_type) {
-- 
2.25.1

