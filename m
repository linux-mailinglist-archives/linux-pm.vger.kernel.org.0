Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F21F58DBFD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiHIQ2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245045AbiHIQ2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 12:28:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309E1F2DB
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 09:28:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e15so17789172lfs.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FskYPTv76833n+1Hq30omnxb9L5MZLnaEUwuBASTaa0=;
        b=n9b8Cvea5EVIT7ZHPBapKzhf/u8xMO3geKItvh4tXL5VfoRjWNI0D2590zpirb8aPY
         T6Qhg9ZxvmhiQZt94wtqCAOdbxAyeYNu720/AI9yUJES8KaGF0Xe2/EltRejIw/bs6CJ
         OWqBJZfbYEOClWPMwzI4Rp8pTeVnZv/F1nDJCJQg9dlD9layQ6Ni+I/DedxKO1fdf7lJ
         L6cEBSbhbSuwxg9TdWGECrJwq5UFvA6tt4ZUoLz4oboMxMfzccOAkHM1CUEI7ZGk3GTk
         UgQOveV1H6a2yLhKI65F7ePdq5dusok+lHZFEWDtmAqxGILLEhWQWprWrBUHBPusdbtz
         vy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FskYPTv76833n+1Hq30omnxb9L5MZLnaEUwuBASTaa0=;
        b=LZYiymi/8pPQLgj+6DZR5NJpVaJWvEYNOSmE4n94zOcAPv5JuhhgQOJEPMIPtPQg8R
         HvyYmZPxuDdQR1p3QvB3h1w+yujHdt8dls0sB19x3nbUrzF630hBFw/0rIxF2gAbw+JA
         w15Xitc2FB8Gv//lbGTSjhgR3wksSgGotI4MuhKCWQY2gJnzfVm12GZNoIHa5BL4N1HM
         zz8FcRV88izihZHon11imGB6kr5l23RmfK9MEdg8tEATr09BHqIQIA06pZiBfHPI6USJ
         HoygeSU8WFZqg8rp1jptNrBNVcz5xHEW9wEh7OihrAX+WAvhfGJ+HcgFZrHKYszQVu4U
         NPxw==
X-Gm-Message-State: ACgBeo1IM1922ROxGGZ9N9bLNY+iOxnIxMjI4InLiQoDhx5LcK7UXZyo
        YVNT2/E0sOrGELvS0J7Rr/CEiQ==
X-Google-Smtp-Source: AA6agR767hSt1vi/jf4SWD0G245jpJ0a3tCpFTASnOz48JrJ7rf8nR0ufvWHqiESt46jw+PhIubt1Q==
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id p36-20020a05651213a400b004793b9ff13cmr7842204lfa.380.1660062483418;
        Tue, 09 Aug 2022 09:28:03 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h7-20020ac24d27000000b0048a8c907fe9sm20999lfk.167.2022.08.09.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:28:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Davis <afd@ti.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 4/5] dt-bindings: Drop Robert Jones
Date:   Tue,  9 Aug 2022 19:27:51 +0300
Message-Id: <20220809162752.10186-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809162752.10186-1-krzysztof.kozlowski@linaro.org>
References: <20220809162752.10186-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Emails to Robert Jones bounce ("550 5.2.1 The email account that you
tried to reach is disabled").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

For maintainers entry see:
https://lore.kernel.org/all/20220808111113.71890-1-krzysztof.kozlowski@linaro.org/
---
 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index 479e7065d4eb..0203b83b8587 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Freescale FXOS8700 Inertial Measurement Unit
 
 maintainers:
-  - Robert Jones <rjones@gateworks.com>
+  - Jonathan Cameron <jic23@kernel.org>
 
 description: |
   Accelerometer and magnetometer combo device with an i2c and SPI interface.
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 5a1e8d21f7a0..5e0fe3ebe1d2 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -19,7 +19,6 @@ description: |
 
 maintainers:
   - Tim Harvey <tharvey@gateworks.com>
-  - Robert Jones <rjones@gateworks.com>
 
 properties:
   $nodename:
-- 
2.34.1

