Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3179AFD0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjIKVFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbjIKLjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 07:39:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7BA12E
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 04:39:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so5561364a12.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432370; x=1695037170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dV5clfovnvmxfWoJFf0sjpcB0l370f7re2S1ptWY3k=;
        b=gjcGtZtfJeuIYBrMoka+HMEqAGi61AK8GZ0Q+7ve3z+4N+2KzckYZkUr7fLtqchcXq
         +BfCJjqVZELY6TaCkVgfBc2I6+X71+djSLfV0p85GOhf5+3FY4W6vRT1DqXkmmIQ7Syb
         DG6Dh0Kj5OexJ12LONNNY5Vn6c8DJLImeESNwfpV3grqpS+5yi+bEQW9+kO/blypMBra
         /si0+WXaka/JRRjtRZj75lPR2s0rucVxr6uNz2qcaG0rgFTppwxIGhJeYDA0TYSUm9hg
         amef01Xl8EY53oRyHNjsvqmuWhb9QkAnR0ifDIZzjy2pNLngbhUodLd7tpklP4JMc6Qi
         5nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432370; x=1695037170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dV5clfovnvmxfWoJFf0sjpcB0l370f7re2S1ptWY3k=;
        b=T1ncgdmpjmX5zQu0byvT2abj0c7haS4xCMe4tkthPvSee4+TGA2ECN/YSEy7XAOf2a
         cav5iDMNxKIAzjGHQfe9FtIfDiXSIGKj+20tAKsgxEYYGxxubXtJG/pchTeGMvhTh3w3
         z6d9Iegu/MoZeywyQzazo6x5Afsd8xKpYZUDggTSFJT0V5qn/DwunjfLKTOKJiOszoOM
         J7FLuMo5lhz62OV4/17BgOZEySsb+FKnKfpLbgWn/7PNgoTWV8HQXhocbLmiRTSyNqsP
         3NZZJOT1y/bXaaofuJRZ5GGHFHA2tmfsyLv9pApn/qo2sGGyhBky4xVWDHq8g2ivqtv6
         fP2g==
X-Gm-Message-State: AOJu0YyQdxyQa6M7z9fYT01wIhlx381MMT0WS1q3j5Kp2tRFpHMnxUHU
        6fO/KDDqI50KP1imqCp477rYOQ==
X-Google-Smtp-Source: AGHT+IGfjOHabCCpFu22I/Ln+ydizv7TNX3FoPbSfKcuPyvjsLJt+HPWHDyz9PVtvK2J6K5QstCFgQ==
X-Received: by 2002:aa7:d40b:0:b0:523:a45f:419a with SMTP id z11-20020aa7d40b000000b00523a45f419amr7454009edq.41.1694432369717;
        Mon, 11 Sep 2023 04:39:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g15-20020a056402180f00b00523b1335618sm4431003edy.97.2023.09.11.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:39:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: (subset) [PATCH v3 4/4] ARM: configs: s5pv210_defconfig: enable IIO required by MAX17040
Date:   Mon, 11 Sep 2023 13:39:22 +0200
Message-Id: <169443234710.34398.14080097652916975038.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731073613.10394-5-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com> <20230731073613.10394-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 31 Jul 2023 10:36:13 +0300, Svyatoslav Ryhel wrote:
> After adding support for passing temperature data from thermal sensor
> to MAX17040 it got dependency on CONFIG_IIO. From all defconfigs
> using MAX17040 only s5pv210_defconfig did not have IIO already enabled
> so let's enable it to avoid regression.
> 
> 

Applied, thanks!

[4/4] ARM: configs: s5pv210_defconfig: enable IIO required by MAX17040
      https://git.kernel.org/krzk/linux/c/dc836afd2be7618d8c849fd93bd3e15513289b70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
