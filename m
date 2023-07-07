Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A074B28B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGGOFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjGGOFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:05:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F544211D
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:04:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso29520291fa.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738694; x=1691330694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvYXj99u7TbpJIDZNfoYyEKQkjm1mobuKtYLdIv6z2U=;
        b=p/oH5D8hyIf5Dkec8klXho99OyxP80D/QtgL4Gm0vWlJ1aeL+tiNklnjF0R12Qpam6
         TaTTV4uQ/sj91Kzjq8BXg21nsyc6hKiIqGm6o3P5frn4qyATm+KWjfsJMJR0DrVnqmAP
         NVQIJrpUbuvXpoIDVMSAfjkwkSFKRKSYfrCOK23vNq69Psdl9sVmPkheppRFu+dl5ppT
         whl3eeKzEnDRDtzxp4Zqc09WgAJEJBCdDROwDRQfAsVFReiEY0dW6FiGQeZW7X2VWHUr
         +iOL5adYEiav1yk9MrfCcYU0cSUcsFsukv+ucSgLTKnfVjo7wrAZgMTj+hwJNAAO1pmy
         E4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738694; x=1691330694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvYXj99u7TbpJIDZNfoYyEKQkjm1mobuKtYLdIv6z2U=;
        b=A5AubqYfaMD4wlsv7X4SyFKejVd7r2c5NrG2bEyDOojwa+1zpI4VCbxVwTG3C6vwM0
         blTWsx/MSS/gCr57hpekBviBjavu9hpjfUwmqwzFoHMeVCBFD2egrycoUOlhjTiAf0lA
         yLQn6PlbGlsTnuwy1rqNxnzpMvxdW4UqoVU5FLpSQBFTzV6tF62vFDTb4qUQ42Rqhjay
         G32fd4Pr9F2BMfpR/l5DT2TZisE2pkUGvsnDQumRifpH7H8yaWdnJKokunnIE82nc4y7
         VvEO69KjYDYSqqyOUf4C3U0ExghvDNh1u/Zp1tl+bvFS79NhEuejCEVVqE5nmQEHVQNP
         dwLg==
X-Gm-Message-State: ABy/qLYcz3pHSKSf4gccb0Xi0Hn0WlOwi+oARLi6MJA5o+l57kK6cBW/
        1DFxCaD8p6IWS/5AOUziVM9NUg==
X-Google-Smtp-Source: APBJJlFZUteWbKYl1aexP46DguwGv5crahAqnytrmTR0O5/HuzUepW8m9GQt2AqtWhVNZYlKuIDy2A==
X-Received: by 2002:a2e:9e58:0:b0:2b6:e12f:267 with SMTP id g24-20020a2e9e58000000b002b6e12f0267mr3598442ljk.5.1688738694744;
        Fri, 07 Jul 2023 07:04:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 10/18] soc: rockchip: Mover power-domain driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:26 +0200
Message-Id: <20230707140434.723349-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
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

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/rockchip/Makefile                                 | 2 ++
 .../{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c}  | 0
 drivers/soc/rockchip/Makefile                                   | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 286598ce7620..c178421e0cbc 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -6,3 +6,4 @@ obj-y					+= bcm/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
+obj-y					+= rockchip/
diff --git a/drivers/genpd/rockchip/Makefile b/drivers/genpd/rockchip/Makefile
new file mode 100644
index 000000000000..8fb9d88a3492
--- /dev/null
+++ b/drivers/genpd/rockchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ROCKCHIP_PM_DOMAINS)	+= pm-domains.o
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/genpd/rockchip/pm-domains.c
similarity index 100%
rename from drivers/soc/rockchip/pm_domains.c
rename to drivers/genpd/rockchip/pm-domains.c
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 05f31a4e743c..23d414433c8c 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -4,5 +4,4 @@
 #
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
-obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
-- 
2.34.1

