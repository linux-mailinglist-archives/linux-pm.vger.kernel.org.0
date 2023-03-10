Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997DE6B5330
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCJVqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 16:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCJVpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 16:45:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF8138F73
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so26069976edy.8
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euRWHr0UtuqpwGJTkiRQ6fkvgau3vkX9qbw5gY31Oi0=;
        b=TZru0gIOrHG64rX4eEReJHZgP+b/OcPOjctwQKLS8foHVDxU75d0W+Fb9UdQ7e6xis
         NmBTqb+GEcVb9DwSygBWk7KtgdWIf9NLUYhb94lNNioydXarMDs4XBECaTh/4+ACvXwt
         bFeZIniNdYlKHiRIIvDe7Fh3rF4GPJO2/JArqyVqrVpjg2VoNI37TL0CsGwUA4qmfNm+
         xIFdCdMemXq9Lf/H+d6lu9COQ35rHXqDlGxQVVONsOab4tJKwI9M+5RcWOSci66BbPTB
         SUKWp/qpQ0DtHVxRA+DLMD3UyFaSXyw1Ws+a1nlgN7iFK9K80Z+QN/fbKxBuRIOVG9pi
         ubkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euRWHr0UtuqpwGJTkiRQ6fkvgau3vkX9qbw5gY31Oi0=;
        b=ADsWeAOeQioVs5UeVvssXqUHRE46rD2uDf5+wAPgYLTosx4m9ZqmH7kvGE+kaQOfEu
         s4GrGr1eXNOEbkiYPCqraXdI6uGNqPLI4iEmBuFgM3ULjdqd4Ic0362tAQE7fFnr+89Z
         pfancGF9N/P7CTnAeXfNMYiSZVz0o4mOffh2R/LADYZrQTJFy1XrlpuZOjG+j0TTBhb6
         xW+fMIZ2zecxyiScxG6GFS4+vtKL2Kphjpg+GqevLDQVkLyeAPWosKG9+t/rkb8k7jhb
         7DZof1a2xttQRvGBKTRafSKoe61V/ghN/lqD9n2dhxHVj0EqPeVlhpjjq3zCItf6PzC/
         KtKw==
X-Gm-Message-State: AO0yUKVoQpKSXkTuDRCcL5j7FZ7kT9hf/0jdCx1yHqXCgpkTZ5tedSgN
        wsHtv0lgOfm/l60XAy56l5hfAg==
X-Google-Smtp-Source: AK7set+P7KiAdjrVwDphE8ZYgCZ0yPuvhmWOIJk792eAii2Tlil8k2tyFBuqwof/wHJ4HIRrO2KUNQ==
X-Received: by 2002:a17:907:d306:b0:91e:7d56:f051 with SMTP id vg6-20020a170907d30600b0091e7d56f051mr1369413ejc.51.1678484621672;
        Fri, 10 Mar 2023 13:43:41 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:41 -0800 (PST)
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
Subject: [PATCH 3/9] ASoC: samsung: aries_wm8994: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:43:27 +0100
Message-Id: <20230310214333.274903-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  sound/soc/samsung/aries_wm8994.c:523:34: error: ‘samsung_wm8994_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/aries_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 0fbbf3b02c09..9122482a0e5c 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -684,7 +684,7 @@ static int aries_audio_probe(struct platform_device *pdev)
 static struct platform_driver aries_audio_driver = {
 	.driver		= {
 		.name	= "aries-audio-wm8994",
-		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
+		.of_match_table = samsung_wm8994_of_match,
 		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= aries_audio_probe,
-- 
2.34.1

