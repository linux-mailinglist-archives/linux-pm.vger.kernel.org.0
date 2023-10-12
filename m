Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434177C7583
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379671AbjJLR7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442086AbjJLR7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:59:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CECDC;
        Thu, 12 Oct 2023 10:59:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a645e54806so195597566b.0;
        Thu, 12 Oct 2023 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133538; x=1697738338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs3+sAOJu0kBwxZ0dser/vItknBWGT6p32J9u+acJCk=;
        b=iaZrBED548IW1oaqTyFiylNlS6rwaa4z3MIZSWBZTELGs75jurHxDiaMqPtYtFatkC
         jKWtL0Z5mkePuA2Vgj9Zh6VbblaNBeriNGZ82HcLwlbHAe1Mn/xbmXu0KNFHh9IItMtW
         m0OwQadbq88HgS4TS16Oi+UbYEbFdL/aGWfNQtvBvGtktLAbgFwNPrfukBVtGqf8QvXi
         Om+YEvEJVJQsmXfbtBo00j/fnFRnPK/fXk3Xh7CbFqDxWtyuBYdT7BXJEnbJh9j3wogU
         R6RDelqlnddhWTcoh3tuUuqT+C1feOjKueUzAeest1aExHbSF/nwh8oymVYie++Oryar
         KScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133538; x=1697738338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs3+sAOJu0kBwxZ0dser/vItknBWGT6p32J9u+acJCk=;
        b=bG/D3MhY8I9z0X0CjA30vzFavwCY5e3R5cI9wsAQ9S0jmOMfeMwuK6xXh4zLaBw44A
         7U6/kjg8Hx1orBr9xme8Rq03+ya3uIIzxSZ+XD0DyE/ClQATlhYpHohnUVxnWypYRet7
         3I9yz9ZX5kXB/an+w0h5jkr6vsb6mjHfB12WjB7ceycR1LckYJpsnmDS3EUIjnriKQ2m
         ybLc2jaRTqgQf3plmFCebUW8lEUTDhDPSi8uyRtrCGboWzuFS2vNcHvJzN55D5UHWSMO
         3XIvzeIUkullUvHWoKzE/NH6FzSxlkQ7BNh0wAYfKMx/VFwVpm8cpxLd8TF5qRH3srQs
         lTKw==
X-Gm-Message-State: AOJu0YxC0226hRWjqt1mjxVd86hLb8HwIvR9bwauTQ5iVDKptawE8Otz
        PH/6g9U4se+NHuqW7ckXxCs=
X-Google-Smtp-Source: AGHT+IF/YU8vd6JUNl+eP3lbnEbdb/071IgSnsQGblva12Ql0JpQaNX94lXgXn3I3hzmtY1egSQFgw==
X-Received: by 2002:a17:907:774c:b0:9b2:7a4e:69fc with SMTP id kx12-20020a170907774c00b009b27a4e69fcmr22373760ejc.19.1697133538582;
        Thu, 12 Oct 2023 10:58:58 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cf7-20020a170906b2c700b009b296ce13a3sm11628560ejb.18.2023.10.12.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:58 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 13/13] thermal: Enforce self-encapsulation
Date:   Thu, 12 Oct 2023 19:58:36 +0200
Message-ID: <20231012175836.3408077-16-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

With the last driver being fixed to not reach into the core anymore,
make sure that no new drivers will be able to do so by generating a
build error when they try to do so.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/thermal_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 91d9d4f63609..9c599658b866 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,7 +15,7 @@
 #include "thermal_netlink.h"
 
 #ifndef THERMAL_CORE_SUBSYS
-#warning This header can only be included by the thermal core code
+#error This header can only be included by the thermal core code
 #endif
 
 /* Default Thermal Governor */
-- 
2.42.0

