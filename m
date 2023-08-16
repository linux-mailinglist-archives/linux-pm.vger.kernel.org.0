Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7377EB04
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbjHPUt2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346300AbjHPUt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 16:49:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22881FCE
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 13:49:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so66065595e9.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692218963; x=1692823763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJl2Cum5v1j8M/WdWxJ+2Hg9ZCvN4o0DHv+SL/M5e9A=;
        b=O6WSQYOx4vG3alpUI7OrrntJAaU1eprK0XFrLDLZprIVBQou4d+o1gesHIOvck50cc
         LLYELyQ9wFphneQIJfvxJv+RUFsdzyNz8CqZx5/RhL4Lro6f6IigEMcvs9ONwXigp08K
         TqdGr8CRkjb9QhVSygnhDpQ5vhwBpJK3++Sip8xjB8D0+5SNEooWFXEGJWr17xw8kD8K
         Ie7Wz5e3lHOBuMB+gv/D1/pOT6/HP3YFbb1BIfDp5U+oPbUUUbdkSwhu9Lg2csOIomS2
         zgvnic7ZZSoWXC0LyPTxgrfmvAD4sZ2eFeZZOvTGTq15e1hXaI4jKBVzLliA4Y7Ndn2C
         /kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218963; x=1692823763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJl2Cum5v1j8M/WdWxJ+2Hg9ZCvN4o0DHv+SL/M5e9A=;
        b=OgymQnRxH6pCeITdwEuTo1/9IjTguKhVeZstL6uTUYARvSRPpN43IzlgiCfyIRP6TL
         uRYteg81Do0ZhRogaFgR5ASLjR0pZvW6BYfJv2suXrmZhpcn5K+qBtBMKP5WDeHknVgZ
         l5JRFi7wSXGRQpO2mZorr/CqXoJqbhsv3PdWKjWqX3WPPDCQmMI6KEnNmmUXl9SuJs+O
         xelQX0ekPtqTjSMdzo8vmSxzqpgCiOoKY+e65aE5ykW1yO1+ddRf/unSYaychBKWCd/R
         7UE/q2ZvO7UV7lZeBpRJE+hnJ66NCK0OMo8wb2jjLaFMojI6O4svrUU4+sQ6vezmKvc6
         ObOQ==
X-Gm-Message-State: AOJu0Yzx25cnnlOJx/r0q5iQTvqbFpyRb2fHqL2ojztFmDN/g730Vn6N
        Tc5C7UInP3NG3+t/8BmPdkS3ew==
X-Google-Smtp-Source: AGHT+IEUdC0DgMSeHraqpjQYSbPR8ia8XpHQGI73h9NGhXoy2ygew8Iv2toIFp6k/NP6kCCh8WVZwg==
X-Received: by 2002:adf:ed0c:0:b0:319:8444:939f with SMTP id a12-20020adfed0c000000b003198444939fmr2396203wro.32.1692218963118;
        Wed, 16 Aug 2023 13:49:23 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p14-20020a7bcc8e000000b003fe1cac37d8sm538331wma.11.2023.08.16.13.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 13:49:22 -0700 (PDT)
Message-ID: <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
Date:   Wed, 16 Aug 2023 22:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <107678ff-c3d5-4c3a-ad0e-fa292a125daa@notapiano>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <107678ff-c3d5-4c3a-ad0e-fa292a125daa@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 16/08/2023 21:57, Nícolas F. R. A. Prado wrote:

[ ... ]

> Hi Daniel,
> 
> just a gentle reminder. As you've just applied [1], there are no longer any
> concerns with this series, and it'll provide both working interrupts and
> reliable thermal readings on MT8192.

There are still concerns and questions in the series for patch2 and 3.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

