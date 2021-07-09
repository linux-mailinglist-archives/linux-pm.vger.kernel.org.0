Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090893C23CC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhGIM7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 08:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhGIM7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 08:59:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59BC0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 05:56:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u25so7868844ljj.11
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmQouUwnHXSB4OdiUD3dDMTm+uNqG32/fIygOWS1rqk=;
        b=TNKFzaJYG6b/K8hMZsQR7UYuFjKqUsAHnAEfeDxwl7ckEscf2i5Exwp88H0e7TaCgf
         M1afe6FMM0NJYlHmc1SSrDADUNI7CMYsSyXfFNww2GK55OFVtTNVep48yJuhNHe07xSo
         ZoLL+JQ20Yuwct0eB1oNBH1gJ650Z+SNC9hmpVOPQeDzNJLFYbh/WipSsiYTAlPUJbCg
         ZytnNWUbSRGFe69YGizzFEevlVfn8N1Sdwz3y0j6SZMrZoaM6X1ULChOtDXQEFgy2NIL
         ux+oyFxFuDHErBIjFhDiDFzwCyDPMyFNnpZeycoBxp4ToRXu4UyXZDsNymtrnLoihPA3
         ABjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pmQouUwnHXSB4OdiUD3dDMTm+uNqG32/fIygOWS1rqk=;
        b=jnMU029QffsKE43zmwulZs2/WyT051PjsnN27iiksmTn3cpB/2n7xZmDk6/yKatNC/
         HhbJnqTSGpem+cv0Qo8JxTY8Zg4YqgoiVvJvnVieHuxO9Vz0n6+rL29DJdVCnraogWcC
         Ej4UOdp1Yxj8hTpEYIHV+6UXUHdDmblhIOB6e/80JltD2t+a6yfFa0aoqbErApdF6R4v
         z9hizJzQSIA95j3TzaoE493MrZsUQlwJE3RtjWk82fySKCgSDT60JEPznj68zfJsRd1B
         kMiSUA2ppPSjFkJXx9Lq/r8h13AkAacNN5uJLav6JFwDrZRhAeAluF1MXAGMnu9wQo23
         nipQ==
X-Gm-Message-State: AOAM531ca3iejeqaMn3dVBpMF12WAhQWcZsLsTdDUfFoAEgGlhSK0A9Q
        GWkjG99Dew2hiyk+fNC6dmbteQ==
X-Google-Smtp-Source: ABdhPJws6OEf65ZuRSjGD6inMZ75FyrYIUnjQzy1kEHtRfxPsLOsHjSEXRvBaqrzpe/ko9aygtFZRA==
X-Received: by 2002:a05:651c:210:: with SMTP id y16mr14067901ljn.437.1625835380940;
        Fri, 09 Jul 2021 05:56:20 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q5sm462097lfr.37.2021.07.09.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:56:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Don't attach a device to genpd that corresponds to a provider
Date:   Fri,  9 Jul 2021 14:56:11 +0200
Message-Id: <20210709125611.135920-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the common power domain DT bindings, a power domain provider
must have a "#power-domain-cells" property in its OF node. Additionally, if
a provider has a "power-domains" property, it means that it has a parent
domain.

It has turned out that some OF nodes that represents a genpd provider may
also be compatible with a regular platform device. This leads to, during
probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
to the genpd provider's parent domain, which is wrong. Instead the genpd
provider should only assign a parent domain, through
pm_genpd_add_subdomain() or of_genpd_add_subdomain().

Let's fix this problem in genpd by checking for the "#power-domain-cells"
property in the OF node for the struct device that is about to be attached.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

This turned up when I was reviewing a couple of genpd realted Qcom patches [1],
from Dmitry Baryshkov (on cc).

I haven't been able to run much tests, so help with that would be greatly
appreciated. If someone encounter issues, I am happy to help to fix those.

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2021/7/9/7
https://lkml.org/lkml/2021/7/9/8

---
 drivers/base/power/domain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a934c679e6ce..21991fb56a19 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2699,6 +2699,10 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (!dev->of_node)
 		return 0;
 
+	/* Don't try to attach a genpd provider. */
+	if (of_find_property(dev->of_node, "#power-domain-cells", NULL))
+		return NULL;
+
 	/*
 	 * Devices with multiple PM domains must be attached separately, as we
 	 * can only attach one PM domain per device.
@@ -2737,6 +2741,10 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	if (!dev->of_node)
 		return NULL;
 
+	/* Don't try to attach a genpd provider. */
+	if (of_find_property(dev->of_node, "#power-domain-cells", NULL))
+		return NULL;
+
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-- 
2.25.1

