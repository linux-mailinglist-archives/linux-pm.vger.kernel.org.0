Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0297AD8D3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjIYNSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjIYNSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 09:18:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D4115
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50435a9f800so8835589e87.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647880; x=1696252680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGGR9pvLY+wooKnYGsA2i71wi2fLynKA1WIbB9823oI=;
        b=JG37IadUaP/C+jwSLs6b4/k1z5rj7KkktkTY6hcQW2pYJ/Ol5dZeIP0PL7ddIXnY8f
         Z1sqsaOeoB76QoCvBl9tJ3zzDW8KPphTbuDyjr2OP1o72CYrs39KIC4wpT6o8ylCxOcP
         icOgHzVtnV4I6oDMnHj5RDnU99Kq0ia066dZKh6m+bBdeUyiNmF+BacxltTXfqzgI1PE
         KOJaXWwSSqQjNKapEw4irqKtPkfUqfNLFDmwtQDJoZL7WaMf36vq7sfnVGzo5avntecu
         mxaGanoE/tEoD4WEx+EhouJlZTo4yvfs+OErgxM7OoNLsWhSTVw+jy3B01PhE9rNmCNT
         Q2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647880; x=1696252680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGGR9pvLY+wooKnYGsA2i71wi2fLynKA1WIbB9823oI=;
        b=nFUffAd2Cn6jdlpIjEhro6Snm3oFREyH7dEDTT+0vmnUMnlfUJ3/EzxOeEpj6SKlGV
         ak0r8Iedlj22TXS2yfkhBP+5M56A5KP8jGZBpBCy7rYk8pIsCIidGUGnoqqCoYwBrrI1
         C/KF4Qgmu1S5ndaYDCwacPbKVOnwPXX+7uzgAwn1ddzDAlbQ0BSV2zYBntWqcZUgr+Qk
         lvkqzRlvCwd+koMFyZnbGCqpp5cxlKLjNL9RnRp2KX2ei21wKe7ROk+SQeYr4DNU6+yB
         ysL8sxHmgieODyrW01zGRfcRgSkaVA7TgDbvNxkCL5mJ9ZJguRvCW3stZ9mEaQgJHKja
         Gcpg==
X-Gm-Message-State: AOJu0YzgkzKV+6h2RTVBGgC9LY9KYc1KpkBpgkkrxXtqnMnnzBwblCNs
        9B7rsmYNQdIdZhBiKrUtNWCQkA==
X-Google-Smtp-Source: AGHT+IFDV/U1+CFvuV0RG+EvBmu3G460XkDr1UWPQuqt8PiHplj52nhcvo2MurwCK5yDWM7XnDcTyQ==
X-Received: by 2002:a19:7711:0:b0:500:78ee:4cd7 with SMTP id s17-20020a197711000000b0050078ee4cd7mr5383774lfc.23.1695647880623;
        Mon, 25 Sep 2023 06:18:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:18:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] OPP: Switch to use dev_pm_domain_set_performance_state()
Date:   Mon, 25 Sep 2023 15:17:11 +0200
Message-Id: <20230925131715.138411-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To support performance scaling for any kinds of PM domains, let's move away
from using the genpd specific API, dev_pm_genpd_set_performance_state(), to
the common dev_pm_domain_set_performance_state().

No intended functional impact at this point.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ca8d1304b508..60dca60ac4af 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1030,7 +1030,7 @@ static int _set_performance_state(struct device *dev, struct device *pd_dev,
 	if (!pd_dev)
 		return 0;
 
-	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
+	ret = dev_pm_domain_set_performance_state(pd_dev, pstate);
 	if (ret) {
 		dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
 			dev_name(pd_dev), pstate, ret);
-- 
2.34.1

