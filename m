Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6424ED81
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHWOKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgHWOKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFAC061574;
        Sun, 23 Aug 2020 07:10:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so6748900ljn.2;
        Sun, 23 Aug 2020 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0/iqnz3eh4YT0SPBZ7HT6PtoyWEl2aG7pq1uIcFnsA=;
        b=gtRZ6LA/hPM1PhW0zRukgaHDTK4C/dNipt79Xq3/ybtRrQLAdiLH0ue9FTX7h4RaBC
         u4CsSXry1snsPO2+YhvGNS2grmCQwQdMfIcZu7A5anUZhMM9zWiy18WF8omjylEKyZU9
         hie1oVH1Po6NsEnfnSpV6X9rNMYhRZ0Cb5NW7a99FKLJzpcSkCTjrPUVdxvVkM6kIqol
         n/t10s5TSVcFblc0Z/R8ad+LTB8F+E4AZztV1m2QPyTBv8lACggowAWqFNGvP3zWBgm6
         2eXaUP2dM+w5wnW7u/0zk73L4xQou730tzfxD/uE5oU+I7nCWeOeh+3JVnmzXsEInpq4
         Y81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0/iqnz3eh4YT0SPBZ7HT6PtoyWEl2aG7pq1uIcFnsA=;
        b=mgALyyGQTXk+iE4D52/ivtCAeiXk3/1Lmr06qTb2BWBquZfG94a4qfcrEOlxaBXPRD
         Ly6yVTFWc3hkZnmJMTP8MET0jQb8xxU1WKsSJvx1krgQZbdyDSFLtTZ9Q+OHHw2zm9QE
         WXmWBkAvcrFBH0L6TX0HyqCAlyenr2JPeEwN2xmmM4Crawv5wQKvVnQNatjZmcKVUlqQ
         kRB5nfHZHkmcNlONzkNX0jvsHO1h4M1v6FW4yJAVC50Iz6zYzelbVg8GzxKZEtoIok47
         eB8noL7IchxAeJyZIHd+OFw+5JAyw7tCJY0eVDfzeTKwtOYxp7o1tBN1rO13YRCFCck8
         8zng==
X-Gm-Message-State: AOAM532/yDWEb/4N2yTIqNi1R9Q3C5JN7nZWsoPNikfVNJxXH9bOwzf4
        LWVGqmLr7pmA+JVLfsSxerk=
X-Google-Smtp-Source: ABdhPJxY3oK+0Juf0WVBhBw5hn+u7TUWOfMJRioQYQVCU6RkCxN1CzJAOvaCf1PWYVay117RKB/2SQ==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr673013ljh.64.1598191804186;
        Sun, 23 Aug 2020 07:10:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:10:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for KB930 and Acer A500
Date:   Sun, 23 Aug 2020 17:08:44 +0300
Message-Id: <20200823140846.19299-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823140846.19299-1-digetx@gmail.com>
References: <20200823140846.19299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ENE KB930 hardware is compatible with KB3930.

Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
that is running firmware specifically customized for the needs of the
Acer A500 hardware. This means that firmware interface isn't re-usable
by other non-Acer devices. Some akin models of Acer tablets should be
able to re-use the FW interface of A500 model, like A200 for example.

This patch adds the new compatibles to the binding.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
index 074243c40891..5a1c4a959d9c 100644
--- a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
+++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
@@ -17,8 +17,11 @@ properties:
   compatible:
     items:
       - enum:
+        - acer,a500-iconia-ec # Acer A500 Iconia tablet device
         - dell,wyse-ariel-ec  # Dell Wyse Ariel board (3020)
-      - const: ene,kb3930
+      - enum:
+        - ene,kb3930
+        - ene,kb930
   reg:
     maxItems: 1
 
-- 
2.27.0

