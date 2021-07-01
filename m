Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA63B992F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhGAXbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhGAXbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB26C0613E4;
        Thu,  1 Jul 2021 16:28:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a15so14804745lfr.6;
        Thu, 01 Jul 2021 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MImUidm1gDekFfDfoWTVcFhn/N8F2Rqq9dMc3ipEl8=;
        b=chyc1ShOo454Rdk0BIabkeO4dsmyA1uVDbqeeJG1RI40lA11s9nTQHnc80N4v8QoYG
         NDbkYKETGm+tDmjELJu7qhUCaClm4qOkWn+sVUu29AEZRazYYmVzLpvZOZzapvDovwrF
         yB5NjfW7YOOwN3tA674lTRHOgoL9Bh1SRTo9HrDEcSI4sDeJZ37KtTFHnPW2XbolyACH
         Vaz/Gs6YN3FFnhFSXxYoo6O2QXfu3ggLZbpSCDO7tB91kiO3Q1hYLAraaF3CHZLp/Dzh
         vJTJw91AlyNhyReCD+/UF2cCNt9NSLzJQsxmFY3ZDa5z6Whn+BECHdxSpv8m2F8FUAWC
         FmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MImUidm1gDekFfDfoWTVcFhn/N8F2Rqq9dMc3ipEl8=;
        b=VMhR9bj+dOFSBgfNG7udFV910t1CKjgvyjSnC/aEHoV4z0aJxWy6y0dXcH4DZDTM8B
         5fa7lVI0gkSq5UTuJRA/qHRigpQQ29hoUgRyOlA37RjSv/KamL8WkfKm+m8S4rXasD8S
         +Si4c4qSgTaxfHXJip8Fa0u+/4Qgzm58pKmCSev272RaO1es4vpI6Y4u7K+hMOMvYRnR
         ETcRd2hamIPHEQZTwxWKnepiyTPM7PUoEr2gdDmjC65qVEQ+DY4ERgIeSQlyydFUnLcd
         jwa2z+QYx7rYnqkSpvcbD0lapIlUbmSyLZYMAj36UrmogxA2TNHfMI+/0rvEJODi7ijs
         qSXw==
X-Gm-Message-State: AOAM530tG/DrDMBaMuIWPP5j2m1JmoyVECIjrUGBTzh1ckWjTJwghq6G
        makneuRW6LrfEw6cwinxiws=
X-Google-Smtp-Source: ABdhPJzbVdICdIgwhYFT642OtXnYQqajx9dryhBakJCzskRpLR2YBvng2rrZn4iMQL/QJaoiaNY+YQ==
X-Received: by 2002:ac2:58d8:: with SMTP id u24mr1563434lfo.460.1625182128547;
        Thu, 01 Jul 2021 16:28:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 31/37] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Fri,  2 Jul 2021 02:27:22 +0300
Message-Id: <20210701232728.23591-32-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new OPP table and power domain properties of the video decoder
hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/media/nvidia,tegra-vde.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
index 3b6c1f031e04..0b7d4d815707 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
@@ -68,6 +68,16 @@ properties:
     description:
       Phandle of the SRAM MMIO node.
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property,
+      which is a bitfield indicating SoC speedo or process ID mask.
+
+  power-domains:
+    maxItems: 1
+    description:
+      Phandle to the SoC core power domain.
+
 required:
   - compatible
   - reg
@@ -104,4 +114,6 @@ examples:
       reset-names = "vde", "mc";
       resets = <&rst 61>, <&mem 13>;
       iommus = <&mem 15>;
+      operating-points-v2 = <&dvfs_opp_table>;
+      power-domains = <&domain>;
     };
-- 
2.30.2

