Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06470751CA9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjGMJGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjGMJFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 05:05:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729A30FB
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:04:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31297125334so257010f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689239078; x=1691831078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU5KDiUEXkqyxb1dz2x3HHUapbhudnVUKqik8C6tDVE=;
        b=dBd1WsIUF22756YKeYlcfQiSg5UUZ2nn+zJ4H3l3KTqOJl7Sr01C28kmD2ZhSs1dGh
         boEnVOOrZ728+wluWVHunLyVWEdfGyUzceI+ObwQrPKv+a0Jc+r+7MUe/htY9+ovc3+X
         awlZkv51RfM9NJWEiPe5iZl4RydZWvoWOeciRVJEuUz+XYROd5E//KRl9sI4mZrgrx53
         KubgJEYQ7IghTzGezX406O7ROHs8ZK5L6/NZEIEavLb05mDLfDFYSr6EeFed8q0m+odF
         qibIRMfQanAGk6O+UbXNX8EVkREtFxRfwSeRBw9iluB5wshx/YneefAfpiY8YXQt7G6M
         KVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239078; x=1691831078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU5KDiUEXkqyxb1dz2x3HHUapbhudnVUKqik8C6tDVE=;
        b=covXZPip7C1pbk7dug6Vn+YYyNIqgmNvMgTKluFuIC29GPUy2if+gJdFewASotKJRX
         iG5ifGxGrDIwnGjXd14nHPU5zNJc5rCKnfPES4JdTkgiOZNrHO0c5eJjsw/9vXH4ntJX
         LAyoyxVe5tzNGcaUo2Yn+/07WIiNzcT+AXeG9HIEy2eJW00WCheFhXkv2iXjyiZkqzHq
         uun7vLObxy2oGJsl9ZQxgBph289JxdAfgwKkKEIUjdopwKYy15X3CYooeuHCXusWUxxy
         5MIYjeS0ce8y9U0HFEXFoxez/Rm044qXQqjQP96zrMGbuv25EpPmkP8AXcRFcQp2RA5Z
         +dtQ==
X-Gm-Message-State: ABy/qLagvFizhSzUmUq2R4SsST2ECPm6EQLUvTTQxV5Ez1YRUsZ1HA9a
        AS+8YEVcy1HGPFedImp7phIj9A==
X-Google-Smtp-Source: APBJJlHa7eA3YGzLEKLvvgvkWg8/+bqmncsrH8kSNAoE1KnD5WGcimF+bQJ6Yl3CogySwfzwhjQmbQ==
X-Received: by 2002:adf:d0c3:0:b0:314:323b:9d3b with SMTP id z3-20020adfd0c3000000b00314323b9d3bmr3684448wrh.32.1689239077829;
        Thu, 13 Jul 2023 02:04:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q14-20020a1cf30e000000b003fbb25da65bsm7235763wmq.30.2023.07.13.02.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:04:37 -0700 (PDT)
Message-ID: <58acd4bd-8694-9bdc-0e61-400120d8c14e@linaro.org>
Date:   Thu, 13 Jul 2023 11:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/6] thermal/drivers/mediatek/lvts_thermal: Fixes to
 the interrupt handling
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230706153823.201943-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> 
> This series fixes interrupt handling in the LVTS thermal driver. It not
> only solves the interrupt storms currently happening, but also allows
> the temperature monitoring interrupts to trigger when the thermal trip
> temperature is reached.
> 
> This series was tested together with the MT8192 support series [1] on
> the Spherion Chromebook (mt8192-asurada-spherion).
> 
> These are standalone fixes and don't depend on anything else.
> 
> [1] https://lore.kernel.org/all/20230530195132.2286163-1-bero@baylibre.com

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

