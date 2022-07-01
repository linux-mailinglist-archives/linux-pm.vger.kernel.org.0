Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4475562DB3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiGAIUt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGAIUt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:20:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FF70AF9
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:20:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so1789171pfc.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfE4CypbYijTDGyXwa2amCPLxG9OKV5lx3ftdIcweMc=;
        b=gIi+0f/OZ7Q4mL+LlGusDtcoH6RxVYkUMUCHAIMeisFQDkyy7OwTU0tgU81l1n1jj9
         VgVY28MjNCBU1LyjLYHj9GagCLrnjG5N/sc79X3W3bTpO7pLLExU7sVOqRQrqZjcIyOg
         7eQ5EteEuM3RjKe0oHieqwn03wPtDW7ZwjPynIDdbCM5zNrYaz8NFaHnhUh+9E5xGzah
         XyqNTVPh/YO1Z04Yjh23qbs2G7GuW6bd3eKvuE7dNztaoh/T0C/1ZTOCGjZf4nIxpkDT
         vEv4yi3dp9QdzuH8Lk3+wdB+fm4fXfEBI7mwyYla5r3TapH8hoFqFfre/KQWRkUF2to/
         OaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfE4CypbYijTDGyXwa2amCPLxG9OKV5lx3ftdIcweMc=;
        b=6vBbYxQe4WubHBFItg3cZtGfGjbi/Ge4OJN0lTIaowhrh24RYFE5kH51IAjMED5M8F
         3D2w3qDTad2djiyxo/wznCB+2L39885KWXtwB6deMI/2j8/pc4oKbvd+A/T6d9gX/7I2
         NemUD5RFISjSZWjQJoxrpQmHGKcji/atwEMjDJTIy9iZBLEZvnVIXOUZIPv/HhqqAjT6
         0+du2pmNZtJpBCXqQ/UXYjavhGXyjb+VFiD98TRd9bgirA27olVd2COYz6O8z+aqzwXN
         FtFaLNviT/wVFBSuNa7+L2vd5kDG7bHG8higgsqx2g7Ek/AE7cbUTZ7g9r4+i/LGpnJu
         /OKw==
X-Gm-Message-State: AJIora9NPGCG8+Gd7O4nogh3MGcd5ZsaAIbNKtkPnnQStrzSyNs0SE8F
        MnrdWr+J2RyW0Mo9ekMXc1lPzgC2ooLOHQ==
X-Google-Smtp-Source: AGRyM1swGiO0ewfIye+zPiLRXSr7kFVxOMCJ3AM/MC5SFIE8HwCt/zs/q/NtUvv6NTDnFE0TocWqvQ==
X-Received: by 2002:a63:560b:0:b0:411:3ecb:ae86 with SMTP id k11-20020a63560b000000b004113ecbae86mr11575208pgb.434.1656663647226;
        Fri, 01 Jul 2022 01:20:47 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903405100b0016a25ba1f46sm14629217pla.256.2022.07.01.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:20:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/30] OPP: Track if clock name is configured by platform
Date:   Fri,  1 Jul 2022 13:49:56 +0530
Message-Id: <0a43452bb6b1f499b695b123e9fedf4b1a9bbf64.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Track if the clock name is configured by the platform or not. This is a
preparatory change and will be used by later commits. This also makes
the behavior of the clkname API similar to other ones, which allow
repeated calls to the same API for each CPU.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 7 +++++++
 drivers/opp/opp.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b2715950e76d..e166bfe5fc90 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2277,6 +2277,10 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	/* Another CPU that shares the OPP table has set the clkname ? */
+	if (opp_table->clk_configured)
+		return opp_table;
+
 	/* clk shouldn't be initialized at this point */
 	if (WARN_ON(opp_table->clk)) {
 		ret = -EBUSY;
@@ -2291,6 +2295,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	opp_table->clk_configured = true;
+
 	return opp_table;
 
 err:
@@ -2311,6 +2317,7 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 
 	clk_put(opp_table->clk);
 	opp_table->clk = ERR_PTR(-EINVAL);
+	opp_table->clk_configured = false;
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..9e1cfcb0ea98 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -149,6 +149,7 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
@@ -200,6 +201,7 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	bool clk_configured;
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
-- 
2.31.1.272.g89b43f80a514

