Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB16B548B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 23:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjCJWgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 17:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjCJWgb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 17:36:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD7312A17A
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 14:35:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so26421797edk.13
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 14:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjRNBwwTPW7bwG9Y1aTb7hINs3HIiC7ZML62hdb82UY=;
        b=wrFNkUjOR/8mBlqWHqFvnPlt0eBSOuSoANyPrBahyHe/j8K3jFCcyLppOitiJAmddy
         jXoRkp3Vh8BYjOHjC4xa9PBL214qCBSje/l5JOtxJnaJPRTEMCnhKDoT9vYW3dHtLSzU
         /ynE0BZ0OVVrDQmD31e2rlJRq9dZWehpfbnG3ryG7t14feqhtsUpPSw3IM9tjM7iQI5E
         DrKpyM1LMaircpbTwBssyRrPQcgJN0J9nURfuXNc3VuKsxZlXXwVhXQad0QpNTxyoYIw
         UwW+bL/NQwZOK9u2oXs+Nf7ILou4ebHfC9MghGdEdwv1p82+zA1aGkrcKOPzxxVc7CSZ
         JUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjRNBwwTPW7bwG9Y1aTb7hINs3HIiC7ZML62hdb82UY=;
        b=l0Z56LRTQafmjUca/CeVHRpZShfcjqzk3PSW/XTUrbczwFU2O/imvQuZxQpQYDFjOW
         XBMBbhgbBrC20sys32fnX3yxGWswRuEHLNEzDSYAiWFWeiAtT3ax5qahsIxCpidByQOz
         5wXtKZPMEsj0rmiZpOoM2xKLyhB7+nwzfK7AMeTtOA00WgL2AYjfe0cWfYokelZjo20r
         NHo2PrISnS+GKD7FzZOfYLwUEMPw0qRlx7iGzWvIVw86ExgTa7mJ8aizcWJTxTKH6WpN
         DnWromWHgKtzS8xHpGhXbJBIKcDLqHXCKfJzEL+jPInLBsZx88jfGCRC1Dbdq+9LwDtQ
         Nn9Q==
X-Gm-Message-State: AO0yUKVDRdp77QStWCybu4KUNsM+3msZ11AvxdL63O5mogJkI7th2I2q
        PMBQS8mLLOIsDuVxKwE3dxMBkw==
X-Google-Smtp-Source: AK7set8KBGk0VRX4+OMl8MnQ6Ri7sbXXfqVhgYiiGmWP3CaaFxwKnzFF2SPMq+7nspOgXMiyLgYXfw==
X-Received: by 2002:a17:907:a0d5:b0:88e:e498:109b with SMTP id hw21-20020a170907a0d500b0088ee498109bmr35691157ejc.5.1678487756766;
        Fri, 10 Mar 2023 14:35:56 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:34:52e3:a77e:cac5? ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090636d200b008d0dbf15b8bsm354390ejc.212.2023.03.10.14.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 14:35:56 -0800 (PST)
Message-ID: <696af359-6734-92ce-4c63-8ba83f477ac4@linaro.org>
Date:   Fri, 10 Mar 2023 23:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
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
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
References: <20230310214333.274903-1-krzysztof.kozlowski@linaro.org>
 <20230310214333.274903-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310214333.274903-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/03/2023 22:43, Krzysztof Kozlowski wrote:
> The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
> on OF thus the driver is OF-only.  It's of_device_id table is built
> unconditionally, thus of_match_ptr() for ID table does not make sense.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/power/reset/qcom-pon.c | 2 +-

This one is a duplicate - I already sent it separate. Please ignore.

Best regards,
Krzysztof

