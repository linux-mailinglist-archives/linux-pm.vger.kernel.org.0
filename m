Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F156E741E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjDSHiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjDSHiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 03:38:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600893D0
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:38:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f17edbc15eso3872365e9.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681889880; x=1684481880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O11cNkDH5z7t2NN2bRH4l8Rl3tYZZQX8cjJddRFOqdc=;
        b=S5FZreJHJ75PqZhRN52OhzYajo1bwJjNaRzt6RKP2GjK8e3PyRmRbLL+O8V5k8C6FY
         bO7IiFQzVpBTRQqQitPaZ7oYEKPu47teqdrxG6cddRkb+R9yseDz/+ArMYZUPDeiFV2g
         DTdZZvyqipQMaP4RmNbV/dnvJSpCxrA7nFmCSs3qrz8kopwZCaTJZFHPMykxkCQtvHgd
         mjE/sHhNt8ZHaRxpnLxlFA4awtvknmn7Du7F0qpTjbAivWTqQ5Qogb9rWp0dUFElAob+
         n8Y6WLYueOoY+8xkil2OKpse81mFFf9T0/FIJGPc3ZXeyT8bpXioF3+rLozTISbV+J+Y
         Ohsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889880; x=1684481880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O11cNkDH5z7t2NN2bRH4l8Rl3tYZZQX8cjJddRFOqdc=;
        b=hXUOGJfrw45NNyCL71/aq6qjstGRKG+n0LRf077cDxt8YKmz/02Fe51024f1G5PKmP
         cUTKrK9c9N2+7ZsvA2wB8jV3/RJIXK66dSw2cyY/LJD4Jtp5l5rn6AbALnbGynBsZ0SW
         Qb76L7+gI8d+cZhFzyW1Fb7geBPeKMhkoB59RIJHQd6QfrSSF7bEqM3XsUSyhlfvX6HN
         OPNUi2AxePhfd8HXpbbnN5gAljZClB4Ocl5xgiBASs6g7l+ws/AyJlD/H7OvlpnFf9nw
         vF72q8qIOklLdXi4kOMzmXpRknxvjUK0yjMTcnQHEOQ+rDBXkBg5M9Aa45z2yhd1XUm/
         ZCSQ==
X-Gm-Message-State: AAQBX9c8g+pQHGMDjSsHietF5nWCGMTIJIyp8Jkb24iTHvtr8+QJxsml
        FC2F7fsoz8FxbN1gaG0YE+XFv8M+G1ZYPZE1clbK6w==
X-Google-Smtp-Source: AKy350YlIA1rvTUogu6pH1nUVDJEW/Kq+1PWBQ+McpJKhPOKEfEArgivWBaYX8xXrx/EcYbULiI7kg==
X-Received: by 2002:adf:ea4f:0:b0:2da:2aa0:13e8 with SMTP id j15-20020adfea4f000000b002da2aa013e8mr3924662wrn.26.1681889879800;
        Wed, 19 Apr 2023 00:37:59 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g16-20020a5d5410000000b002d1e49cff35sm14974598wrv.40.2023.04.19.00.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:37:59 -0700 (PDT)
Message-ID: <edba7c7e-0b6a-64ac-a267-1e9bfef60d12@linaro.org>
Date:   Wed, 19 Apr 2023 09:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/2] thermal: mediatek: use devm_of_iomap to avoid
 resource leak in mtk_thermal_probe
Content-Language: en-US
To:     Kang Chen <void0red@hust.edu.cn>
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com
References: <20230419020749.621257-1-void0red@hust.edu.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230419020749.621257-1-void0red@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/04/2023 04:07, Kang Chen wrote:
> Smatch reports:
> 1. mtk_thermal_probe() warn: 'apmixed_base' from of_iomap() not released.
> 2. mtk_thermal_probe() warn: 'auxadc_base' from of_iomap() not released.
> 
> The original code forgets to release iomap resource when handling errors,
> fix it by switch to devm_of_iomap.
> 
> Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
> Signed-off-by: Kang Chen <void0red@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Dropped v4 and applied v5

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

