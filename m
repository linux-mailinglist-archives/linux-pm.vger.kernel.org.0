Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61C3570BA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353716AbhDGPpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 11:45:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46253 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhDGPpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 11:45:52 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUAN9-0008QP-A8
        for linux-pm@vger.kernel.org; Wed, 07 Apr 2021 15:45:40 +0000
Received: by mail-wm1-f72.google.com with SMTP id u22so223376wmp.6
        for <linux-pm@vger.kernel.org>; Wed, 07 Apr 2021 08:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rG51SJ9b2j59QDiuKuphq0VcbOFNOs71jH8++a6urQ=;
        b=Ki54Dm4TMHrn165avhqLN/hFz/mO27+kAgbBtSR8W6DaEd/4bqnDv5bIrqMjTwkU/R
         GapF374z+xd56wmMzd1BlCJdNFcR/SUNvU+3vuHkvWWOPqwq81fg2h49dzku/9sIRkhS
         lvLtXaNZuZuzFFJdKRBOizpBC/jmNZhBJ0CaEu2FDizdIugapBVTqP5UFCTNsYkOFpmZ
         ZXdSf15JQOV6CKIFS6mozeZst4BOY/clHKUPDCdhLuZCQkUutGFXsXYxolZLULLZFUb6
         lfnlk/Jz+ZeVNjuMDDToOpUihQITDgYzyNcS2RVJ0ln3XvXARJZwxtMkALZ3UpGJoMVo
         Eb0g==
X-Gm-Message-State: AOAM531jgdx9CRD52E22jnGR45hB927KRkeMJufBIt8MU+V6mR+/DKLz
        BZiKzjawdQiwR9agXQ50FcYrRpkrYVp8oE1mzJrpy0+shuhOtwsSFtbNkk6bf0nveOU+jh4SrS/
        zkm5BeeXSkvmlTRbU3cFvyJwqTwFT4b0dW25H
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr5102168wrc.138.1617810339102;
        Wed, 07 Apr 2021 08:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO3yDp/yMNG0dr/oMAaV1wjrumOV1gXxmp2b3gm7xGo7YMYB/+jov0VlU3GDVXbeWhmTWV8w==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr5102154wrc.138.1617810338946;
        Wed, 07 Apr 2021 08:45:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id c2sm9215943wmr.22.2021.04.07.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:45:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: samsung: exynos5422-dmc: handle clk_set_parent() failure
Date:   Wed,  7 Apr 2021 17:45:35 +0200
Message-Id: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

clk_set_parent() can fail and ignoring such case could lead to invalid
clock setup for given frequency.

Addresses-Coverity: Unchecked return value
Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 56f6e65d40cd..9c8318923ed0 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1293,7 +1293,9 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 
 	dmc->curr_volt = target_volt;
 
-	clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
+	ret = clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
+	if (ret)
+		return ret;
 
 	clk_prepare_enable(dmc->fout_bpll);
 	clk_prepare_enable(dmc->mout_bpll);
-- 
2.25.1

