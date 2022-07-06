Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C256817D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGFI3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 04:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGFI2y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 04:28:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBE252BF
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 01:28:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu42so4790161lfb.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ihN/GWHwopsWUaO9HWk8EaPgTlpNZcEuy/mZqtNe84=;
        b=Dp2oWCfU4mUajaGl2MeihNJqSjMKLnAvq2TPK6wllGy/Mc2/9sTV+iKh9o5ZNZo/eh
         iim6VZ3SdR5rx1IwK5HKBOQSaA+30u0UfkiMVNglOofeXGRS3jrY/RCX94YZw0kJJ49o
         ug8urXm8oyEL7gvXbJm0LAYiBdVN+BSguChXG8oq9JIXc6qRwAx+D/W1K7lM4U3Xh37/
         AwD+CbxSlCKineqbvzMz5nNI9vRo1wSJFpUI2sOYfPK/AJlHZrmFdxMxO7RhYSoUjZND
         t2dPPmF7+5J6c33l7+jBhg4thlbr/WxFR1oCwU9Ss+WO0STGbZWSJ2qfyoCbYx7Wbx+l
         wrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ihN/GWHwopsWUaO9HWk8EaPgTlpNZcEuy/mZqtNe84=;
        b=qEoaei7SGDMyYjlN8NQf+91oD2jUnMRtx6FYCdazNrAFqnHM33IUheqSpfVcCzDLRn
         puQm6o3LmFJVONeA+SCJmD8wbKZWEaDGW5Frx59LMzgZN3kFJWibQenWgV3K1rc5sWCa
         SPgVbym+R4HnDDyO+Tq3qQzHFe/4c9a0H8eUm8DDuBMHlpSlpohmynMUYUXrmRsW1bPs
         XaLC3kI0Uh7NGvpoMfvluhTSUuAZa4FQfrwNC26VQ7Z2kKc2Ute04Wpb5g7I/NpcZLHF
         J9cVuSlqrQcLGLSgIVAmWfhnJ9yMbp/+ooHxh71i2+Zkmqb8p6rDtKyPW8+h94yhrzWp
         871w==
X-Gm-Message-State: AJIora/SAH+Nu4NxYNM8NprnsDg6+T1vp7hJJkiocguJwc55GNIE1uVd
        M3ylW1tmhaF0qt3TMGelyxMW5Q==
X-Google-Smtp-Source: AGRyM1sQJL8XOPbwZKb0uQWQWqPFmLqBGaQTcIFbciyzk7oVX91USyZpd3PFUy1WpyFL3rx8OEmIYA==
X-Received: by 2002:a05:6512:baa:b0:481:6f0:ac3f with SMTP id b42-20020a0565120baa00b0048106f0ac3fmr26200176lfv.676.1657096080641;
        Wed, 06 Jul 2022 01:28:00 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v14-20020a056512348e00b00482dceee5f4sm1070377lfr.203.2022.07.06.01.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:27:59 -0700 (PDT)
Message-ID: <e9917b17-49e2-6f0f-201c-8b2064c5efc6@linaro.org>
Date:   Wed, 6 Jul 2022 10:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/15] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
 <20220704161541.943696-2-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704161541.943696-2-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/07/2022 18:15, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'clock' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Hm, you kept Stephen's ack, so why you did not keep my review? Sorry, I
am not going to do the same review second time. Please add changelog to
each patch instead describing what changed, which also will justify why
my review was dropped.

Best regards,
Krzysztof
