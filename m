Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E051F0E83
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgFGS6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgFGS5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F809C08C5C3;
        Sun,  7 Jun 2020 11:57:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j18so4708642lji.2;
        Sun, 07 Jun 2020 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaLwBgEJHAnRll2My7iiWFVAnwuWkHTJFbXmtwzd9MY=;
        b=DiPzbUO/RDiI5W88efnkYO/TDHc8sDz6irKWYG6cR+jJVJYZU3bu6lqUog0lOOklg9
         I7+Iksqx5pNyNqM7Ny2tzo/Fce9VuXs+LcQ2fzxgHnkJF8Vjl9O89CTu0+7gvJW0jfIw
         EKTf0bNuoxH7s3gR2T6CXJcSnQQHr5JByoImMrATC7Axf+g5Ej3jfb1kBE7RFo4cr7fP
         4k2SX1ncwhwdCrgV+zKuPBikiS/I4Z16tzOMzaRNUEDIMq0WX6VReyY7ko8N9/NqZKYS
         Ls/bQZRLIPaLOKiyx1/9BhAj7FFfw3mrFEYE2rHrwAYlGBmDrTVPSc46kTA9nWP5hdga
         tJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaLwBgEJHAnRll2My7iiWFVAnwuWkHTJFbXmtwzd9MY=;
        b=CRO8MTQJMVJKK8fidzxGpeEeFhn6N7EAWVCf3fg9ESWHsvBwV/Id6M5FWjQkU84BJO
         v2a7Xgs4CrEoGry7NWoWTUsZWwqNCtTx8ORdl2XxVirUGQIN7Zwn6nYIE4JImS7kllor
         465J48o3vsFeKDQLzwni0STloOxf+xn5TaRZESAqZJuww9tuESr5+h7ybnDzZayGflac
         wtVuAXaA43n0Jq6PErOSP+fX1Vp9BXGsizIkesYSm5mkui65V5RBZdcX43xx2XEwjy1a
         OKTLKRl9k4u6Ydr2gBZ9L2w+kA5fYsItpxWqd45it++47Z/vgBJK6Tz+RkR+Mc0I4CRr
         Chcg==
X-Gm-Message-State: AOAM532EUp1y4Je+yYLzIEmvfv7qkeIA6fc6cpTvutHn55YFbLCuTX3n
        yEq/lihpvS6qTotsExE6fU0=
X-Google-Smtp-Source: ABdhPJxAx48J4/BOHbqmc66MSdgPZ+pfZ9D6AgeCtMQ5TzoOzTuCkJgFLzz27dDgT2Zp+G0iqqYJjw==
X-Received: by 2002:a2e:974c:: with SMTP id f12mr7136792ljj.38.1591556265994;
        Sun, 07 Jun 2020 11:57:45 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:45 -0700 (PDT)
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
Subject: [PATCH v3 27/39] interconnect: Relax requirement in of_icc_get_from_provider()
Date:   Sun,  7 Jun 2020 21:55:18 +0300
Message-Id: <20200607185530.18113-28-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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

