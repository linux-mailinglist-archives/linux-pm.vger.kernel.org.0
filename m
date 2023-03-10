Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A16B5336
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCJVq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 16:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjCJVpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 16:45:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAB141635
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so26037343eda.7
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1KmqQZradWQGSeXUs/uKrqZTIEt/A0yqDxE+DkkN5A=;
        b=pAFb423pNZ8Bqtr7gmFx7JY0iqO1BBmFb27jY3CTsWbaAzqpwbWJboaCifJ6G1VmeW
         xC0I0G7nDy/zs2irsrlPVFl3BTQOqaTNgZesVwZ8+AWUBiMiW4rDDGem4g0qyp55M4w8
         ieX7R4tXpOiRyfsVGxZWFz8O4kg+lE8SH03OT8b77Xhfc0W7nLsbo/xzUddeQmi865Ax
         eYY/RpmifwZXRcRacB0c29hkDEYByUFvmCg5jLsvpbT8BeUQM+Ki2nZiCDUkzuf+0bAz
         Bd0HgxkURtuthewHLtEnDnYU2fSSsB/gYoN00LhX5S4Z9sIVwdVk4VLKHFQo3wO656VC
         9KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1KmqQZradWQGSeXUs/uKrqZTIEt/A0yqDxE+DkkN5A=;
        b=3eXcWM3PJE++Up7f9HeLhPIwIpCst0DHqTVCYx7HoJRylSB/mfGhN5JqAwXnn5vtcz
         OMajgKih7TDTvKC3hQM3UHycHokkY+c9qE7S7lEteM1c5g+QTqdO0tc6dTLrDEYiLGma
         ao55eaqvBqEacoxrPgC909VERT34uIMEVc5AII3flxilxFwxWONX0O7M6KKdMmAafHQ1
         dy2Bwe8Rx12GjBHYyNDLTyOdy2JhkPlbWsEau5M6ak5B+8yR0ybZAhNU21qTGV9mcWqn
         L1awSUeDwkr5KIfn3CqJTuBfD984/YZTep7E1GhLFrEdlowFSa60KqbpZUMl04QAmSJJ
         D5WA==
X-Gm-Message-State: AO0yUKXsSxhQXkL9F0rGalhzmgmrHqQoSgbmz3yTKLxHLgmKiOUqwwZq
        JgzuQWVLHb9D8dkMbggZPbO/sQ==
X-Google-Smtp-Source: AK7set+gaHp3hBL7F1oXupuPhXZSIMZ1OAV+9R0OWspcJbUAN3By/iv+tFcINwicQVOcsjzCgSGcMA==
X-Received: by 2002:a17:906:b1c5:b0:878:4a5e:3a56 with SMTP id bv5-20020a170906b1c500b008784a5e3a56mr26605983ejb.15.1678484624747;
        Fri, 10 Mar 2023 13:43:44 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b008dcf89a72d7sm327228ejw.147.2023.03.10.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:43:44 -0800 (PST)
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
Subject: [PATCH 5/9] ASoC: codecs: adau1977-spi: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 22:43:29 +0100
Message-Id: <20230310214333.274903-6-krzysztof.kozlowski@linaro.org>
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

  sound/soc/codecs/adau1977-spi.c:58:34: error: ‘adau1977_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/adau1977-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1977-spi.c b/sound/soc/codecs/adau1977-spi.c
index 8370bec27a9c..207c5c95f35a 100644
--- a/sound/soc/codecs/adau1977-spi.c
+++ b/sound/soc/codecs/adau1977-spi.c
@@ -55,7 +55,7 @@ static const struct spi_device_id adau1977_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1977_spi_ids);
 
-static const struct of_device_id adau1977_spi_of_match[] = {
+static const struct of_device_id adau1977_spi_of_match[] __maybe_unused = {
         { .compatible = "adi,adau1977" },
         { .compatible = "adi,adau1978" },
         { .compatible = "adi,adau1979" },
-- 
2.34.1

