Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406191F3B9C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgFINPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgFINPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C04C05BD1E;
        Tue,  9 Jun 2020 06:14:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so24953565ljh.13;
        Tue, 09 Jun 2020 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaLwBgEJHAnRll2My7iiWFVAnwuWkHTJFbXmtwzd9MY=;
        b=aC4glVDhDS6ajEjF584IuzsxAMYQt4toyxqZK52jEcvULo8RhpSOxNphdBVi8P4OLv
         DLLzp/QJx/rbgkC6qG1/ST9kv+T/ES4KUlqW2rPtOO0Wph6Hs0Z1qgNv0uIgYfPZyEQI
         llyWxvYfnUXdL6kWcoCuZ/oZ4mbaCS7kAtLPhwpKjUcOfRUx/4ITmOaJcOV6P2sDgKD1
         iU/pzZsNOp5pZLqWuj4uY2KzElystLbeKXihgwOOzUnCcTr5/E5sjMPqhFPjtwPOwYxv
         SylCskYpcyi9T2zgRF0lQBRLmg5udBC3dmOTS4p3B+WxlFyFBszPy/gE4DMm2ero/0pK
         9nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaLwBgEJHAnRll2My7iiWFVAnwuWkHTJFbXmtwzd9MY=;
        b=M3jjeQU+sdjzohaLGHLHgwV0A4cRkZ0SAV0QAAFI9AgfwE7gGhn/nY8QM3RzvB868H
         LDW1nvN2GX8vPNxFTbNOLjvvuAfMuWffqFtmHNLYvIou3KYGmVdarz0jpmR5N2q3IqUL
         z1CJCAbzxbULNRuqXSmq0lpTGRooY7Yl2cTyJR1zThLrkhvg++xWh7EC6wX4HjaZ0B3D
         WHE8lOYj3tme0FGAQpWIjigDSfLTKDV8qY5pVe/LuRd4P45JemojH86O+wMXMVOEGCKa
         FEWh1QCAXoBrbDfpC5+2hgnL5se+jGRTLoP1QEIh8pt5I3tPBbGMIikkjXHIuVUCzRg1
         dRvw==
X-Gm-Message-State: AOAM530jliYBkttLeXl7ZlABUJ5aL4j4fYA1TF7l2xIdinC/4QoPSgjE
        Wvt7JI7KCiTezNYPebAUK4s7o4cy
X-Google-Smtp-Source: ABdhPJwqzjarfix9XEE4prNh4Lc0nEjZ80Nvozu6vayHIphT+WuI7ooDdLSLgKJLy9OUPp/ATKnKnA==
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr13086844ljm.90.1591708498010;
        Tue, 09 Jun 2020 06:14:58 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 27/37] interconnect: Relax requirement in of_icc_get_from_provider()
Date:   Tue,  9 Jun 2020 16:13:54 +0300
Message-Id: <20200609131404.17523-28-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch relaxes the condition in of_icc_get_from_provider() so that it
is no longer required to set #interconnect-cells = <1> in the DT. In case
of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
[digetx@gmail.com: added cells_num checking for of_icc_xlate_onecell()]
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/interconnect/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e5f998744501..cb143421ca67 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -339,7 +339,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
@@ -967,6 +967,15 @@ EXPORT_SYMBOL_GPL(icc_nodes_remove);
  */
 int icc_provider_add(struct icc_provider *provider)
 {
+	struct device_node *np = provider->dev->of_node;
+	u32 cells_num;
+	int err;
+
+	err = of_property_read_u32(np, "#interconnect-cells", &cells_num);
+	if (WARN_ON(err))
+		return err;
+	if (WARN_ON(provider->xlate == of_icc_xlate_onecell && cells_num != 1))
+		return -EINVAL;
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
 	if (WARN_ON(!provider->xlate))
-- 
2.26.0

