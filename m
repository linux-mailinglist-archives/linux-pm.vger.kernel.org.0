Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62586B533A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 22:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjCJVqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 16:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjCJVpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 16:45:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E64139D1C
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k10so25984803edk.13
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeP716t4cBIYV/Qo8houZ6GjE5tTEcSLUUsmtmHrwME=;
        b=Xx3SrnmgKxS5czxvERbapZo0uZsV01LxxYnZdeXVvqWMaJbIqc6s7RwE0R1PdiZQbQ
         5VvqmpWZBxmGyzQQmiflyogrwY/TNDk5BSD48fwB9vkiEReyJZQLKCSWQyW3GgMcaFvJ
         GX9wIjCjB0UbY2BXuCkpTOkwcynB2cvUqjM8zQknB1+Nyrmgcc8UK/BpY39FN/n32OAj
         lRJdt+Uj/pTnNn7dqxBx/km2qBCwBBtsKSatpPh8iDKCLwgNPmaNSXOLGzWfogNUMry6
         aiKCN+Jk9unAevVTpYExN6ukJmrgIuhQ0/nio8/z1in77IIffGTubp9hE/ZgIiDkKu7G
         QPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeP716t4cBIYV/Qo8houZ6GjE5tTEcSLUUsmtmHrwME=;
        b=aaqs0LU48t8tXtVQGWizprYbwxYQYV3/jgMIfKXwl88pfGeU471VAFqYO/TDcn7JbD
         5vF0qxZBl378hhOjw4Q6rgnsMBH8IA6ZR7x2GUTeeJ/HzCdEq9oIdOs5ZgphdXPBNpYA
         BkwMxsXiTPTmfC3t486PpjN6PUSaFtLlkteLknjtnnPcom6FftAkU6Qlg6cfpwI8/sjR
         uBEbmT18nDNMbrQBWKtdh2vBPbmbQ/hZKALMTK7IKa0VJkwtrlj2SrkRI0Rq8q4UcN06
         aH5HQxJrFnNWxyWwUpH6P+WJ6E2QBzHqiWZ3mKh4qOu+7W2LjEsNJV8pNPdomuUBPMVj
         Vamg==
X-Gm-Message-State: AO0yUKWCJ7Ao9VFpkGzPViuJKKH3h3qPZmn1sa60RqMX9De3NwRquVLp
        qaHOdXfXHHHtVnp93PYJWrh6hA==
X-Google-Smtp-Source: AK7set+FJFc4dSGpVtgH0w1GTDHbF5wg5x4nW3Gcxvq33tKawN+X7rAHAi4mTn8Xl6rlAxUk/Z87aw==
X-Received: by 2002:a05:6402:391:b0:4fa:4b1c:5ea4 with SMTP id o17-20020a056402039100b004fa4b1c5ea4mr244220edv.29.1678484628394;
        Fri, 10 Mar 2023 13:43:48 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] ASoC: codecs: rt1019: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:43:31 +0100
Message-Id: <20230310214333.274903-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/codecs/rt1019.c:549:34: error: ‘rt1019_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1019.c b/sound/soc/codecs/rt1019.c
index 49f527c61a7a..dff2596c81eb 100644
--- a/sound/soc/codecs/rt1019.c
+++ b/sound/soc/codecs/rt1019.c
@@ -546,7 +546,7 @@ static const struct i2c_device_id rt1019_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt1019_i2c_id);
 
-static const struct of_device_id rt1019_of_match[] = {
+static const struct of_device_id rt1019_of_match[] __maybe_unused = {
 	{ .compatible = "realtek,rt1019", },
 	{},
 };
-- 
2.34.1

