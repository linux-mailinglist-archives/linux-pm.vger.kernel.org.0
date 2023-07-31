Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9F769401
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGaLAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGaLA2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 07:00:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57107E46
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 04:00:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbdc05a93bso25450985ad.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1690801225; x=1691406025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFu/JPo/heUh8tZtPktgVoKIudqTiKgcM8V0fJH/i9Y=;
        b=1v2MnK+H1CiH/nknYPjsMWMv5uS25LE7m4TpV/2Ws5S7GEdQYHGIsEqWpPchb7KRvX
         10+4CDyk0wy/3YqCGKWbnd2Maf5RaO+3UP9FEpVl+R6zfu9dRAHKHo9yOtrijUsIgRYU
         9okmTNhyQY7bAb2zFXxStJFtbOjlKOmVqY2ocqYrIZ2XIyrqrVLbyFi/1HWM3PmOTgXp
         ASP7TB5msegRAcV01tSNbfm150m14zycgybAWnX+TRTYCJ3ihXjFiafdbISgtom4gn7Z
         e0bVXb6xOBTSNO3A5BF4oWq/h4eW0w4EfMwnPeeI8ZhXUBIjgbZpkw4mgReAMtu5r0/O
         eegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801225; x=1691406025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFu/JPo/heUh8tZtPktgVoKIudqTiKgcM8V0fJH/i9Y=;
        b=YIjcnNxKXfCjFgBmWIXJKCKaqzk4/4f0rnUPlX/hHDbWJZypFexRVmjBECYhzQ+NVz
         K5VvJj1AUKTBEPYfaSIbaH9xzSKljiriFJ37Px3E0WgzkPVGd0wi7BytvClMvZZi97xh
         gJhE3tsCNON9X1gjFWjvMBaYe4xT91b1E1wBx1eQrdx5ugijKn8SkOzs6YR3YiJJyjRJ
         Eet4PJ5jFUy0mOrVbb2NZJsA43BJZyvogxN4nGkqtPicAcv85hu0eW3gX7LZP6Sg8u//
         s1RqJEM6jmwXvsiZltWM7P4QxcGTjxi1RxgU5/vO9PGTI8+9+NSFqkR84qNJ0C/flaNi
         VGQg==
X-Gm-Message-State: ABy/qLZgl5mlpkpGHrYrHuk31AAPDE4pWBYTw9RtI98y8og/el+LDJIF
        SAxW6IxixxBh9g125ahkJBukl6Y1OR1bOAlQCJ3gpg==
X-Google-Smtp-Source: APBJJlENmczCMqYJUL3zBRJdO3rj0ca5qfst6RnY1rZPFxWTnpTOgab05okF6l0KlSJaqmu9Fuk+ew==
X-Received: by 2002:a17:902:d4cb:b0:1b3:f5c7:4e75 with SMTP id o11-20020a170902d4cb00b001b3f5c74e75mr10119622plg.58.1690801224688;
        Mon, 31 Jul 2023 04:00:24 -0700 (PDT)
Received: from localhost.localdomain ([49.205.243.15])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001b1a2c14a4asm8281096plo.38.2023.07.31.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:00:24 -0700 (PDT)
From:   Jagan Teki <jagan@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Jagan Teki <jagan@edgeble.ai>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/14] genpd: rockchip: Add PD_VO entry for rv1126
Date:   Mon, 31 Jul 2023 16:29:59 +0530
Message-Id: <20230731110012.2913742-2-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731110012.2913742-1-jagan@edgeble.ai>
References: <20230731110012.2913742-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PD_VO power-domain entry in RV1126 are connected to
- BIU_VO
- VOP
- RGA
- IEP
- DSIHOST

Add an entry for it.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>

 drivers/genpd/rockchip/pm-domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/genpd/rockchip/pm-domains.c b/drivers/genpd/rockchip/pm-domains.c
index e3de49e671dc..d5d3ecb38283 100644
--- a/drivers/genpd/rockchip/pm-domains.c
+++ b/drivers/genpd/rockchip/pm-domains.c
@@ -976,6 +976,7 @@ static const struct rockchip_domain_info px30_pm_domains[] = {
 static const struct rockchip_domain_info rv1126_pm_domains[] = {
 	[RV1126_PD_VEPU]	= DOMAIN_RV1126("vepu", BIT(2),  BIT(9),  BIT(9), false),
 	[RV1126_PD_VI]		= DOMAIN_RV1126("vi", BIT(4),  BIT(6),  BIT(6),  false),
+	[RV1126_PD_VO]		= DOMAIN_RV1126("vo", BIT(5),  BIT(7),  BIT(7),  false),
 	[RV1126_PD_ISPP]	= DOMAIN_RV1126("ispp", BIT(1), BIT(8), BIT(8),  false),
 	[RV1126_PD_VDPU]	= DOMAIN_RV1126("vdpu", BIT(3), BIT(10), BIT(10), false),
 	[RV1126_PD_NVM]		= DOMAIN_RV1126("nvm", BIT(7), BIT(11), BIT(11),  false),
-- 
2.25.1

