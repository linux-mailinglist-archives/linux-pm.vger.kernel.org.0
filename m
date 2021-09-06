Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB66401AE7
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhIFMGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbhIFMGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 08:06:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00CC061757;
        Mon,  6 Sep 2021 05:05:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h9so13096857ejs.4;
        Mon, 06 Sep 2021 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFqmTVUbeZj2dIyftamndsiUfBvI+zNuJcQH5/mATKY=;
        b=LBS0SXzwvpin1Biq/q0ftlmnWh0zGEE1fKFGvyQ5WAUvd0bQsduKCHapP6nJ0RdFkI
         tddeFbrK/BfJQRfzqfNtF3WmzZrYn+kUn/JnXmaSrFiaymoCqQ7K8SsENIbZlTOrGxed
         kaEcBvqVPkDeXXMFKc7tMTgp/wQeO/ld+7psLUNyz6Ie6mVs4W7RWv+egx02PNcNwFLH
         weICMOQ3O7vj7o0HaVl4DVZ17vI9Jm+oWPLisK5qo0WdFvo5Lpf4eXpim3EdDycCBK8m
         5otJweZJVd2cHqFvpOnGzZQ9CteLZu4NEjmyje/U9X+wiKtOeegScZvOHm/+1VTLsFx2
         2+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFqmTVUbeZj2dIyftamndsiUfBvI+zNuJcQH5/mATKY=;
        b=XJ0RwIb4vOXbB8LFiRFhlLugRm/LgmvEbLrB19qgvxp/yOBkhC4KKGuJ4YaUyzvNco
         8eJLZ1sSRPukzPD6uzxIZR2vqxQjy3UunXvk0whBMe2zQg+VdGy3pTYawpAwzENQdFL4
         UgLyZfRnaEKBo4oyqZSLkTXizGchx8rTvkpX8tcB2HxdBnf8tTt29PrnG+sSwcd6TT2A
         SFloqhpehP49tpz7BLf7l+qUoRsBZDtVCn8nHxgrc515gM1+x1Qpkc6u+ramsxNdsv9X
         Ivnyd2H3WQ5sZO5FG9xoIl11bs0TgdLOgRwbpDe9qJ+BAtwKA14FfRCRJmHrI0vIN/Qa
         se0Q==
X-Gm-Message-State: AOAM530oIUhc2k174uI0BanSzlVt7aaq0L3LUoB4vLVhDm4waWDx29rl
        C4D5krbl6wnJUkf3gBoVKWk=
X-Google-Smtp-Source: ABdhPJzuZrT4cssp2j/I5kbPw5P3C98PF8K3pfsZ+kWdFZCSGpUz5JGgx2sJuCryTTDwMkNg8BCbnA==
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr13120478eje.390.1630929933968;
        Mon, 06 Sep 2021 05:05:33 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b8sm4536954edv.96.2021.09.06.05.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 05:05:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] dt-bindings: thermal: remove redundant comments from rockchip-thermal.yaml
Date:   Mon,  6 Sep 2021 14:04:02 +0200
Message-Id: <20210906120404.10005-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210906120404.10005-1-jbx6244@gmail.com>
References: <20210906120404.10005-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove redundent comments from rockchip-thermal.yaml
Sort compatibles in alphabetical order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/thermal/rockchip-thermal.yaml       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index ee104e451..6ea6c9f7e 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -12,14 +12,14 @@ maintainers:
 properties:
   compatible:
     enum:
-      - rockchip,px30-tsadc # PX30 SoCs
-      - rockchip,rv1108-tsadc # RV1108 SoCs
-      - rockchip,rk3228-tsadc # RK3228 SoCs
-      - rockchip,rk3288-tsadc # RK3288 SoCs
-      - rockchip,rk3328-tsadc # RK3328 SoCs
-      - rockchip,rk3368-tsadc # RK3368 SoCs
-      - rockchip,rk3399-tsadc # RK3399 SoCs
-      - rockchip,rk3568-tsadc # RK3568 SoCs
+      - rockchip,px30-tsadc
+      - rockchip,rk3228-tsadc
+      - rockchip,rk3288-tsadc
+      - rockchip,rk3328-tsadc
+      - rockchip,rk3368-tsadc
+      - rockchip,rk3399-tsadc
+      - rockchip,rk3568-tsadc
+      - rockchip,rv1108-tsadc
 
   reg:
     maxItems: 1
-- 
2.20.1

