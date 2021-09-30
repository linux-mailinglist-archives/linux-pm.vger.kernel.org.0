Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11741D85D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbhI3LHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbhI3LHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:07:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C74C06176C;
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so20784698edt.7;
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBgiYM1YMUTaur/C3QVNo5tGNXLvclq4l1ZtgjUpd4g=;
        b=YBqn7GnDNNqpPZm/pAsrfEWR6oNufq3gED9cMWzTOQCUB+JOr2+U09kMI4xKWxRnz8
         TUE5Nf/xPHO58TzitUkyR1OQFJhhofIcsT9WSupMX4hnXBFc+MkEsZxX7bd2JEBzvx4p
         vYniaazUeh33JUWXas+vd/VGfciosUEiWR+tDQMbx+P55FZKBBL1MKpxyCIDwaCFRK5D
         VOSaLqQ816WFVm3HV6mZ6VaRIJn3dyprPKNJyYtwpY24Q9mwNBoOtPdzzNqMJSRCBXDr
         5P/MD57OedkY+KxKMJdRP2EqZyuybxESuY9B9LhoaBHaY67qB6hNYIlPwNyJgXpqS07L
         de9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBgiYM1YMUTaur/C3QVNo5tGNXLvclq4l1ZtgjUpd4g=;
        b=ONISd4hGauGMqB5v5iOvVKkHBl5isMWc/6ziMIbMuHU7K29BQfxVnLT0ztiKwAon2a
         QEC7lV1ch4Zm7XRqUhDls4doe4eHcJPG/L1Tnf72alstC6u5J6KVSZzxlZHpVl/m+oNq
         uxD86SUK383OgZMZFwkQlrm8vM19JSuxdkdRvlM2VH15BD8oqstFHWMXCj6M71dOrnun
         FDqZKvbakit6PvsZKCj3vU1PY3oXnscZ7PkU5bR0FCroYv7UWUCfHtL65FI914KQiL7o
         2qJkUMM9CR6H/15O0FeV0s81BFqBX9W5+4UqFTmlmaJgd3OPJU3oWjHZyS6/Xsy3k27Q
         oDDQ==
X-Gm-Message-State: AOAM532lrDZfdCbnh2k5NSFjGvNbMxfQPpzToIsj6paWgeJedUCzZbGP
        CdU+3b/xeoFulUc5spL0uxg=
X-Google-Smtp-Source: ABdhPJxQcP1chqO/WvyPc81rUAxaSYZBidr29l5CD+EWy0vjVJQ+473yq6yGDaVGnNZoGeer4Kzi9w==
X-Received: by 2002:a05:6402:1d9c:: with SMTP id dk28mr1144800edb.241.1632999924775;
        Thu, 30 Sep 2021 04:05:24 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i2sm1305158edv.7.2021.09.30.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:05:24 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: thermal: remove redundant comments from rockchip-thermal.yaml
Date:   Thu, 30 Sep 2021 13:05:15 +0200
Message-Id: <20210930110517.14323-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
References: <20210930110517.14323-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove redundent comments from rockchip-thermal.yaml
Sort compatibles in alphabetical order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/rockchip-thermal.yaml       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 3c074706e..f6c1be226 100644
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

