Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECC562DC8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiGAIV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiGAIVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:21:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55C71261
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x20so1711475plx.6
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJVM4zFbFbhC4PcmmIcXH43PSItTV2w1+waf0FbvJO8=;
        b=ac3+8dQHtEe1GOgSD/+czOHQobsLexnh9mWvBEggRIwxaSkJBUDtOkg+DdQaX5UU4E
         /gF3RRVm1g4RdX3XjTJQAcgHRHoZT54dk8B20CgpadbZbkeIczX08V0uSVwJZ/2fHpOc
         BrxDO5WkUpbdEm5ZsGV4KXnf8tLMdR9fC5obVM1zvtSDdtsWzQqeuANKELx6Z0FiWqeh
         Xpy4r/vAGHlZOBjNPfjrlhLmEIdrQaRr2fS57CCpFMYLsBczqnDWqCURvTumj1Y6c1Mb
         sac7u8Q5HUOdteP+2VnJmr6qovBq50d5MAhM1sgP+0JN/+NPK4UjkYBMtVaMxEyWS+KA
         FaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJVM4zFbFbhC4PcmmIcXH43PSItTV2w1+waf0FbvJO8=;
        b=N6Cpwu/njjx0/gSx96IX+S0rYdnmHsZaAFmh6RzZ4xQRVCTjij69OF63RJSNe/DkUQ
         6auvj75bN+9fI5QnWDK8iV7JpJ0DTU6ymFQs8NDmw1wamSmpoKBUCEQTzAnvtY1AzmnT
         maI9OLjq4Cp80Dgw9GzPEQ2ygFkLxzkmamnpHjmoXtZ1vM8qwKJn/Zx7+Ow4eeINQ1R1
         OqLjj9QBHa4v4Arviz9wLDwI8wf6vC7HZSSav2U3r3g/7eL/D6HyCwRV9qxa7d/tNlae
         BAFop1mdlOUAcpMLvzXJKxWUHQP819EbYQnIQZkxS5YG61ctjXly/F74qrngwv78owJQ
         dUGA==
X-Gm-Message-State: AJIora9EQAbMBNl1+cbvZKgpItCbzk9YOjxVmwzRnxwTaVaGXn0SbSD4
        nVj0d2cL8penREeQQLP2RyROLQ==
X-Google-Smtp-Source: AGRyM1vu5xQ/FaApTDjk/0jnEWXTkKjAl95QQ8Gbqhs9UyvgMPjWnaNlxNRSi4k/foLg6slD829VNA==
X-Received: by 2002:a17:902:f650:b0:15f:3a10:a020 with SMTP id m16-20020a170902f65000b0015f3a10a020mr18701639plg.61.1656663675180;
        Fri, 01 Jul 2022 01:21:15 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b0051bada81bc7sm14907263pfu.161.2022.07.01.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/30] devfreq: sun8i: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:06 +0530
Message-Id: <cb05495f1f2af5a40767bb67211d69fbaf626298.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/sun8i-a33-mbus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 13d32213139f..0dcc13cae7d7 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -337,6 +337,10 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	unsigned int max_state;
 	const char *err;
 	int i, ret;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "dram" },
+		.clk_count = 1,
+	};
 
 	variant = device_get_match_data(dev);
 	if (!variant)
@@ -404,9 +408,9 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	priv->profile.freq_table	= priv->freq_table;
 	priv->profile.max_state		= max_state;
 
-	ret = devm_pm_opp_set_clkname(dev, "dram");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
-		err = "failed to add OPP table\n";
+		err = "failed to set OPP config\n";
 		goto err_unlock_mbus;
 	}
 
-- 
2.31.1.272.g89b43f80a514

