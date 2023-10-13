Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712287C80A9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjJMItD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJMItC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 04:49:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959FD9
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b26a3163acso343180b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186939; x=1697791739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il8qfrUz/VvYSn9zWibaW2EcrYf9IhDD8qWnA/nDM/0=;
        b=zFvuZ+v6bcwUvKVEs+3fLEJhusLNtle5frH1gamu5LxaQSETaab5Aozpa6sGqw9qMT
         SeSmIxsc+ccqs/p+lveeerVxz4jHK1vGW2yXxcbFs9pbV72ge2///v4NJ6etsg5fnS/O
         jBl+qz7wLlkQxgSUN3yJuNZ6VLHqokTsEjBRD4yjJl9h5QP5cDpeYAbzU/sReQzli2p+
         JgeJJvEgzZf/IDiR285Ev88BcpAfwZMlrxsJyplKi+s5EV/8oJzphjTXQe/shl5IGXSE
         B/rmGG4rVYoNPppTbjMidByz4p7KhBOpUe0PJnIbK9cZQ7TYd4Gje1CLVA/dp+s1VAOH
         WADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186939; x=1697791739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il8qfrUz/VvYSn9zWibaW2EcrYf9IhDD8qWnA/nDM/0=;
        b=ALSnX+q8ASubxT4PxvZiZYyJQaaabcxQYueg+7SUIxJGTooUqpVCi4JJWh/veNhYra
         Xn2dQbUhFjA16w2cIQzEQFxOo3i9l9BKk9xrt87oLYF2vHyjcBIMI7mdLP9HWOQYne7c
         7YUveEXMPc9Sr6ranebhfIZzy38g1cNE9gYZ/NYxeziWdZNTRH2D9EBEtKA/2NiAt1MK
         yXzbHLp4ACa/vlfF3LM/mZxBaYi6+3MGgJ6U+CXqU2yUohj6yi2ylxgaWDczTZlN+bkH
         jQGpeRa+hdtGFp/nhU860jUxYb+j5UVA8qoAJBSY2n6ODBpe8L83fFT0Lx1JpsJc4z3o
         b19A==
X-Gm-Message-State: AOJu0YwGrqq//YmPFPEI0eipqm7//d6ImfWV8O9Z3dTwytjUVlOFOAnU
        rBw/aAaePTEQTMfF5QyIXAMtZxA69IDGFlVYNqM=
X-Google-Smtp-Source: AGHT+IFuX8OHWuQqLIHMu+hE/a9qLVdUVDAqw5Eo/AfAH/SMAqPwytZyqJGU2cHfT2sWeC/2xRVuaw==
X-Received: by 2002:a05:6a00:b8f:b0:693:4202:b535 with SMTP id g15-20020a056a000b8f00b006934202b535mr29675823pfj.27.1697186939127;
        Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id g24-20020a62e318000000b00696e8215d28sm13025120pfh.20.2023.10.13.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] OPP: Reorder code in _opp_set_required_opps_genpd()
Date:   Fri, 13 Oct 2023 14:18:39 +0530
Message-Id: <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reorder code in _opp_set_required_opps_genpd() to reduce duplicate code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f42b663a4d8b..3516e79cf743 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1076,7 +1076,18 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 {
 	struct device **genpd_virt_devs =
 		opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
-	int i, ret = 0;
+	int index, target, delta, ret;
+
+	/* Scaling up? Set required OPPs in normal order, else reverse */
+	if (!scaling_down) {
+		index = 0;
+		target = opp_table->required_opp_count;
+		delta = 1;
+	} else {
+		index = opp_table->required_opp_count - 1;
+		target = -1;
+		delta = -1;
+	}
 
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
@@ -1084,24 +1095,17 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
-	/* Scaling up? Set required OPPs in normal order, else reverse */
-	if (!scaling_down) {
-		for (i = 0; i < opp_table->required_opp_count; i++) {
-			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
-			if (ret)
-				break;
-		}
-	} else {
-		for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
-			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
-			if (ret)
-				break;
-		}
+	while (index != target) {
+		ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
+		if (ret)
+			break;
+
+		index += delta;
 	}
 
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
-	return ret;
+	return 0;
 }
 
 /* This is only called for PM domain for now */
-- 
2.31.1.272.g89b43f80a514

