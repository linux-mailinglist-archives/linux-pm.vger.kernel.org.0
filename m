Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095157AD8D2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjIYNSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjIYNSJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 09:18:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB1111
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bff936e10fso90932071fa.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647879; x=1696252679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfkqeVqdpd6l51oQ+egV78dBLzEOf1KilkGCosg+Yiw=;
        b=u41YYv22g50xb8QpjwJtG24W6Fxy/ctgkC7vFmFK+TY2Z8G5K7EPTcPkT3ReJAdA2r
         wyixSiblBxYPY3ZcxH7K0GCYJs+ax/9Z62qiQiLa7Lx3Nl1uQgMShzQx418z4UGN8kiy
         4Y4rEdXh8L2zeXZu+LrPd4Um9X3awI7CxBPa6oPujM+wJ150Mc5cKSPbr8ywIMMjzYfr
         aSuBmPDvoPkGorB/Jj7UzXcdzrwsXtUwCB4n43nfqQ3pzfF8VG/103B23S/3+woqq8yi
         z8sLoWJYNXIlciNsc0VF8QeycK2ZDIHjGwwXEVjKf+PmGP2KegpvTbYf1HCtYylQGPrN
         ctDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647879; x=1696252679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfkqeVqdpd6l51oQ+egV78dBLzEOf1KilkGCosg+Yiw=;
        b=TD1i8PaQfE8HIl8MAPNiVHkxMbHMpjlpsTAOvyE0COuhRdy7KDefxp8mFXp4o1F4jF
         nL9uh42DAsALRvYomghImXtdOcmAVzbcfTZYnD3Qyg4KsveFrY/W/GewA1TZOkphj2X/
         aiK0NZviF8MO8XKIe82CqogbjAzjiicgtZDQF69nZz/8Dnf0bpcTBEkjd6gD5xK+Mrza
         osy1OPeRlPiMzpVuxQsGEGMYbiTG0DqOwNZr483j32L1BHuUdkd2oTV1gWus3TlZJpJY
         qvxNhkExtSEpHlOLRyhX65sxvDnZcWPxuh3hdJKgEWhtKGUWfIDXjAsuO/nmX1kWjjEE
         v/dA==
X-Gm-Message-State: AOJu0YwlndKJpqGEZ7Tz3hdjvZtWa9Wyd71PuqitM0T3x1ZZV4zWmpLT
        5xYU7R45pVchEbzaNN0016VkOQ==
X-Google-Smtp-Source: AGHT+IHUeAveoKV6cgGDL1reWFsIV8ERcTryTKk6fC6YsXc7K93e96d8/uM2zJtwmknQMiaKXRIhQg==
X-Received: by 2002:a05:6512:3d15:b0:502:d973:3206 with SMTP id d21-20020a0565123d1500b00502d9733206mr3663580lfv.6.1695647879531;
        Mon, 25 Sep 2023 06:17:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:17:59 -0700 (PDT)
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
Subject: [PATCH 4/9] OPP: Extend dev_pm_opp_data with a level
Date:   Mon, 25 Sep 2023 15:17:10 +0200
Message-Id: <20230925131715.138411-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's extend the dev_pm_opp_data with a level variable, to allow users to
specify a corresponding level (performance state) for a dynamically added
OPP.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 1 +
 include/linux/pm_opp.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 54b6138e1189..ca8d1304b508 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2035,6 +2035,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 
 	/* populate the opp table */
 	new_opp->rates[0] = data->freq;
+	new_opp->level = data->level;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a8ee93ba41d8..9ad168f4cbf1 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -94,10 +94,12 @@ struct dev_pm_opp_config {
 
 /**
  * struct dev_pm_opp_data - The data to use to initialize an OPP.
+ * @level: The performance level for the OPP.
  * @freq: The clock rate in Hz for the OPP.
  * @u_volt: The voltage in uV for the OPP.
  */
 struct dev_pm_opp_data {
+	unsigned int level;
 	unsigned long freq;
 	unsigned long u_volt;
 };
-- 
2.34.1

