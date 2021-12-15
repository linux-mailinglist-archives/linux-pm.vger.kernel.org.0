Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5629D474F1A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Dec 2021 01:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhLOAYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbhLOAYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 19:24:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E9C06173F
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 16:24:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g19so19206316pfb.8
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 16:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0LCleeVgPddpywZvy/2C5sZ89uWkTFhzpdgxSPbdXrM=;
        b=HEjfe1rlhIw6i6zONf5pZQU8FNQYi16UbnHecWZvWblyoZUgzrIVHawydWjwfa6lYq
         6RzAZOEtNrzSgzQhaGdc1swtb7ujagp11sqcaVXPohGh8icts9uKSeauWZ0yQeplMVeM
         L1SInz8zOjNA2o3INXl5E/UNjgMuNlX/UXX44vbte//9TgYzp1fcvI4JgNf96K4JGT5M
         ohgEljHuUmhyk/NyTKGwtUUwyuFQT6bDBbseOFkTE8Ehv2VOS1wXTNORxUsLbelUTr+C
         HVwLDpsFAoKQfJZtgb1sk3L63oXwQWy1dkaYt8+EclMBWShg+73cBeAvOJZBf1lwocgx
         C3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LCleeVgPddpywZvy/2C5sZ89uWkTFhzpdgxSPbdXrM=;
        b=4U87o1l96hj7AUjISECQF6yKbUJ81GIj3dfHVOA5g76iH8Svg8MhBlAxBy0Dg4+TDq
         4p7QEh97hvrJL+Fpj/1uzHfjNvmrCcTAhjhThzpTOGe+hnj9jskWlDRagehMYYia+fY0
         rBfExGvyd7U/DmGRrHUPb7cOKLvLfQ3D0VVcQwRZo/w/L74TIFkBxEbLEyjwKc4ZGBX8
         AOM78GbN3jbwSNZ0q8fGzOOJtlllBQ3y2L6+A77v6N0PhcOwv8KCanHQLqLCorpTn0j5
         TPU1Hcwdgb/wtMA2gdJdm1qQKmxGr/leknsCmAL+E1ROGxiLrgj0dOKuYLktTf9IGRfD
         ThHA==
X-Gm-Message-State: AOAM5311FqIH8gnNkvSGOUroLOML09aj5G2Zj4gx9VaHbZoQraAZepjR
        449l88EPgEdydEzops1spQlUhQ==
X-Google-Smtp-Source: ABdhPJw38xhONkHEUgu0UdZh5JIDbj6dpkPYRCE8Tpi+Hi6nP6h13WJeypF4F0HXywO7pYijSzth3Q==
X-Received: by 2002:a05:6a00:1a8d:b0:4ad:df18:8be3 with SMTP id e13-20020a056a001a8d00b004addf188be3mr6767500pfv.33.1639527842390;
        Tue, 14 Dec 2021 16:24:02 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a12sm185840pgg.28.2021.12.14.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:24:01 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 3/5] interconnect: icc-rpm: Support child NoC device probe
Date:   Wed, 15 Dec 2021 08:23:22 +0800
Message-Id: <20211215002324.1727-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215002324.1727-1-shawn.guo@linaro.org>
References: <20211215002324.1727-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As shown in downstream DT[1], the System NoC of QCM2290 is modelled
using 4 fab/noc devices: sys_noc + qup_virt + mmnrt_virt + mmrt_virt.
Among those 3 virtual devices, qup is owned by RPM and has no regmap
resource, while mmnrt and mmrt are owned by AP and share the same
regmap as sys_noc.  So it's logical to represent these virtual devices
as child nodes of sys_noc in DT, so that such configuration can be
supported with a couple of changes on qnoc_probe():

- If there are child nodes, populate them.
- If the device descriptor has .regmap_cfg but there is no IOMEM
  resource for the device, use parent's regmap.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/scuba-bus.dtsi

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index d8ea9bb479b1..34125e8f8b60 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -349,8 +349,13 @@ int qnoc_probe(struct platform_device *pdev)
 		void __iomem *mmio;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
+		if (!res) {
+			/* Try parent's regmap */
+			qp->regmap = dev_get_regmap(dev->parent, NULL);
+			if (qp->regmap)
+				goto regmap_done;
 			return -ENODEV;
+		}
 
 		mmio = devm_ioremap_resource(dev, res);
 
@@ -366,6 +371,7 @@ int qnoc_probe(struct platform_device *pdev)
 		}
 	}
 
+regmap_done:
 	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
@@ -417,6 +423,10 @@ int qnoc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qp);
 
+	/* Populate child NoC devices if any */
+	if (of_get_child_count(dev->of_node) > 0)
+		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	return 0;
 err:
 	icc_nodes_remove(provider);
-- 
2.17.1

