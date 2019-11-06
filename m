Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A4F1705
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfKFN25 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:28:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:28:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so17137651pgr.8
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SZaR5E/HobZwk+pxemYk2DTTfx/38H5VTmSiCwvG6UI=;
        b=Rye+OiPHXXnz8fja5i/j36mcB3yxJE200yCycPPv/3yhaPayJX6hhLERUxiLv6twmY
         bRZnfcm4BeOTxHrM0T1dh3bxydk+eryZkBBgfWPuhK4aG8QNxLF6odpN7Wv1ozcxHS2x
         EM+oMzZPi0TW1kj26d5Iwt0mWXAnHYzU9F9GgDWX6XrGEKxwV/a9nINLctgxZUw829Ce
         5eieb5zsF3ES/aNP6VvbfBpz154Dgd0kNNgpiKwizk8XAsV3wn1HEe7DSpP35Kc42TNG
         oye9OOHONa1HKV27klLS7W3cknlg94qFuKEXx7Mg6rY9yOx4mh6LEsdZEnrGTkQubm+j
         RwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SZaR5E/HobZwk+pxemYk2DTTfx/38H5VTmSiCwvG6UI=;
        b=uJUsdVhtIK4FgiuX4mfjDa60t66d/bg8eVKv8vCTP9yGlm0BKJB4/I5v17HnsL8Zw1
         FlPYTSVFh+KDWtEXcBJX7K/0s4HiLHzhwyIjzfjcamNps+ONnMP/mTh/FXttwcjgjb5b
         JwRGSfDBAr6MmGptUvULtHv1flEFyeFJtK/rLNAvAjp6Kizyd00t1Vl2IaNWOfrGTlcd
         fd1kpAcO+jHhatpsXETIJvWuASbKA4ePUN9tYnR83SKGtPf5svnjCtwuPnqULLOpGNE6
         +qyMox7cCXGucQg/VVGhkz8Xh7/qA1iImBtiw6CJ/b0HA6MFNI3oDHPQ2RXdZ9fb1ov3
         rh/w==
X-Gm-Message-State: APjAAAUPIs11T9VUSIxp+GgEvTyqcn/wA//c60eQw0fKuswMFpsToYTT
        flNpJg2Cuk9ZmBzi3Z4O3DSGyw==
X-Google-Smtp-Source: APXvYqyZFg7LWgQLA0ps9j10NIeUGqb4RJJmvIBaoLP3lH9l+h++FT18GZ1LrFeVUa71Fch4ebAaZg==
X-Received: by 2002:aa7:86c2:: with SMTP id h2mr3321962pfo.248.1573046935453;
        Wed, 06 Nov 2019 05:28:55 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id a33sm23504468pgb.57.2019.11.06.05.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:54 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 05/11] thermal: max77620: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:21 +0530
Message-Id: <09609109359054d2a1f7e0456402ebabad1e315f.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/max77620_thermal.c:48: warning: Function
parameter or member 'temp' not described in 'max77620_thermal_read_temp'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/max77620_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 88fd0fbe0cfac..82d06c7411eb3 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -33,7 +33,7 @@ struct max77620_therm_info {
 /**
  * max77620_thermal_read_temp: Read PMIC die temperatue.
  * @data:	Device specific data.
- * temp:	Temperature in millidegrees Celsius
+ * @temp:	Temperature in millidegrees Celsius
  *
  * The actual temperature of PMIC die is not available from PMIC.
  * PMIC only tells the status if it has crossed or not the threshold level
-- 
2.17.1

