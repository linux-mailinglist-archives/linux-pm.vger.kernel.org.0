Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6296B5AF2
	for <lists+linux-pm@lfdr.de>; Sat, 11 Mar 2023 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCKLRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Mar 2023 06:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCKLQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Mar 2023 06:16:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB325E2A
        for <linux-pm@vger.kernel.org>; Sat, 11 Mar 2023 03:15:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id er25so2603595edb.5
        for <linux-pm@vger.kernel.org>; Sat, 11 Mar 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnVytKXzG/PfqmH1YFo44HqQ/pxS3EVtu4JHHtkscVQ=;
        b=W2cNVSZPzNqiL8DwRdYMZLA+BBMukG08dxRtSpQIT/o1HRRioAgzbrwmQF3xhPJffx
         2pzuB8hgC6WVtEWtdYQDBWU2+IYETM8+EFi6bQGYt06ikJ9VOQVAkW47Pn6enRbMnyOl
         rLnxTVKkxx8KGLdy04O2baaEfqst8StaX31t23qnEDp8lXw9i0C7klcr+I0jwDefULoU
         oe7H/tJ2suaAmTgC0Omu/UOFtrtKo7Z3PFmtY1+w+XveTMlrmxMFQIytf/h5CXYqNN9z
         FJT7o5oudwRMPAP68syb9qv4M/5F39fo9WghtFXmGgNwC0EPnrWq0o4zKG9l1t9ZPzHv
         dDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnVytKXzG/PfqmH1YFo44HqQ/pxS3EVtu4JHHtkscVQ=;
        b=ZOL6CZLe1C0lKx/IvAlT4qod3z5m+gifwS4tLsEJ1HknXs0j0ooGcGy0pCqkwzlVzo
         Kk68h/cZmxpQ0VkLgKYcfov0AVmvh33Cq+za6TYFajvJHQ07Qh0JbirdOsIKUjGIYqhg
         dnmCXPep1q/3WKFltVvWc28bxvFYpc9CgzSumKQjzyvDi9lV5p/clhMkloJTj2dN28OW
         MVnQz51GeqSEkS6XoyH10X/z5vIF006SC1RzL09EOe1ir3k6XBN4cbllnckUlJs56j+4
         fZMU6Nab06leaR9EzJjCHckW6eocU7nnNEQJ3D15+AOXvwa4aNOqnBPDzJ8IkO8GxsSH
         6KVQ==
X-Gm-Message-State: AO0yUKVndqo2wryf2ivnMoKW0K0FyQNcRhQ/skNVHIrLHkfWAvJWSAEP
        eO1d+26MfzOZaa3g5eJmAEJ6Cg==
X-Google-Smtp-Source: AK7set+WPqvhWN6zo0+j5J849Jl6Kh+GwuoGLiZVKuNdzn6qAMbBsp6RrjA412S51YmdGdQm7SUzuA==
X-Received: by 2002:a17:906:dd7:b0:87e:a34b:9e2b with SMTP id p23-20020a1709060dd700b0087ea34b9e2bmr28952527eji.28.1678533338677;
        Sat, 11 Mar 2023 03:15:38 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] power: supply: bq24257_charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:31 +0100
Message-Id: <20230311111532.251604-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/power/supply/bq24257_charger.c:1143:34: error: ‘bq24257_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/bq24257_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 103ddc2b3def..45e4ba30da98 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1140,7 +1140,7 @@ static const struct i2c_device_id bq24257_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
 
-static const struct of_device_id bq24257_of_match[] = {
+static const struct of_device_id bq24257_of_match[] __maybe_unused = {
 	{ .compatible = "ti,bq24250", },
 	{ .compatible = "ti,bq24251", },
 	{ .compatible = "ti,bq24257", },
-- 
2.34.1

