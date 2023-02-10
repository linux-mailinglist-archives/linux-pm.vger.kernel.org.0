Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D136920D1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjBJO2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 09:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjBJO2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 09:28:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A145B7358A
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 06:28:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso4183674wms.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guuw8fNr8ek6MKlKjsKHEfRl2wvHYLY1FYFS39aDXmo=;
        b=wwlzhw00GEnOlY5ru98N3sJZjli9DmVZXQsWhbquo+ZIWztUTytBzwgFgSPccuBvPr
         7Aj2i4W+zkBnv3C3BRi3W8tmxOqlqvAjLqDrUG7VOY5a6a15fL0Qk6ul0Z8DzvERRosv
         6UUMKhyjKibE8wB+GV5JczReFz4lfRIdXyfS+REHPv1Pq8cBA47MXsR50z7WAQ1eqTj6
         lnT6vKSaLL18Wa5LDLGI7eqvS9+oTbwDLl2lAcngvvtQqCTYxHwgKObXI7KTJazFjzyk
         0lBZf6LuKT47Dg5+X4oYwEBtscnV23aIIAGOJrI4SyFrhjgAdxh3eUuJJZrmOrqeNO9g
         qM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guuw8fNr8ek6MKlKjsKHEfRl2wvHYLY1FYFS39aDXmo=;
        b=b4SnqoAXox9sbWVbIotFT8cM0emWoM3ma6e1gWfgbSBMrKuMo0SBiDQ4niDGxRDtwL
         u2hzl3/Dzq9CTnrnvbb1eD4ueEwfNkPDgvHBvinODhS7SD8SHs5Fk8qKHw+94WEitMnj
         y2qsuuPt1+we550razFZUiGaMp4xQDqIoHqo5x3Vd+4mpb+UY6WcwaQZ3owliFYIV6AB
         U4IgttKKm5XSXEvWb66DOZoXVotIaDuUilgrsg7UXnoPBgnsO9OW2mVURRRb9LiLcqQ2
         4yN0wcVpokswLiYsF6ruPTj5E6gXl7hpkDclKWnRWqWrXuEK9zre3/Sze1+m/11wjSdd
         6B5w==
X-Gm-Message-State: AO0yUKWTCW9EAiMsGLXOGtaYxS7jM7m4MjY+XclA5+Ed/nV8h1RoL4ON
        l1dqcmodZw1c5A0ObYJquTGF/g==
X-Google-Smtp-Source: AK7set9psfB2CgFVm0ZCdVqPYR3dikKyySJ+OFxHi2O3dgsTxlOvcyYTV7Wv31CppCH/lcwneloMVw==
X-Received: by 2002:a05:600c:4d92:b0:3df:dea7:8e3 with SMTP id v18-20020a05600c4d9200b003dfdea708e3mr14313259wmp.21.1676039332126;
        Fri, 10 Feb 2023 06:28:52 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r14-20020a05600c35ce00b003dc4ecfc4d7sm5694466wmq.29.2023.02.10.06.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:28:51 -0800 (PST)
Message-ID: <f24e7016-0131-7c42-6b59-c45fcc7873cd@linaro.org>
Date:   Fri, 10 Feb 2023 15:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] thermal/drivers/hisi: Drop second sensor hi3660
Content-Language: en-US
To:     Yongqin Liu <yongqin.liu@linaro.org>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, sumit.semwal@linaro.org, jstultz@google.com
References: <20230210141507.71014-1-yongqin.liu@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230210141507.71014-1-yongqin.liu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/02/2023 15:15, Yongqin Liu wrote:
> The commit 74c8e6bffbe1 ("driver core: Add __alloc_size hint to devm
> allocators") exposes a panic "BRK handler: Fatal exception" on the
> hi3660_thermal_probe funciton.
> This is because the function allocates memory for only one
> sensors array entry, but tries to fill up a second one.
> 
> Fix this by removing the unneeded second access.
> 
> Fixes: 7d3a2a2bbadb ("thermal/drivers/hisi: Fix number of sensors on hi3660")
> Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
> Link: https://lore.kernel.org/linux-mm/20221101223321.1326815-5-keescook@chromium.org/
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

