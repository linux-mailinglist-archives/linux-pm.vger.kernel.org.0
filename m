Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1B6E23C7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDNM5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDNM5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E01AAF25;
        Fri, 14 Apr 2023 05:57:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso5109076wmo.0;
        Fri, 14 Apr 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477047; x=1684069047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhi30Q6rsEgaICi18lwEGWgCxy7hCcC5QmVwAwqnB3w=;
        b=gFHAVrMr5QyDTdSy7jXt1PKsFnm78z5XB+Kj5Kajz5W1rZ5p+tRe0XT9QZiE3UliTd
         m+cZ0zh2ZDqWBjqrwsS5Tea6G054FgfER2x0UAvFWzEWYo1JAhEoM5/Vq+B7pHBW54Ub
         JXXhOhjilluwh2q0LH5iQVVZY8yc5sFsw2axD1THyB7lQ+sEyqH4gZdt3wSl+JZvFD2Z
         i3+NoTlQd2imzSMnK+Aw7yhQMWPjMxKfnEF/wG2uQSzI9QJuY8xZtKV3FArb2bfXda2/
         64M6fBWlX+ybSrl16F/70m+qbIKFpHViv2EkrR8kkMZYegEfQiDaMKNtNIywsCwO1b2x
         ohYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477047; x=1684069047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uhi30Q6rsEgaICi18lwEGWgCxy7hCcC5QmVwAwqnB3w=;
        b=MHaM5y7znGKBxub6CobdQhn5gRG0wY6uHe+ggldWTrgrBYjn5mr4glDoZ+XNB9JB7q
         VHm3SxveOkhA9Vvi7N4FI32/tvj7+OJMl3u7UVfiE5Fngk/FzQxli8nG/WDBV56b1pV1
         9XioQte6DlYG+xsRSa8ary4N+WNjwxxCpJJb5d82lycIxaF8UsUPvwF4KHcdSMQhSD6y
         tyh60V3W4Do+X9lIV5tf9+3PSNLJvV5/OBF8XjyarvGQ6Ig/jqmTEof90yuMBG1r1Wzh
         EfjKj+rLe7Jtlsl08kQDtnt/B9TUWdGWDFDLi2QXLtfcM6EEQ4BbnLhpluMqBrSBY7DY
         02ig==
X-Gm-Message-State: AAQBX9fTmEuBKX9VbXsEZ3nenlmniIEC4tQQCntgh5Yndi19y8d8JCCf
        Ga6/O+EWRMr3yufcZuFza0U=
X-Google-Smtp-Source: AKy350aTQaoponEEHe8Mkagx3IV+LVByNgodyyyixEiBKdBvTr44JLiUxm/SSPCLdpPxJH4qJaes7A==
X-Received: by 2002:a7b:c7c8:0:b0:3ed:b094:3c93 with SMTP id z8-20020a7bc7c8000000b003edb0943c93mr4143506wmk.23.1681477047069;
        Fri, 14 Apr 2023 05:57:27 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f149715cb6sm719240wmj.10.2023.04.14.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: thermal: tegra: Document throttle temperature
Date:   Fri, 14 Apr 2023 14:57:12 +0200
Message-Id: <20230414125721.1043589-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Each throttling configuration needs to specify the temperature threshold
at which it should start throttling. Previously this was tied to a given
trip point as a cooling device and used the temperature specified for
that trip point. This doesn't work well because the throttling mechanism
is not a cooling device in the traditional sense.

Instead, allow device trees to specify the throttle temperature in the
throttle configuration directly so that the throttle doesn't need to be
exposed as a cooling device.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 4677ad6645a5..37dac851f486 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -120,6 +120,13 @@ properties:
               # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
               - 3
 
+          temperature:
+            $ref: /schemas/types.yaml#/definitions/int32
+            minimum: -273000
+            maximum: 200000
+            description: The temperature threshold (in millicelsius) that,
+              when crossed, will trigger the configured automatic throttling.
+
           # optional
           # Tegra210 specific and valid only for OCx throttle events
           nvidia,count-threshold:
-- 
2.40.0

