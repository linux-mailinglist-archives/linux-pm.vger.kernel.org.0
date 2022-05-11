Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD5523657
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiEKO50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 May 2022 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245267AbiEKO5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 10:57:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890A6A42C
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o22so2055642ljp.8
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=dki0vUPuO6N2MH4IL3ZTgEaxHGtGP6p6K0m8Q72dfkfKBbFT0OwqRrUiuBrl3lXLgZ
         JFjAobUlKptUEqnzST5BCRTsTA/rZijsUSqp69imeyxWu9csCASx04zP2ecPcCxgtG29
         SEmcuQQFzv+jHpS16Oml5yWyakl16G2yDbL598oH0xaLD25bYYNYmY35usC091wBaR97
         d5YeKaCQ7WmbxTgul/MLdJgLW9GdTi2tlX77R14DOyZ7VpC+5Y0IiIgtn5XFhIrNNUS6
         fdD2XyMqPjitot5O893/T4TZDMsiuEanmcy0qR0CybUhE0Bs2o3a9vnlxr12ytHgUslf
         DDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=UtbC5WTQnF2cHj/hkta1105zdZ53Pc9z9Pui7sb3pGcMDe4dOWRpNFFw2okdm0YrEI
         W2BtaXg2WDy9Y3yqV1k7vza6wmtq45M3rVNdBsvathIMZ9NKbAxEyjc2ypD/zPFMCTha
         sx9VTt8YyfyIAepuICXO7P2vKos/DrUm0Rj55LAnGP0n6NcXiamQNAhEX1ZsheZQC5F1
         lF2dVLNYNkfIfXJv2fmTgxFaUiUu3g2fzpajCv44zIe7JQYmXkSjX4ueFv1VB9ZAX91V
         yArrYFTIO+NBJ5eqFxJpqSr0Gv7+96+/BeCmiKDUIb2OerhFdSoHJAsBcWa6k2pWSTRx
         klgw==
X-Gm-Message-State: AOAM53258qWjdc55kAT01rH1gHqUh+7wg9NQpqg7l62emLdl+6+ZQ/mq
        FvCl2dHbNi6Y9IowuXASejNNSQ==
X-Google-Smtp-Source: ABdhPJxN7/QyIiPpFUbdwfUHavikSQxiBF96wJKrFR+5weGOmkPZiZowCNcAmTYK4Y2f75InPhl2lQ==
X-Received: by 2002:a05:651c:b90:b0:250:7fa3:b234 with SMTP id bg16-20020a05651c0b9000b002507fa3b234mr17825253ljb.188.1652281039986;
        Wed, 11 May 2022 07:57:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
Date:   Wed, 11 May 2022 16:56:51 +0200
Message-Id: <20220511145704.698189-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rather than relying on the genpd provider to set the corresponding flag,
GENPD_FLAG_RPM_ALWAYS_ON, when the always-on governor is being used, let's
add it in pm_genpd_init(). In this way, it starts to benefits all genpd
providers immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 18cd7965e5d6..262bda9b56ef 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2016,6 +2016,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/* The always-on governor works better with the corresponding flag. */
+	if (gov == &pm_domain_always_on_gov)
+		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+
 	/* Always-on domains must be powered on at initialization. */
 	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
 			!genpd_status_on(genpd))
-- 
2.25.1

