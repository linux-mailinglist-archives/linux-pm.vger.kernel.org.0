Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929416918A6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 07:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjBJGpC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 01:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBJGpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 01:45:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0E1B307
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 22:45:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o18so4063260wrj.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMd8zrjo8o2xkfWSu/tAGCytSiDkDCaLT/oxKSVCWik=;
        b=VHi8pkvLswSSTqhgg6j25ca2gZJkWx0OMQ2WgDithqO21aSOgvkv5d/bwSb6pFNp9w
         jJtt0JHOu36VK/XhOBV9Kll7/wC5C5Alw40AM8/zkFvZQeWLuQf3gxaxxvqZ95TF6i65
         teRnURGdRwSsbF0srlRnmkQCXLb4xFXGRJXXYSmG1mFXJQwQUviIF/EHVAusmpfGojRe
         ePfTTbFSwFgN1rIir0LGruU8Ho2fo8CA2voJkx8Cs0061zwrJVP6CQtpbuGRFM0imaUK
         /5vxJdUDxc6Au2WUF4mPfbpX1EZjdh6ZTdqxBPB5u9DNhFLF15sno/T+WTktBu+AncbK
         WnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMd8zrjo8o2xkfWSu/tAGCytSiDkDCaLT/oxKSVCWik=;
        b=mF8IUouLxZftAKd2GhLG8X0ja3no/GZpaUPnxFv49k4apN0RQQiYjTMVQIN+adt/lQ
         yrcSqtef4M2Zx0qBNzY09EvVAn7+sD934CTtTxhB5L5eZxbxXoOnV7hdqYr8Lt9i56e8
         bVyvgQg/EwQEGuI7Ni4Ce/kMEL+/tJRG4czDxWSZQEvWSb8RAAYQikjv6zrCGbMcHhWx
         MiVXnyJSIse29lL48KfsW6gDqkk2PnuJLtoKsffkzO/zqQCJC7k+k0jaZEex/cLAVOYl
         IByAY9xi5bHDkkSDYIn3sp+aNnN86bl2y91ypp1TEz7OHXHAdT1GS/03MCRy07jY/Dab
         sL2g==
X-Gm-Message-State: AO0yUKUF3mgDZsUZYvTGLd4zNdwM6iZSDM0HyRDTNsZMW1CYrGSj0Ivf
        DpJrnH1ZH8iuYGVJVzoM4x24LA==
X-Google-Smtp-Source: AK7set/ZLHNwvWdizk6P8QdKUHDk0+Dh3idhFbBpHn4LBD1uQR3gkwqJhQJ4PJKV0hvTZbL5Tu7VIg==
X-Received: by 2002:a5d:46c8:0:b0:2c5:4a20:120f with SMTP id g8-20020a5d46c8000000b002c54a20120fmr863924wrs.43.1676011498492;
        Thu, 09 Feb 2023 22:44:58 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i3-20020adffc03000000b002c53d69a8easm2326411wrr.92.2023.02.09.22.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 22:44:58 -0800 (PST)
Message-ID: <b41930f9-89d9-1b12-b024-05fb12700769@linaro.org>
Date:   Fri, 10 Feb 2023 07:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v14 0/6] Add LVTS Thermal Architecture
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230209105628.50294-1-bchihi@baylibre.com>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230209105628.50294-1-bchihi@baylibre.com>
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

On 09/02/2023 11:56, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> The LVTS (Low Voltage Thermal Sensor) driver is capable of monitoring
> multiple hot points. For that, it contains 7 thermal control blocks
> dedicated to specific devices on the die. Each control block can handle
> up to 4 sensors.
> 
> The thermal controller supports several interrupts. One for the cold
> trip point, the hot trip point, the return to the normal trip point,
> and a specific programmable trip point to monitor the temperature
> dynamically.
> 
> The temperature measurement can be done in two ways, the immediate mode
> where the temperature read is instantaneous and the filtered mode where
> the controller uses, by configuration, an average of a set of values
> removing the minimum and the maximum.
> 
> Finally, it is composed of 2 finite-state machines responsible for
> the state of the temperature (cold, hot, hot 2 normal, hot hot),
> the triggering of the interrupts, and the monitoring of the temperature.
> 
> As requested, the thermal driver has been reworked to reduce
> the complexity of the code. At this time, the 4 little CPUs and
> the 4 big CPUs are supported by the thermal driver.They are described
> in a data structure and more devices can be added later.
> The calibration routine has been simplified also.
> 
> The series provide the following changes:
>   - Move the Mediatek drivers inside a dedicated folder as their number
>     is increasing
>   - Add the DT bindings for the controller
>   - Add the efuse node for the mt8195
>   - The LVTS driver
>   - The thermal zones description in the DT

Applied patch 1,2 and 4 for v6.3

Patches 5 and 6 should go through the Mediatek tree.

Thanks!

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

